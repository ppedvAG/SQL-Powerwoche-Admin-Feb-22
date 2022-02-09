

SELECT      dbo.Customers.CustomerID, dbo.Customers.CompanyName, dbo.Customers.City, dbo.Customers.Country, 
				dbo.[Order Details].OrderID, dbo.Orders.OrderDate, dbo.Orders.Freight, dbo.[Order Details].ProductID, dbo.[Order Details].UnitPrice, dbo.[Order Details].Quantity, dbo.Products.ProductName
INTO KU
FROM         dbo.Customers INNER JOIN
                   dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID INNER JOIN
                   dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID INNER JOIN
                   dbo.Products ON dbo.[Order Details].ProductID = dbo.Products.ProductID
GO


insert into KU
select * from ku --bei 551000 Stop--> ca 1,1 Mio Ds

select * from ku where customerid = 'ALFKI'

alter table ku add id int identity

set statistics io, time on
select * from ku where id = 100
-- CPU-Zeit = 141 ms, verstrichene Zeit = 150 ms. 51478
--select 51478*8/1024 --402MB

--, CPU-Zeit = 0 ms, verstrichene Zeit = 0 ms...3 Seiten 


select * from ku where companyname like '%A%' --alle--SCAN
select * from ku where companyname like 'A%' --alle--SEEK

select * from ku where left(companyname,1 ) = 'A' ---->SCAN



