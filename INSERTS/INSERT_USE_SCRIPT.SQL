


--==========================================--
----------	INSERT SIMPLE TO TABLE	----------
--==========================================--

INSERT INTO [dbo].[Order] ([OrderDate],[OrderNumber],[CustomerId],[TotalAmount])
     VALUES
	 (GETDATE(),121345,1,3730.00),
	 (GETDATE(),121347,1,4000.00),
	 (GETDATE(),121348,1,5000.00)
GO

--==========================================--
----------	INSERT FROM TABLE	--------------
--==========================================--

INSERT INTO Customer_Historic
SELECT	TOP 10   Id
				,FirstName
				,LastName
				,City
				,Country
				,Phone
				,GETDATE()
				,'I'
FROM	Customer


--==================================================================--
----------	INSERT FROM TABLE TO TABLE SAME STRUCTURE	--------------
--==================================================================--
SELECT  Id
		,FirstName
		,LastName
		,City
		,Country
		,Phone
INTO Customer_bkp FROM Customer
