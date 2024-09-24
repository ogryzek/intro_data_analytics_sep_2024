# Week 2  
- [4. Grouping & Aggregation](#4-grouping--aggregation)  
- [5. Advanced Filtering](#5-advanced-filtering)  
- [6. Diagram & Join Tables](#6-diagram--join-tables)
- [7. Union & Conditions](#7-union--conditions)  
  
## 4. Grouping & Aggregation  

1. Howmuchincome(SubTotal)wastherein2012(OrderDate)? Instruction: Write a query that answers the question, is based on the Sales SalesOrderHeader table and filters the data by year. (Use the function YEAR().)  

2. Howmuchincome(SubTotal)wastherein2013(OrderDate)? Instruction: Write a query that answers the question, based on the Sales.SalesOrderHeader table .  

3. Examinetheresultsofthe2previousquestionsandanswerthefollowing:
    a. Was there a rise or drop in sales?
    b. Thinkwhatthecausesforthismaybe(basedonyourgeneralknowledgeand life experience).  

4. Writeaquerythatdisplaystheamountofordersmadebyeachcustomer (CustomerID). Use the Sales.SalesOrderHeader table. Instruction: Write a query that groups the data in the Sales.SalesOrderHeader table according to Customer ID and displays the Customer ID and a count of the number of orders. Give a significant name to the column with the number of orders per customer.  

5. Continuingfromthepreviousquestion,sortthequeryresultsaccordingtothe number of orders from the highest to the lowest.  

6. Continuingfromthepreviousquestion,addcodesothatthequerywillrunonly on the orders with Order Date 2013.

7. WriteaquerythatdisplaysdescriptivestatisticsforeachColorfromthe Production.Product table : quantity of items of the same color, maximum list price, average list price, minimum list price, Instruction: Write a query that retrieves data from the Production.Product table, and groups it by Color field. Display the color code, and the appropriate aggregate functions. Be sure to give significant, comprehensible names to the calculated columns.  

8. Continuingfromthepreviousquestion,examinetheresults.Notethatthereare colors for which the minimum price is 0. Since a product cannot have a price to the customer of 0, copy the query and add a filter to it, so that lines with List Price 0 will not be included in the calculation.  

9. Continuingfromthe2previousquestions,usethemousetoselectthecodesof both queries and run them together. Note that both results will appear in the Results window. These are the corresponding query results. Examine the Average Price column for the colors that had a minimum price of 0. Are there discrepancies in the average? Pay attention to this is a very important point! Sometimes we must filter out data that skew the calculations. Therefore, it is important to verify the data and the results. This is a significant part of the analyst’s job: critical thinking.  

10. What is the most common Last Name in the Person.Person table Instruction: Write a query that shows how many times the same last name repeats for each Last Name in the Person.Person table. Sort the results according to the number of repetitions of the last name in descending order.Hint: Use “Group by” and pay attention to how many fields you choose to display in the query (Select).

11. Examine the Order details (Sales.SalesOrderHeader) for 2012. Check the following in the Total Payment for Order field (SubTotal):
  a. What is the highest Order amount? 
  b. WhatisthelowestOrderamount? 
  c. What is the average Order amount? 
  d. WhatisthetotaloftheOrders?
  e. Howmanyorders(separaterecordsinSales.SalesOrderHeader)were issued?
### Part II - Having clause
1. WriteaquerybasedontheSales.SalesOrderDetailtable,thatcountshowmany rows there are in each order (SalesOrderID). Display the Order number, and the quantity of lines in the order. Display data only for orders that have more than 3 lines.  

2. WriteaquerybasedontheSales.SalesOrderDetailtable,thataddsuptheLine Total for each order (SalesOrderID). Display the Order number, and the Total for Payment for orders that have a Total for Payment above 1000.  

3. Howmanycustomersmademorethan20orders?(Eachrowinthe Sales.SalesOrderHeader table represents an order.) Instruction: Write a query based on the data in the Order details table (Sales.SalesOrderDetail) that groups the data according to CustomerID. Add a filter after aggregation, such that only the rows with a Count higher or equal to 20 will be displayed.  

4. Whichjobsinthecompany(JobTitle)have10employeesormoreinthesame job? Display the list of Jobs (JobTitle) that answer the criteria and the number of employees in that job. Base your answers on the HumanResources.Employee table. Instruction: Write a query that displays the Job Titles and the number of employees in each job from the HumanResources.Employee table. Add a filter that will display only the jobs with 10 employees or more.  

5. WriteaquerybasedontheSales.SalesOrderDetailtablethatdisplaystheamount of each product ordered only for products with an amount above 50 units Instruction: Write a query based on the Sales.SalesOrderDetail table. The query groups the data according to Product ID and calculates the total number of items ordered for each item. (Pay attention to which aggregate function you are using and on which field. Use ERD.)  
  
6. WriteaquerythatdisplaystheLastnamesfromthePerson.Persontablefor people whose last name appears 100 times or more in the Person.Person table.  
  
7. WriteaquerythatdisplaystheCustomerIDandtotalpurchaseamount(SubTotal) for customers who purchased a total amount over 100,000 in 2012 (all the orders in that year). Base your answer on the Sales.SalesOrderHeader table.  
  
8. Write a query based on the Sales.SalesOrderDetail table that displays the Order number and the number of lines in each order only for orders with more than 3 lines and Order numbers between 45,000 and 50,000, inclusive. Instruction: Before you begin writing the query, examine the columns and data in the Sales.SalesOrderDetail table.  
  
9. WriteaquerybasedonthePerson.PersontablethatdisplaystheLastnamesand the number of appearances of that name. Display only the Last names that appear between 10 and 50 times.

## 5. Advanced Filtering  
### Part 1 – SELECT DISTINCT, SELECT TOP  
1. Copyandrunthefollowingqueries.Whatisthedifferencebetweentheresults?
    a. Query 1:
    ```sql
    select ProductSubcategoryID
    from Production.Product
    ```
    b. Query2:
    ```sql
    select distinct ProductSubcategoryID
    from Production.Product
    ```
2. Writeaquerythatdisplaysthe5firstDepartmentnamesfromthe HumanResources.Department table.

3. Writeaquerythatdisplaysallthedetailsofthe20productswiththehighestcost (StandardCost) from the Production.Product table.  

4. WriteaquerythatdisplaysthelistofColorsoftheproductsfromthe Production.Product table, where each color appears only once.  

5. Displaythe10itemswiththelowestListPriceintheProduction.Producttable.Do not include items without a price (i.e., Price = 0).  

6. Whatdoesthefollowingquerydo?  

```sql
select distinct top 5 Color
from Production.Product
```

7. Displaythe10Customernumbers(CustomerID)andOrdertotals(SubTotal)for the customers with the highest order amounts in 2012 (OrderDate). Base your answer on the Sales.SalesOrderHeader table.  

8. Challengequestion:  What is the number of unique (non-repeating) cities in the Person.Address table?  

9. Whicharethe10orderswiththehighestamounts(SubTotal)in2013(OrderDate)? Instruction: Figure out how to ensure that the highest amounts will be at the top?  
  
10. What does the following query return?  
```sql
select distinct top 10 FirstName
from Person.Person
order by FirstName
```

### Part 2 – IN, BETWEEN OPERATORS, LIKE & Aliases  
1. DisplaythenamesofthepeopleinthePeopletablethathaveoneofthefollowing Last names: Adams, Kelly, Perry, Wilson. Use the “IN” operator.

2. Writeaquerythatdisplaystheproductcode(ProductID),theProductnameand the subcategory code (ProductSubcategoryID) from the Production.Product table, Display the data only for products for which the subcategory is one of the following: 2,5,9,14,15,30. Sort the data by subcategory  
  
3. Writeaquerythatdisplaystheproductcode(ProductID)andproductcost (StandardCost) from the Production.Product table for products with a cost between 100 and 500,  
  
4. Writeaquerythatshowstheordernumber(SalesOrderID),orderdate (OrderDate) and total for payment (SubTotal), for orders generated on the dates 10/01/2012 to 10/02/2012, inclusive . Base your answer on the Order title table. * The dates in the question are written in dd/mm/yyyy format.  
  
5. Writeaquerythatdisplaystheproductcode(ProductID),theproductnameand the Product number for all the products in the Production.Product table that begin with the letter “C”.  
  
6. Writeaquerythatdisplaystheproductcode(ProductID),theproductnameand the Product number for all the products in the Production.Product table that begin with the letters “C”, “B” or “E”.  
  
7. Writeaquerythatdisplaystheproductcode(ProductID),theproductnameand the Product number for all the products in the Production.Product table that end with the number “8”.  
  
8. DisplaytherecordsfromthePerson.Addresstablewiththeword“New”intheir Address 1 line (beginning/middle/end).  
  
9. DisplaytheFirstnamesofthepeopleinthePerson.PersontablewheretheFirst name has only 5 letters, the first letter is “D” and the third letter is “N”. Display the names without repetition.  
  
10. Write a query that displays the data from the Sales.SalesOrderDetail table where the total per line (LineTotal) is between 1,000 and 5,000 (use “Between”) and the Carrier Tracking Number contains the sequence F89. Sort the results by Unit price in ascending order.  
  
11. Write a query that displays the product code (ProductID) and product name from the Production.Product table for all the products that have the word “Red” in their name and their List Price is between 600 and 1,500, inclusive.  

### Part 3 – IS NULL

1. WriteaquerythatdisplaystheproductdetailsoftheproductswiththecolorNULL from the Production.Product table. Check the table for the appropriate column name  

2. WriteaquerythatdisplaysalltheorderdetailsfromtheSales.SalesOrderHeader table for the orders that have data in the Sales Person ID column.  

3. Writeaquerythatdisplaysthecustomercodeandthehighestorderamount (SubTotal) in the years 2012 and 2013 for each customer in the Sales.SalesOrderHeader table. Display only sales that have values both in the Sales Person column, and in the Purchase Order Number column. Check the table for the appropriate column names.  

## 6. Diagram & Join Tables
### Part 1–Database Diagram
1. Whichcolumnconnectsthefollowingtables? Instruction: For each row in the table, open a diagram and insert Tables 1 and 2 into it. Check the name of the connecting column in each table and write the name in the appropriate place in the question.

| Table 1 Name | Connecting Column in Table 1 | Table 2 Name | Connecting Column in Table 2 |   
| ----- | --- | --- | --- |   
| Sales.SalesPerson |   |  Sales.Store |  |  
| Production.TransactionHistory |  | Production.Product |  |  
| Production.BillOfMaterials |  | Production.Product |  |  
| Person.Person |  | Person.BusinessEntity |  |  

2. LookatthePerson.AddressandPerson.BusinessEntityAddresstables.
  a. What is the connection between them? How can they be connected?
  b. Whatisthesignificanceofthedataineachofthetables?
  
### Part 2–Basics: Join, Left Join, Right Join, Full Outer Join  
 
1. Beloware2tablesfromthedatabaseoftheAnalystintheMakingCollege.  

![](./studentdetails.png)
![](./studentcourses.png)  
  

2. Lookatthedatainthetablesandtrytounderstandthefollowing:  
  a. What does each table represent? What is significant about the content?
  b. Isthereaconnectionbetweenthetables?Whatisit?
3. Takepaperandpenandtrytoarriveatthequeryresultsmanually.Writedownthe results.  
    a. JOIN / INNER JOIN:
```sql
select s.StudentNo, c.CourseNo
from StudentDetails s
inner join StudentCourses c
on s.StudentNo = c.StudentNo
```


## 7. Union & Conditions  

