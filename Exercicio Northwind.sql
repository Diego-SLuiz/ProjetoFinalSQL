--Territórios por região

SELECT COUNT(TerritoryID) AS Territorios 
FROM Territories
GROUP BY RegionID;

--Ordens com mais de 50 unidades vendidas

SELECT Products.ProductName
FROM [Order Details]
INNER JOIN Products
ON [Order Details].ProductID = Products.ProductID
WHERE [Order Details].Quantity >50
GROUP BY Products.ProductName;

--Tempo médio de envio por cidade de destino

SELECT Orders.ShipCity AS Cidade,
	AVG(DATEDIFF(DAY, Orders.OrderDate, Orders.ShippedDate)) AS MediaDias
FROM Orders
GROUP BY Orders.ShipCity;

--Para cada empregado, exiba seu total de vendas em cada país

SELECT Employees.FirstName AS Nome,
	Customers.Country AS País,
	SUM([Order Details].Quantity) AS TotalVendas
FROM Employees 
	INNER JOIN Orders
	ON Employees.EmployeeID = Orders.EmployeeID
	INNER JOIN [Order Details]
	ON Orders.OrderID = [Order Details].OrderID
	INNER JOIN Customers
	ON Orders.CustomerID = Customers.CustomerID
GROUP BY Employees.FirstName,
	Customers.Country
ORDER BY Employees.FirstName

--Preço de cada pedido após descontos

SELECT Products.ProductName AS Produto, 
	[Order Details].UnitPrice * ROUND(1 - [Order Details].Discount, 2) AS Valor
FROM [Order Details]
	INNER JOIN Products
	ON [Order Details].ProductID = Products.ProductID

-- Crie uma view chamada ProductDetais que mostre o ProductID, 
-- CompanyName, CategoryName, Description, QuantityPerUnit, 
-- UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, 
-- Discontinued das tabelas Supplier, Products a Categories.

CREATE VIEW ProductDetails  AS (
	SELECT Products.ProductID,
		Suppliers.CompanyName,
		Categories.CategoryName,
		Categories.Description,
		Products.QuantityPerUnit,
		Products.UnitPrice,
		Products.UnitsInStock,
		Products.UnitsOnOrder,
		Products.ReorderLevel,
		Products.Discontinued
	FROM Products
		INNER JOIN Suppliers
		ON Products.SupplierID = Suppliers.SupplierID
		INNER JOIN Categories
		ON Products.CategoryID = Categories.CategoryID
)

SELECT * FROM ProductDetails;
