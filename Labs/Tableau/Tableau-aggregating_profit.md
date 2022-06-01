
# Lab | Tableau -Aggregating Profitability

Build the following charts making use of the date parts/values in tableau and publish them to your tableau public account in order to submit the url via the Student Portal

## Your Challenge

Using the data set [global_superstore](https://github.com/student-IH-labs-and-stuff/BCNDATA0122/blob/main/Labs/Tableau/Global%20Superstore.xlsx) with the Orders table and Tableau Public, create the following charts to visualise:

(Ensure each chart has the appropriate fit, chart/mark type, title, axis labels and colour scheme.Images supplied for reference - no need to replicate)


1. A view of the overall Profit, over time (using order date), by market - as a line chart, with year and quarter. 
BONUS - Add a reference line (from the analytics panel) which shows the average profit as a dotted line through the time series.  You can experiment with shading below or above the average line, the label of the average line, anything else to make it visually clear which quarter is over the average in terms of profit. 
<img width="1137" alt="image" src="https://user-images.githubusercontent.com/71644535/164491586-a9c56cbb-1dcd-43d9-99b9-05d1d6dec16f.png">

2. Overall Profitability by Category and Sub category - with Category, Date, Market filters, and add profit on to colour. Add a reference line (hint:  analytics panel) which shows the average profit by each category - allowing each sub category can be compared to the rest in that category. 
<img width="590" alt="image" src="https://user-images.githubusercontent.com/71644535/164491943-0802a382-1171-4b06-a04b-5a1bfe316eb2.png">

3. Average Profit per unit sold (using a calculation of profit divided by quantity) with a filter for Category and Subcategory (please link your filters using only relevant values)
<img width="533" alt="image" src="https://user-images.githubusercontent.com/71644535/164492211-cea00a5c-3759-4754-b20c-e1346733b880.png">

4. Profitability % of total by Country (as a filled map) with a market filter- ie how much of the world profit does each country contribute in this data
- BONUS include a clever % of total label created from an LOD: By using a FIXED LOD on the text label, we hope to see the global contribution made to the company profit from each country- ie how much of the profit does France account for, globally (7.4%) - in this way the % of total profit label is unaffected by ANY filters when applied). 
<img width="330" alt="image" src="https://user-images.githubusercontent.com/71644535/164495759-d0ae7090-02e9-4ba7-ac76-c0e18178c7d1.png">

5. Create a highlight table or any other chart type to quickly see the the profit pattern between weeks and days of the week, with profit ratio as a calculated field (sum of profit divided by sum of sales amount) on colour - be careful with your calculation, you will need to pre-aggregate! 
<img width="263" alt="image" src="https://user-images.githubusercontent.com/71644535/164497286-0b2e6165-fe8b-4c92-b0f3-f8b4a8fdcaa4.png">

BONUS 6. Create a stacked 100% bar view showing the % of transactions which were profitable within each category and subcategory. Hint: you will need a table calculation at the cell level, but you will want to use a non aggregated calculation for profit> 0 so that the logic is applied at the row level. This should be a stacked 100% bar chart (each bar is 100% of the sales for that sub category)
<img width="928" alt="image" src="https://user-images.githubusercontent.com/71644535/164497378-ee97c28b-4194-47c2-b0a6-b0260a2e7bb2.png">


----- proprietary content of SED Training Ltd-------
