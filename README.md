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










