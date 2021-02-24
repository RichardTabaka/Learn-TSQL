USE TSQL;
GO

SELECT c.contactname AS [Contact Name], c.custid AS [Customer ID], freight07 AS [2007 Highest Freight Cost], orderid07 AS [2007 Order ID],
	 orderdate07 AS [2007 Order Date], freight06 AS [2006 Highest Freight Cost], orderid06 AS [2006 Order ID], orderdate06 AS [2006 Order Date]
FROM Sales.Customers AS c
OUTER APPLY (SELECT MAX(freight) AS freight07
			 FROM Sales.Orders o
			 WHERE YEAR(orderdate) = '2007' AND o.custid = c.custid) AS mf07
OUTER APPLY (SELECT orderid AS orderid07, orderdate AS orderdate07
			 FROM Sales.Orders o
			 WHERE o.custid = c.custid AND o.freight = freight07) AS order07
OUTER APPLY (SELECT MAX(freight) AS freight06
			 FROM Sales.Orders o
			 WHERE YEAR(orderdate) = '2006' AND o.custid = c.custid) as mf06
OUTER APPLY (SELECT orderid AS orderid06, orderdate AS orderdate06
			 FROM Sales.Orders o
			 WHERE o.custid = c.custid AND o.freight = freight06) AS order06
ORDER BY custid;