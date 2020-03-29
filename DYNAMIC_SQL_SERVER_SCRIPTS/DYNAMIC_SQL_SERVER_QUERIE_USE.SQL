

DECLARE @SQLString NVARCHAR(1000);
DECLARE @ParmDefinition NVARCHAR(1000);
DECLARE @SupplierId INT = 28;
DECLARE @ProductName VARCHAR(300);

SET @SQLString = N'SELECT ProductName FROM Product	WHERE SupplierId = @SupplierId';
EXEC sp_executesql @SQLString, N'@SupplierId INT,@ProductName varchar(300)OUTPUT', @SupplierId, @ProductName OUTPUT;

