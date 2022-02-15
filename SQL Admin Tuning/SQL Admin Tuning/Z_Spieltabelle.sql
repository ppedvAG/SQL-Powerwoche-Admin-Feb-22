use Northwind
GO

SELECT dbo.Customers.CustomerID, dbo.Customers.CompanyName, dbo.Customers.City, dbo.Customers.Country,
dbo.[Order Details].OrderID, dbo.Orders.OrderDate, dbo.Orders.Freight, dbo.[Order Details].ProductID, dbo.[Order Details].UnitPrice, dbo.[Order Details].Quantity, dbo.Products.ProductName
INTO KU
FROM dbo.Customers INNER JOIN
dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID INNER JOIN
dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID INNER JOIN
dbo.Products ON dbo.[Order Details].ProductID = dbo.Products.ProductID
GO


insert into ku
select * from KU
GO  8


alter table ku add id int identity
GO
