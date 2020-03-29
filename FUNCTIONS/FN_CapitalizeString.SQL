




CREATE FUNCTION [dbo].[fn_CapitalizeString]
(
 @stringIncome varchar(max)
)   RETURNS varchar(max)
AS BEGIN
	-->QUERY QUE HACE UPPER AL PRIMER CARACTER
	return UPPER(LEFT(@stringIncome,1))+LOWER(SUBSTRING(@stringIncome,2,LEN(@stringIncome)))
END

-->USO PRACTICO DE LA FUNCION
select [dbo].[fn_CapitalizeString]('capital letter')
