CREATE FUNCTION [dbo].[fn_RemoveDiacritics] (
 @stringIncome varchar(max)
)   RETURNS varchar(max)
AS BEGIN
--DECLARE @stringIncome varchar(max)= 'a{{a123123123textàècontainingéìòaccentsçàèéìòù<>á';
DECLARE @StringResult VARCHAR(max);
DECLARE @string VARCHAR(1500);

-->QUITA LOS ACENTOS
select @StringResult= @stringIncome collate SQL_Latin1_General_Cp1251_CS_AS

-->QUITA LOS CARACTERES ESPECIALES
DECLARE @caracterToSplit CHAR='|';-->SEPARADOR DE CARACTERES
DECLARE @stringToSplit VARCHAR(MAX)='<|#|>|{|}'; -->CARACTERES NO DESEADOS
DECLARE @returnList TABLE (id int identity(1,1),caracter VARCHAR(1500))
DECLARE @CUENTA INT=0;
DECLARE @INDICE INT=0;
DECLARE @CARACTER CHAR = '';
DECLARE @name NVARCHAR(255)
DECLARE @pos INT

-->QUITA LOS CARACTERES SOLICITADOS
 WHILE CHARINDEX(@caracterToSplit, @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(@caracterToSplit, @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)
  INSERT INTO @returnList 
  SELECT @name
  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END
 INSERT INTO @returnList
 SELECT @stringToSplit

 SET @CUENTA = (SELECT COUNT(1) FROM @returnList)-->SETEA LA CANTIDAD DE CARACTERES A REMOVER
 IF(@CUENTA!=0)
 BEGIN
	SET @INDICE = 1;
	WHILE(@INDICE<=@CUENTA)-->RECORRE CARACTERES NO DESEADOS Y LOS ELIMINA
	BEGIN 
		SELECT  @CARACTER = (SELECT caracter from @returnList where id= @INDICE)
		SELECT @StringResult = REPLACE(@StringResult,@CARACTER,'')
		SET @INDICE = @INDICE + 1
	END
 END

 RETURN @StringResult

END


------>FORMA DE EJECUTAR FUNCION
/*
select [dbo].[fn_RemoveDiacritics]('a{{a123123123textàècontainingéìòaccentsçàèéìòù<>á')as diacriticts 
*/




                                  