create database ControlPC
use ControlPC
use master

create table tb_Monitor(
dc_usuario_m varchar (50)not null,
dc_monitor varchar(80)not null,
dg_dispositivo varchar(50),
df_manufactura varchar (50),
dg_modelo varchar(80),
dg_estado_mon varchar(80),
df_asignacion_m date)



create table tb_Pc(
dc_usuario_pc varchar(80)not null,
dc_pc integer not null,
dc_estado_pc varchar(80),
dg_modeloprocesador varchar(120),
dg_modeloplaca varchar(100),
dg_capacidaddisco integer,
dg_cantidadram integer,
df_asignacion date)



create table tb_Usuario(
dc_usuario varchar(80),
dg_sucursal varchar (100)
)
------------------------
------PRIMARYS KEYS-----
------------------------

---Primary key monitor
ALTER TABLE dbo.tb_Monitor ADD CONSTRAINT PK_Monitor
PRIMARY KEY CLUSTERED (dc_usuario_m, dc_monitor);

---Primary key pc
ALTER TABLE dbo.tb_Pc ADD CONSTRAINT PK_Pc
PRIMARY KEY CLUSTERED (dc_usuario_pc, dc_pc);

---Primary key usuario
ALTER TABLE dbo.tb_Usuario ADD CONSTRAINT PK_Usuario
PRIMARY KEY CLUSTERED (dc_usuario);

------------------------
------FOREIGN KEY-----
------------------------

---Foreign key Usuario
ALTER TABLE dbo.tb_Usuario ADD CONSTRAINT FK_Usuario_monitor
FOREIGN KEY (dc_usuario) REFERENCES dbo.tb_Monitor(dc_usuario_m)

ALTER TABLE dbo.tb_Usuario ADD CONSTRAINT FK_Usuario_pc
FOREIGN KEY (dc_usuario) REFERENCES dbo.tb_Pc(dc_usuario_pc)


---------------------------------------------------------------------
---------------------------------------------------------------------

create table tb_Monitor(
dc_usuario_m varchar (50)not null,
dc_monitor varchar(80)not null,
dg_dispositivo varchar(50),
df_manufactura varchar (50),
dg_modelo varchar(80),
dg_estado_mon varchar(80),
df_asignacion_m date)


--------------------------------
------------INSERTS-------------
--------------------------------
insert into tb_Monitor
values('CROSAS','KJSDA1545','LOVB15','25-06-2014','LG2541HD','Activo','13-07-2015')
insert into tb_Monitor
values('CROSAS','KJSDA1545','LOVB15','29-09-2014','LG2541HD','inactivo','13-07-2015')
insert into tb_Monitor
values('CROSAS','KJSDA1545','LOVB15','23-05-2014','LG2541HD','inactivo','13-07-2015')

insert into tb_Pc
values ('CROSAS',115451123122,'Activo','INTEL i5 3.1','Asus x99x895',250.48,2048,'13-07-2015')
insert into tb_Pc
values ('CROSAS',6515646546,'inactivo','INTEL i7 3.3','Asus x99popl',480.500,2048,'13-07-2015')

insert into tb_Usuario
values('CROSAS','FORUM')



-----------------------------
-----ALTERS USADOS----------
ALTER TABLE tb_Pc 
ALTER COLUMN dc_estado_pc varchar(80)

ALTER TABLE tb_Monitor 
ADD df_asignacion_m date

ALTER TABLE tb_Monitor
ALTER COLUMN dg_estado_mon varchar(80)


sp_columns tb_Pc

select*from dbo.tb_Pc


delete from tb_Pc where dc_usuario_pc = 'crosas'

select * from tb_Pc


create table tb_Pc(
dc_usuario_pc varchar(80)not null,
dc_pc varchar(50) not null,
dc_estado_pc varchar(80),
dg_modeloprocesador varchar(120),
dg_modeloplaca varchar(100),
dg_capacidaddisco float,
dg_cantidadram float,
df_asignacion date)

drop table tb_Pc


----procedimientos almacenados




-------------------------------------
-------------------INSERT POR SEPARADO
GO
CREATE  PROCEDURE Insert_Monitor_Info
(
@dc_usuario_m varchar (50),
@dc_monitor varchar(80),
@dg_dispositivo varchar(50),
@df_manufactura varchar (50),
@dg_modelo varchar(80),
@dg_estado_mon varchar(80),
@df_asignacion_m date)
AS
BEGIN
insert into tb_Monitor
values(@dc_usuario_m,@dc_monitor,@dg_dispositivo,@df_manufactura,@dg_modelo,@dg_estado_mon,@df_asignacion_m)
END

--insert into tb_Monitor (NOLOCK)(dc_usuario_m,dc_monitor,dg_dispositivo,df_manufactura,dg_modelo,dg_estado_mon,df_asignacion_m) 
--------------------------------------

--create table tb_Pc(
--dc_usuario_pc varchar(80)not null,
--dc_pc varchar(50) not null,
--dc_estado_pc varchar(80),
--dg_modeloprocesador varchar(120),
--dg_modeloplaca varchar(100),
--dg_capacidaddisco float,
--dg_cantidadram float,
--df_asignacion date)


GO
CREATE  PROCEDURE Insert_Pc_Info
(
@dc_usuario_pc varchar(80),
@dc_pc varchar(50),
@dc_estado_pc varchar(80),
@dg_modeloprocesador varchar(120),
@dg_modeloplaca varchar(100),
@dg_capacidaddisco float,
@dg_cantidadram float,
@df_asignacion date)
AS
BEGIN
insert into tb_Pc
values(@dc_usuario_pc,@dc_pc,@dc_estado_pc,@dg_modeloprocesador,@dg_modeloplaca,@dg_capacidaddisco,@dg_cantidadram,@df_asignacion)
END






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


select * from tb_pc


GO
CREATE  PROCEDURE Select_Consultar_info
(
@dc_usuario_m varchar (50),
@dc_monitor varchar(80),
@dg_dispositivo varchar(50),
@df_manufactura varchar (50),
@dg_modelo varchar(80),
@dg_estado_mon varchar(80),
@df_asignacion_m date,
@dc_usuario_pc varchar(80),
@dc_pc integer,
@dc_estado_pc varchar(80),
@dg_modeloprocesador varchar(120),
@dg_modeloplaca varchar(100),
@dg_capacidaddisco integer,
@dg_cantidadram integer,
@df_asignacion date)
AS
BEGIN
select	dc_usuario_m,
		dc_monitor,
		dg_dispositivo,
		df_manufactura,
		dg_modelo,
		dg_estado_mon,
		df_asignacion_m
from tb_Monitor	WHERE dc_usuario_m = @dc_usuario_m
select	dc_usuario_pc,
		dc_pc,
		dc_estado_pc,
		dg_modeloprocesador,
		dg_modeloplaca,
		dg_capacidaddisco,
		dg_cantidadram,
		df_asignacion
from tb_pc where dc_usuario_pc = @dc_usuario_pc
END
