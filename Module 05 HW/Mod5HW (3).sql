USE TSQL;

SELECT contactname, fax, c.city, c.country, o.orderdate
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid
WHERE c.city IN (N'Reims', N'Paris')
 AND o.orderdate > '20071101'
 AND o.orderdate < '20071201'
ORDER BY orderdate;