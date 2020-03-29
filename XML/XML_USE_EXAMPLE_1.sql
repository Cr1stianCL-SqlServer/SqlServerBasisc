use db_crosas2016


create table Usuario(
UsuarioIDc int identity,
UsuarioNOmbre nvarchar(50),
UsuarioNick nvarchar(50),
UsuarioClave nvarchar(1024)
);


insert into Usuario  values('','','')

select us



SELECt * FROM TableXML;

-----como xml
DECLARE @idoc int, @doc xml;
SET @doc =(select XmlContent from TableXML)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
SELECT *
FROM       OPENXML (@idoc,'Cesiones/DTECedido/DocumentoDTECedido/DTE/Documento/Encabezado/IdDoc/TipoDTE',50)
            WITH (
			TipoDTE varchar(20))

---como varchar

DECLARE @idoc int, @doc nvarchar(max)
SET @doc =(select  cast(XmlContent as nvarchar(max)) from TableXML)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
SELECT *
FROM       OPENXML (@idoc,'Cesiones/DTECedido/DocumentoDTECedido/DTE/Documento/Encabezado/IdDoc/TipoDTE',1)
            WITH (
			TipoDTE varchar(20))



----- Crear la tabla
CREATE TABLE [dbo].[TableXML](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [XmlContent] [xml] NOT NULL) -- especifica el tipo [xml] 
       
----- para guardar el xml como string
delete TableXML


 INSERT INTO [dbo].[TableXML]
 ([XmlContent])
VALUES
           ('<IdDoc>
<TipoDTE>33</TipoDTE>
<Folio>7206</Folio>
<FchEmis>2016-04-27</FchEmis>
<TermPagoGlosa>CREDITO 30 DIAS</TermPagoGlosa>
<FchVenc>2016-05-27</FchVenc>
</IdDoc>')

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)
SELECT @XML = [XmlContent] FROM [dbo].[TableXML]
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML
SELECT xmlns
FROM OPENXML(@hDoc, 'AEC')
WITH 
(
xmlns [varchar](50)'xmlns'
)
EXEC sp_xml_removedocument @hDoc
GO


			  
INSERT INTO TableXML(XmlContent)
SELECT CONVERT(XML, BulkColumn)
FROM OPENROWSET(BULK 'C:\Users\crosas\Desktop\schema_dte\DTE_v10.xsd', SINGLE_BLOB) AS x;


delete TableXML
CREATE XML SCHEMA COLLECTION 
			  
INSERT INTO TableXML(XmlContent)
SELECT CONVERT(XML,BulkColumn)
FROM OPENROWSET(BULK 'C:\Users\crosas\Desktop\schema_dte\DTE_v10.xsd', SINGLE_BLOB) AS x;


declare @xml as varchar(max)
set @xml=(select  cast(XmlContent as varchar(max)) from TableXML)
CREATE XML SCHEMA COLLECTION EmployeeSchema
AS @xml



