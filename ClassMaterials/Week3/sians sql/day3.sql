use bank;

# how many clients per district? 

SELECT d.A2 as districtname, d.A3 as regionname, count(distinct c.client_id) as noofclients
FROM district d #left table
LEFT JOIN client c #right table and join type 
ON d.A1 = c.district_id # join clause(s)
-- USING() if the fields are named the same 
group by d.A2, d.A3;

SELECT * from district 
LEFT JOIN client 
ON district.A1 = client.district_id;

#how many loans and avg(amount) per account?
SELECT a.account_id, a.date, count(l.loan_id), avg(l.amount)
FROM loan l # left table
INNER JOIN account a  # right table
USING(account_id) # join clause 
group by a.account_id, a.date; #aggreg process

# Activity - join 2 tables 
-- Get a list of districts ordered by the number of clients (descending order). 
-- Name the columns as: District_name and Number_of_clients respectively.
SELECT d.A2 as District_name, count(c.client_id) as Numberofclients
FROM district d
JOIN client c
ON d.A1 = c.district_id
GROUP BY d.A2
ORDER BY Numberofclients DESC;

SELECT d.A2 as DistrictName, COUNT(distinct c.client_id) as NumberofClients
FROM DISTRICT d
JOIN CLIENT c
ON d.A1=c.district_id
GROUP BY d.A2
order by NumberofClients DESC;

-- Get a list of regions ordered by the number of clients (descending order). 
-- Name the columns as: Region_name and Number_of_clients respectively.
SELECT d.A3 as RegionName, COUNT(c.client_id) as NumberofClients
FROM DISTRICT d
JOIN CLIENT c
ON d.A1=c.district_id
GROUP BY d.A3
order by NumberofClients DESC;

-- Get the number of accounts opened by district and year. 
-- Name the columns as: District_name, Year and Accounts_opened. 
-- Order the results by District_name and Year.
SELECT d.A2 as District_name, date_format(a.date,'%Y') As Year,
count(a.account_id) as Accounts_opened
from district d
join account a
on d.A1=a.district_id
GROUP BY d.A2, date_format(a.date,'%Y') 
ORDER BY d.A2, date_format(a.date,'%Y');

# example where left and right matters
select * from loan
right join account
using(account_id);

# join = inner join in mysql 

# what about joining more than 2 tables loan- account - district 
# how many loans, clients, accounts per region 
SELECT d.A3 as region, 
count(l.loan_id) as noofloans, 
count(dp.account_id) as noofaccounts,
count(c.client_id) as noofclients
FROM loan l
INNER JOIN account a using(account_id)
INNER JOIN disp dp using(account_id)
INNER JOIN client c using(client_id)
INNER JOIN district d ON c.district_id = d.A1
WHERE dp.type='OWNER'
GROUP BY A3;


-- activity 
#Extend the query below and list district_name, client_id, 
# and account_id for those clients who are the owner of the account. 
#Order the results by district_name:
-- original 
select * from bank.disp as d
join bank.client as c
on d.client_id = c.client_id
join bank.district as da
on da.A1 = c.district_id;
-- new - add owner, specify fields, and order by 
select da.A2 as districtname,c.client_id, d.account_id 
from disp d
join client c USING(client_id)
join district da on c.district_id=da.A1
WHERE d.type='OWNER'
ORDER BY da.A2;

# get the biggest and smallest trans with trans id (roger question)
 WITH B as (Select trans_id, amount, row_number() OVER(order by amount DESC) as rn1,
 row_number() OVER(order by amount) as rn2 
from trans 
where amount <>0
)
select BMin.amount as MinAmount,
       BMin.trans_id as MinTransid,
       BMax.amount as MaxAmount,
       BMax.trans_id as MaxTransid
from B as BMin
cross join B as BMax
where BMin.rn1 = 1 and BMax.rn2 = 1;











-- DDL(definition) and DML(manipulate)
# CREATE ALTER DROP TRUNCATE RENAME  UPDATE

DROP DATABASE booksauthors;
CREATE DATABASE booksauthors;
use booksauthors;

DROP table IF EXISTS authors;
CREATE table authors
(
author_id INT AUTO_INCREMENT NOT NULL,
authorname VARCHAR(30) DEFAULT NULL,
country VARCHAR(30) DEFAULT NULL,
PRIMARY KEY (author_id)
);

DROP table IF EXISTS books;
CREATE table books 
(
book_id INT AUTO_INCREMENT NOT NULL,
author_id INT NOT NULL,
bookname VARCHAR(50) DEFAULT NULL, 
PRIMARY KEY (book_id),
KEY idx_fk_author_id(author_id),
CONSTRAINT fk_author_id FOREIGN KEY (author_id)
REFERENCES authors(author_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- populate with data - first authors 
INSERT INTO authors (authorname,country)
VALUES('Hans Rosling', 'Sweden'),('C Craido Perez','Britain'),
('Malcolm Gladwell', 'USA'), ('D Spiegelhalter','Britain'), 
('D Mccandless','Britain'), ('D Trump', 'USA');

# UPDATE authors set country='UK' where author_id in(2,4,5)
# if needed to make a change 

# INSERT INTO authors()... 

-- populate with data - now books 
INSERT INTO books (bookname,author_id)
VALUES('Factfulness',1),('Invisible Women',2),('Outliers',3),('Blink',3),
('the art of statistics',4),('Knowledge is beautiful',5),
('Information is beautiful',5);

Select * from books 
right join authors 
using(author_id);

# CTES - common table expressions 
# subqueries 
# views 
# more window fx - optional 

# create a view which combines clients with their loans, loan status 
use bank;
CREATE OR REPLACE VIEW clients_loans_combo AS 
SELECT c.client_id, c.district_id, l.loan_id, l.status,
l.amount, l.duration, l.payments, l.date as loan_date
from client c
join disp dp using(client_id)
join account a using(account_id)
join loan l using(account_id) 
where dp.type = 'OWNER'; 

# SUBQUERY = a query inside a query 
-- step 2 outer query
-- step 1 (inner query) - check it 

-- eg which loans are bigger than average 
select * from loan where amount > 
(select avg(amount) from loan)
;
-- one value (=>), a column of values (IN) , a table of values (subquery needs an alias)
-- example of table in subquery
#select s1.firstcolumn from
#(select from ....) s1

# activity 
#Find out the average of the number of transactions by account.
#option 1 - create view then query view 
create view acctrans as 
select account_id, count(trans_id) as transact from trans
group by account_id;
select avg(transact) from acctrans; #if i have created a view

#option 2 create subquery 
select ceiling(avg(transact)) as avg_trans_overall
from 
(select account_id, count(trans_id) as transact
from trans group by account_id) as s;

#Get a list of accounts from Central Bohemia using a subquery.
#Rewrite the previous as a join query.
select account_id from account where district_id in
(select A1 from district where A3 = 'central Bohemia');

select account_id from account
join district 
on account.district_id=district.A1
where A3 = 'central Bohemia'; 

# CTE's - we want to join x + y but x does not exist 
-- transactions table - get the total amount for each account and any acc info
-- then draw on that table to get information 
-- or use that table to join to another table 
-- or join that table to itself (cross join)

#WITH cte_trans AS
#(SELECT .... 
#) 
#SELECT ct.field , ct.field, ct.field 
#from cte_trans as ct;

-- get the biggest and smallest trans 
-- with trans id for those transactions (roger question)

select max(amount), min(amount), trans_id from trans
where amount <>0
group by trans_id;

#example cte complex
 WITH B as (Select trans_id, amount, row_number() OVER(order by amount DESC) as rn1,
 row_number() OVER(order by amount) as rn2
from trans
where amount <>0
)
select BMin.amount as MinAmount,
       BMin.trans_id as MinTransid,
       BMax.amount as MaxAmount,
       BMax.trans_id as MaxTransid
from B as BMin
cross join B as BMax
where BMin.rn1 = 1 and BMax.rn2 = 1;

#example basic concept 
with cte_loan as ( select * from loan) 
select loan_id from cte_loan
where status = 'B';
