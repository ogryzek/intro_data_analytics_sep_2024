# TECH-DA101-4 Introduction to Data Analytics  

## Resources 
  - [Docker-Setup](/Docker-Setup/)

## Weeks
- [Week 1](/Week1)  
  
## Week 2  

- [An Introduction to Data Analysis - Lesson 4: Grouping and Aggregation]
- [An Introduction to Data Analysis - Lesson 5: Advancing FilteringPage]
 - [An Introduction to Data Analysis - Lesson 6: Diagram and Join TablesPage]
 - [An Introduction to Data Analysis - Lesson 7: Union and ConditionsPage]  
   
### Grouping and Aggregation - Lesson 4  
  


In Class Exercises:  
  
1. Find a table of records with some fields containing null values.
  - You could write a query to automate this or
  - Look at the tables and figure it out manually

2. Write a query similar to the example given for `ProductID, Color` in the Aggregate Functions slide, such that you can explain what the query result will be.  
  
```sql
SELECT SUM(Subtotal) AS 'Total Income for 2012' 
FROM Sales.SalesOrderHeader 
WHERE Year(OrderDate) = 2012;
```

