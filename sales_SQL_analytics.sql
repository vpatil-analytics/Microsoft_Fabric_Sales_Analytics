SELECT COUNT(*) AS Rows FROM dbo.Orders;
SELECT COUNT(*) AS TOTAL_CUSTOMERS FROM dbo.[Customerss.csv];
SELECT COUNT(*) AS TOTAL_PRODUCTS FROM dbo.[Products.csv];
select SUM(SalesAmount)AS Total_Sales from dbo.Orders;
SELECT AVG(SalesAmount) AS Average_Order_Value from dbo.Orders;

Select Count(*) As Missing_OrderDate
from dbo.Orders
where OrderDate is NULL;

Select Count(*) As Missing_Quantity
from dbo.Orders
where Quantity is NULL;

#Unmatched customers.
Select 
    o.OrderID, 
    o.CustomerID
From dbo.Orders o 
left join
dbo.[Customerss.csv] as c 
    on o.CustomerID = c.CustomerID
where c.CustomerID is null;


Select p.Category,
       SUM(o.SalesAmount) AS Total_Sales_Amount
from dbo.[Products.csv] As p  
Join dbo.Orders o 
On p.ProductID=o.ProductID
group by p.Category
Order by Total_Sales_Amount DEsc ;

Select TOP 5
    p.ProductName,
    SUM(o.SalesAmount) as Total_Sales 
from dbo.[Products.csv] as p  
JOIN dbo.Orders as o
On p.ProductID = o.ProductID
Group by p.ProductName
Order by Total_Sales Desc;

Select 
    p.ProductName,
    Count(o.OrderID) as Total_Orders
from dbo.[Products.csv] as p  
JOIN dbo.Orders as o
On p.ProductID = o.ProductID
where p.ProductName = 'Product_495'
Group by p.ProductName;


Select 
    p.ProductName,
    sum(o.Quantity) as Total_Quantity
from dbo.[Products.csv] as p  
JOIN dbo.Orders as o
On p.ProductID = o.ProductID
where p.ProductName = 'Product_495'
Group by p.ProductName;


Select 
    p.ProductName,
    Avg(o.SalesAmount) as Avg_sales_per_Order
from dbo.[Products.csv] as p  
JOIN dbo.Orders as o
On p.ProductID = o.ProductID
Where p.ProductName = 'Product_495'
Group by p.ProductName;

# Sales by City:

Select c.City,
    Sum(o.SalesAmount) as Total_Sales
from dbo.[Customerss.csv] AS c  
JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
Group By c.City
Order By Total_Sales DESC;

SELECT c.City,
    count(o.OrderID) as Total_Orders
from dbo.[Customerss.csv] as c
JOIN dbo.Orders as o
    ON c.CustomerID =o.CustomerID
group by c.City
having c.City IN ('Ahmedabad', 'Chennai')
order by Total_Orders desc;

SELECT c.City,
    count(o.OrderID) as Total_Orders,
    sum(o.SalesAmount) as Total_Sales,
    Avg(o.SalesAmount) as avg_Order_value
from dbo.[Customerss.csv] as c
JOIN dbo.Orders as o
    ON c.CustomerID =o.CustomerID
group by c.City
having c.City IN ('Ahmedabad', 'Chennai')
order by Total_Orders desc;

SELECT
    c.City,
    SUM(o.Quantity) AS Total_Quantity,
    AVG(o.Quantity) AS Avg_Quantity_Per_Order
FROM dbo.[Customerss.csv] AS c
JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE c.City IN ('Ahmedabad', 'Chennai')
GROUP BY c.City;

SELECT
    c.City,
    p.Category,
    SUM(o.SalesAmount) AS Total_Sales
FROM dbo.[Customerss.csv] AS c
JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
JOIN dbo.[Products.csv] AS p
    ON o.ProductID = p.ProductID
WHERE c.City IN ('Ahmedabad', 'Chennai')
GROUP BY
    c.City,
    p.Category
ORDER BY
    c.City,
    Total_Sales DESC;


SELECT TOP 10
    p.ProductName,
    SUM(o.SalesAmount) AS Total_Sales,
    SUM(o.Quantity) AS Total_Quantity,
    COUNT(o.OrderID) AS Total_Orders
FROM dbo.[Products.csv] AS p
JOIN dbo.Orders AS o
    ON p.ProductID = o.ProductID
JOIN dbo.[Customerss.csv] AS c
    ON o.CustomerID = c.CustomerID
WHERE c.City = 'Ahmedabad'
  AND p.Category = 'Electronics'
GROUP BY p.ProductName
ORDER BY Total_Sales DESC;

SELECT
    c.City,
    COUNT(o.OrderID) AS Total_Orders,
    SUM(o.Quantity) AS Total_Quantity,
    SUM(o.SalesAmount) AS Total_Sales,
    AVG(o.SalesAmount) AS Avg_Order_Value
FROM dbo.[Customerss.csv] AS c
JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
JOIN dbo.[Products.csv] AS p
    ON o.ProductID = p.ProductID
WHERE c.City IN ('Ahmedabad', 'Chennai')
  AND p.Category = 'Electronics'
GROUP BY c.City
ORDER BY Total_Sales DESC;