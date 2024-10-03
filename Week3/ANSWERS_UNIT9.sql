--*************************************************************************************
--****** Part 1 - Unrelated Nested Queries										*******
--				  A subquery that returns a single value or a list (one column) *******
--*************************************************************************************

/* 
Question 1
*/
select	ProductID,
		ListPrice,
		(	select avg (ListPrice)
			from Production.Product
		) 
from Production.Product

/* 
Question 2
*/
select	ProductID,
		ListPrice,
		(	select avg (ListPrice)
			from Production.Product
			where ListPrice > 0
		) AverageListPrice
from Production.Product

/* 
Question 3
*/
select	ProductID,
		Color
from Production.Product
where color = (	select	Color
				from Production.Product
				where ProductID = 741
			  )

/* 
Question 4
*/
select	BusinessEntityID,
		Gender
from HumanResources.Employee
where Gender = (	select Gender
					from HumanResources.Employee
					where BusinessEntityID = 38
				)

/* 
Question 5
*/
select	e.BusinessEntityID,
		e.Gender,
		p.LastName,
		p.FirstName
from HumanResources.Employee e
	left join Person.Person p
		on e.BusinessEntityID = p.BusinessEntityID
where Gender = (	select Gender
					from HumanResources.Employee
					where BusinessEntityID = 38
				)

/* 
Question 6
*/
select SalesOrderID
from sales.SalesOrderHeader
where SubTotal < (	select avg (SubTotal)
					from Sales.SalesOrderHeader )

/* 
Question 7
*/
select count (*) as CountOrdersAboveAvg
from sales.SalesOrderHeader
where TotalDue < (	select avg (TotalDue)
					from Sales.SalesOrderHeader )

/* 
Question 8
*/
select SalesOrderID,
		ProductID,
		LineTotal / OrderQty as UnitPriceAfterDiscount,
		LineTotal - (	select AVG (LineTotal)
						from Sales.SalesOrderDetail
					) as DiffFromAVG
from Sales.SalesOrderDetail

/* 
Question 9
*/
select	ProductID, 
		[Name]
from Production.Product
where ProductID in (select d.ProductID 
					from Sales.SalesOrderDetail d
						join Sales.SalesOrderHeader h
							on d.SalesOrderID = h.SalesOrderID
					where YEAR(h.OrderDate) = 2013
					)

/* 
Question 10
*/
select	ProductID, 
		[Name]
from Production.Product
where ProductID in (select d.ProductID 	
					from Sales.SalesOrderDetail d
						join Sales.SalesOrderHeader h
							on d.SalesOrderID = h.SalesOrderID
					where YEAR(h.OrderDate) = 2013
					group by ProductID
					having SUM(d.OrderQty) > 300
					)

/* 
Question 11
*/
select	d.ProductID,
		d.ProductID,
		p.[Name],
		d.OrderQty,
		d.LineTotal

from Sales.SalesOrderDetail d
	join Production.Product p
		on d.ProductID = p.ProductID
	join Sales.SalesOrderHeader h
		on d.SalesOrderID = h.SalesOrderID
where	YEAR(h.OrderDate) = 2013 and 
		d.ProductID in (
							select TOP 10 d.ProductID
							from Sales.SalesOrderDetail d
								join Sales.SalesOrderHeader h
									on d.SalesOrderID = h.SalesOrderID
							where YEAR(h.OrderDate) = 2012
							group by d.ProductID
							order by SUM(d.OrderQty) desc
						)

/* 
Question 12
*/
select	d.ProductID,
		p.[Name],
		SUM (d.OrderQty) as TotalQty,
		SUM (d.LineTotal) as TotalAmount

from Sales.SalesOrderDetail d
	join Production.Product p
		on d.ProductID = p.ProductID
	join Sales.SalesOrderHeader h
		on d.SalesOrderID = h.SalesOrderID
where	YEAR(h.OrderDate) = 2013 and 
		d.ProductID in (
							select TOP 10 d.ProductID
							from Sales.SalesOrderDetail d
								join Sales.SalesOrderHeader h
									on d.SalesOrderID = h.SalesOrderID
							where YEAR(h.OrderDate) = 2012
							group by d.ProductID
							order by SUM(d.OrderQty) desc
						)
group by d.ProductID, p.[Name]

-- Another solution
select p.productid ,
       p.Name ,
       SUM(LineTotal) TotalAmount,
       SUM(OrderQty) TotalQty
from
	 (	select	ProductID,
				RANK() over (order by SUM(d.OrderQty) desc) SalesQtyRank
		from sales.SalesOrderDetail d
		   join sales.SalesOrderHeader h 
				on d.SalesOrderID = h.SalesOrderID
		where YEAR(h.OrderDate)=2012
		group by ProductID
	) sub
	join Production.Product p on p.ProductID = sub.ProductID
	join sales.SalesOrderDetail d on p.ProductID = d.ProductID
	join sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where YEAR(h.OrderDate)=2013
  AND sub.SalesQtyRank <= 10
group by p.ProductID, p.[Name]


/* 
Question 13
*/
select	d.ProductID,
		p.[Name],
		SUM (case when YEAR(h.OrderDate) = 2012 then d.OrderQty end) as TotalQty2012,
		SUM (case when YEAR(h.OrderDate) = 2013 then d.OrderQty end) as TotalQty2013,
		SUM (case when YEAR(h.OrderDate) = 2012 then d.LineTotal end) as TotalAmount2012,
		SUM (case when YEAR(h.OrderDate) = 2013 then d.LineTotal end) as TotalAmount2013

from Sales.SalesOrderDetail d
	join Production.Product p
		on d.ProductID = p.ProductID
	join Sales.SalesOrderHeader h
		on d.SalesOrderID = h.SalesOrderID
where	d.ProductID in (
							select TOP 10 d.ProductID
							from Sales.SalesOrderDetail d
								join Sales.SalesOrderHeader h
									on d.SalesOrderID = h.SalesOrderID
							where YEAR(h.OrderDate) = 2012
							group by d.ProductID
							order by SUM(d.OrderQty) desc
						)
group by d.ProductID, p.[Name]
order by TotalAmount2012 desc

/* Answer:
From the results of the query, it can be concluded that some of the most ordered products in 2012 (6 products) 
decreased in their quantities and order amounts in the orders of 2013, 
but there are several items (4 products) for which we saw a significant increase in the quantities and amounts sold.

This raises a number of interesting points, for example:
a.	Is this a business that is influenced by trends and fashion, 
	such that a product that is the most ordered in one year might not 
	be ordered at all in the following year?

b.	Could it be that items that could have been ordered and profitable 
	were not ordered at all the following year due to them being out of stock?
*/


/* 
Question 14
*/
 select sod.SalesOrderID, 
		sod.ProductID
 from Sales.SalesOrderDetail sod
 where SalesOrderID in ( select SalesOrderID
                         from Sales.SalesOrderDetail
						 group by SalesOrderID
						 having count (*) = 1)

/* 
Question 15
*/
--Option 1
select  ProductID, 
		[Name]
from Production.Product
where ProductID not in ( select ProductID 
						 from Sales.SalesOrderDetail
						 where ProductID is not null 
					   )
order by ProductID

--Option 2
Select distinct p.ProductID	
from Production.Product p 
	left join Sales.SalesOrderDetail d
		on p.ProductID = d.ProductID
where d.ProductID is null
order by p.ProductID


--*************************************************************************
--****** Part 2 - Unrelated Nested Queries							*******
--				  A subquery that returns a table (several columns) *******
--**************************************************************************

/* 
Question 1
*/
select	ProductID,
		SUM(OrderQty) TotalQty,
		SUM(LineTotal) TotalAmount
from Sales.SalesOrderDetail
group by ProductID

/* 
Question 2
*/
select	p.ProductID,
		p.[Name],
		p.ProductNumber,
		p.Color,
		SaleSummery.TotalAmount,
		SaleSummery.TotalQty
		
from Production.Product p
	join (
			select	ProductID,
					SUM(OrderQty) TotalQty,
					SUM(LineTotal) TotalAmount
			from Sales.SalesOrderDetail
			group by ProductID
		 ) as SaleSummery

		 on p.ProductID = SaleSummery.ProductID

/* 
Question 3
*/
select 	h.SalesOrderID, 
		h.SubTotal, 
		d.LinesSum
from 	Sales.SalesOrderHeader h
	left join (	select	SalesOrderID, 
						SUM (LineTotal) as LinesSum
				from sales.SalesOrderDetail
				group by SalesOrderID 
               )d
		on d.SalesOrderID = h.SalesOrderID

/* 
Question 4
*/
select 	h.SalesOrderID, 
		h.SubTotal, 
		d.LinesSum,
		h.SubTotal - d.LinesSum as Diff
from 	Sales.SalesOrderHeader h
	left join (	select	SalesOrderID, 
						SUM (LineTotal) as LinesSum
				from sales.SalesOrderDetail
				group by SalesOrderID 
               )d
		on d.SalesOrderID = h.SalesOrderID

/* 
Question 5
*/
select 	h.SalesOrderID, 
		h.SubTotal, 
		d.LinesSum,
		h.SubTotal - d.LinesSum as Diff
from 	Sales.SalesOrderHeader h
	left join (	select	SalesOrderID, 
						SUM (LineTotal) as LinesSum
				from sales.SalesOrderDetail
				group by SalesOrderID 
               )d
		on d.SalesOrderID = h.SalesOrderID
where h.SubTotal - d.LinesSum <> 0

/* 
Question 6
*/
select 	h.SalesOrderID, 
		h.SubTotal, 
		d.LinesSum,
		h.SubTotal - d.LinesSum as Diff
from 	Sales.SalesOrderHeader h
	left join (	select	SalesOrderID, 
						SUM (LineTotal) as LinesSum
				from sales.SalesOrderDetail
				group by SalesOrderID 
               )d
		on d.SalesOrderID = h.SalesOrderID
where h.SubTotal - d.LinesSum <> 0
order by h.SubTotal - d.LinesSum

/* 
Question 7
*/
--Explain on question number 6

/* 
Question 8
*/
select	p.ProductID,
		p.[name],
		p.ListPrice,
		p.ProductSubcategoryID,
		p.ListPrice - ac.avgCategoryPrice as diff

from Production.Product p
	join  ( select	ProductSubcategoryID,
				avg (ListPrice) avgCategoryPrice
			from Production.Product
			where ListPrice <> 0 and ProductSubcategoryID is not null
			group by ProductSubcategoryID
		  ) ac
		on p.ProductSubcategoryID = ac.ProductSubcategoryID
order by p.ProductSubcategoryID

