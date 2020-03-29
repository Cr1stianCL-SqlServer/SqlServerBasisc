

--==========================================--
----------		DELETE SIMPLE		----------
--==========================================--
DECLARE @ID INT = (SELECT ID FROM Product where Package LIKE '%bags%' and IsDiscontinued = 1)
DELETE FROM  [OrderItem] where ProductId = @ID
DELETE FROM  Product where ID =@ID

--==========================================--
----------		DELETE JOIN		----------
--==========================================--

DELETE OI	
FROM [OrderItem] OI
INNER JOIN [Order] O ON O.CustomerId = OI.OrderId
INNER JOIN Product P ON OI.ProductId = P.Id
WHERE OI.UnitPrice < 7.30 
AND O.OrderDate < '2012-07-10 00:00:00.000'
AND P.IsDiscontinued = 1


