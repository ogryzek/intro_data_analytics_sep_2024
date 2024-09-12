# TECH-DA101-4 Introduction to Data Analytics  

## Resources 
  - [Docker-Setup](/Docker-Setup/)

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







