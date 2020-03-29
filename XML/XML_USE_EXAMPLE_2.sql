select * from tb_documento_xml_prueba



SELECT  
       Tbl.Col.value('@IdInvernadero', 'smallint'),  
       Tbl.Col.value('@IdProducto', 'smallint'),  
       Tbl.Col.value('@IdCaracteristica1', 'smallint'),
       Tbl.Col.value('@IdCaracteristica2', 'smallint'),
       Tbl.Col.value('@Cantidad', 'int'),
       Tbl.Col.value('@Folio', 'varchar(7)')

FROM   @xml.nodes('//row') Tbl(Col)



DECLARE @XML XML
SET @XML =(select dxml_doc from tb_documento_xml_prueba)
DECLARE @handle INT  
DECLARE @PrepareXmlStatus INT 
EXEC @PrepareXmlStatus= sp_xml_preparedocument @handle OUTPUT,@XML

SELECT  *
FROM    OPENXML(@handle, '/rows/row', 2)  
    WITH (
    IdInvernadero INT,
    IdProducto INT,
    IdCaracteristica1 INT,
    IdCaracteristica2 INT,
    Cantidad INT,
    Folio INT
    )  

select cast(XMLCol as varchar(max))



DECLARE @idoc int, @doc nvarchar(max)
SET @doc =(select  cast(dxml_doc as nvarchar(max)) from tb_documento_xml_prueba)
--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
-- Execute a SELECT statement that uses the OPENXML rowset provider.
SELECT    *
FROM       OPENXML (@idoc,'/DocumentoAEC/IdDoc/TipoDTE',1)
            WITH (
			TipoDTE varchar(20),
			Folio varchar(20),
			FchEmis varchar(20),
			TermPagoGlosa varchar(20),
			FchVenc varchar(20));


--<TipoDTE>33</TipoDTE>
--<Folio>7203</Folio>
--<FchEmis>2016-04-22</FchEmis>
--<TermPagoGlosa>CREDITO 30 DIAS</TermPagoGlosa>
--<FchVenc>2016-05-22</FchVenc>
------------------------------------------------------
----------------------------------------------------
DECLARE @idoc int, @doc varchar(1000);
SET @doc =(select dxml_doc from tb_documento_xml_prueba)
--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
-- Execute a SELECT statement that uses the OPENXML rowset provider.
SELECT    *
FROM       OPENXML (@idoc, '/Cesiones',1)
            WITH (CustomerID  varchar(10),
                  ContactName varchar(20));


-----------------------------------------------------------------------------
----------------------------------------------------------------------------

DECLARE @idoc int, @doc varchar(max)
SET @doc =(select  cast(dxml_doc as varchar(max)) from tb_documento_xml_prueba)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
SELECT *
FROM       OPENXML (@idoc,'Cesiones/DTECedido/DocumentoDTECedido/DTE/Documento/Encabezado/IdDoc/TipoDTE',1)
            WITH (
			TipoDTE varchar(20))
select @doc
-----------------------------------------------------------------------------
----------------------------------------------------------------------------
DECLARE @idoc int, @doc xml;
SET @doc =(select dxml_doc from tb_documento_xml_prueba)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;
SELECT *
FROM       OPENXML (@idoc,'Cesiones/DTECedido/DocumentoDTECedido/DTE/Documento/Encabezado/IdDoc/TipoDTE',50)
            WITH (
			TipoDTE varchar(20))

			--------------------------------------------
			--------------------------------------------
DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML
SELECT TipoDTE
FROM OPENXML(@hDoc, 'Cesiones/DTECedido/DocumentoDTECedido/DTE/Documento/Encabezado/IdDoc/TipoDTE')
WITH 
(
TipoDTE [varchar](50) '@TipoDTE'
)
-----------------------------------------------------------------------------
----------------------------------------------------------------------------
DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)
SELECT @XML = [XmlContent] FROM [dbo].[TableXML]
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML
SELECT CustomerID, CustomerName, Address
FROM OPENXML(@hDoc, 'ROOT/Customers/Customer')
WITH 
(
CustomerID [varchar](50) '@CustomerID',
CustomerName [varchar](100) '@CustomerName',
Address [varchar](100) 'Address'
)		
-----------------------------------------------------------------------------
----------------------------------------------------------------------------

----- Crear la tabla
CREATE TABLE [dbo].[TableXML](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [XmlContent] [xml] NOT NULL –-- especifica el tipo [xml] 
       )
----- para guardar el xml como string

       INSERT INTO [dbo].[TableXML]
           ([XmlContent])
     VALUES
           ('<?xml version="1.0" encoding="UTF-8"?>
               <EventSchedule>
                 <Event Uid="2" Type="Main Event">
                   <IsFixed>True</IsFixed>
                   <EventKind>MainEvent</EventKind>
                   <Fields>
                     <Parameter Name="Type" Value="TV_Show"/>
                     <Parameter Name="Name" Value="The Muppets"/>
                     <Parameter Name="Duration" Value="00:30:00"/>
                   </Fields>
                </Event>
              </EventSchedule>')

-----------------------------------------------------------------------------
----------------------------------------------------------------------------

DECLARE @XML AS XML, @hDoc AS INT, @SQL NVARCHAR (MAX)
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
EXEC sp_xml_preparedocument @hDoc OUTPUT, @XML
SELECT *
FROM OPENXML(@hDoc, 'AEC/DocumentoAEC')
WITH 
(
Caratula[varchar](30)'@Caratula'
--RutCedente	[varchar](50)'RutCedente'
)
EXEC sp_xml_removedocument @hDoc
GO


		-----------------------------------------------------------------------------
----------------------------------------------------------------------------
-----------------------------------------------------------------------------
----------------------------------------------------------------------------



DECLARE @XML AS XML
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
SELECT
    RutCedente = Events.value('(RutCedente)[1]', 'varchar(20)'),
    RutCesionario = Events.value('(RutCesionario)[1]', 'varchar(20)'),
    NmbContacto =Events.value('(NmbContacto)[1]', 'varchar(20)'),
	TmstFirmaEnvio =Events.value('(TmstFirmaEnvio)[1]', 'varchar(20)')
FROM
 @XML.nodes('/AEC/DocumentoAEC/Caratula') AS XTbl(Events)



DECLARE @ProdID varchar(15)
DECLARE @XML AS XML
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
select @ProdID = @XML.value('(/Cars/Car[@id=5678]/Make)[1]', 'varchar(15)')as hola
SELECT @ProdID


DECLARE @ProdID int
DECLARE @XML AS XML
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
select @XML.value('(/AEC/DocumentoAEC[@ID="AEC_78636590-2T33F7206"]/Caratula[@version="1.0"]/RutCedente)[1]', 'int')as hola

SELECT
  @cars.value('(/Cars/Car[@id=5678]/Make)[1]', 'varchar(15)')
    AS Make,
  @cars.value('(/Cars/Car[@id=5678]/Model)[1]', 'varchar(15)')
    AS Model;

---------------------------------------------------------------
DECLARE @myDoc xml
DECLARE @ProdID float
SET @myDoc = '<Root>'
SET @ProdID =  @myDoc.value('(/Root/ProductDescription/@ProductID)[1]', 'float' )
SELECT @ProdID


  @cars.value('(/Cars/Car[@id=5678]/Make)[1]', 'varchar(15)')
float

<AEC xmlns="http://www.sii.cl/SiiDte" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sii.cl/SiiDte AEC_v10.xsd" version="1.0">
  <DocumentoAEC ID="AEC_78636590-2T33F7206">
    <Caratula version="1.0">
      <RutCedente>78636590-2</RutCedente>

DECLARE @xml xml;
SELECT @XML = dxml_doc FROM tb_documento_xml_prueba
SELECT xpath, value FROM dbo.xmlTable(@cars)
WHERE value is not null ORDER BY xpath


DECLARE @xml xml;
SET @xml =(select  cast(dxml_doc as varchar(max)) from tb_documento_xml_prueba)
SELECT xpath, value FROM dbo.xmlTable(@xml)
WHERE value is not null ORDER BY xpath

delete TableXML
CREATE XML SCHEMA COLLECTION 
			  
INSERT INTO TableXML(XmlContent)
SELECT CONVERT(XML,BulkColumn)
FROM OPENROWSET(BULK 'C:\Users\crosas\Desktop\schema_dte\DTE_v10.xsd', SINGLE_BLOB) AS x;
---------------------------------------------------------------

---------------------------------------------------------------


INSERT INTO TableXML(XmlContent)
SELECT CONVERT(XML SCHEMA COLLECTION BulkColumn)
FROM OPENROWSET(BULK 'C:\Users\crosas\Desktop\schema_dte\DTE_v10.xsd', SINGLE_BLOB) AS x;

CREATE XML SCHEMA COLLECTION EmployeeSchema
    AS'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element >
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element />
                <xsd:element />
                <xsd:element />
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>'


CREATE XML SCHEMA COLLECTION dtechema
AS'<xs:schema  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:SiiDte="http://www.sii.cl/SiiDte" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="DTE"/>
	<xs:complexType name="DTEDefType">
		<xs:annotation>
			<xs:documentation>Documento Tributario Electronico</xs:documentation>
		</xs:annotation>
		<xs:sequence>
			<xs:choice>
				<xs:element name="Documento">
					<xs:annotation>
						<xs:documentation>Informacion Tributaria del DTE</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Encabezado">
								<xs:annotation>
									<xs:documentation>Identificacion y Totales del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="IdDoc">
											<xs:annotation>
												<xs:documentation>Identificacion del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoDTE" type="SiiDte:DTEType">
														<xs:annotation>
															<xs:documentation>Tipo de DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Folio" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio del Documento Electronico</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FchEmis" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision Contable del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IndNoRebaja" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Nota de Credito sin Derecho a Descontar Debito</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Nota de Credito sin Derecho a Descontar Debito</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TipoDespacho" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica Modo de Despacho de los Bienes que Acompanan al DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Comprador</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Emisor a Instalaciones del Comprador</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Emisor a Otras Instalaciones</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IndTraslado" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Incluido en Guias de Despacho para Especifiicar el Tipo de Traslado de Productos</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Operacion Constituye Venta</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Venta por Efectuar</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Consignacion</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="4">
																	<xs:annotation>
																		<xs:documentation>Promocion  o Donacion (RUT Emisor = RUT Receptor)</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="5">
																	<xs:annotation>
																		<xs:documentation>Traslado Interno</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="6">
																	<xs:annotation>
																		<xs:documentation>Otros Traslados que no Constituyen Venta</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="7">
																	<xs:annotation>
																		<xs:documentation>Guia de Devolucion</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="8"/>
																<xs:enumeration value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TpoImpresion" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo de impresión N (Normal)  o T (Ticket) </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:length value="1"/>
																<xs:enumeration value="N"/>
																<xs:enumeration value="T"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IndServicio" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica si Transaccion Corresponde a la Prestacion de un Servicio</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Facturacion de Servicios Periodicos Domiciliarios</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Facturacion de Otros Servicios Periodicos</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Factura de Servicio</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MntBruto" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica el Uso de Montos Brutos en Detalle</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Monto de Lineas de Detalle  Corresponde a Valores Brutos (IVA + Impuestos Adicionales)</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FmaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Forma de Pago del DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Pago Contado</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Pago Credito</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Sin Costo</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FmaPagExp" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Forma de Pago Exportación Tabla Formas de Pago de Aduanas</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchCancel" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Cancelacion del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntCancel" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Cancelado al   emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SaldoInsol" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Saldo Insoluto al       emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntPagos" minOccurs="0" maxOccurs="30">
														<xs:annotation>
															<xs:documentation>Tabla de Montos de Pago</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="FchPago" type="SiiDte:FechaType">
																	<xs:annotation>
																		<xs:documentation>Fecha de Pago (AAAA-MM-DD)</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MntPago" type="SiiDte:MontoType">
																	<xs:annotation>
																		<xs:documentation>Monto de Pago</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="GlosaPagos" minOccurs="0">
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="PeriodoDesde" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo de Facturacion - Desde (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="PeriodoHasta" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo Facturacion - Hasta (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MedioPago" type="SiiDte:MedioPagoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Medio de Pago</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TpoCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo Cuenta de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
																<xs:minLength value="5"/>
																<xs:enumeration value="AHORRO"/>
																<xs:enumeration value="CORRIENTE"/>
																<xs:enumeration value="VISTA"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="NumCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Número de la cuenta del pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="BcoPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Banco donde se realiza el pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoCdg" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Termino de Pago Acordado</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoGlosa" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Términos del Pago - glosa</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoDias" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Dias de Acuerdo al Codigo de Termino de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchVenc" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Vencimiento del Pago (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Emisor">
											<xs:annotation>
												<xs:documentation>Datos del Emisor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTEmisor" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Emisor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RznSoc">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Emisor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:RznSocLargaType"/>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GiroEmis">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Emisor Relevante para el DTE </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Telefono" minOccurs="0" maxOccurs="2">
														<xs:annotation>
															<xs:documentation>Telefono Emisor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:FonoType">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoEmisor" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Acteco" maxOccurs="4">
														<xs:annotation>
															<xs:documentation>Codigo de Actividad Economica del Emisor Relevante para el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="6"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GuiaExport" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Emisor de una Guía de despacho para Exportación </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="CdgTraslado" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código Emisor Traslado Excepcional  </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="1"/>
																			<xs:enumeration value="1"/>
																			<xs:enumeration value="2"/>
																			<xs:enumeration value="3"/>
																			<xs:enumeration value="4"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="FolioAut" type="SiiDte:NroResolType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Folio Autorización ( N° de Resolución del SI)</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="FchAut" type="SiiDte:FechaType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Fecha de emisión de la Resolución de autorización (AAAA-MM-DD)</xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Sucursal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Sucursal que Emite el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CdgSIISucur" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo de Sucursal Entregado por el SII</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DirOrigen" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion de Origen</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaOrigen" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadOrigen" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgVendedor" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Vendedor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="60"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IdAdicEmisor" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Identificador Adicional del Emisor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RUTMandante" type="SiiDte:RUTType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>RUT a Cuenta de Quien se Emite el DTE</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="Receptor">
											<xs:annotation>
												<xs:documentation>Datos del Receptor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTRecep" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Receptor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgIntRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo Interno del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RznSocRecep" type="SiiDte:RznSocLargaType">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Extranjero" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Receptor Extranjero</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="NumId" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Num. Identif. Receptor Extranjero</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Nacionalidad" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nacionalidad Receptor Extranjero</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="3"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="GiroRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Contacto" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Telefono o E-mail de Contacto del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoRecep" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion en la Cual se Envian los Productos o se Prestan los Servicios</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaRecep" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadRecep" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirPostal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion Postal</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaPostal" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadPostal" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RUTSolicita" type="SiiDte:RUTType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>RUT que solicita el DTE en Venta a Publico</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="Transporte" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Informacion de Transporte de Mercaderias</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Patente" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Patente del Vehiculo que Transporta los Bienes</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="8"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RUTTrans" type="SiiDte:RUTType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>RUT del Transportista</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Chofer" minOccurs="0">
														<xs:complexType>
															<xs:sequence>
																<xs:element name="RUTChofer" type="SiiDte:RUTType">
																	<xs:annotation>
																		<xs:documentation>RUT del Chofer</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="NombreChofer">
																	<xs:annotation>
																		<xs:documentation>Nombre del Chofer</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="30"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="DirDest" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion de Destino</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaDest" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Destino</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadDest" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Destino</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Aduana" minOccurs="0">
														<xs:annotation>
															<xs:documentation>documentos de Exportación y guías de despacho </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="CodModVenta" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código según  tabla "Modalidad de Venta" de aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodClauVenta" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código según  Tabla "Cláusula compra-venta" de  Aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotClauVenta" type="SiiDte:Dec16_2Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Total  Cláusula de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="CodViaTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Indicar el Código de la vía de transporte utilizada para transportar la mercadería, según tabla Vías de Transporte de Aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="NombreTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nombre o Identificación del Medio de Transporte</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="RUTCiaTransp" type="SiiDte:RUTType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Rut Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="NomCiaTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nombre Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Booking" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Numero de reserva del Operador</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Operador" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del Operador</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPtoEmbarque" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del puerto de embarque según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="4"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicPtoEmb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Puerto de Embarque</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPtoDesemb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del puerto de desembarque según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="4"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicPtoDesemb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Puerto de Desembarque</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Tara" minOccurs="0">
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="7"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidMedTara" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="PesoBruto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Sumatoria de los pesos brutos de todos los ítems del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:totalDigits value="10"/>
																			<xs:fractionDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidPesoBruto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="PesoNeto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Sumatoria de los pesos netos de todos los ítems del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:totalDigits value="10"/>
																			<xs:fractionDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidPesoNeto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotItems" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Indique el total de items del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="18"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotBultos" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Cantidad total de bultos que ampara el documento.</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="18"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TipoBultos" minOccurs="0" maxOccurs="10">
																	<xs:annotation>
																		<xs:documentation>Tabla de descripción de los distintos tipos de bultos</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="CodTpoBultos" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Código según  tabla "Tipos de Bultos" de aduana</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:positiveInteger">
																						<xs:totalDigits value="3"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="CantBultos" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Cantidad de Bultos </xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:positiveInteger">
																						<xs:totalDigits value="10"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Marcas" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Identificación de marcas, cuando es distinto de contenedor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="255"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="IdContainer" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Se utiliza cuando el tipo de bulto es contenedor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="25"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Sello" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Sello contenedor. Con digito verificador</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="20"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="EmisorSello" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Nombre emisor sello</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="70"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="MntFlete" type="SiiDte:Dec14_4Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Monto del flete según moneda de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MntSeguro" type="SiiDte:Dec14_4Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Monto del seguro , según moneda de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="CodPaisRecep" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del país del receptor extranjero de la mercadería,
según tabla Países aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPaisDestin" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del país de destino extranjero de la mercadería,
según tabla Países aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Totales">
											<xs:annotation>
												<xs:documentation>Montos Totales del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="MntNeto" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Neto del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntExe" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Exento del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntBase" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Base Faenamiento Carne</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntMargenCom" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Base de Márgenes de Comercialización. Monto informado</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TasaIVA" type="SiiDte:PctType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tasa de IVA</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVA" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto de IVA del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVAProp" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto del IVA propio</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVATerc" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto del IVA de Terceros</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ImptoReten" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Impuestos y Retenciones Adicionales</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="TipoImp" type="SiiDte:ImpAdicDTEType">
																	<xs:annotation>
																		<xs:documentation>Tipo de Impuesto o Retencion Adicional</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="TasaImp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Tasa de Impuesto o Retencion</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="SiiDte:PctType">
																			<xs:maxInclusive value="100.00"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MontoImp" type="SiiDte:MntImpType">
																	<xs:annotation>
																		<xs:documentation>Monto del Impuesto o Retencion</xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="IVANoRet" type="SiiDte:MntImpType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>IVA No Retenido</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CredEC" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Credito Especial Empresas Constructoras</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="GrntDep" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Garantia por Deposito de Envases o Embalajes</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Comisiones" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comisiones y otros cargos es obligatoria para Liquidaciones Factura </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ValComNeto" type="SiiDte:MontoType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Valor Neto Comisiones y Otros Cargos</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="ValComExe" type="SiiDte:MontoType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Val. Comis. y Otros Cargos no Afectos o Exentos</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="ValComIVA" type="SiiDte:MontoType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Valor IVA Comisiones y Otros Cargos  </xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="MntTotal" type="SiiDte:MontoType">
														<xs:annotation>
															<xs:documentation>Monto Total del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MontoNF" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto No Facturable - Corresponde a Bienes o Servicios Facturados Previamente</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MontoPeriodo" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Total de Ventas o Servicios del Periodo</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SaldoAnterior" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Saldo Anterior - Puede ser Negativo o Positivo</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="VlrPagar" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Valor a Pagar Total del documento</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="OtraMoneda" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Otra Moneda </xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoMoneda" type="SiiDte:TipMonType">
														<xs:annotation>
															<xs:documentation>Tipo Ottra moneda Tabla de Monedas  de Aduanas</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TpoCambio" type="SiiDte:Dec6_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo de Cambio fijado por el Banco Central de Chile</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntNetoOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Neto del DTE en Otra Moneda  </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntExeOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Exento del DTE en Otra Moneda  </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntFaeCarneOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Base Faenamiento Carne en Otra Moneda  </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntMargComOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Base de Márgenes de Comercialización. Monto informado</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVAOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto de IVA del DTE en Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ImpRetOtrMnda" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Impuestos y Retenciones Adicionales</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="TipoImpOtrMnda" type="SiiDte:ImpAdicDTEType">
																	<xs:annotation>
																		<xs:documentation>Tipo de Impuesto o Retencion Adicional</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="TasaImpOtrMnda" type="SiiDte:PctType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Tasa de Impuesto o Retencion</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="VlrImpOtrMnda" type="SiiDte:Dec14_4Type">
																	<xs:annotation>
																		<xs:documentation>Valor del impuesto o retención en otra moneda </xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="IVANoRetOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>IVA no retenido Otra Moneda </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntTotOtrMnda" type="SiiDte:Dec14_4Type">
														<xs:annotation>
															<xs:documentation>Monto Total Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Detalle" maxOccurs="60">
								<xs:annotation>
									<xs:documentation>Detalle de Itemes del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinDet">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CdgItem" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Codificacion del Item</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoCodigo">
														<xs:annotation>
															<xs:documentation>Tipo de Codificacion</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="VlrCodigo">
														<xs:annotation>
															<xs:documentation>Valor del Codigo de Item, para la Codificacion Particular</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="IndExe" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indicador de Exencion/Facturacion</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ESTA Afecto a IVA</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ES Facturable</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Garantia por Deposito/Envase</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="4">
														<xs:annotation>
															<xs:documentation>El producto No Constituye Venta</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="5">
														<xs:annotation>
															<xs:documentation>Item a Rebajar</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="6">
														<xs:annotation>
															<xs:documentation>No facturables negativos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Retenedor" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Sólo para transacciones realizadas por agentes retenedores</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="IndAgente">
														<xs:annotation>
															<xs:documentation>Indicador Agente Retenedor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="1"/>
																<xs:enumeration value="R"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MntBaseFaena" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Base Faenamiento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntMargComer" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Márgenes de Comercialización</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="PrcConsFinal" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Precio Unitario Neto Consumidor Final</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="NmbItem">
											<xs:annotation>
												<xs:documentation>Nombre del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="80"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="DscItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Descripcion del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="1000"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="QtyRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad para la Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario de Referencia para Unidad de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="QtyItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="Subcantidad" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Distribucion de la Cantidad</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="SubQty" type="SiiDte:Dec12_6Type">
														<xs:annotation>
															<xs:documentation>Cantidad  Distribuida</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SubCod">
														<xs:annotation>
															<xs:documentation>Codigo Descriptivo de la Subcantidad</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FchElabor" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Elaboracion del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="FchVencim" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Vencimiento del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario del Item en Pesos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="OtrMnda" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio del Item en Otra Moneda</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="PrcOtrMon" type="SiiDte:Dec12_6Type">
														<xs:annotation>
															<xs:documentation>Precio Unitario en Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Moneda">
														<xs:annotation>
															<xs:documentation>Codigo de Otra Moneda (Usar Codigos de Moneda del Banco Central)</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FctConv" type="SiiDte:Dec6_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Factor  para Conversion a Pesos</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DctoOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Descuento en Otra Moneda </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RecargoOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Recargo en Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MontoItemOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Valor por línea de detalle en Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="DescuentoPct" type="SiiDte:PctType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Porcentaje de Descuento</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="DescuentoMonto" type="SiiDte:MntImpType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Monto de Descuento</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubDscto" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Desglose del Descuento</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoDscto" type="SiiDte:DineroPorcentajeType">
														<xs:annotation>
															<xs:documentation>Tipo de SubDescuento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ValorDscto" type="SiiDte:Dec16_2Type">
														<xs:annotation>
															<xs:documentation>Valor del SubDescuento</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RecargoPct" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Porcentaje de Recargo</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="SiiDte:PctType">
													<xs:maxInclusive value="999.99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="RecargoMonto" type="SiiDte:MntImpType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Monto de Recargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubRecargo" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Desglose del Recargo</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoRecargo" type="SiiDte:DineroPorcentajeType">
														<xs:annotation>
															<xs:documentation>Tipo de SubRecargo</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ValorRecargo" type="SiiDte:Dec16_2Type">
														<xs:annotation>
															<xs:documentation>Valor de SubRecargo</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="CodImpAdic" type="SiiDte:ImpAdicDTEType" minOccurs="0" maxOccurs="2">
											<xs:annotation>
												<xs:documentation>Codigo de Impuesto Adicional o Retencion</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="MontoItem" type="SiiDte:MontoType">
											<xs:annotation>
												<xs:documentation>Monto por Linea de Detalle. Corresponde al Monto Neto, a menos que MntBruto Indique lo Contrario </xs:documentation>
											</xs:annotation>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="SubTotInfo" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Subtotales Informativos</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroSTI">
											<xs:annotation>
												<xs:documentation>Número de Subtotal </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GlosaSTI">
											<xs:annotation>
												<xs:documentation>Glosa</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="40"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OrdenSTI" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Ubicación para Impresión </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubTotNetoSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor Neto del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotIVASTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor del IVA del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotAdicSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de los Impuestos adicionales o específicos del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotExeSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor no Afecto o Exento del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValSubtotSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de la línea de subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="LineasDeta" minOccurs="0" maxOccurs="60">
											<xs:annotation>
												<xs:documentation>TABLA de  Líneas de Detalle que se agrupan en el Subtotal</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger"/>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="DscRcgGlobal" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Descuentos y/o Recargos que afectan al total del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinDR" type="xs:positiveInteger">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="TpoMov">
											<xs:annotation>
												<xs:documentation>Tipo de Movimiento</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:minLength value="1"/>
													<xs:maxLength value="1"/>
													<xs:enumeration value="D">
														<xs:annotation>
															<xs:documentation>Descuento</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="R">
														<xs:annotation>
															<xs:documentation>Recargo</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GlosaDR" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Descripcion del Descuento o Recargo</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="45"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TpoValor" type="SiiDte:DineroPorcentajeType">
											<xs:annotation>
												<xs:documentation>Unidad en que se Expresa el Valor</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValorDR" type="SiiDte:Dec16_2Type">
											<xs:annotation>
												<xs:documentation>Valor del Descuento o Recargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValorDROtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor en otra moneda</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="IndExeDR" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indica si el D/R es No Afecto o No Facturable</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>Descuento/Recargo Global No Afecto</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>Descuento/Recargo No Facturable</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Referencia" minOccurs="0" maxOccurs="40">
								<xs:annotation>
									<xs:documentation>Identificacion de otros documentos Referenciados por Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinRef">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TpoDocRef">
											<xs:annotation>
												<xs:documentation>Tipo de Documento de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="3"/>
													<xs:minLength value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IndGlobal" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indica que se esta Referenciando un Conjunto de Documentos</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:nonNegativeInteger">
													<xs:totalDigits value="1"/>
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Documento hace Referencia a un Conjunto de Documentos Tributarios del Mismo Tipo</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="FolioRef" type="SiiDte:FolioRType">
											<xs:annotation>
												<xs:documentation>Folio del Documento de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="RUTOtr" type="SiiDte:RUTType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>RUT Otro Contribuyente</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="FchRef" type="SiiDte:FechaType">
											<xs:annotation>
												<xs:documentation>Fecha de la Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="CodRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Tipo de Uso de la Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>Anula Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>Corrige Texto del Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Corrige Montos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="RazonRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Razon Explicita por la que se Referencia el Documento</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="90"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Comisiones" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Comisiones y otros cargos es obligatoria para Liquidaciones Factura </xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinCom">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="20"/>
													<xs:minInclusive value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TipoMovim">
											<xs:annotation>
												<xs:documentation>C (comisión) u O (otros cargos)</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:minLength value="1"/>
													<xs:enumeration value="C"/>
													<xs:enumeration value="O"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Glosa">
											<xs:annotation>
												<xs:documentation>Especificación de la comisión u otro  cargo</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="60"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TasaComision" type="SiiDte:PctType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor porcentual de la comisión u otro cargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComNeto" type="SiiDte:MontoType">
											<xs:annotation>
												<xs:documentation>Valor Neto Comisiones y Otros Cargos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComExe" type="SiiDte:MontoType">
											<xs:annotation>
												<xs:documentation>Val. Comis. y Otros Cargos no Afectos o Exentos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComIVA" type="SiiDte:MontoType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor IVA Comisiones y Otros Cargos  </xs:documentation>
											</xs:annotation>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TED">
								<xs:annotation>
									<xs:documentation>Timbre Electronico de DTE</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="DD">
											<xs:annotation>
												<xs:documentation>Datos Basicos de Documento</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RE" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Emisor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TD" type="SiiDte:DTEType">
														<xs:annotation>
															<xs:documentation>Tipo DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="F" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FE" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision DTE en Formato AAAA-MM-DD</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RR" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RSR">
														<xs:annotation>
															<xs:documentation>Razon Social Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MNT" type="xs:unsignedLong">
														<xs:annotation>
															<xs:documentation>Monto Total DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IT1">
														<xs:annotation>
															<xs:documentation>Descripcion Primer Item de Detalle</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CAF">
														<xs:annotation>
															<xs:documentation>Codigo Autorizacion Folios</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="DA">
																	<xs:annotation>
																		<xs:documentation>Datos de Autorizacion de Folios</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="RE" type="SiiDte:RUTType">
																				<xs:annotation>
																					<xs:documentation>RUT Emisor</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RS">
																				<xs:annotation>
																					<xs:documentation>Razon Social Emisor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:minLength value="1"/>
																						<xs:maxLength value="40"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="TD" type="SiiDte:DTEType">
																				<xs:annotation>
																					<xs:documentation>Tipo DTE</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RNG">
																				<xs:annotation>
																					<xs:documentation>Rango Autorizado de Folios</xs:documentation>
																				</xs:annotation>
																				<xs:complexType>
																					<xs:sequence>
																						<xs:element name="D" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Inicial (Desde)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																						<xs:element name="H" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Final (Hasta)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																					</xs:sequence>
																				</xs:complexType>
																			</xs:element>
																			<xs:element name="FA" type="SiiDte:FechaType">
																				<xs:annotation>
																					<xs:documentation>Fecha Autorizacion en Formato AAAA-MM-DD</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:choice>
																				<xs:element name="RSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica RSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="M" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="E" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Exponente RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																				<xs:element name="DSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica DSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="P" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo Primo</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Q" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero Divisor de P - 1</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="G" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero f(P, Q)</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Y" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>G**X mod P</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																			</xs:choice>
																			<xs:element name="IDK" type="xs:long">
																				<xs:annotation>
																					<xs:documentation>Identificador de Llave</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="FRMA">
																	<xs:annotation>
																		<xs:documentation>Firma Digital (RSA) del SII Sobre DA</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:simpleContent>
																			<xs:extension base="xs:base64Binary">
																				<xs:attribute name="algoritmo" type="xs:string" use="required" fixed="SHA1withRSA"/>
																			</xs:extension>
																		</xs:simpleContent>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
															<xs:attribute name="version" use="required" fixed="1.0"/>
														</xs:complexType>
													</xs:element>
													<xs:element name="TSTED" type="SiiDte:FechaHoraType">
														<xs:annotation>
															<xs:documentation>TimeStamp de Generacion del Timbre</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FRMT">
											<xs:annotation>
												<xs:documentation>Valor de Firma Digital  sobre DD</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:simpleContent>
													<xs:extension base="xs:base64Binary">
														<xs:attribute name="algoritmo" use="required">
															<xs:simpleType>
																<xs:restriction base="xs:string">
																	<xs:enumeration value="SHA1withRSA"/>
																	<xs:enumeration value="SHA1withDSA"/>
																</xs:restriction>
															</xs:simpleType>
														</xs:attribute>
													</xs:extension>
												</xs:simpleContent>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
									<xs:attribute name="version" use="required" fixed="1.0"/>
								</xs:complexType>
							</xs:element>
							<xs:element name="TmstFirma" type="SiiDte:FechaHoraType">
								<xs:annotation>
									<xs:documentation>Fecha y Hora en que se Firmo Digitalmente el Documento AAAA-MM-DDTHH:MI:SS</xs:documentation>
								</xs:annotation>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="ID" type="xs:ID" use="required"/>
					</xs:complexType>
				</xs:element>
				<xs:element name="Liquidacion">
					<xs:annotation>
						<xs:documentation>Informacion Tributaria de Liquidaciones</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Encabezado">
								<xs:annotation>
									<xs:documentation>Identificacion y Totales del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="IdDoc">
											<xs:annotation>
												<xs:documentation>Identificacion del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoDTE" type="SiiDte:LIQType">
														<xs:annotation>
															<xs:documentation>Tipo de DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Folio" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio del Documento Electronico</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FchEmis" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision Contable del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IndServicio" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica si Transaccion Corresponde a la Prestacion de un Servicio</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Facturacion de Servicios Periodicos Domiciliarios</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Facturacion de Otros Servicios Periodicos</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Factura de Servicio</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MntBruto" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica el Uso de Montos Brutos en Detalle</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Monto de Lineas de Detalle  Corresponde a Valores Brutos (IVA + Impuestos Adicionales)</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FmaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Forma de Pago del DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Pago Contado</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Pago Credito</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Sin Costo</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchCancel" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Cancelacion del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntCancel" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Cancelado al   emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SaldoInsol" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Saldo Insoluto al       emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntPagos" minOccurs="0" maxOccurs="30">
														<xs:annotation>
															<xs:documentation>Tabla de Montos de Pago</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="FchPago" type="SiiDte:FechaType">
																	<xs:annotation>
																		<xs:documentation>Fecha de Pago (AAAA-MM-DD)</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MntPago" type="SiiDte:MontoType">
																	<xs:annotation>
																		<xs:documentation>Monto de Pago</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="GlosaPagos" minOccurs="0">
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="PeriodoDesde" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo de Facturacion - Desde (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="PeriodoHasta" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo Facturacion - Hasta (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MedioPago" type="SiiDte:MedioPagoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Medio de Pago</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TpoCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo Cuenta de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
																<xs:minLength value="5"/>
																<xs:enumeration value="AHORRO"/>
																<xs:enumeration value="CORRIENTE"/>
																<xs:enumeration value="VISTA"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="NumCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Número de la cuenta del pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="BcoPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Banco donde se realiza el pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoCdg" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Termino de Pago Acordado</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoGlosa" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Términos del Pago - glosa</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoDias" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Dias de Acuerdo al Codigo de Termino de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchVenc" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Vencimiento del Pago (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Emisor">
											<xs:annotation>
												<xs:documentation>Datos del Emisor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTEmisor" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Emisor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RznSoc">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Emisor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="100"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GiroEmis">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Emisor Relevante para el DTE </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Telefono" minOccurs="0" maxOccurs="2">
														<xs:annotation>
															<xs:documentation>Telefono Emisor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:FonoType">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoEmisor" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Acteco" maxOccurs="4">
														<xs:annotation>
															<xs:documentation>Codigo de Actividad Economica del Emisor Relevante para el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="6"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Sucursal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Sucursal que Emite el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CdgSIISucur" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo de Sucursal Entregado por el SII</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DirOrigen">
														<xs:annotation>
															<xs:documentation>Direccion de Origen</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaOrigen" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadOrigen" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgVendedor" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Vendedor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="60"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Receptor">
											<xs:annotation>
												<xs:documentation>Datos del Receptor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTRecep" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Receptor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgIntRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo Interno del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RznSocRecep" type="SiiDte:RznSocLargaType">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="GiroRecep">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Contacto" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Glosa con nombre o teléfono de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoRecep" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirRecep">
														<xs:annotation>
															<xs:documentation>Direccion en la Cual se Envian los Productos o se Prestan los Servicios</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaRecep" type="SiiDte:ComunaType">
														<xs:annotation>
															<xs:documentation>Comuna de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadRecep" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirPostal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion Postal</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaPostal" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadPostal" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Totales">
											<xs:annotation>
												<xs:documentation>Montos Totales del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="MntNeto" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Neto del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntExe" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Exento del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TasaIVA" type="SiiDte:PctType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tasa de IVA</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVA" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto de IVA del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVAProp" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto del IVA propio</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IVATerc" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto del IVA de Terceros</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="ImptoReten" minOccurs="0" maxOccurs="20">
														<xs:annotation>
															<xs:documentation>Impuestos y Retenciones Adicionales</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="TipoImp" type="SiiDte:ImpAdicDTEType">
																	<xs:annotation>
																		<xs:documentation>Tipo de Impuesto o Retencion Adicional</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="TasaImp" type="SiiDte:PctType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Tasa de Impuesto o Retencion</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MontoImp" type="SiiDte:MntImpType">
																	<xs:annotation>
																		<xs:documentation>Monto del Impuesto o Retencion</xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Comisiones" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comisiones y otros cargos es obligatoria para Liquidaciones Factura </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ValComNeto" type="SiiDte:ValorType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Valor Neto Comisiones y Otros Cargos</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="ValComExe" type="SiiDte:ValorType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Val. Comis. y Otros Cargos no Afectos o Exentos</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="ValComIVA" type="SiiDte:ValorType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Valor IVA Comisiones y Otros Cargos  </xs:documentation>
																	</xs:annotation>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="MntTotal" type="SiiDte:ValorType">
														<xs:annotation>
															<xs:documentation>Monto Total del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MontoPeriodo" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Total de Ventas o Servicios del Periodo</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SaldoAnterior" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Saldo Anterior - Puede ser Negativo o Positivo</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="VlrPagar" type="SiiDte:ValorType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Valor a Pagar Total del documento</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Detalle" maxOccurs="60">
								<xs:annotation>
									<xs:documentation>Detalle de Itemes del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinDet">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CdgItem" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Codificacion del Item</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoCodigo">
														<xs:annotation>
															<xs:documentation>Tipo de Codificacion</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="VlrCodigo">
														<xs:annotation>
															<xs:documentation>Valor del Codigo de Item, para la Codificacion Particular</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="TpoDocLiq">
											<xs:annotation>
												<xs:documentation>Tipo de Documento que se Liquida</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:minLength value="1"/>
													<xs:maxLength value="3"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IndExe" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indicador de Exencion/Facturacion</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ESTA Afecto a IVA</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ES Facturable</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Garantia por Deposito/Envase</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="4">
														<xs:annotation>
															<xs:documentation>El producto No Constituye Venta</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="5">
														<xs:annotation>
															<xs:documentation>Item a Rebajar</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="6">
														<xs:annotation>
															<xs:documentation>No facturables negativos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="NmbItem">
											<xs:annotation>
												<xs:documentation>Nombre del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="80"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="DscItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Descripcion del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="1000"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="QtyRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad para la Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario de Referencia para Unidad de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="QtyItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="Subcantidad" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Distribucion de la Cantidad</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="SubQty" type="SiiDte:Dec12_6Type">
														<xs:annotation>
															<xs:documentation>Cantidad  Distribuida</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SubCod">
														<xs:annotation>
															<xs:documentation>Codigo Descriptivo de la Subcantidad</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FchElabor" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Elaboracion del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="FchVencim" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Vencimiento del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario del Item en Pesos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="CodImpAdic" type="SiiDte:ImpAdicDTEType" minOccurs="0" maxOccurs="2">
											<xs:annotation>
												<xs:documentation>Codigo de Impuesto Adicional o Retencion</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="MontoItem" type="SiiDte:ValorType">
											<xs:annotation>
												<xs:documentation>Monto por Linea de Detalle. Corresponde al Monto Neto, a menos que MntBruto Indique lo Contrario </xs:documentation>
											</xs:annotation>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="SubTotInfo" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Subtotales Informativos</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroSTI">
											<xs:annotation>
												<xs:documentation>Número de Subtotal </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GlosaSTI">
											<xs:annotation>
												<xs:documentation>Glosa</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="40"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OrdenSTI" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Ubicación para Impresión </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubTotNetoSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor Neto del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotIVASTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor del IVA del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotAdicSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de los Impuestos adicionales o específicos del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotExeSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor no Afecto o Exento del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValSubtotSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de la línea de subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="LineasDeta" minOccurs="0" maxOccurs="60">
											<xs:annotation>
												<xs:documentation>TABLA de  Líneas de Detalle que se agrupan en el Subtotal</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger"/>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Referencia" minOccurs="0" maxOccurs="40">
								<xs:annotation>
									<xs:documentation>Identificacion de otros documentos Referenciados por Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinRef">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TpoDocRef">
											<xs:annotation>
												<xs:documentation>Tipo de Documento de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="3"/>
													<xs:minLength value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IndGlobal" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indica que se esta Referenciando un Conjunto de Documentos</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:nonNegativeInteger">
													<xs:totalDigits value="1"/>
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Documento hace Referencia a un Conjunto de Documentos Tributarios del Mismo Tipo</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="FolioRef" type="SiiDte:FolioRType">
											<xs:annotation>
												<xs:documentation>Folio del Documento de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="FchRef" type="SiiDte:FechaType">
											<xs:annotation>
												<xs:documentation>Fecha de la Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="CodRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Tipo de Uso de la Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>Anula Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>Corrige Texto del Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Corrige Montos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="RazonRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Razon Explicita por la que se Referencia el Documento</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="90"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Comisiones" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Comisiones y otros cargos es obligatoria para Liquidaciones Factura </xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinCom">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="20"/>
													<xs:totalDigits value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TipoMovim">
											<xs:annotation>
												<xs:documentation>C (comisión) u O (otros cargos)</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:minLength value="1"/>
													<xs:maxLength value="1"/>
													<xs:enumeration value="C"/>
													<xs:enumeration value="O"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Glosa">
											<xs:annotation>
												<xs:documentation>Especificación de la comisión u otro  cargo</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="60"/>
													<xs:minLength value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TasaComision" type="SiiDte:PctType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor porcentual de la comisión u otro cargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComNeto" type="SiiDte:ValorType">
											<xs:annotation>
												<xs:documentation>Valor Neto Comisiones y Otros Cargos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComExe" type="SiiDte:ValorType">
											<xs:annotation>
												<xs:documentation>Val. Comis. y Otros Cargos no Afectos o Exentos</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValComIVA" type="SiiDte:ValorType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor IVA Comisiones y Otros Cargos  </xs:documentation>
											</xs:annotation>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TED">
								<xs:annotation>
									<xs:documentation>Timbre Electronico de DTE</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="DD">
											<xs:annotation>
												<xs:documentation>Datos Basicos de Documento</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RE" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Emisor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TD" type="SiiDte:LIQType">
														<xs:annotation>
															<xs:documentation>Tipo DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="F" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FE" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision DTE en Formato AAAA-MM-DD</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RR" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RSR">
														<xs:annotation>
															<xs:documentation>Razon Social Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MNT" type="xs:unsignedLong">
														<xs:annotation>
															<xs:documentation>Monto Total DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="IT1">
														<xs:annotation>
															<xs:documentation>Descripcion Primer Item de Detalle</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CAF">
														<xs:annotation>
															<xs:documentation>Codigo Autorizacion Folios</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="DA">
																	<xs:annotation>
																		<xs:documentation>Datos de Autorizacion de Folios</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="RE" type="SiiDte:RUTType">
																				<xs:annotation>
																					<xs:documentation>RUT Emisor</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RS" type="SiiDte:RznSocCortaType">
																				<xs:annotation>
																					<xs:documentation>Razon Social Emisor</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="TD" type="SiiDte:LIQType">
																				<xs:annotation>
																					<xs:documentation>Tipo DTE</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RNG">
																				<xs:annotation>
																					<xs:documentation>Rango Autorizado de Folios</xs:documentation>
																				</xs:annotation>
																				<xs:complexType>
																					<xs:sequence>
																						<xs:element name="D" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Inicial (Desde)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																						<xs:element name="H" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Final (Hasta)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																					</xs:sequence>
																				</xs:complexType>
																			</xs:element>
																			<xs:element name="FA" type="SiiDte:FechaType">
																				<xs:annotation>
																					<xs:documentation>Fecha Autorizacion en Formato AAAA-MM-DD</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:choice>
																				<xs:element name="RSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica RSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="M" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="E" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Exponente RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																				<xs:element name="DSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica DSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="P" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo Primo</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Q" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero Divisor de P - 1</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="G" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero f(P, Q)</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Y" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>G**X mod P</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																			</xs:choice>
																			<xs:element name="IDK" type="xs:long">
																				<xs:annotation>
																					<xs:documentation>Identificador de Llave</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="FRMA">
																	<xs:annotation>
																		<xs:documentation>Firma Digital (RSA) del SII Sobre DA</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:simpleContent>
																			<xs:extension base="xs:base64Binary">
																				<xs:attribute name="algoritmo" type="xs:string" use="required" fixed="SHA1withRSA"/>
																			</xs:extension>
																		</xs:simpleContent>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
															<xs:attribute name="version" use="required" fixed="1.0"/>
														</xs:complexType>
													</xs:element>
													<xs:element name="TSTED" type="SiiDte:FechaHoraType">
														<xs:annotation>
															<xs:documentation>TimeStamp de Generacion del Timbre</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FRMT">
											<xs:annotation>
												<xs:documentation>Valor de Firma Digital  sobre DD</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:simpleContent>
													<xs:extension base="xs:base64Binary">
														<xs:attribute name="algoritmo" use="required">
															<xs:simpleType>
																<xs:restriction base="xs:string">
																	<xs:enumeration value="SHA1withRSA"/>
																	<xs:enumeration value="SHA1withDSA"/>
																</xs:restriction>
															</xs:simpleType>
														</xs:attribute>
													</xs:extension>
												</xs:simpleContent>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
									<xs:attribute name="version" use="required" fixed="1.0"/>
								</xs:complexType>
							</xs:element>
							<xs:element name="TmstFirma" type="SiiDte:FechaHoraType">
								<xs:annotation>
									<xs:documentation>Fecha y Hora en que se Firmo Digitalmente el Documento AAAA-MM-DDTHH:MI:SS</xs:documentation>
								</xs:annotation>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="ID" type="xs:ID" use="required"/>
					</xs:complexType>
				</xs:element>
				<xs:element name="Exportaciones">
					<xs:annotation>
						<xs:documentation>Informacion Tributaria de exportaciones</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Encabezado">
								<xs:annotation>
									<xs:documentation>Identificacion y Totales del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="IdDoc">
											<xs:annotation>
												<xs:documentation>Identificacion del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoDTE" type="SiiDte:EXPType">
														<xs:annotation>
															<xs:documentation>Tipo de DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Folio" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio del Documento Electronico</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FchEmis" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision Contable del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TipoDespacho" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica Modo de Despacho de los Bienes que Acompanan al DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Comprador</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Emisor a Instalaciones del Comprador</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Despacho por Cuenta del Emisor a Otras Instalaciones</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IndServicio" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Indica si Transaccion Corresponde a la Prestacion de un Servicio</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="1"/>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Factura de Servicio</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="4"/>
																<xs:enumeration value="5"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FmaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Forma de Pago del DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:enumeration value="1">
																	<xs:annotation>
																		<xs:documentation>Pago Contado</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="2">
																	<xs:annotation>
																		<xs:documentation>Pago Credito</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="3">
																	<xs:annotation>
																		<xs:documentation>Sin Costo</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FmaPagExp" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Forma de Pago Exportación Tabla Formas de Pago de Aduanas</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchCancel" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Cancelacion del DTE (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntCancel" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Cancelado al   emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SaldoInsol" type="SiiDte:MontoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Saldo Insoluto al       emitirse el documento</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntPagos" minOccurs="0" maxOccurs="30">
														<xs:annotation>
															<xs:documentation>Tabla de Montos de Pago</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="FchPago" type="SiiDte:FechaType">
																	<xs:annotation>
																		<xs:documentation>Fecha de Pago (AAAA-MM-DD)</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MntPago" type="SiiDte:MontoType">
																	<xs:annotation>
																		<xs:documentation>Monto de Pago</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="GlosaPagos" minOccurs="0">
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="PeriodoDesde" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo de Facturacion - Desde (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="PeriodoHasta" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Periodo Facturacion - Hasta (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MedioPago" type="SiiDte:MedioPagoType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Medio de Pago</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TpoCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo Cuenta de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
																<xs:minLength value="5"/>
																<xs:enumeration value="AHORRO"/>
																<xs:enumeration value="CORRIENTE"/>
																<xs:enumeration value="VISTA"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="NumCtaPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Número de la cuenta del pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="BcoPago" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Banco donde se realiza el pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoCdg" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Termino de Pago Acordado</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoGlosa" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Términos del Pago - glosa</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TermPagoDias" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Dias de Acuerdo al Codigo de Termino de Pago</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FchVenc" type="SiiDte:FechaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Fecha de Vencimiento del Pago (AAAA-MM-DD)</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Emisor">
											<xs:annotation>
												<xs:documentation>Datos del Emisor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTEmisor" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Emisor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RznSoc">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Emisor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="100"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GiroEmis">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Emisor Relevante para el DTE </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Telefono" minOccurs="0" maxOccurs="2">
														<xs:annotation>
															<xs:documentation>Telefono Emisor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:FonoType">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoEmisor" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Acteco" maxOccurs="4">
														<xs:annotation>
															<xs:documentation>Codigo de Actividad Economica del Emisor Relevante para el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="6"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Sucursal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Sucursal que Emite el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CdgSIISucur" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo de Sucursal Entregado por el SII</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:positiveInteger">
																<xs:totalDigits value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CodAdicSucur" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Sucursal que Emite el DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DirOrigen" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion de Origen</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaOrigen" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadOrigen" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Origen</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgVendedor" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo del Vendedor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="60"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IdAdicEmisor" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Identificador Adicional del Emisor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Receptor">
											<xs:annotation>
												<xs:documentation>Datos del Receptor</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RUTRecep" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT del Receptor del DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CdgIntRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Codigo Interno del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="20"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RznSocRecep" type="SiiDte:RznSocLargaType">
														<xs:annotation>
															<xs:documentation>Nombre o Razon Social del Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Extranjero" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Receptor Extranjero</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="NumId" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Num. Identif. Receptor Extranjero</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Nacionalidad" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nacionalidad Receptor Extranjero</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="3"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicRecep" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional del Receptor  extranjero</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="GiroRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Giro Comercial del Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Contacto" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Glosa con nombre o teléfono de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="80"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CorreoRecep" type="SiiDte:MailType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Correo Elect. de contacto en empresa del  receptor </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirRecep" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion en la Cual se Envian los Productos o se Prestan los Servicios</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaRecep" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadRecep" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Recepcion</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DirPostal" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion Postal</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaPostal" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadPostal" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad Postal</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Transporte" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Informacion de Transporte de Mercaderias</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Patente" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Patente del Vehiculo que Transporta los Bienes</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="8"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RUTTrans" type="SiiDte:RUTType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>RUT del Transportista</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Chofer" minOccurs="0">
														<xs:complexType>
															<xs:sequence>
																<xs:element name="RUTChofer" type="SiiDte:RUTType">
																	<xs:annotation>
																		<xs:documentation>RUT del Chofer</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="NombreChofer">
																	<xs:annotation>
																		<xs:documentation>Nombre del Chofer</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="30"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="DirDest" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Direccion de Destino</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CmnaDest" type="SiiDte:ComunaType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Comuna de Destino</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="CiudadDest" type="SiiDte:CiudadType" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Ciudad de Destino</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Aduana" minOccurs="0">
														<xs:annotation>
															<xs:documentation>documentos de Exportación y guías de despacho </xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="CodModVenta" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código según  tabla "Modalidad de Venta" de aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodClauVenta" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código según  Tabla "Cláusula compra-venta" de  Aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotClauVenta" type="SiiDte:Dec16_2Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Total  Cláusula de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="CodViaTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Indicar el Código de la vía de transporte utilizada para transportar la mercadería, según tabla Vías de Transporte de Aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="NombreTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nombre o Identificación del Medio de Transporte</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="RUTCiaTransp" type="SiiDte:RUTType" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Rut Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="NomCiaTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Nombre Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="40"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicTransp" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Cía. Transportadora</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Booking" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Numero de reserva del Operador</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Operador" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del Operador</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPtoEmbarque" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del puerto de embarque según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="4"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicPtoEmb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Puerto de Embarque</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPtoDesemb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del puerto de desembarque según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="4"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="IdAdicPtoDesemb" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Identificador Adicional Puerto de Desembarque</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:string">
																			<xs:maxLength value="20"/>
																			<xs:minLength value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Tara" minOccurs="0">
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="7"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidMedTara" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="PesoBruto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Sumatoria de los pesos brutos de todos los ítems del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:totalDigits value="10"/>
																			<xs:fractionDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidPesoBruto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="PesoNeto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Sumatoria de los pesos netos de todos los ítems del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:totalDigits value="10"/>
																			<xs:fractionDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodUnidPesoNeto" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código de la unidad de medida  según tabla de Aduana </xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotItems" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Indique el total de items del documento</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="18"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TotBultos" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Cantidad total de bultos que ampara el documento.</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="18"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="TipoBultos" minOccurs="0" maxOccurs="10">
																	<xs:annotation>
																		<xs:documentation>Tabla de descripción de los distintos tipos de bultos</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="CodTpoBultos" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Código según  tabla "Tipos de Bultos" de aduana</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:positiveInteger">
																						<xs:totalDigits value="3"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="CantBultos" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Cantidad de Bultos </xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:positiveInteger">
																						<xs:totalDigits value="10"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Marcas" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Identificación de marcas, cuando es distinto de contenedor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="255"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="IdContainer" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Se utiliza cuando el tipo de bulto es contenedor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="25"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Sello" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Sello contenedor. Con digito verificador</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="20"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="EmisorSello" minOccurs="0">
																				<xs:annotation>
																					<xs:documentation>Nombre emisor sello</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:maxLength value="70"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="MntFlete" type="SiiDte:Dec14_4Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Monto del flete según moneda de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="MntSeguro" type="SiiDte:Dec14_4Type" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Monto del seguro , según moneda de venta</xs:documentation>
																	</xs:annotation>
																</xs:element>
																<xs:element name="CodPaisRecep" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del país del receptor extranjero de la mercadería,
según tabla Países aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CodPaisDestin" minOccurs="0">
																	<xs:annotation>
																		<xs:documentation>Código del país de destino extranjero de la mercadería,
según tabla Países aduana</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:positiveInteger">
																			<xs:totalDigits value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Totales">
											<xs:annotation>
												<xs:documentation>Montos Totales del DTE</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoMoneda" type="SiiDte:TipMonType">
														<xs:annotation>
															<xs:documentation>Tipo de Moneda en que se regisrtra la transacción.  Tabla de Monedas  de Aduanas</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntExe">
														<xs:annotation>
															<xs:documentation>Monto Exento del DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.0000"/>
																<xs:maxInclusive value="99999999999999.9999"/>
																<xs:totalDigits value="18"/>
																<xs:fractionDigits value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MntTotal">
														<xs:annotation>
															<xs:documentation>Monto Total del DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.0000"/>
																<xs:maxInclusive value="99999999999999.9999"/>
																<xs:totalDigits value="18"/>
																<xs:fractionDigits value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="OtraMoneda" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Otra Moneda </xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoMoneda" type="SiiDte:TipMonType">
														<xs:annotation>
															<xs:documentation>Tipo Otra moneda Tabla de Monedas  de Aduanas</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TpoCambio" type="SiiDte:Dec6_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo de Cambio fijado por el Banco Central de Chile</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntExeOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Monto Exento del DTE en Otra Moneda  </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="MntTotOtrMnda" type="SiiDte:Dec14_4Type">
														<xs:annotation>
															<xs:documentation>Monto Total Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Detalle" maxOccurs="60">
								<xs:annotation>
									<xs:documentation>Detalle de Itemes del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinDet">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CdgItem" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Codificacion del Item</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TpoCodigo">
														<xs:annotation>
															<xs:documentation>Tipo de Codificacion</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="VlrCodigo">
														<xs:annotation>
															<xs:documentation>Valor del Codigo de Item, para la Codificacion Particular</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="IndExe" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indicador de Exencion/Facturacion</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ESTA Afecto a IVA</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>El Producto o Servicio NO ES Facturable</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Garantia por Deposito/Envase</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="4">
														<xs:annotation>
															<xs:documentation>El producto No Constituye Venta</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="5">
														<xs:annotation>
															<xs:documentation>Item a Rebajar</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="6">
														<xs:annotation>
															<xs:documentation>No facturables negativos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="NmbItem">
											<xs:annotation>
												<xs:documentation>Nombre del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="80"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="DscItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Descripcion del Item</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="1000"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="QtyRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad para la Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcRef" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario de Referencia para Unidad de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="QtyItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Cantidad del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="Subcantidad" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Distribucion de la Cantidad</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="SubQty" type="SiiDte:Dec12_6Type">
														<xs:annotation>
															<xs:documentation>Cantidad  Distribuida</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="SubCod">
														<xs:annotation>
															<xs:documentation>Codigo Descriptivo de la Subcantidad</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TipCodSubQty" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Tipo de Código Subcantidad</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="10"/>
																<xs:minLength value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FchElabor" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Elaboracion del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="FchVencim" type="SiiDte:FechaType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Fecha Vencimiento del Item</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="UnmdItem" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Unidad de Medida</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="PrcItem" type="SiiDte:Dec12_6Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio Unitario del Item </xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="OtrMnda" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Precio del Item en Otra Moneda</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="PrcOtrMon" type="SiiDte:Dec14_4Type">
														<xs:annotation>
															<xs:documentation>Precio Unitario en Otra Moneda</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="Moneda">
														<xs:annotation>
															<xs:documentation>Codigo de Otra Moneda (Usar Codigos de Moneda del Banco Central)</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:maxLength value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="FctConv" type="SiiDte:Dec6_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Factor  para Conversion a Pesos</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="DctoOtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Descuento en Otra Moneda </xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RecargoOtrMnda" minOccurs="0">
														<xs:annotation>
															<xs:documentation>Recargo en Otra Moneda</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:Dec14_4Type">
																<xs:totalDigits value="18"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MontoItemOtrMnda">
														<xs:annotation>
															<xs:documentation>Valor por línea de detalle en Otra Moneda</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="SiiDte:Dec14_4Type">
																<xs:totalDigits value="18"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="DescuentoPct" type="SiiDte:PctType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Porcentaje de Descuento</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="DescuentoMonto" type="SiiDte:MntImpType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Monto de Descuento</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubDscto" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Desglose del Descuento</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoDscto">
														<xs:annotation>
															<xs:documentation>Tipo de SubDescuento</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:enumeration value="$">
																	<xs:annotation>
																		<xs:documentation>Descuento en Monto</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="%">
																	<xs:annotation>
																		<xs:documentation>Descuento en Porcentaje</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ValorDscto" type="SiiDte:Dec16_2Type">
														<xs:annotation>
															<xs:documentation>Valor del SubDescuento</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RecargoPct" type="SiiDte:PctType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Porcentaje de Recargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="RecargoMonto" type="SiiDte:MntImpType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Monto de Recargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubRecargo" minOccurs="0" maxOccurs="5">
											<xs:annotation>
												<xs:documentation>Desglose del Recargo</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="TipoRecargo">
														<xs:annotation>
															<xs:documentation>Tipo de SubRecargo</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:enumeration value="$">
																	<xs:annotation>
																		<xs:documentation>Recargo en Monto</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
																<xs:enumeration value="%">
																	<xs:annotation>
																		<xs:documentation>Recargo en Porcentaje</xs:documentation>
																	</xs:annotation>
																</xs:enumeration>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ValorRecargo" type="SiiDte:Dec16_2Type">
														<xs:annotation>
															<xs:documentation>Valor de SubRecargo</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="MontoItem">
											<xs:annotation>
												<xs:documentation>Monto por Linea de Detalle. Corresponde al Monto Neto, a menos que MntBruto Indique lo Contrario </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.0000"/>
													<xs:maxInclusive value="99999999999999.9999"/>
													<xs:totalDigits value="18"/>
													<xs:fractionDigits value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="SubTotInfo" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Subtotales Informativos</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroSTI">
											<xs:annotation>
												<xs:documentation>Número de Subtotal </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GlosaSTI">
											<xs:annotation>
												<xs:documentation>Glosa</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="40"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OrdenSTI" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Ubicación para Impresión </xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubTotNetoSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor Neto del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotIVASTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor del IVA del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotAdicSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de los Impuestos adicionales o específicos del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="SubTotExeSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor no Afecto o Exento del Subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValSubtotSTI" type="SiiDte:Dec16_2Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor de la línea de subtotal</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="LineasDeta" minOccurs="0" maxOccurs="60">
											<xs:annotation>
												<xs:documentation>TABLA de  Líneas de Detalle que se agrupan en el Subtotal</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger"/>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="DscRcgGlobal" minOccurs="0" maxOccurs="20">
								<xs:annotation>
									<xs:documentation>Descuentos y/o Recargos que afectan al total del Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinDR" type="xs:positiveInteger">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="TpoMov">
											<xs:annotation>
												<xs:documentation>Tipo de Movimiento</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:enumeration value="D">
														<xs:annotation>
															<xs:documentation>Descuento</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="R">
														<xs:annotation>
															<xs:documentation>Recargo</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GlosaDR" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Descripcion del Descuento o Recargo</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="45"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TpoValor">
											<xs:annotation>
												<xs:documentation>Unidad en que se Expresa el Valor</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:enumeration value="%">
														<xs:annotation>
															<xs:documentation>El valor se Expresa como Porcentaje</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="$">
														<xs:annotation>
															<xs:documentation>El Valor se Expresa en Pesos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ValorDR" type="SiiDte:Dec16_2Type">
											<xs:annotation>
												<xs:documentation>Valor del Descuento o Recargo</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="ValorDROtrMnda" type="SiiDte:Dec14_4Type" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Valor en otra moneda</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="IndExeDR" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indica si el D/R es No Afecto o No Facturable</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>Descuento/Recargo Global No Afecto</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>Descuento/Recargo No Facturable</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Referencia" minOccurs="0" maxOccurs="40">
								<xs:annotation>
									<xs:documentation>Identificacion de otros documentos Referenciados por Documento</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="NroLinRef">
											<xs:annotation>
												<xs:documentation>Numero Secuencial de Linea de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:maxInclusive value="99"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TpoDocRef">
											<xs:annotation>
												<xs:documentation>Tipo de Documento de Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="3"/>
													<xs:minLength value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IndGlobal" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Indica que se esta Referenciando un Conjunto de Documentos</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:nonNegativeInteger">
													<xs:totalDigits value="1"/>
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>El Documento hace Referencia a un Conjunto de Documentos Tributarios del Mismo Tipo</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="FolioRef" type="SiiDte:FolioRType">
											<xs:annotation>
												<xs:documentation>Folio del Documento de Referencia</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="RUTOtr" type="SiiDte:RUTType" minOccurs="0">
											<xs:annotation>
												<xs:documentation>RUT Otro Contribuyente</xs:documentation>
											</xs:annotation>
										</xs:element>
										<xs:element name="IdAdicOtr" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Identificador Adicional del otro contribuyente</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="20"/>
													<xs:minLength value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="FchRef">
											<xs:annotation>
												<xs:documentation>Fecha de la Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
													<xs:minInclusive value="1950-01-01"/>
													<xs:maxInclusive value="2050-12-31"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CodRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Tipo de Uso de la Referencia</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:positiveInteger">
													<xs:enumeration value="1">
														<xs:annotation>
															<xs:documentation>Anula Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="2">
														<xs:annotation>
															<xs:documentation>Corrige Texto del Documento de Referencia</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
													<xs:enumeration value="3">
														<xs:annotation>
															<xs:documentation>Corrige Montos</xs:documentation>
														</xs:annotation>
													</xs:enumeration>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="RazonRef" minOccurs="0">
											<xs:annotation>
												<xs:documentation>Razon Explicita por la que se Referencia el Documento</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:string">
													<xs:maxLength value="90"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TED">
								<xs:annotation>
									<xs:documentation>Timbre Electronico de DTE</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="DD">
											<xs:annotation>
												<xs:documentation>Datos Basicos de Documento</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RE" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Emisor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="TD" type="SiiDte:EXPType">
														<xs:annotation>
															<xs:documentation>Tipo DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="F" type="SiiDte:FolioType">
														<xs:annotation>
															<xs:documentation>Folio DTE</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="FE" type="SiiDte:FechaType">
														<xs:annotation>
															<xs:documentation>Fecha Emision DTE en Formato AAAA-MM-DD</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RR" type="SiiDte:RUTType">
														<xs:annotation>
															<xs:documentation>RUT Receptor</xs:documentation>
														</xs:annotation>
													</xs:element>
													<xs:element name="RSR">
														<xs:annotation>
															<xs:documentation>Razon Social Receptor</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MNT">
														<xs:annotation>
															<xs:documentation>Monto Total DTE</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.0000"/>
																<xs:maxInclusive value="99999999999999.9999"/>
																<xs:totalDigits value="18"/>
																<xs:fractionDigits value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IT1">
														<xs:annotation>
															<xs:documentation>Descripcion Primer Item de Detalle</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:string">
																<xs:minLength value="1"/>
																<xs:maxLength value="40"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="CAF">
														<xs:annotation>
															<xs:documentation>Codigo Autorizacion Folios</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="DA">
																	<xs:annotation>
																		<xs:documentation>Datos de Autorizacion de Folios</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="RE" type="SiiDte:RUTType">
																				<xs:annotation>
																					<xs:documentation>RUT Emisor</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RS">
																				<xs:annotation>
																					<xs:documentation>Razon Social Emisor</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:string">
																						<xs:minLength value="1"/>
																						<xs:maxLength value="40"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="TD" type="SiiDte:EXPType">
																				<xs:annotation>
																					<xs:documentation>Tipo DTE</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:element name="RNG">
																				<xs:annotation>
																					<xs:documentation>Rango Autorizado de Folios</xs:documentation>
																				</xs:annotation>
																				<xs:complexType>
																					<xs:sequence>
																						<xs:element name="D" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Inicial (Desde)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																						<xs:element name="H" type="SiiDte:FolioType">
																							<xs:annotation>
																								<xs:documentation>Folio Final (Hasta)</xs:documentation>
																							</xs:annotation>
																						</xs:element>
																					</xs:sequence>
																				</xs:complexType>
																			</xs:element>
																			<xs:element name="FA" type="SiiDte:FechaType">
																				<xs:annotation>
																					<xs:documentation>Fecha Autorizacion en Formato AAAA-MM-DD</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																			<xs:choice>
																				<xs:element name="RSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica RSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="M" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="E" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Exponente RSA</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																				<xs:element name="DSAPK">
																					<xs:annotation>
																						<xs:documentation>Clave Publica DSA del Solicitante</xs:documentation>
																					</xs:annotation>
																					<xs:complexType>
																						<xs:sequence>
																							<xs:element name="P" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Modulo Primo</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Q" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero Divisor de P - 1</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="G" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>Entero f(P, Q)</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																							<xs:element name="Y" type="xs:base64Binary">
																								<xs:annotation>
																									<xs:documentation>G**X mod P</xs:documentation>
																								</xs:annotation>
																							</xs:element>
																						</xs:sequence>
																					</xs:complexType>
																				</xs:element>
																			</xs:choice>
																			<xs:element name="IDK" type="xs:long">
																				<xs:annotation>
																					<xs:documentation>Identificador de Llave</xs:documentation>
																				</xs:annotation>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="FRMA">
																	<xs:annotation>
																		<xs:documentation>Firma Digital (RSA) del SII Sobre DA</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:simpleContent>
																			<xs:extension base="xs:base64Binary">
																				<xs:attribute name="algoritmo" type="xs:string" use="required" fixed="SHA1withRSA"/>
																			</xs:extension>
																		</xs:simpleContent>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
															<xs:attribute name="version" use="required" fixed="1.0"/>
														</xs:complexType>
													</xs:element>
													<xs:element name="TSTED" type="SiiDte:FechaHoraType">
														<xs:annotation>
															<xs:documentation>TimeStamp de Generacion del Timbre</xs:documentation>
														</xs:annotation>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="FRMT">
											<xs:annotation>
												<xs:documentation>Valor de Firma Digital  sobre DD</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:simpleContent>
													<xs:extension base="xs:base64Binary">
														<xs:attribute name="algoritmo" use="required">
															<xs:simpleType>
																<xs:restriction base="xs:string">
																	<xs:enumeration value="SHA1withRSA"/>
																	<xs:enumeration value="SHA1withDSA"/>
																</xs:restriction>
															</xs:simpleType>
														</xs:attribute>
													</xs:extension>
												</xs:simpleContent>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
									<xs:attribute name="version" use="required" fixed="1.0"/>
								</xs:complexType>
							</xs:element>
							<xs:element name="TmstFirma" type="SiiDte:FechaHoraType">
								<xs:annotation>
									<xs:documentation>Fecha y Hora en que se Firmo Digitalmente el Documento AAAA-MM-DDTHH:MI:SS</xs:documentation>
								</xs:annotation>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="ID" type="xs:ID" use="required"/>
					</xs:complexType>
				</xs:element>
			</xs:choice>
			<xs:element ref="ds:Signature">
				<xs:annotation>
					<xs:documentation>Firma Digital sobre Documento</xs:documentation>
				</xs:annotation>
			</xs:element>
		</xs:sequence>
		<xs:attribute name="version" type="xs:decimal" use="required" fixed="1.0"/>
	</xs:complexType>
</xs:schema>'