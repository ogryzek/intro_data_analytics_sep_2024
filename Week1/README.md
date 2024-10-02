## Week 1  
  
### `SELECT` Statement  

```sql
SELECT * FROM table_name;
```

```sql
SELECT column1, column2, column3, ... 
FROM table_name;
```

```sql
SELECT * FROM Production.Product;
```

1.) Write a query that displays BusinessEntityID, FirstName, LastName from the Person.Person table.  
  
```sql
SELECT BusinessEntityID, FirstName, LastName FROM Person.Person;
```

### `WHERE` Clause  
  
```sql
SELECT * FROM table_name WHERE condition;
```

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

2.) Retrieve all records from the Person.Person table where the first name is Ken.  
  
```sql
SELECT * FROM Person.Person WHERE FirstName = 'Ken';
```

3.) Retrieve all records from the Production.Product table where the list price is greater than 500.  
  
```sql
SELECT * FROM Production.Product WHERE price > 500;
```

More examples
```sql
SELECT ProductID, [Name], ProductNumber FROM Production.Product WHERE ProductNumber > 'N';

SELECT * FROM Sales.SalesOrderHeader WHERE OrderDate = '2013-11-07';
```

What will the following queries retrieve?
```sql
select FirstName, LastName from Person.Person where FirstName <> 'Ken';

select * from Sales.SalesOrderHeader where SalesOrderID = 43662;
```

### `AND`,`OR`, and `NOT` Operators

```
SELECT * FROM table_name WHERE condition1 AND condition2;

SELECT * FROM table_name WHERE condition1 OR condition2;  
```

With a `WHERE` clause
```sql
select * from Sales.SalesOrderDetail where OrderQty >= 3 and UnitPrice > 1800;

select BusinesEntityID, FirstName
from Person.Person
where FirstName = "Diane"
    or FirstName = "Mary"
    or FirstName = "Latoya";
```

### `NOT` Operator

```sql
SELECT * FROM table_name WHERE NOT conditional;
```

Examples

```sql
SELECT ProductID, Color, ListPrice
FROM Production.Product
WHERE NOT Color = "Silver";

SELECT ProductID, Color, ListPrice
FROM Production.Product
WHERE NOT (Color = "Silver" AND ListPrice < 700);
```

### Home Activities Practice 2  
  
```SQL
-- Write a query that displays the Order number (SalesOrderID), Order date, 
-- Customer Number (CustomerID) and Order amount (SubTotal) from
-- the Sales.SalesOrderHeader table, for the orders above $1500 and 
-- an Order date from Jan. 1,2013 onwards.
SELECT SalesOrderId AS "Order Number", OrderDate, CustomerId, SubTotal from Sales.SalesOrderHeader
WHERE SubTotal > 1500 AND OrderDate >= '2013-01-01';
```

```SQL
-- Write a query that displays all the data from the Person.Person table, 
-- only for people whose BusinessEntityID is above 10,000 and their 
-- first name is either Jack or Crystal.

SELECT BusinessEntityID, FirstName FROM Person.Person 
WHERE BusinessEntityID > 10000 
AND (FirstName = 'Jack' OR FirstName = 'Crystal');
```

```sql
-- Write a query that displays the SalesOrderID, ProductID, and total amount 
-- for that order line (LineTotal) 
-- only for items with a Line Total between 100 and 1.000, inclusive.
SELECT SalesOrderID, ProductID, LineTotal AS "Total Amount" FROM Sales.SalesOrderDetail
WHERE LineTotal >= 100 AND LineTotal <= 1000;
```

## SQL Practice Booklet Part 2  
  
1. Write a query that returns the Firstname, Middlename and Lastname of the people with the Middle name J in the `Person.Person` table.  
  
```sql
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName = 'J';
```

2. How many orders were made by customer no.15148(CustomerID)? Find it in the Sales.SalesOrderHeader table.
Instruction: Write a query that returns the order details for customer 15148.

```SQL
-- The instructions and the question seem to be asking for somewhat different
-- things. Any of these following answers seem reasonable.  

SELECT COUNT(*) AS "The Answer" FROM Sales.SalesOrderHeader
WHERE CustomerID = 15148;

-- SELECT * FROM Sales.SalesOrderHeader WHERE CustomerID = 15148;
-- SELECT SalesOrderID, OrderDate, ShipDate, DueDate, TotalDue FROM Sales.SalesOrderHeader WHERE CustomerID = 15148;
```

3. Write a query that returns all the orders in the Sales.SalesOrderHeader table that were issued on 31/07/2013 (OrderDate).
```sql
SELECT * FROM Sales.SalesOrderHeader WHERE OrderDate = '2013-07-31';
```
4. Write a query that returns all the product details from the Production.Product table for all the products with the Color Black.
```sql
SELECT * FROM Production.Product WHERE Color = 'Black';
```

5. Display the product details for the products from the Production.Product table with a List Price of 1079.99 or lower. Display the following columns: ProductID, Color, ListPrice.

```sql
SELECT ProductID, Color, ListPrice FROM Production.Product
WHERE ListPrice <= 1079.99;
```

6. Display the product details for the products from the Production. Producttable with a List Price above 3000.
Display the following columns: ProductID, Color, ListPrice.
How many such products are there?
```sql
SELECT ProductID, Color, ListPrice
-- How many such products are there? 
-- SELECT COUNT(*) 
FROM Production.Product WHERE ListPrice > 3000;
```

### Part 3 - Filtering using AND, OR, NOT operators
1. Write a query that returns all the product details from the Production.Product table for all the products with the Colors Silver or Black.

```sql
SELECT * FROM Production.Product
WHERE Color = 'Silver' OR Color = 'Black';
```
 
2. Display the product details for the products from the Production.Product table with a List Price of 1079.99 or lower, except the products with a price of 0. (In other words, do not display the products with a List price of 0.)
Display the following columns: ProductID, Color, ListPrice.
```sql
SELECT ProductID, Color, ListPrice FROM Production.Product
WHERE ListPrice <= 1079.99
AND ListPrice <> 0;
```

3. Write a query that returns all the employee details from the HumanResources.Employee table for all the employees in the following jobs: Research and Development Engineer, Design Engineer
Display the Employee code (BusinessEntityID), Job title (JobTitle) and User ID (LoginID).
Instruction: If you are unsure which field displays the job, write a query that shows all the data in the table. Afterwards, go over it column by column and determine which is the appropriate column, in your opinion.

```sql
SELECT BusinessEntityID as "Employee Code", JobTitle as "Job Title", LoginID as "User ID"
FROM HumanResources.Employee
WHERE JobTitle = 'Research and Development Engineer'
OR JobTitle = 'Design Engineer';
```

4. Display the First name, Last name and ID number (BusinessEntityID) of all the people in the Person.Person table whose first name is not: Diane, James, Aaron.
```SQL
SELECT FirstName, LastName, BusinessEntityID AS "ID number"
FROM Person.Person WHERE FirstName != 'Diane'
OR FirstName != 'James'
OR FirstName <> 'Aaron';
```
5. Display the Ordernumber (SalesOrderID) and Orderdate from the Sales.SalesOrderHeader table for all the orders that were issued during January 2013.
Instruction: What are the dates in the month of January. Think of the simplest way to include all the dates in a condition.
```sql
SELECT SalesOrderID as "Ordernumber", Orderdate
FROM Sales.SalesOrderHeader
WHERE Orderdate >= '2013-01-01' AND Orderdate <= '2013-01-31';
```

6. Display the Product ID, Color, Standard Cost and List Price from the Production.Product table only for the products with the Color Black, Cost higher than 1,000 and List Price lower than 3,000.
```sql
SELECT ProductID, Color, StandardCost, ListPrice FROM Production.Product
WHERE Color = 'Black' AND StandardCost > 1000 AND ListPrice < 3000;
```

### Part 1 – Calculated columns and aliases 

1. Margin = the difference between the price list price of the item and its cost, i.e., the company's profit from the sale of the item. Write a query that returns the Product ID, Product name and Margin from the Production.Product table. To calculate the margin, use the fields `ListPrice` and `StandardCost`.  
  
```sql
select 
    ProductID, 
    [Name], 
    ListPrice - StandardCost as Profit
from Production.Product
```

2. Continuing from the previous question note that there are products with a list price of 0. Adjust the query so that it only displays the products with a list price that is different than 0.  

```sql
select 
    ProductID, 
    [Name], 
    ListPrice - StandardCost as Profit
from Production.Product
where ListPrice <> 0
```
  
3. Write a query that returns the `ProductID`, `Listprice` and `Listprice`+12% (a calculated column) from the `Production.Product` table. Display only the products with a list price that is different than 0.  
  **note**: In the presentation from today’s lesson, you will find the formula for calculating a percentage change.  

```sql
select	
    ProductID,
    ListPrice,
    ListPrice * 1.12 as ListPriceRaise15Prec
from Production.Product
where ListPrice <> 0
```

4. The company learned that item costs will be going up by 12%,so they want to raise prices by 12%. Write a query that returns the following columns from the Production.Product table. only for products with a list price that is different than 0.
  a. ProductID
  b. ListPrice
  c. StandardCost
  d. Currentprofit(calculatedcolumn:ListPricelessStandardCost)
  e. ListPriceaftera12%rise(calculatedcolumn)
  f. Cost after a 12% rise (calculated column)
  
  **note**: In the presentation from today’s lesson, you will find the formula for calculating a percentage change.  

```sql
select	
    ProductID,
    ListPrice,
    StandardCost,
    ListPrice - StandardCost as Profit,
    ListPrice * 1.12 as NewListPrice,
    StandardCost * 1.12 as NewStandartCost,
    ListPrice * 1.12 - StandardCost * 1.12 as NewProfit
from Production.Product
where ListPrice <> 0
```

5. Challenge question:  
  
  Continuing from the previous question, the company wants to know the difference between the new profit and the old.
  
  Add an additional column to the query that displays the difference between the old and new profits (New profit less Old profit).  

```sql
select	
    ProductID,
    ListPrice,
    StandardCost,
    ListPrice - StandardCost as Profit,
    ListPrice * 1.12 as NewListPrice,
    StandardCost * 1.12 as NewStandartCost,
    ListPrice * 1.12 - StandardCost * 1.12 as NewProfit,
    (ListPrice * 1.12 - StandardCost * 1.12) - (ListPrice - StandardCost) as Diff
from Production.Product
where ListPrice <> 0
```

6. Continuing from the previous question, examine the results. Will the company profit or lose from the 12% price rise?  

```
Answer:
The company will benefit from changing costs and prices, 
because it will earn more than it has previously earned on each item.

This can be seen from the difference between the new profit and the new profit.

The difference is positive, so the company earns more on each product
```
  
### Part 2 – YEAR() function self-study practice, ORDER BY Keyword
  
As part of your job as analyst, you will be required to study and research independently to find solutions to the queries and tasks you will be asked to execute.  
  
In order that you may be well prepared for the job, every few lessons, as part of the practice, I will have you learn another function/sub-topic independently. Afterwards, you will have to answer questions using the new topic you have learned.

1. On the internet, search for information about the functionYEAR().Remember to add the words SQL Server to your search in order to target relevant results.  
  
  In order to understand the method and application of the function, you must find answers to the following questions:  
    
    a. What is the purpose of the function? What is the result that it returns?
    b. Does the function take parameters?(Parameter=information that we give the function within the parentheses) What are they?
    c. What is the syntax of the function?
    d. What are some examples for using the function? (Important because it really helps to understand how to use it.)  

```sql
/*
Answer:
The YEAR() function returns the year part for a specified date.

Syntax: YEAR(date)
Parameter: data = The date or datetime to extract the year from
Examples: 
*/
--1.
select YEAR('2000/07/31') AS Year
--2.
select YEAR('2000/07/31 09:08') AS Year
--3.
select YEAR(OrderDate) AS OrderYear
from Sales.SalesOrderHeader
```

2. Write a query that returns the `Ordernumber` (`SalesOrderID`),`Orderdate` and the Order year (calculated column) from the `Sales.SalesOrderHeader` table.  
```sql
select	
    SalesOrderID,
    OrderDate,
    YEAR (OrderDate) as OrderYear
from Sales.SalesOrderHeader
```

3. Write a query that returns the `BusinessEntityID`, `Lastname` and `Firstname` from the `Person.Person` table. Sort the results according to Last name in ascending order.  
```sql
select
    BusinessEntityID,
    LastName,
    FirstName
		
from Person.Person
order by LastName
```

4. Write a query that returns the `BusinessEntityID`, `Lastname` and `Firstname` from the `Person.Person` table. Sort the results according to Last name in ascending order, and secondary sort according to First name in descending order.  
```sql
select
    BusinessEntityID,
    LastName,
    FirstName
		
from Person.Person
order by LastName, FirstName desc
```

5. Write a query that returns the `BusinessEntityID`, `Lastname` and `Firstname` from the `Person.Person` table. Sort the results according to Last name in descending order, and secondary sort according to First name in descending order.  
```sql
select	
    BusinessEntityID,
    LastName,
    FirstName
		
from Person.Person
order by LastName desc, FirstName desc
```

6. Write a query that returns the Employee number (`BusinessEntityID`), `HireDate` and Year of birth (a column calculated by function on the `BirthYear` column) from the `HumanResources.Employee` table. Sort the results according to Hire date from the newest employee (will appear first) to the oldest (will appear last).  
```sql
select
    BusinessEntityID,
    HireDate,
    YEAR (BirthDate) BirthYear
from HumanResources.Employee
order by HireDate desc
```
  
7. Continuing from the previous question, add a filter to display the data only of employees that began working in 2010.  
  
  Instruction: In which section of the query are the data filtered? What is the value returned by the function YEAR()?

```sql
select	
    BusinessEntityID,
	HireDate,
	YEAR (BirthDate) BirthYear
from HumanResources.Employee
where YEAR (HireDate) = 2010
order by HireDate desc
```
