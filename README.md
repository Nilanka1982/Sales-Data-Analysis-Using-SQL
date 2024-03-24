# Sales Data Analyzing
### Project Overview

Through this data set, we can see sales data of some product categories, customers, period (from 2014 to 2018), shipping modes, States, and more. Identifying some critical values like states with the least sales, top customers, best shipping method, and summarizing data.

### Data Source 
Sales Data set - From Kaggle
(I created 3 Dimension tables and 1 fact table from the Data Set)

### SQL
MySQL Workbench

### Data Cleaning
1. Data Loading
2. Investigating all tables

### 1. Data Loading
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/d2b5323f-ba81-436d-89f3-06da78ddf1b8)
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/6d2f9e7a-b4c8-4f99-90b7-ec886c2a7515)


### 2. Investigating all tables

#### Customer
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/81625285-9eff-4e50-946b-19a4c823bc93)
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/f7a76579-26c6-4a56-b0aa-d5827df77f3e)

#### location
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/9c1211b5-40b3-4fbd-953a-91106d72185e)
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/7bd2f901-cdef-46dc-8ca3-229a81161e00)


#### products
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/6dd23336-2334-4bc8-a717-07f33a70e93d)
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/8f5bf7f4-40c8-4562-a101-abefbdb39f53)


#### Sales
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/23b5d9a7-b422-46f5-a21d-b904b21e84f0)
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/bbadfaca-0f83-4f53-9a19-c38f0d8c8c69)


### A few codes that I used in the Analysis

#### Sales by Category
```
SELECT 
    p.category,  ROUND(SUM(s.sales),2) AS total_sale
FROM
    sales AS s
        JOIN
    products AS p ON s.productid = p.productid
GROUP BY p.category
ORDER BY total_sale DESC;
```
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/a9664cfe-68fe-4810-aac1-621ac041a718)


#### Sales by State and Segment

```SELECT 
    l.state,
    ROUND(SUM(CASE WHEN s.segment = 'Consumer' THEN s.sales ELSE 0 END),2) AS consumer,
    ROUND(SUM(CASE WHEN s.segment = 'Corporate' THEN s.sales ELSE 0 END),2) AS corporate,
    ROUND(SUM(CASE WHEN s.segment = 'Home office' THEN s.sales ELSE 0 END),2) AS homeoffice
FROM
    sales AS s
JOIN 
    location AS l ON l.postalcode = s.postalcode
GROUP BY 
    l.state;
```
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/9afbb323-b514-409d-9c5b-7aedaf5c4209)

#### Top 10 Customers

```
WITH t1 AS(
SELECT 
    c.customername, ROUND(SUM(s.sales), 2) AS sales
FROM
    sales AS s
        JOIN
    customers AS c ON c.customerid = s.customerid
GROUP BY c.customername),
t2 AS 
( SELECT *, DENSE_RANK() OVER(ORDER BY sales DESC) as rnk_num FROM t1)
SELECT 
    *
FROM
    t2
WHERE
    rnk_num <= 10;
```
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/184d6113-c7a3-4e94-a00c-418edb53e4bd)


#### Yearly sales of all categories
```
SELECT 
    p.category,
    ROUND(SUM(CASE
                WHEN (YEAR(s.shipdate)) = 2014 THEN s.sales
                ELSE 0
            END),
            2) AS '2014',
    ROUND(SUM(CASE
                WHEN YEAR(s.shipdate) = 2015 THEN s.sales
                ELSE 0
            END),
            2) AS '2015',
    ROUND(SUM(CASE
                WHEN YEAR(s.shipdate) = 2016 THEN s.sales
                ELSE 0
            END),
            2) AS '2016',
    ROUND(SUM(CASE
                WHEN YEAR(s.shipdate) = 2017 THEN s.sales
                ELSE 0
            END),
            2) AS '2017',
    ROUND(SUM(CASE
                WHEN YEAR(s.shipdate) = 2018 THEN s.sales
                ELSE 0
            END),
            2) AS '2018'
FROM
    sales AS s
        JOIN
    products AS p ON s.productid = p.productid
GROUP BY p.category;
```
![image](https://github.com/Nilanka1982/Sales-Data-Analysis-Using-SQL/assets/66845038/69cd7d22-826f-4a7e-a740-6c8828ace2a4)


### Findings
* Best Leading Category is Technology ($73,023.62)
* Best State is Texas for Technology ($ 17,604.80)
* Top Customer is "Becky Martin" 
* Worst State for Sales is "New Mexico"
* Best shipping mode is Standard Class
  


















