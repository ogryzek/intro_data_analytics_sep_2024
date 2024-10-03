--*******************************************************
--****** Part 1 � XXX *******
--*******************************************************

/* 
Question 1
*/
--Supplier list
--answer: 104 rows in the table
select	BusinessEntityID,
		[Name],
		AccountNumber
from Purchasing.Vendor

 
/* 
Question 2
*/
--Show all vendors that their name ends with 'Company'
select	BusinessEntityID,
		[Name],
		AccountNumber
from Purchasing.Vendor
where [Name] like '%Company'


/* 
Question 3
*/
--purchase order header list
select	PurchaseOrderID,
		VendorID,
		OrderDate,
		TotalDue
from Purchasing.PurchaseOrderHeader


/* 
Question 4
*/
--purchase order header list with vendor's details
--answer: yes, all the vendors in the list,so we will use 'join' 
select	ph.PurchaseOrderID,
		ph.VendorID,
		v.[Name],
		ph.OrderDate,
		ph.TotalDue
from Purchasing.PurchaseOrderHeader ph
	left join Purchasing.Vendor v
		on ph.VendorID = v.BusinessEntityID


/* 
Question 5
*/
/*purchase order header list with vendor's details
  where the order was on 2012 and the vendor's name 
  starts with 'a-i' and ends with '2' */
--answer: no need to choose the column in the select clouse
select	ph.PurchaseOrderID,
		ph.VendorID,
		v.[Name],
		ph.OrderDate,
		ph.TotalDue,
		v.AccountNumber
from Purchasing.PurchaseOrderHeader ph
	left join Purchasing.Vendor v
		on ph.VendorID = v.BusinessEntityID
where v.AccountNumber like '[A-I]%2' and YEAR (ph.OrderDate)=2012


/* 
Question 6
*/
/*This query shows for each vendor, all the purchases order
  that was issued on 2012-2013  */
select	ph.PurchaseOrderID,
		ph.VendorID,
		v.[Name],
		ph.OrderDate,
		ph.TotalDue
from Purchasing.PurchaseOrderHeader ph
	join Purchasing.Vendor v
		on ph.VendorID = v.BusinessEntityID
where YEAR(ph.OrderDate) between 2012 and 2013
order by ph.VendorID, ph.OrderDate


/* 
Question 7
*/
-- Concentrate summery of the purchase order per supplier
select	VendorID,
		COUNT (*) as OrderAmount,
		SUM (TotalDue) as SumTotalDue
from Purchasing.PurchaseOrderHeader 
group by VendorID
order by SumTotalDue desc


/* 
Question 8
*/
-- Concentrate summery of the purchase order per supplier
--Option A
select	h.VendorID,
		COUNT (*) as OrderAmount,
		SUM (oq.SumStockedQty) as SumStockedQty,
		SUM (h.TotalDue) as SumTotalDue
from Purchasing.PurchaseOrderHeader h
	join (	select  PurchaseOrderID,
					SUM (StockedQty) as SumStockedQty
			from Purchasing.PurchaseOrderDetail
			group by PurchaseOrderID
	     ) oq
		on oq.PurchaseOrderID = h.PurchaseOrderID
group by h.VendorID
order by SumStockedQty desc

--Option B
with	StockedPerSupplier
		as	(
				select  PurchaseOrderID,
						SUM (StockedQty) as SumStockedQty
				from Purchasing.PurchaseOrderDetail
				group by PurchaseOrderID
			)

select	h.VendorID,
		COUNT (*) as OrderAmount,
		SUM (sps.SumStockedQty) as SumStockedQty,
		SUM (h.TotalDue) as SumTotalDue
from Purchasing.PurchaseOrderHeader h
	join StockedPerSupplier sps
		on sps.PurchaseOrderID = h.PurchaseOrderID
group by h.VendorID
order by SumStockedQty desc

/* 
Question 9
*/
/* Show who is the supplier of each productid
   can see here is there is more then 1 vendor for item */
select distinct pd.ProductID,
				ph.VendorID
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
order by ProductID


/* 
Question 10
*/
--How many productID supply each vendor

--Option A
select	pv.VendorID,
		COUNT (*) ProductSupply
		
from	(	select distinct pd.ProductID,
							ph.VendorID
			from Purchasing.PurchaseOrderDetail pd
				join Purchasing.PurchaseOrderHeader ph
					on pd.PurchaseOrderID = ph.PurchaseOrderID
		)pv
group by pv.VendorID
order by ProductSupply desc

--Option B
with	VendorsSupply
		as	(
				select distinct pd.ProductID,
								ph.VendorID
				from Purchasing.PurchaseOrderDetail pd
					join Purchasing.PurchaseOrderHeader ph
						on pd.PurchaseOrderID = ph.PurchaseOrderID
			)
select	VendorID,
		COUNT (*) ProductSupply
from	VendorsSupply
group by VendorID
order by ProductSupply desc


/* 
Question 11
*/
--Shows how many purchase ordered where in each shipment method
select	ph.PurchaseOrderID,
		ph.ShipMethodID,
		sm.[Name]
from Purchasing.PurchaseOrderHeader ph
	join Purchasing.ShipMethod sm
		on ph.ShipMethodID = sm.ShipMethodID

 
/* 
Question 12
*/
--How many purchase orders for each shipMethodID
select	ph.ShipMethodID,
		sm.[Name],
		COUNT (*) as NoOfOrders
from Purchasing.PurchaseOrderHeader ph
	join Purchasing.ShipMethod sm
		on ph.ShipMethodID = sm.ShipMethodID
group by ph.ShipMethodID, sm.[Name]
order by NoOfOrders desc


/* 
Question 13
*/
--How many purchase orders for each shipMethodID
--Show only method that more then 500 purchase orders was sent this way
select	ph.ShipMethodID,
		sm.[Name],
		COUNT (*) as NoOfOrders
from Purchasing.PurchaseOrderHeader ph
	join Purchasing.ShipMethod sm
		on ph.ShipMethodID = sm.ShipMethodID
group by ph.ShipMethodID, sm.[Name]
having COUNT (*) >500
order by NoOfOrders desc


/* 
Question 14
*/
/*How many purchase orders for each shipMethodID
  Show only method that more then 25 precect of 
  purchase orders was sent this way  */
select	ph.ShipMethodID,
		sm.[Name],
		COUNT (*) as NoOfOrders
from Purchasing.PurchaseOrderHeader ph
	join Purchasing.ShipMethod sm
		on ph.ShipMethodID = sm.ShipMethodID
group by ph.ShipMethodID, sm.[Name]
having COUNT (*) > (	select COUNT (*)
						from Purchasing.PurchaseOrderHeader 
					)/4
order by NoOfOrders desc


/* 
Question 15
*/
/*This query shows all the orders that a vendor didn't
  supply all the needed qty of goods on 2012  */
select	ph.VendorID,
		pd.ProductID,
		pd.OrderQty,
		pd.OrderQty - pd.StockedQty as LackQty
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
where YEAR (ph.OrderDate)=2012
order by ph.VendorID


/* 
Question 16
*/
/*This query shows all the orders that a vendor didn't
  supply all the needed qty of goods on 2012  */
select	ph.VendorID,
		pd.ProductID,
		pd.OrderQty,
		pd.OrderQty - pd.StockedQty as LackQty
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
where pd.OrderQty - pd.StockedQty > 0 and YEAR (ph.OrderDate)=2012
order by ph.VendorID


/* 
Question 17
*/
/* This query shows the qty ordered and the qty
	of lack items per vendor */
select	ph.VendorID,
		SUM (pd.OrderQty) as TotalQtyOrdered,
		SUM (pd.OrderQty - pd.StockedQty) as TotalLackQty
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
where YEAR (ph.OrderDate)=2012
group by ph.VendorID
order by TotalLackQty desc


/* 
Question 18
*/
/* This query shows the precent of lack qty 
   for the suppliers that didnt send all the ordered qty*/
select	ph.VendorID,
		SUM (pd.OrderQty) as TotalQtyOrdered,
		SUM (pd.OrderQty - pd.StockedQty) as TotalLackQty,
		SUM (pd.OrderQty - pd.StockedQty)/SUM (pd.OrderQty)*100 as LackPrecent
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
where YEAR (ph.OrderDate)=2012
group by ph.VendorID
having SUM (pd.OrderQty - pd.StockedQty) > 0
order by LackPrecent desc


/* 
Question 19
*/
-- show how many goods were stocked per productID
select	ProductID,
		SUM (StockedQty) as totalQtyStocked
from Purchasing.PurchaseOrderDetail
group by ProductID
order by totalQtyStocked desc


/* 
Question 20
*/
-- Show how many goods were stocked per productID
--Option A
select	p.ProductID,
		p.[Name],
		st.TotalQtyStocked
from Production.Product p
	join (	select	ProductID,
					SUM (StockedQty) as TotalQtyStocked
			from Purchasing.PurchaseOrderDetail
			group by ProductID
	     ) st
		on st.ProductID = p.ProductID
order by TotalQtyStocked desc

--Option B
select	distinct pd.ProductID,
		  p.[Name],
		  SUM (StockedQty) over (partition by pd.ProductID) as TotalQtyStocked
from Purchasing.PurchaseOrderDetail pd
	join Production.Product p
		on pd.ProductID = p.ProductID
order by TotalQtyStocked desc

--Option C
with	StockedItems
		as	(
				select	ProductID,
						SUM (StockedQty) as TotalQtyStocked
				from Purchasing.PurchaseOrderDetail
				group by ProductID
			)
select	p.ProductID,
		p.[Name],
		st.TotalQtyStocked
from Production.Product p
	join StockedItems st
		on st.ProductID = p.ProductID
order by TotalQtyStocked desc

/* 
Question 21
*/
--Split vendors to group according to the total purhase amount
select  VendorID,
		SUM (TotalDue) as SumTotalDue,
		NTILE (4) over (order by SUM (TotalDue) desc) as SuppGroup
from Purchasing.PurchaseOrderHeader
group by VendorID


/* 
Question 22
*/
/*Rank the suppliers according to the total purhase amount
  New rank for each year */
select  VendorID,
		YEAR (OrderDate) as OrderYear,
		SUM (TotalDue) as SumTotalDue,
		RANK () over (	partition by YEAR (OrderDate)
						order by SUM (TotalDue) desc) as YearlyRank
from Purchasing.PurchaseOrderHeader
group by VendorID, YEAR (OrderDate)
order by VendorID


/* 
Question 23
*/
-- show days to delivery per order
select	ph.PurchaseOrderID,
		ph.VendorID,
		ph.OrderDate,
		pd.DueDate,
		datediff (day, ph.OrderDate, pd.DueDate) as ShipDays
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
order by ShipDays desc


/* 
Question 24
*/
-- show average days to delivery for vendor
select  ph.VendorID,
		avg (datediff (day, ph.OrderDate, pd.DueDate)) as AvgShipDays
from Purchasing.PurchaseOrderDetail pd
	join Purchasing.PurchaseOrderHeader ph
		on pd.PurchaseOrderID = ph.PurchaseOrderID
group by ph.VendorID

