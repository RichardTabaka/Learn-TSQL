USE TSQL;
GO

-- This was my first WORKING version of the Query. (I think) It got the results the homework was looking for and did so in a way that made sense to me.
-- Unfortunately it didn't use correlated subqueries at all. It is re-done with subqueries below!

SELECT DISTINCT c.contactname AS [Contact Name], c.custid AS [Customer ID], freight07 AS [Highest 2007 Freight], orderidf07 AS [2007 Order ID],
				orderdatef07 AS [2007 Order Date], freight06 AS [Highest 2006 Freight], orderidf06 AS [2006 Order ID], orderdatef06 AS [2006 Order Date]
FROM Sales.Customers AS c
FULL OUTER JOIN Sales.Orders AS o ON o.custid = c.custid
FULL OUTER JOIN (SELECT o.custid, o.orderid AS orderidf07, freight07, o.orderdate AS orderdatef07
FROM Sales.Orders AS o
INNER JOIN (SELECT MAX(freight) as freight07, custid
			FROM Sales.Orders
			WHERE YEAR(orderdate) = '2007'
			GROUP BY custid) AS f07 ON f07.custid = o.custid AND freight = freight07) AS f2007 ON c.custid = f2007.custid
FULL OUTER JOIN (SELECT o.custid, o.orderid AS orderidf06, freight06, o.orderdate AS orderdatef06
FROM Sales.Orders AS o
INNER JOIN (SELECT MAX(freight) as freight06, custid
			FROM Sales.Orders
			WHERE YEAR(orderdate) = '2006'
			GROUP BY custid) AS f06 ON f06.custid = o.custid AND freight = freight06) AS f2006 ON c.custid = f2006.custid
ORDER BY c.custid

-- This version actually uses correlated subqueries in the SELECT statement:

SELECT c.contactname AS [Contact Name], c.custid AS [Customer ID], (SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2007' AND c.custid = Orders.custid) AS [Highest 2007 Freight],
		(SELECT orderid FROM Sales.Orders WHERE freight = (SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2007' AND c.custid = Orders.custid) AND custid = c.custid) AS [2007 Order ID],
		(SELECT orderdate FROM Sales.Orders WHERE freight = (SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2007' AND c.custid = Orders.custid) AND custid = c.custid) AS [2007 Order Date],
		(SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2006' AND c.custid = Orders.custid) AS [Highest 2006 Freight],
		(SELECT orderid FROM Sales.Orders WHERE freight = (SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2006' AND c.custid = Orders.custid) AND custid = c.custid) AS [2006 Order ID],
		(SELECT orderdate FROM Sales.Orders WHERE freight = (SELECT MAX(freight) FROM Sales.Orders WHERE YEAR(orderdate) = '2006' AND c.custid = Orders.custid) AND custid = c.custid) AS [2006 Order Date]
FROM Sales.Customers AS c