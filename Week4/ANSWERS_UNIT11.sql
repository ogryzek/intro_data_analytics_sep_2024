--******************************************************
--****** Part 1 � CTE (Common Table Expressions) *******
--******************************************************

/* 
Question 1
*/
with	Sales_CTE (SalesOrderID, SalesPersonID, SalesYear)  
		as   
		(  
			select	SalesOrderID, 
					SalesPersonID, 
					YEAR(OrderDate) as SalesYear  
			from Sales.SalesOrderHeader  
			where SalesPersonID IS NOT NULL  
		)  

select	SalesPersonID,
		SalesYear,
		COUNT(SalesOrderID) as TotalSales  
from Sales_CTE  
group by SalesYear, SalesPersonID  
order by SalesPersonID, SalesYear

 
/* 
Question 2
*/
with	Sales_CTE (SalesPersonID, NumberOfOrders)  
		as  
		(  
			select	SalesPersonID, 
					COUNT(*)  
			from Sales.SalesOrderHeader  
			where SalesPersonID IS NOT NULL  
			group by SalesPersonID  
		)  
select AVG(NumberOfOrders) as "Average Sales Per Person"  
from Sales_CTE

/* 
Question 3
*/
with	Person_CTE
		as
		(
			select	c.CustomerID,
					p.FirstName,
					p.LastName
			from Sales.Customer c
				join Person.Person p
					on p.BusinessEntityID = c.PersonID
		)
select	h.SalesOrderID,
		h.CustomerID,
		p.FirstName,
		p.LastName,
		h.SubTotal
from Sales.SalesOrderHeader h
	join Person_CTE p
		on p.CustomerID = h.CustomerID


/* 
Question 4
*/
with	Sales_CTE
		as
		(
			select	h.SalesOrderID,
					h.OrderDate,
					d.ProductID,
					d.OrderQty
			from Sales.SalesOrderHeader h
				join Sales.SalesOrderDetail d
					on h.SalesOrderID = d.SalesOrderID
		)
select	p.Color,
		SUM(s.OrderQty) SalesQty
from Sales_CTE s
	join Production.Product p
		on s.ProductID = p.ProductID
where YEAR (s.OrderDate) = 2013
group by p.Color
order by SalesQty desc

--***************************************************************
--****** Part 2 � Multiple CTE (Common Table Expressions) *******
--***************************************************************
/* 
Question 1
*/
with Person_CTE
		as
		(
			select	c.CustomerID,
					p.FirstName,
					p.LastName
			from Sales.Customer c
				join Person.Person p
					on p.BusinessEntityID = c.PersonID
		),
		Sales_CTE   
		as   
		(  
			select	CustomerID,
					YEAR(OrderDate) as SalesYear,  
					COUNT (*) as NoOfOrders,
					SUM (SubTotal) as TotalAmount
			from Sales.SalesOrderHeader  
			group by YEAR(OrderDate), CustomerID  
		)
select *
from Sales_CTE s
	join Person_CTE p
		on s.CustomerID = p.CustomerID
where SalesYear = 2012

/*
Answer:
The CTE prepares the data for copying into additional queries. 
In each of the queries, the data can be filtered differently according to the requirements.

In addition, it is correct to perform the filtering in the query, 
because when changing the structure of the CTE, one must check both the accuracy of the CTE, 
and the accuracy of the query based on the CTE. 

Conversely, if the filter is changed only in the final part, i.e. in the query itself, 
then only the query will be affected, so only the accuracy of the query will require checking.
*/


/* 
Question 2
*/
with	Sales_CTE
		as
		(
			select	p.Color,
					SUM (d.OrderQty) as SalesQty,
					COUNT (*) as NoOfSales
			from Sales.SalesOrderDetail d
				join Production.Product p
					on d.ProductID = p.ProductID
			group by p.Color
		),

		Color_CTE
		as
		(
			select	Color,
					COUNT (*) as NoOfItems
			from Production.Product
			group by Color
		)
select	s.*,
		c.NoOfItems
		
from Sales_CTE s
	join Color_CTE c
		on s.Color = c.Color
where s.Color is not NULL
