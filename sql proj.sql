-- STEP 1: Import the data into sql
-- STEP 2: Examine the data
show columns  from sales_proj.upwork_task;

--  < GET THE COUNT OF THE TOTAL NO OF ROWS IN THE TABLE:]
select count(*) from upwork_task;

--  STEP 3:CLEANING AND TRANSFORMING THE DATA ]

--   < FIND DUPLICATE ROWS AND REMOVING THEM FROM THE TABLE >
SELECT COUNT(*) - COUNT(DISTINCT `Date`, `Customer Name`, `Product Name`, `Line Quantity`, `Line Total Amount`,
        `Customer Address`, `Customer City`, `Customer Country`, `Customer Email`, `Customer Phone No`,
        `Line Number`, `Line Tax Amount`, `Line Unit Price`, `Payment Method`, `Product Category`,
        `Product Cost`, `Product Price`, `Product Quantity On Hand`, `Product SKU`, `Shipped Date`,
        `Status`, `Subtotal Amount`, `Tax Amount`, `Total Amount`) as `Duplicate Rows Count`
FROM `sales_proj`.`upwork_task`;

CREATE TABLE `sales_proj`.`upwork_task_clean` AS
SELECT DISTINCT *
FROM `sales_proj`.`upwork_task`;

-- <CHECKING MISSING VALUES >
SELECT COUNT(*) as `Total Rows`,
       SUM(CASE WHEN `Date` IS NULL OR `Date` = '' THEN 1 ELSE 0 END) as `Missing Dates`,
       SUM(CASE WHEN `Customer Name` IS NULL OR `Customer Name` = '' THEN 1 ELSE 0 END) as `Missing Customer Names`,
       SUM(CASE WHEN `Product Name` IS NULL OR `Product Name` = '' THEN 1 ELSE 0 END) as `Missing Product Names`,
       SUM(CASE WHEN `Line Quantity` IS NULL THEN 1 ELSE 0 END) as `Missing Line Quantities`,
       SUM(CASE WHEN `Line Total Amount` IS NULL THEN 1 ELSE 0 END) as `Missing Line Total Amounts`,
       SUM(CASE WHEN `Customer Address` IS NULL OR `Customer Address` = '' THEN 1 ELSE 0 END) as `Missing Customer Addresses`,
       SUM(CASE WHEN `Customer City` IS NULL OR `Customer City` = '' THEN 1 ELSE 0 END) as `Missing Customer Cities`,
       SUM(CASE WHEN `Customer Country` IS NULL OR `Customer Country` = '' THEN 1 ELSE 0 END) as `Missing Customer Countries`,
       SUM(CASE WHEN `Customer Email` IS NULL OR `Customer Email` = '' THEN 1 ELSE 0 END) as `Missing Customer Emails`,
       SUM(CASE WHEN `Customer Phone No` IS NULL OR `Customer Phone No` = '' THEN 1 ELSE 0 END) as `Missing Customer Phone Nos`,
       SUM(CASE WHEN `Line Number` IS NULL THEN 1 ELSE 0 END) as `Missing Line Numbers`,
       SUM(CASE WHEN `Line Tax Amount` IS NULL THEN 1 ELSE 0 END) as `Missing Line Tax Amounts`,
       SUM(CASE WHEN `Line Unit Price` IS NULL THEN 1 ELSE 0 END) as `Missing Line Unit Prices`,
       SUM(CASE WHEN `Payment Method` IS NULL OR `Payment Method` = '' THEN 1 ELSE 0 END) as `Missing Payment Methods`,
       SUM(CASE WHEN `Product Category` IS NULL OR `Product Category` = '' THEN 1 ELSE 0 END) as `Missing Product Categories`,
       SUM(CASE WHEN `Product Cost` IS NULL THEN 1 ELSE 0 END) as `Missing Product Costs`,
       SUM(CASE WHEN `Product Price` IS NULL THEN 1 ELSE 0 END) as `Missing Product Prices`,
       SUM(CASE WHEN `Product Quantity On Hand` IS NULL THEN 1 ELSE 0 END) as `Missing Product Quantities On Hand`,
       SUM(CASE WHEN `Product SKU` IS NULL OR `Product SKU` = '' THEN 1 ELSE 0 END) as `Missing Product SKUs`,
       SUM(CASE WHEN `Shipped Date` IS NULL OR `Shipped Date` = '' THEN 1 ELSE 0 END) as `Missing Shipped Dates`,
       SUM(CASE WHEN `Status` IS NULL OR `Status` = '' THEN 1 ELSE 0 END) as `Missing Statuses`,
       SUM(CASE WHEN `Subtotal Amount` IS NULL THEN 1 ELSE 0 END) as `Missing Subtotal Amounts`,
       SUM(CASE WHEN `Tax Amount` IS NULL THEN 1 ELSE 0 END) as `Missing Tax Amounts`,
       SUM(CASE WHEN `Total Amount` IS NULL THEN 1 ELSE 0 END) as `Missing Total Amounts`
FROM `sales_proj`.`upwork_task_clean`;

-- LIST OF DISTINCT PRODUCT CATEGORIES IN TABLE:
select distinct(`Product Category`) from sales_proj.upwork_task;

-- GET THE LIST OF DISTINCT CUSTOMERS AND COUNT OF CUSTOMERS IN THE TABLE:
select distinct(`Customer Name`) from sales_proj.upwork_task;
select count(distinct(`Customer Name`)) from upwork_task;

-- GET THE TOTAL SALES BY YEAR:
select year(`Date`) as `year`, round(sum(`Total Amount`),2) as `Total revenue`
 from sales_proj.upwork_task
 group by year(`Date`)
 order by `year` asc;
 
 -- GET THE AVERAGE ORDER VALUE BY PRODUCT CATEGORY:
 select `Product Category`,round(avg(`Line Total Amount`),2) as `average order value`
 from upwork_task
 group by `Product Category`
 order by `average order value` desc;
 
-- ANALYZE SALES BY PRODUCT CATEGORY:
 SELECT `Product Category`, ROUND(SUM(`Total Amount`), 2) as `Total Sales`
FROM `sales_proj`.`upwork_task`
GROUP BY `Product Category`
ORDER BY `Total Sales` DESC;

-- top-selling products by revenue
SELECT `Product Name`, SUM(`Line Total Amount`) as `Total Sales`
FROM `sales_proj`.`upwork_task`
GROUP BY `Product Name`
ORDER BY `Total Sales` DESC
LIMIT 10;

SELECT DATE_FORMAT(`Date`, '%Y-%m') as `Month`, SUM(`Total Amount`) as `Total Sales`
FROM `sales_proj`.`upwork_task`
GROUP BY `Month`
ORDER BY `Month` ASC;

SELECT COUNT(DISTINCT `Customer Email`) as `Total Customers`,
       COUNT(DISTINCT CASE WHEN YEAR(`Date`) = 2022 THEN `Customer Email` END) as `Returning Customers`
FROM `sales_proj`.`upwork_task`
WHERE YEAR(`Date`) >= 2021;