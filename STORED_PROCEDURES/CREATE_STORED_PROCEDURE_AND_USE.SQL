
--==========================================--
----------	SIMPLE PROCEDURE SELECT	----------
--==========================================--

CREATE PROCEDURE SPS_TOP_ORDERS_FILTER_BY_PRICE
@TOP INT,
@PRICE DECIMAL(12,9)
AS BEGIN
BEGIN TRY

	SELECT TOP(@TOP)	 Id
						,ProductName
						,SupplierId
						,UnitPrice
						,Package
						,IsDiscontinued
	FROM PRODUCT
	WHERE UnitPrice >= @PRICE
END TRY
BEGIN CATCH
		SELECT	ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS NUMBER,
				ERROR_LINE()AS LINE
END CATCH
END


/*
-->USAGE
EXECUTE SPS_TOP_ORDERS_FILTER_BY_PRICE 10,60
*/


--==========================================--
----------	SIMPLE PROCEDURE UPDATE ---------
--==========================================--

CREATE PROCEDURE SPU_ORDERS_BY_PACKAGE_IsDiscontinued
@PACKAGE VARCHAR(100)
AS BEGIN
BEGIN TRY

	UPDATE PRODUCT SET IsDiscontinued = 1
	WHERE Package LIKE '%'+@PACKAGE+'%'

END TRY
BEGIN CATCH
		SELECT	ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS NUMBER,
				ERROR_LINE()AS LINE
END CATCH
END


/*
-->USAGE
EXECUTE SPU_ORDERS_BY_PACKAGE_IsDiscontinued 'oz jars'

-->VERIFICATION
EXECUTE 
*/