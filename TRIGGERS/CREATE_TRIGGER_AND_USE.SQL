



--==========================================--
----------		CREATE TRIGGER	--------------
--==========================================--

--TRIGGER QUE RESCATA LOS VALORES ELIMINADOS, INSERTADOS Y ACTUALIZADOS DE LA TABLA Customer
--Y LOS GUARDA EN LA TABLA DE HISTORICOS Customer_Historic
CREATE TRIGGER tr_GuardaHistoricoCustomer ON Customer
FOR  DELETE,INSERT,UPDATE
AS
BEGIN
		
	SET NOCOUNT ON;
	
	IF EXISTS ( SELECT 0 FROM Deleted )
        BEGIN
            IF EXISTS ( SELECT 0 FROM Inserted )
                BEGIN
                    INSERT  INTO dbo.Customer_Historic
                            (	 								
								 Id_Hist
								,FirstName
								,LastName
								,City
								,Country
								,Phone
								,Audit_Date
								,Action
                            )
                            SELECT   D.Id
                                    ,D.FirstName 
                                    ,D.LastName 
                                    ,D.City 
                                    ,D.Country
									,D.Phone
                                    ,GETDATE()
                                    ,'U'
                            FROM    Deleted D
                END
            ELSE
                BEGIN
                     INSERT  INTO dbo.Customer_Historic
                            (	 								
								 Id_Hist
								,FirstName
								,LastName
								,City
								,Country
								,Phone
								,Audit_Date
								,Action
                            )
                            SELECT   D.Id
                                    ,D.FirstName 
                                    ,D.LastName 
                                    ,D.City 
                                    ,D.Country
									,D.Phone
                                    ,GETDATE()
                                    ,'D'
                            FROM    Deleted D
                END  
        END
    ELSE
        BEGIN
            INSERT  INTO dbo.Customer_Historic
                            (	 								
								 Id_Hist
								,FirstName
								,LastName
								,City
								,Country
								,Phone
								,Audit_Date
								,Action
                            )
                            SELECT   D.Id
                                    ,D.FirstName 
                                    ,D.LastName 
                                    ,D.City 
                                    ,D.Country
									,D.Phone
                                    ,GETDATE()
                                    ,'I'
                            FROM    Deleted D
        END
END

--==========================================================--
-->INSERT SIMPLE A LA TABLA Customer PARA PROBAR TRIGGER
--==========================================================--
INSERT INTO Customer(FirstName,LastName,City,Country,Phone)
VALUES('Carlos','Villagran','Temuco','Chile',99887744)

--==========================================================--
-->REVISION DE LO QUE GUARDO EL TRIGGER
--==========================================================--

-->dato insertado en tabla base
SELECT Id,FirstName,LastName,City,Country,Phone FROM Customer where  City like '%Temuco%' 

-->dato insertado en tabla de historico, prueba que el trigger funcciona correctamente
SELECT Id,FirstName,LastName,City,Country,Phone,Audit_Date,Action FROM Customer_Historic where  City like '%Temuco%' 
