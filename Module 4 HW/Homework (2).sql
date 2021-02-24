USE TSQL;

SELECT  c.contactname, c.fax, o.orderdate
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c ON o.custid = c.custid
WHERE c.city = 'London'
ORDER BY o.orderdate;