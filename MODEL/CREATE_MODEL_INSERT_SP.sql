--create database ReportesBD
--use ReportesBD

create table tb_reports(
Rut_Emp integer not null,
Rep_Period varchar(50),
dayspicked varchar(30),
To_Email varchar (50) not null,
type_report varchar(30)not null,
City varchar(50),
Contact_Name varchar(60),
Phone_number integer,
Save_Record date, 
);
-- Select a la tabla
select * from tb_reports

---inserts a la tabla
insert into tb_reports 
values(12777888,'Semanal','vie','carlos@acfcaoital.cl','Comercial',
'Santiago','Carlos Norambuena',88556699,'2015-06-10')
insert into tb_reports 
values(13222444,'Semanal','mi,jue','carlos@acfcaoital.cl','Comercial',
'Santiago','Carlos Lopez',77744411,'2015-07-10')
insert into tb_reports 
values(13666999,'Semanal','lu,ma,mi,jue,vie','carlos@acfcaoital.cl','Comercial',
'Santiago','Luis Norambuena',88844422,'2015-08-10')
insert into tb_reports 
values(4555777,'Semanal','lu,ma','carlos@acfcaoital.cl','Comercial',
'Santiago','Tito Norambuena',44462355,'2015-09-10')
insert into tb_reports 
values(78999666,'Semanal','jue,vie','carlos@acfcaoital.cl','Comercial',
'Santiago','juan carlos tapia',88844411,'2015-10-10')

--- Alter para agregar la pk compuesta solicitada
ALTER TABLE dbo.tb_reports ADD CONSTRAINT PK_reports
PRIMARY KEY CLUSTERED (Rut_Emp, To_Email,type_report);

---procedimientos almacenados

-------------------------------------
-------------------INSERT POR SEPARADO
GO
CREATE  PROCEDURE Insert_tb_reports
(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date, 
@StatementType nvarchar(20) = ''-- sujeto a esta variable que puede ser aplicable en la tabla.
) 
AS
BEGIN
insert into tb_reports (NOLOCK)(Rut_Emp, Rep_Period,dayspicked,To_Email,type_report,City,Contact_Name,Phone_number,Save_Record) 
values( @Rut_Emp,@Rep_Period,@dayspicked,@To_Email,@type_report,@City,@Contact_Name,@Phone_number,@Save_Record)
END

--------------------------------------
------------------UPDATE POR SEPARADO
GO
CREATE  PROCEDURE Update_tb_reports
(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date, 
@StatementType nvarchar(20) = ''-- sujeto a esta variable que puede ser aplicable en la tabla.
) 
AS
UPDATE tb_reports (NOLOCK) SET
            Rut_Emp =  @Rut_Emp, Rep_Period = @Rep_Period, dayspicked = @dayspicked,To_Email=@To_Email,type_report=@type_report,
            City = @city,Contact_Name = @Contact_Name, Phone_number= @Phone_number,Save_Record=@Save_Record
      WHERE Rut_Emp = @Rut_Emp and Rep_Period= @Rep_Period and To_Email=@To_Email
END
GO

-----------------------------------------
--- ----------------DELETE POR SEPARADO
GO
CREATE  PROCEDURE Delete_tb_reports
(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date) 
AS
BEGIN
Delete from dbo.tb_reports(NOLOCK)
where Rut_Emp = @Rut_Emp and Rep_Period= @Rep_Period and To_Email=@To_Email
END


---------------------------------------
----- -------------SELECT POR SEPARADO
GO
CREATE  PROCEDURE Select_tb_reports(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date)
AS
Begin
Select	Rut_Emp, 
		Rep_Period,
		dayspicked,
		To_Email,
		type_report,
		City,
		Contact_Name,
		Phone_number,
		Save_Record
from dbo.tb_reports (NOLOCK)
WHERE Rut_Emp = @Rut_Emp and Rep_Period= @Rep_Period and To_Email=@To_Email
END



--CREACION DEL PROCEDIMIENTO MULTIPLE con todas las manipulaciones, sujeto a un "campo"


create PROCEDURE MasterInsertUpdateDelete
(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date, 
@StatementType nvarchar(20) = ''-- sujeto a esta variable que puede ser aplicable en la tabla.
) 
AS
BEGIN
IF @StatementType = 'Insert'
BEGIN
insert into tb_reports(Rut_Emp, Rep_Period,dayspicked,To_Email,type_report,City,Contact_Name,Phone_number,Save_Record) 
values( @Rut_Emp,@Rep_Period,@dayspicked,@To_Email,@type_report,@City,@Contact_Name,@Phone_number,@Save_Record)
END 
IF @StatementType = 'Update'
BEGIN
UPDATE tb_reports SET
            Rut_Emp =  @Rut_Emp, Rep_Period = @Rep_Period, dayspicked = @dayspicked,To_Email=@To_Email,type_report=@type_report,
            City = @city,Contact_Name = @Contact_Name, Phone_number= @Phone_number,Save_Record=@Save_Record
      WHERE Rut_Emp = @Rut_Emp and Rep_Period= @Rep_Period and To_Email=@To_Email
END
 
else IF @StatementType = 'Delete'
BEGIN
DELETE FROM reports WHERE Rut_Emp = @Rut_Emp
END
end

-----------------------------------------------------
-----------------------------------------------------
---CONDICION PARA LA EJECUCION.

IF ( OBJECT_ID('dbo.tb_reports') IS NOT NULL ) 
   DROP PROCEDURE MasterInsertUpdateDelete(
GO
Alter  PROCEDURE MasterInsertUpdateDelete
(
@Rut_Emp integer ,
@Rep_Period varchar(50),
@dayspicked varchar(30),
@To_Email varchar (50),
@type_report varchar(30),
@City varchar(50),
@Contact_Name varchar(60),
@Phone_number integer,
@Save_Record date, 
@StatementType nvarchar(20) = ''-- sujeto a esta variable que puede ser aplicable en la tabla.
) 
AS
BEGIN
IF @StatementType = 'Insert'
BEGIN
insert into tb_reports(Rut_Emp, Rep_Period,dayspicked,To_Email,type_report,City,Contact_Name,Phone_number,Save_Record) 
values( @Rut_Emp,@Rep_Period,@dayspicked,@To_Email,@type_report,@City,@Contact_Name,@Phone_number,@Save_Record)
END 
IF @StatementType = 'Update'
BEGIN
UPDATE tb_reports SET
            Rut_Emp =  @Rut_Emp, Rep_Period = @Rep_Period, dayspicked = @dayspicked,To_Email=@To_Email,type_report=@type_report,
            City = @city,Contact_Name = @Contact_Name, Phone_number= @Phone_number,Save_Record=@Save_Record
      WHERE Rut_Emp = @Rut_Emp and Rep_Period= @Rep_Period and To_Email=@To_Email
END
 
else IF @StatementType = 'Delete'
BEGIN
DELETE FROM reports WHERE Rut_Emp = @Rut_Emp
END
end

