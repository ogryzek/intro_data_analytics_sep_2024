--***************************************
--****** Part 1 - GROUP BY Keyword ******
--***************************************

/* 
Question 1
*/
select sum(SubTotal) as SumSales2012
from Sales.SalesOrderHeader
where year (OrderDate) = 2012
--Total income for 2012: 33,524,301.326
 
/* 
Question 2
*/
select sum(SubTotal) as SumSales2013
from Sales.SalesOrderHeader
where year (OrderDate) = 2013
--Total income for 2013: 43,622,479.0537


/* 
Question 3
*/
/*
Answer:
A. There was an increase in sales in 2013, compared to 2012.
B. The reason could stem from better marketing.
*/

/* 
Question 4
*/
select	CustomerID,
		COUNT (*) as NoOfOrders
from Sales.SalesOrderHeader
group by CustomerID

/* 
Question 5
*/
select	CustomerID,
		COUNT (*) as NoOfOrders
from Sales.SalesOrderHeader
group by CustomerID
order by NoOfOrders desc

/* 
Question 6
*/
select	CustomerID,
		COUNT (*) as NoOfOrders
from Sales.SalesOrderHeader
where YEAR(OrderDate) = 2013
group by CustomerID
order by NoOfOrders desc

/* 
Question 7
*/
select	Color,
		COUNT(*) as NoOfItems,
		MAX(ListPrice) as MaxPrice,
		AVG(ListPrice) as AvgPrice,
		MIN(ListPrice) as MinPrice
from Production.Product
group by Color

/* 
Question 8
*/
select	Color,
		COUNT(*) as NoOfItems,
		MAX(ListPrice) as MaxPrice,
		AVG(ListPrice) as AvgPrice,
		MIN(ListPrice) as MinPrice
from Production.Product
where ListPrice <> 0
group by Color

/* 
Question 9
*/
/*
Answer:
There is a difference in the average price list price when there are items
of the same color whose price list price is 0.

This should be checked with the business entity, 
but if there is an error in the data, and the price list price equal to 0 is incorrect, 
then it disrupts and lowers the average significantly.

For our data, since there is no real business factor we can consult, 
we can assume that there are no products whose price per customer is 0, 
so we will filter these lines out
*/

/* 
Question 10
*/
select	LastName,
		COUNT (*) as CountTimesAppear
from Person.Person
group by LastName
order by CountTimesAppear desc
-- Answer: Diaz (appear 211 times)

/* 
Question 11
*/
select	MAX(SubTotal) as MaxSale,
		MIN(SubTotal) as MinSale,
		AVG(SubTotal) as AvgSale,
		SUM(SubTotal) as SumSale,
		COUNT(SalesOrderID) as CountSale
from Sales.SalesOrderHeader
where year (orderDate) = 2012

--************************************
--****** Part 2 � HAVING Clause ******
--************************************

/* 
Question 1
*/
select	SalesOrderID,
		COUNT(*) as CountOfDetailLines
from Sales.SalesOrderDetail
group by SalesOrderID
having COUNT(*) > 3

/* 
Question 2
*/
select	SalesOrderID,
		SUM(LineTotal) as SumOfLineTotal
from Sales.SalesOrderDetail
group by SalesOrderID
having SUM(LineTotal) > 1000

/* 
Question 3
*/
select	CustomerID,
		COUNT (*) as CountSales
from Sales.SalesOrderHeader
group by CustomerID
having COUNT(*) >= 20
 
/* 
Question 4
*/
select  JobTitle,
		count (*) as departPplAmount

from HumanResources.Employee
group by JobTitle
having count (*) >= 10

/* 
Question 5
*/
select	ProductID,
		SUM(OrderQty) TotalQtyOrdered
from Sales.SalesOrderDetail
group by ProductID
having SUM(OrderQty) < 50

/* 
Question 6
*/
select	LastName,
		count (*) as NoOfTimes
from Person.Person
group by LastName
having count (*) >= 100
order by LastName

/* 
Question 7
*/
select	CustomerID,
		sum (SubTotal) as SumTotal
from sales.salesOrderHeader
where year (OrderDate) = 2012
group by CustomerID
having sum (SubTotal) > 100000


/* 
Question 8
*/
select	SalesOrderID,
		count (*) as CountNoOfLines
from Sales.SalesOrderDetail
where SalesOrderID >= 45000 and SalesOrderID <= 50000
group by SalesOrderID
having count (*) > 3

/* 
Question 9
*/
select	LastName,
		COUNT (*) NoOfPersons
from Person.Person
group by LastName
having COUNT (*) > 10 and COUNT (*) < 50
