USE TSQL;
GO
	
WITH CTE_2007 AS
	(
	SELECT o.custid, o.orderid AS orderidf07, freight07, o.orderdate AS orderdatef07
FROM Sales.Orders AS o
INNER JOIN (SELECT MAX(freight) as freight07, custid
			FROM Sales.Orders
			WHERE YEAR(orderdate) = '2007'
			GROUP BY custid) AS f07 ON f07.custid = o.custid AND freight = freight07
	),
	CTE_2006 AS
	(
	SELECT o.custid, o.orderid AS orderidf06, freight06, o.orderdate AS orderdatef06
FROM Sales.Orders AS o
INNER JOIN (SELECT MAX(freight) as freight06, custid
			FROM Sales.Orders
			WHERE YEAR(orderdate) = '2006'
			GROUP BY custid) AS f06 ON f06.custid = o.custid AND freight = freight06
	)
	SELECT c.contactname AS [Contact Name], c.custid AS [Customer ID], freight07 AS [2007 Highest Freight Cost], orderidf07 AS [2007 Order ID],
	 orderdatef07 AS [2007 Order Date], freight06 AS [2006 Highest Freight Cost], orderidf06 AS [2006 Order ID], orderdatef06 AS [2006 Order Date]
	FROM Sales.Customers AS c
	LEFT OUTER JOIN CTE_2007 ON CTE_2007.custid = c.custid
	FULL OUTER JOIN CTE_2006 ON CTE_2006.custid = c.custid
	-- Using ORDER BY contactname sorts by last name and first name on its own but to explicitly sort by first name you would add the rest of what I
	-- put in the ORDER BY statement
	ORDER BY contactname, SUBSTRING(contactname, CHARINDEX(' ', contactname), LEN(contactname));