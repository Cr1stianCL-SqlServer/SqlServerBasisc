

 
SET NOCOUNT ON;    
  
DECLARE @Id int ,
		@ProductName varchar(100),
		@SupplierId int,
		@UnitPrice decimal,
		@Package nvarchar(60),
		@IsDiscontinued bit
  
PRINT '-------- [Product] --------';  
DECLARE product_cursor CURSOR FOR   
SELECT   [Id]
		,[ProductName]
		,[SupplierId]
		,[UnitPrice]
		,[Package]
		,[IsDiscontinued]
FROM	[Product] 
  
OPEN product_cursor 
	FETCH NEXT FROM product_cursor     
	INTO @Id,@ProductName,@SupplierId,@UnitPrice,@Package,@IsDiscontinued   
 
	WHILE @@FETCH_STATUS = 0    
	BEGIN    
		-->genera un cambio en el precio de un 30% MENOS
		print  'ANTES:' + convert(varchar,@UnitPrice);
		SET @UnitPrice = (@UnitPrice - (@UnitPrice*0.30));
		UPDATE [Product] SET UnitPrice = @UnitPrice WHERE Id = @Id
		print  'DESPUES:' + convert(varchar,@UnitPrice);
		      
		FETCH NEXT FROM product_cursor     
		INTO @Id,@ProductName,@SupplierId,@UnitPrice,@Package,@IsDiscontinued   
	END     
CLOSE product_cursor;    
DEALLOCATE product_cursor; 