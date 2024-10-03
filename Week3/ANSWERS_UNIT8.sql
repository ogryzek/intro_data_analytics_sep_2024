--*****************************************************************************
--****** Part 1 - Built-in Aggregate Functions,							*******
--				  Built-in Functions on Number, Strings and dates Fields ******
--*****************************************************************************

/* 
Question 1
*/
select	MAX (OrderQty)
from Sales.SalesOrderDetail
--Answer: 44
 
/* 
Question 2
*/
select COUNT (distinct ProductID)
from Sales.SalesOrderDetail d
	join Sales.SalesOrderHeader h
		on d.SalesOrderID = h.SalesOrderID
where YEAR (h.OrderDate) = 2012
--Answer: 132

/* 
Question 3
*/
--Option A
select MAX (LEN (FirstName)) MaxLenFirstName
from Person.Person

--Option B
select LEN (FirstName) LenFirstName
from Person.Person
order by LenFirstName desc
--Answer: 24

/* 
Question 4
*/
select	SalesOrderID,
		OrderDate,
		YEAR (OrderDate) as SaleYear,
		MONTH (OrderDate) as SaleMonth,
		DATENAME (weekday, OrderDate) as SaleDayOfWeek
from Sales.SalesOrderHeader

/* 
Question 5
*/
select	DATENAME (weekday, OrderDate) as SaleDayOfWeek,
		COUNT (*) NoOfSales
from Sales.SalesOrderHeader
group by (DATENAME (weekday, OrderDate))
order by NoOfSales desc
--Answer: Monday

/* 
Question 6
*/
select	DATENAME (weekday, OrderDate) as SaleDayOfWeek,
		SUM (SubTotal) SalesAmount
from Sales.SalesOrderHeader
group by (DATENAME (weekday, OrderDate))
order by SalesAmount desc
--Answer: Monday

/* 
Question 7
*/
--Answer:
/*
The three most profitable days are also the days when the most orders were generated.
Subsequently, the order differs between the two queries.
This result can be due to the amount of orders.
There may have been a lot of orders on a given day, but each of the orders was for a relatively low amount. 
On the other hand, there may be one day a week with fewer orders, 
but the amounts of all the orders are relatively high, which causes a discrepancy.
*/


/* 
Question 8
*/
select	LEFT (p.ProductNumber, 2) ProductType,
		SUM (d.OrderQty) TotalQty, 
		SUM (d.LineTotal) TotalAmount
from Production.Product p
	join Sales.SalesOrderDetail d
		on p.ProductID = d.ProductID
group by LEFT (p.ProductNumber, 2)

/* 
Question 9
*/
select	LEFT (p.ProductNumber, 2) ProductType,
		s.[Name],
		SUM (d.OrderQty) TotalQty, 
		SUM (d.LineTotal) TotalAmount
from Production.Product p
	join Sales.SalesOrderDetail d
		on p.ProductID = d.ProductID
	join Production.ProductSubcategory s
		on p.ProductSubcategoryID = s.ProductSubcategoryID
group by LEFT (p.ProductNumber, 2), s.[Name]

/* 
Question 10
*/
select	CONCAT (pp.FirstName,' ', pp.MiddleName, ' ', pp.LastName) as FullNameConcat,
		pp.FirstName + ' ' + pp.MiddleName + ' ' + pp.LastName as 'FullName+',
		ph.PhoneNumber
from Person.Person pp
	left join Person.PersonPhone ph
		on pp.BusinessEntityID = ph.BusinessEntityID

/* 
Question 11
*/
select	CONCAT (p.FirstName,' ', p.MiddleName, ' ', p.LastName) as FullName,
		BirthDate,
		DATEDIFF(YYYY, e.BirthDate, GETDATE()) as Age
from HumanResources.Employee e
	left join Person.Person p
		on e.BusinessEntityID = p.BusinessEntityID


--****************************************
--****** Part 2 - Window Functions *******
--****************************************

/* 
Question 1
*/
select	LastName,
		FirstName 
from person.person
where lastName ='Adams' and FirstName like 'j%'
order by LastName, FirstName

 
/* 
Question 2
*/
select	LastName, 
		FirstName, 
		rank () over (	partition by lastname 
						order by firstname) as NameRank
from person.person
where lastName ='Adams' and FirstName like 'j%'
order by LastName, FirstName


/* 
Question 3
*/
select	LastName, 
		FirstName, 
		rank () over ( partition by lastname 
	 			 order by firstname) as NameRank,
		dense_rank () over ( partition by lastname 
					order by firstname) as NameDenseRank
from person.person
where lastName ='Adams' and FirstName like 'j%'
order by LastName, FirstName

/* 
Question 4
*/
select	SalesOrderID,
		OrderDate,
		SubTotal,
		dense_rank () over (	partition by OrderDate
								order by SubTotal desc) as DailyRank
from sales.SalesOrderHeader
where OrderDate between '2013-01-01' and '2013-01-02'


/* 
Question 5
*/
select	year (OrderDate) as 'Year',
		month(OrderDate)as 'Month',
		sum (SubTotal) as MonthlyTotalAmount,
		rank() over (	partition by year (OrderDate)
						order by sum (SubTotal) desc) as MonthRank
from sales.SalesOrderHeader
group by year (OrderDate), month(OrderDate)
order by year (OrderDate), MonthRank

/* 
Question 6
*/
select	year (OrderDate) as 'Year',
		month(OrderDate)as 'Month',
		format (sum (TotalDue), '#,###') as MonthlyTotalAmount,
		percent_rank() over (	partition by year (OrderDate)
								order by sum (TotalDue) ) as MonthPercentRank
from sales.SalesOrderHeader
group by year (OrderDate), month(OrderDate)
order by year (OrderDate), MonthPercentRank
