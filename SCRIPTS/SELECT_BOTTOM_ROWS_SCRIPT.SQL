



--==========================================--
----------	SELECT BOTTOM ROWS	----------
--==========================================--

SP_HELP PRODUCT

SELECT
			 FECHA
			,CODERR
			,CODTRAN			
			,RUT
			,DV			
			,INDICADOR		
			,NOMDES			
			,NOMBANCDES
FROM
(
     SELECT TOP 10
          *
     FROM
          LOGWEB_cold
     ORDER BY
          FECHA DESC
) SQ
ORDER BY
     FECHA ASC