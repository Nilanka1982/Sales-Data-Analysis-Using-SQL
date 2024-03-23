CREATE SCHEMA IF NOT EXISTS sales;
USE sales;
SELECT * FROM customers;
SELECT * FROM location;
SELECT * FROM products;
SELECT * FROM sales;

/*01. Find  Sales by category*/
SELECT 
    p.category,  ROUND(SUM(s.sales),2) AS total_sale
FROM
    sales AS s
        JOIN
    products AS p ON s.productid = p.productid
GROUP BY p.category
ORDER BY total_sale DESC;



/*02. Find sales by state and category*/

SELECT 
    state, category, ROUND(SUM(sales), 2) AS totalsale
FROM
    sales AS s
        JOIN
    location AS l ON l.postalcode = s.postalcode
        JOIN
    products AS p ON p.productid = s.productid
GROUP BY state , category
ORDER BY totalsale DESC;




/*03. Sales by Region */

SELECT 
l.region, ROUND(SUM(s.sales),2) AS total_sales
FROM sales AS s
JOIN 
location AS l ON l.postalcode = s.postalcode
GROUP BY region
ORDER BY total_sales DESC;



/*04.Sales by State and Segment*/

SELECT 
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
    
/* 05. Top 10 Customers*/
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

/* 06. 10 Least sales states*/

WITH t1 AS
(SELECT 
    l.state, ROUND(SUM(s.sales), 2) AS sale
FROM
    sales AS s
        JOIN
    location AS l ON s.postalcode = l.postalcode
GROUP BY l.state),
t2 AS
( SELECT *, DENSE_RANK() OVER(ORDER BY sale ASC) AS rnk_state FROM t1
)
 SELECT * FROM t2 
 WHERE rnk_state <=10 ;
    
    
/*07. Best shipping mode*/

SELECT 
    shipmode, ROUND(SUM(sales), 2) AS total_sale
FROM
    sales
GROUP BY shipmode
ORDER BY total_sale DESC
LIMIT 1;



/*08. Yearly sales of all categories*/
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

/*09. Top 10 states for Technology in 2016*/

SELECT 
    l.state, ROUND(SUM(s.sales), 2) AS totalsales
FROM
    sales AS s
        JOIN
    location AS l ON s.postalcode = l.postalcode
        JOIN
    products AS p ON s.productid = p.productid
WHERE
    YEAR(s.shipdate) = 2016
        AND p.category = 'Technology'
GROUP BY l.state
ORDER BY totalsales DESC
LIMIT 10;


/*10. Finding Top 10 Cuatomers of Technology Categories*/

SELECT 
    c.customername, ROUND(SUM(s.sales), 2) AS totalsales
FROM
    sales AS s
        JOIN
    customers AS c ON s.customerid = c.customerid
        JOIN
    products AS p ON s.productid = p.productid
WHERE
    p.category = 'Technology'
GROUP BY c.customername
ORDER BY totalsales DESC
LIMIT 10;
    
    

    
    
    
    
    
    
    
    