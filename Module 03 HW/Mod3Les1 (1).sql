USE TSQL;

SELECT firstname, lastname, city, country
FROM HR.Employees
WHERE city = 'Seattle'
ORDER BY firstname DESC;