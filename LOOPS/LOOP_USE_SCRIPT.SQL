



--==========================================--
----------	USE FOR WHILE LOOP	----------
--==========================================--
DECLARE @INDEX INT = 0; -->DECLARACION DE INDICE
DECLARE @TOTAL_ROWS INT = (SELECT COUNT(1) FROM Product)

WHILE @INDEX < @TOTAL_ROWS
BEGIN
	SELECT 'VALOR PRODUCTO'+ ' '+ CONVERT(VARCHAR,@INDEX)+' '+'SELECCIONADO'
	SELECT UnitPrice FROM Product WHERE Id = @INDEX		
	SET @INDEX = @INDEX + 1
END
