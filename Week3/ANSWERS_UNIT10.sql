--**********************************************
--****** Part 1 - Related Nested Queries *******
--				  Exist                  *******
--**********************************************

/* 
Question 1
*/
--A: Using In
select	ProductID, 
		[Name]
from Production.Product
where ProductID in (select ProductID 
					from Sales.SalesOrderDetail)
--B: Using Exist
select	ProductID,	
		[Name]
from Production.Product p
where exists (select ProductID 
			  from Sales.SalesOrderDetail d
			  where p.ProductID = d.ProductID)

/* 
Question 2
*/
select	p.[Name]
from Production.Product p
where exists  ( select *
				from Production.ProductSubcategory sb
				where sb.ProductSubcategoryID = p.ProductSubcategoryID
					and sb.[Name] ='Wheels'
				)

/* 
Question 3
*/
select *
from Person.Person p 
where exists (
				select * 
				from Sales.SalesOrderHeader h
					join Sales.Customer c
						on c.CustomerID = h.CustomerID
				where	p.BusinessEntityID = c.PersonID 
						and YEAR (OrderDate) = 2013
			 )

/* 
Question 4
*/
select	pe.BusinessEntityID,
		pe.LastName,
		pe.FirstName
from Person.Person pe 
	join Sales.Customer sc
		on pe.BusinessEntityID = sc.PersonID
where exists (
				select *
				from Sales.SalesOrderHeader sh
					join Sales.SalesOrderDetail sd
						on sh.SalesOrderID = sd.SalesOrderID
					join Production.Product pr
						on sd.ProductID = pr.ProductID
				where	pr.ProductSubcategoryID in (1, 2, 3) 
						and pr.StandardCost > 600
						and sh.CustomerID = sc.CustomerID
			)

/*
Answer: 
The query will return the numbers and names of the customers who bought products 
with a cost per item greater than 600 from sub-categories 1, 2 or 3.

The query enables us to obtain a list of customers that meet certain conditions, 
when the data being reviewed is in the customer table or other tables, 
without it being necessary to include the data from the tables.

The advantage of this method is that when we attach a table (using Join), 
if there is more than one matching record, the rows will be duplicated. 
This solution prevents this problem. 
*/


/* 
Question 5
*/
select *
from Sales.SalesPerson s
where exists	(
					select *
					from	Sales.SalesOrderHeader h
						join Sales.SalesOrderDetail d
							on h.SalesOrderID = d.SalesOrderID
						join Production.Product p
							on d.ProductID = p.ProductID
						join Production.ProductModel m
							on p.ProductModelID = m.ProductModelID
					where	m.[Name] like '%frame%'
							and s.BusinessEntityID = h.SalesPersonID
				)

/* 
Question 6
*/
--option A
select  p.LastName,
		p.FirstName,
		e.JobTitle,
		(	select count (*)
			from HumanResources.Employee
			where JobTitle = e.JobTitle) as AmountInDepartment
		
from HumanResources.Employee e
	left join Person.Person p
		on p.BusinessEntityID = e.BusinessEntityID

--option B
select  p.LastName,
		p.FirstName,
		e.JobTitle,
		dc.AmountInDepartment
		
from HumanResources.Employee e
	left join Person.Person p
		on p.BusinessEntityID = e.BusinessEntityID
	join (	select JobTitle,
					count (*) as AmountInDepartment
			from HumanResources.Employee
			group by JobTitle 
		  ) dc
		  on dc.JobTitle = e.JobTitle

