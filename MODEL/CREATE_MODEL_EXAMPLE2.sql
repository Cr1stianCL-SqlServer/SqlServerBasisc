--Create database Inventory

--use Inventory


select * from tb_inventory_

create table tb_inventory_(
dc_username varchar(100),
dc_machineName varchar(100),
dg_ipv4 varchar(20),
dg_ipv6 varchar(20),
dg_gateway varchar(40),
dg_mask varchar(40),
dg_dns1 varchar(20),
dg_dns2 varchar(20),
dg_proxy varchar(40),
dc_cpuSerial varchar(50),
dg_cpuModel varchar(50),
dc_motherBoardSerial varchar(100),
dg_motherModel varchar(50),
dg_operativeSystem varchar(80),
dg_hdd_total varchar(80),
dg_ram_total varchar(80),
df_creationDate datetime,
CONSTRAINT pk_inventory_ PRIMARY KEY (dc_username,dc_machineName,dc_cpuSerial,dc_motherBoardSerial,df_creationDate)
)

create procedure spi_inventory_(
@dc_username varchar(100),
@dc_machineName varchar(100),
@dg_ipv4 varchar(20),
@dg_ipv6 varchar(20),
@dg_gateway varchar(40),
@dg_mask varchar(40),
@dg_dns1 varchar(20),
@dg_dns2 varchar(20),
@dg_proxy varchar(40),
@dc_cpuSerial varchar(50),
@dg_cpuModel varchar(50),
@dc_motherBoardSerial varchar(100),
@dg_motherModel varchar(50),
@dg_operativeSystem varchar(80),
@dg_hdd_total varchar(80),
@dg_ram_total varchar(80),
@df_creationDate datetime
)as
begin
insert into dbo.tb_inventory_ values( 
@dc_username,
@dc_machineName,
@dg_ipv4,
@dg_ipv6,
@dg_gateway,
@dg_mask,
@dg_dns1,
@dg_dns2,
@dg_proxy,
@dc_cpuSerial,
@dg_cpuModel,
@dc_motherBoardSerial,
@dg_motherModel,
@dg_operativeSystem,
@dg_hdd_total,
@dg_ram_total,
getdate()
)
end
go

---------------------------------------------------
---------------------------------------------------


select top 10 *  from tb_inventory_cpu

select top 10 *  from tb_inventory_cpu

--select top 10 *  from tb_inventory_ram

select top 10 *  from tb_inventory_monitor

select *  from tb_inventory_userAccount

select *  from tb_inventory_motherBoard

select *  from tb_inventory_OperativeSystem


--create table tb_inventory_ --OK
--create table tb_inventory_cpu --OK
--create table tb_inventory_ram --OK
--create table tb_inventory_monitor --OK
--create table tb_inventory_userAccount --OK
--create table tb_inventory_motherBoard --OK
--create table tb_inventory_OperativeSystem --OK
--create table tb_inventory_networkInterfaceCard
--create table tb_inventory_hardDisk --OK
--create table tb_inventory_software --OK
--create table tb_inventory_errorLog
---create table tb_inventory_monitorDetails

drop table tb_inventory_OperativeSystem

select * from tb_inventory_OperativeSystem

delete from  tb_inventory_OperativeSystem where  dc_machineName = 'crosas2'

create table tb_inventory_OperativeSystem(
dc_OSserialNumber varchar(80),
dc_machineName varchar(80),
dg_BootDevice varchar(80),
dg_BuildNumber varchar(80),
dg_BuildType varchar(80),
dg_Caption varchar(80),
dg_CodeSet varchar(80),
dg_CountryCode varchar(80),
dg_CSDVersion varchar(80),
dg_CSCreationClassName varchar(80),
dg_CSName varchar(80),
dg_CurrentTimeZone varchar(80),
dg_Description varchar(80),
dg_FreePhysicalMeOSry varchar(80),
dg_FreeSpaceInPagingFiles varchar(80),
dg_FreeVirtualMeOSry varchar(80),
dg_InstallDate varchar(80),
dg_LastBootUpTime varchar(80),
dg_LocalDateTime varchar(80),
dg_Locale varchar(80),
dg_Manufacturer varchar(80),
dg_MaxNumberOfProcesses varchar(80),
dg_MUILanguages varchar(80),
dg_Name varchar(80),
dg_NumberOfLicensedUsers varchar(80),
dg_NumberOfProcesses varchar(80),
dg_NumberOfUsers varchar(80),
dg_OperatingSystemSKU varchar(80),
dg_Organization varchar(80),
dg_OSArchitecture varchar(80),
dg_OSLanguage varchar(80),
dg_OSProductSuite varchar(80),
dg_OSType varchar(80),
dg_ProductType varchar(80),
dg_RegisteredUser varchar(80),
dg_ServicePackMajorVersion varchar(80),
dg_ServicePackMinorVersion varchar(80),
dg_Status varchar(80),
dg_SystemDevice varchar(80),
dg_SystemDirectory varchar(80),
dg_SystemDrive varchar(80),
dg_TotalSwapSpaceSize varchar(80),
dg_TotalVirtualMeOSrySize varchar(80),
dg_TotalVisibleMeOSrySize varchar(80),
dg_Version varchar(80),
dg_WindowsDirectory varchar(80),
df_creationDate Datetime,
CONSTRAINT pk_inventory_OS PRIMARY KEY (dc_OSserialNumber,dc_machineName,df_creationDate)
)

alter procedure spi_inventory_OperativeSystem(
@dc_OSserialNumber varchar(80),
@dc_machineName varchar(80),
@dg_BootDevice varchar(80),
@dg_BuildNumber varchar(80),
@dg_BuildType varchar(80),
@dg_Caption varchar(80),
@dg_CodeSet varchar(80),
@dg_CountryCode varchar(80),
@dg_CSDVersion varchar(80),
@dg_CSCreationClassName varchar(80),
@dg_CSName varchar(80),
@dg_CurrentTimeZone varchar(80),
@dg_Description varchar(80),
@dg_FreePhysicalMeOSry varchar(80),
@dg_FreeSpaceInPagingFiles varchar(80),
@dg_FreeVirtualMeOSry varchar(80),
@dg_InstallDate varchar(80),
@dg_LastBootUpTime varchar(80),
@dg_LocalDateTime varchar(80),
@dg_Locale varchar(80),
@dg_Manufacturer varchar(80),
@dg_MaxNumberOfProcesses varchar(80),
@dg_MUILanguages varchar(80),
@dg_Name varchar(80),
@dg_NumberOfLicensedUsers varchar(80),
@dg_NumberOfProcesses varchar(80),
@dg_NumberOfUsers varchar(80),
@dg_OperatingSystemSKU varchar(80),
@dg_Organization varchar(80),
@dg_OSArchitecture varchar(80),
@dg_OSLanguage varchar(80),
@dg_OSProductSuite varchar(80),
@dg_OSType varchar(80),
@dg_ProductType varchar(80),
@dg_RegisteredUser varchar(80),
@dg_ServicePackMajorVersion varchar(80),
@dg_ServicePackMinorVersion varchar(80),
@dg_Status varchar(80),
@dg_SystemDevice varchar(80),
@dg_SystemDirectory varchar(80),
@dg_SystemDrive varchar(80),
@dg_TotalSwapSpaceSize varchar(80),
@dg_TotalVirtualMeOSrySize varchar(80),
@dg_TotalVisibleMeOSrySize varchar(80),
@dg_Version varchar(80),
@dg_WindowsDirectory varchar(80),
@df_creationDate Datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_OperativeSystem where  dc_OSserialNumber=@dc_OSserialNumber and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into tb_inventory_OperativeSystem values(
		@dc_OSserialNumber,
		@dc_machineName,
		@dg_BootDevice,
		@dg_BuildNumber,
		@dg_BuildType,
		@dg_Caption,
		@dg_CodeSet,
		@dg_CountryCode,
		@dg_CSDVersion,
		@dg_CSCreationClassName,
		@dg_CSName,
		@dg_CurrentTimeZone,
		@dg_Description,
		@dg_FreePhysicalMeOSry,
		@dg_FreeSpaceInPagingFiles,
		@dg_FreeVirtualMeOSry,
		@dg_InstallDate,
		@dg_LastBootUpTime,
		@dg_LocalDateTime,
		@dg_Locale,
		@dg_Manufacturer,
		@dg_MaxNumberOfProcesses,
		@dg_MUILanguages,
		@dg_Name,
		@dg_NumberOfLicensedUsers,
		@dg_NumberOfProcesses,
		@dg_NumberOfUsers,
		@dg_OperatingSystemSKU,
		@dg_Organization,
		@dg_OSArchitecture,
		@dg_OSLanguage,
		@dg_OSProductSuite,
		@dg_OSType,
		@dg_ProductType,
		@dg_RegisteredUser,
		@dg_ServicePackMajorVersion,
		@dg_ServicePackMinorVersion,
		@dg_Status,
		@dg_SystemDevice,
		@dg_SystemDirectory,
		@dg_SystemDrive,
		@dg_TotalSwapSpaceSize,
		@dg_TotalVirtualMeOSrySize,
		@dg_TotalVisibleMeOSrySize,
		@dg_Version,
		@dg_WindowsDirectory,
		getdate())
	end
end
go

-------------------------------------------
-----------------------------------------
------------------------------------------


select * from  tb_inventory_cpu

create table tb_inventory_cpu(
dc_cpuSerial varchar(80), --ProcessorId
dc_machineName varchar(100),
dg_name varchar(100),
dg_CurrentClockSpeed varchar(100),
dg_DataWidth varchar(100),
dg_DeviceID varchar(100),
dg_L2CacheSize varchar(100),
dg_L3CacheSpeed varchar(100),
dg_Manufacturer varchar(100),
dg_NumberOfCores varchar(100),
dg_NumberOfLogicalProcessors varchar(100),
dg_Status varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_cpu PRIMARY KEY (dc_cpuSerial,dc_machineName,df_creationDate)
)


----ALTER TABLE tb_inventory_cpu ALTER COLUMN dc_cpuSerial varchar(100) NOT NULL
----ALTER TABLE tb_inventory_cpu ALTER COLUMN dc_machineName varchar(100) NOT NULL
----ALTER TABLE tb_inventory_cpu ALTER COLUMN df_creationDate datetime NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dg_Version varchar(100) NOT NULL

------ALTER TABLE tb_inventory_cpu
------DROP CONSTRAINT pk_inventory_cpu

------ALTER TABLE tb_inventory_cpu
------ADD CONSTRAINT pk_inventory_cpu PRIMARY KEY (dc_cpuSerial,dc_machineName,df_creationDate)


  --				  ArrayListCpu.Add("ProcessorId", CPU["ProcessorId"].ToString());
						--machineName
  --                  ArrayListCpu.Add("name", CPU["name"].ToString());
  --                  ArrayListCpu.Add("CurrentClockSpeed",CPU["CurrentClockSpeed"].ToString());
  --                  ArrayListCpu.Add("DataWidth", CPU["DataWidth"].ToString());
  --                  ArrayListCpu.Add("DeviceID", CPU["DeviceID"].ToString());
  --                  ArrayListCpu.Add("L2CacheSize", CPU["L2CacheSize"].ToString());
  --                  ArrayListCpu.Add("L3CacheSpeed",CPU["L3CacheSpeed"].ToString());
  --                  ArrayListCpu.Add("Manufacturer", CPU["Manufacturer"].ToString());
  --                  ArrayListCpu.Add("NumberOfCores", CPU["NumberOfCores"].ToString());
  --                  ArrayListCpu.Add("NumberOfLogicalProcessors",CPU["NumberOfLogicalProcessors"].ToString());
  --                  ArrayListCpu.Add("Status", CPU["Status"].ToString());

select * from tb_inventory_cpu

alter procedure spi_inventory_cpu(
@dc_cpuSerial varchar(80), --ProcessorId
@dc_machineName varchar(100),
@dg_name varchar(100),
@dg_CurrentClockSpeed varchar(100),
@dg_DataWidth varchar(100),
@dg_DeviceID varchar(100),
@dg_L2CacheSize varchar(100),
@dg_L3CacheSpeed varchar(100),
@dg_Manufacturer varchar(100),
@dg_NumberOfCores varchar(100),
@dg_NumberOfLogicalProcessors varchar(100),
@dg_Status varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_cpu where  dc_cpuSerial = @dc_cpuSerial and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_cpu values( 
		@dc_cpuSerial, --ProcessorId
		@dc_machineName,
		@dg_name,
		@dg_CurrentClockSpeed,
		@dg_DataWidth,
		@dg_DeviceID,
		@dg_L2CacheSize,
		@dg_L3CacheSpeed,
		@dg_Manufacturer,
		@dg_NumberOfCores,
		@dg_NumberOfLogicalProcessors,
		@dg_Status,
		getdate()
		)
	end
end
go
----------------------------//////////////////////
---------------------------------------------------
---------------------------------------------------

drop table tb_inventory_ram

sp_help tb_inventory_ram

select * from tb_inventory_ram

create table tb_inventory_ram(
dc_ramSerial varchar(100), --SerialNumber
dc_machineName varchar(100),
dg_Attributes varchar(100),
dg_BankLabel varchar(100),
dg_Capacity varchar(100),
dg_ConfiguredClockSpeed varchar(100),
dg_DataWidth varchar(100),
dg_Description varchar(100),
dg_DeviceLocator varchar(100),
dg_InterleaveDataDepth varchar(100),
dg_InterleavePosition varchar(100),
dg_Manufacturer varchar(100),
dg_MemoryType varchar(100),
dg_Name varchar(100),
dg_PartNumber varchar(100),
dg_SMBIOSMemoryType varchar(100),
dg_Speed varchar(100),
dg_Tag varchar(100),
dg_TypeDetail varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_ram PRIMARY KEY (dc_ramSerial,dc_machineName,df_creationDate)
)

ALTER TABLE tb_inventory_ram ALTER COLUMN dc_ramSerial varchar(100) NOT NULL
ALTER TABLE tb_inventory_ram ALTER COLUMN dc_machineName varchar(100) NOT NULL
ALTER TABLE tb_inventory_ram ALTER COLUMN df_creationDate datetime NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dg_Version varchar(100) NOT NULL

ALTER TABLE tb_inventory_ram
DROP CONSTRAINT pk_inventory_ram

ALTER TABLE tb_inventory_ram
ADD CONSTRAINT pk_inventory_ram PRIMARY KEY (dc_ramSerial,dc_machineName,df_creationDate)

alter procedure spi_inventory_ram(
@dc_ramSerial varchar(100), --SerialNumber
@dc_machineName varchar(100),
@dg_Attributes varchar(100),
@dg_BankLabel varchar(100),
@dg_Capacity varchar(100),
@dg_ConfiguredClockSpeed varchar(100),
@dg_DataWidth varchar(100),
@dg_Description varchar(100),
@dg_DeviceLocator varchar(100),
@dg_InterleaveDataDepth varchar(100),
@dg_InterleavePosition varchar(100),
@dg_Manufacturer varchar(100),
@dg_MemoryType varchar(100),
@dg_Name varchar(100),
@dg_PartNumber varchar(100),
@dg_SMBIOSMemoryType varchar(100),
@dg_Speed varchar(100),
@dg_Tag varchar(100),
@dg_TypeDetail varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_ram where  dc_ramSerial = @dc_ramSerial and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_ram values( 
		@dc_ramSerial, --SerialNumber
		@dc_machineName,
		@dg_Attributes,
		@dg_BankLabel,
		@dg_Capacity,
		@dg_ConfiguredClockSpeed,
		@dg_DataWidth,
		@dg_Description,
		@dg_DeviceLocator,
		@dg_InterleaveDataDepth,
		@dg_InterleavePosition,
		@dg_Manufacturer,
		@dg_MemoryType,
		@dg_Name,
		@dg_PartNumber,
		@dg_SMBIOSMemoryType,
		@dg_Speed,
		@dg_Tag,
		@dg_TypeDetail,
		getdate())
	end
end
go

---------------------------------------------------
---------------------------------------------------

--drop table tb_inventory_monitor


create table tb_inventory_monitor(
dc_monitorSerial varchar(100), ----PNPDeviceID
dc_machineName varchar(100),
dg_Availability varchar(100),
dg_Caption varchar(100),
dg_CreationClassName varchar(100),
dg_Description varchar(100),
dg_monitorSerial varchar(100),
dg_DeviceID varchar(100),
dg_MonitorType varchar(100),
dg_Status varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_monitor PRIMARY KEY (dc_monitorSerial,dc_machineName,df_creationDate)
)

create procedure spi_inventory_monitor(
@dc_monitorSerial varchar(100), ----PNPDeviceID
@dc_machineName varchar(100),
@dg_Availability varchar(100),
@dg_Caption varchar(100),
@dg_CreationClassName varchar(100),
@dg_Description varchar(100),
@dg_monitorSerial varchar(100),
@dg_DeviceID varchar(100),
@dg_MonitorType varchar(100),
@dg_Status varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_monitor where  dc_monitorSerial = @dc_monitorSerial and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_monitor values( 
		@dc_monitorSerial, ----PNPDeviceID
		@dc_machineName,
		@dg_Availability,
		@dg_Caption,
		@dg_CreationClassName,
		@dg_Description,
		@dg_monitorSerial,
		@dg_DeviceID,
		@dg_MonitorType,
		@dg_Status,
		getdate())
	end		
end
go

---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
select * from tb_inventory_userAccount

drop table tb_inventory_userAccount

sp_help tb_inventory_userAccount

create table tb_inventory_userAccount(
dc_userName varchar(100),
dc_machineName varchar(100),
dg_AccountType varchar(100),
dg_Caption varchar(100),
dg_Description varchar(100),
dg_Disabled varchar(100),
dg_Domain varchar(100),
dg_FullName varchar(100),
dg_InstallDate varchar(100),
dg_LocalAccount varchar(100),
dg_Name varchar(100),
dg_PasswordChangeable varchar(100),
dg_PasswordExpires varchar(100),
dg_PasswordRequired varchar(100),
dg_SID varchar(100),
dg_SIDType varchar(100),
dg_Status varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_userAccount PRIMARY KEY (dc_userName,dc_machineName,df_creationDate)
)

create procedure spi_inventory_userAccount(
@dc_userName varchar(100),
@dc_machineName varchar(100),
@dg_AccountType varchar(100),
@dg_Caption varchar(100),
@dg_Description varchar(100),
@dg_Disabled varchar(100),
@dg_Domain varchar(100),
@dg_FullName varchar(100),
@dg_InstallDate varchar(100),
@dg_LocalAccount varchar(100),
@dg_Name varchar(100),
@dg_PasswordChangeable varchar(100),
@dg_PasswordExpires varchar(100),
@dg_PasswordRequired varchar(100),
@dg_SID varchar(100),
@dg_SIDType varchar(100),
@dg_Status varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_userAccount where  dc_userName = @dc_userName and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_userAccount values( 
		@dc_userName,
		@dc_machineName,
		@dg_AccountType,
		@dg_Caption,
		@dg_Description,
		@dg_Disabled,
		@dg_Domain,
		@dg_FullName,
		@dg_InstallDate,
		@dg_LocalAccount,
		@dg_Name,
		@dg_PasswordChangeable,
		@dg_PasswordExpires,
		@dg_PasswordRequired,
		@dg_SID,
		@dg_SIDType,
		@dg_Status,
		getdate())
	end
end
go


---------------------------------------------------
---------------------------------------------------

--use BD_COBRANZA

---------------------------------------------------
---------------------------------------------------
--drop table tb_inventory_motherBoard

select * from tb_inventory_motherBoard

create table tb_inventory_motherBoard(
dc_motherBoardSerial varchar(100),---SerialNumber
dc_machineName varchar(100),
dg_Description varchar(100),
dg_Manufacturer varchar(100),
dg_Name varchar(100),
dg_Product varchar(100),
dg_Status varchar(100),
dg_Caption varchar(100),
dg_CreationClassName varchar(100),
dg_HostingBoard varchar(100),
dg_HotSwappable varchar(100),
dg_PoweredOn varchar(100),
dg_Removable varchar(100),
dg_Replaceable varchar(100),
dg_RequiresDaughterBoard varchar(100),
dg_Tag varchar(100),
dg_Version varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_motherBoard PRIMARY KEY (dc_motherBoardSerial,dc_machineName,df_creationDate)
)


ALTER TABLE tb_inventory_motherBoard ALTER COLUMN dc_motherBoardSerial varchar(100) NOT NULL
ALTER TABLE tb_inventory_motherBoard ALTER COLUMN dc_machineName varchar(100) NOT NULL
ALTER TABLE tb_inventory_motherBoard ALTER COLUMN df_creationDate datetime NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dg_Version varchar(100) NOT NULL

ALTER TABLE tb_inventory_motherBoard
DROP CONSTRAINT pk_inventory_motherBoard

ALTER TABLE tb_inventory_motherBoard
ADD CONSTRAINT pk_inventory_motherBoard PRIMARY KEY (dc_motherBoardSerial,dc_machineName,df_creationDate)

alter procedure spi_inventory_motherBoard(
@dc_motherBoardSerial varchar(100),---SerialNumber
@dc_machineName varchar(100),
@dg_Description varchar(100),
@dg_Manufacturer varchar(100),
@dg_Name varchar(100),
@dg_Product varchar(100),
@dg_Status varchar(100),
@dg_Caption varchar(100),
@dg_CreationClassName varchar(100),
@dg_HostingBoard varchar(100),
@dg_HotSwappable varchar(100),
@dg_PoweredOn varchar(100),
@dg_Removable varchar(100),
@dg_Replaceable varchar(100),
@dg_RequiresDaughterBoard varchar(100),
@dg_Tag varchar(100),
@dg_Version varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_motherBoard where  dc_motherBoardSerial = @dc_motherBoardSerial and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_motherBoard values( 
		@dc_motherBoardSerial,---SerialNumber
		@dc_machineName,
		@dg_Description,
		@dg_Manufacturer,
		@dg_Name,
		@dg_Product,
		@dg_Status,
		@dg_Caption,
		@dg_CreationClassName,
		@dg_HostingBoard,
		@dg_HotSwappable,
		@dg_PoweredOn,
		@dg_Removable,
		@dg_Replaceable,
		@dg_RequiresDaughterBoard,
		@dg_Tag,
		@dg_Version,
		getdate())
	end
end
go

---------------------------------------------------
---------------------------------------------------

---------------------------------------------------
---------------------------------------------------
--select * from tb_inventory_OperativeSystem

drop table tb_inventory_OperativeSystem

create table tb_inventory_OperativeSystem(
dc_serialNumber varchar(80), -----SerialNumber
dc_userName varchar(100),
dc_machineName varchar(100),
dg_BootDevice varchar(100),
dg_BuildNumber varchar(100),
dg_BuildType varchar(100),
dg_Caption varchar(100),
dg_CodeSet varchar(100),
dg_CountryCode varchar(100),
dg_CSDVersion varchar(100), ----integer 16
dg_CSCreationClassName varchar(100),
dg_CSName varchar(100),
dg_CurrentTimeZone varchar(100), ----integer 16
dg_Description varchar(100),
dg_FreePhysicalMemory varchar(100),
dg_FreeSpaceInPagingFiles varchar(100),
dg_FreeVirtualMemory varchar(100),
dg_InstallDate varchar(100),
dg_LastBootUpTime varchar(100),
dc_LocalDateTime varchar(100),
dc_Locale varchar(100),
dc_Manufacturer varchar(100),
dc_MaxNumberOfProcesses varchar(100),
dc_MUILanguages varchar(100),
dc_Name varchar(100),
dc_NumberOfLicensedUsers varchar(100),
dc_NumberOfProcesses varchar(100),
dc_NumberOfUsers varchar(100),
dc_OperatingSystemSKU varchar(100),
dc_Organization varchar(100),
dc_MOSArchitecture varchar(100),
dc_OSLanguage varchar(100),
dc_OSProductSuite varchar(100),
dc_OSType varchar(100),
dc_ProductType varchar(100),
dc_RServicePackMajorVersion varchar(100),
dc_ServicePackMinorVersion varchar(100),
dc_Status varchar(100),
dc_SystemDevice varchar(100),
dc_SystemDirectory varchar(100),
dc_SystemDrive varchar(100),
dc_TotalSwapSpaceSize varchar(100),
dc_TotalVirtualMemorySize varchar(100),
dc_TotalVisibleMemorySize varchar(100),
dc_Version varchar(100),
dc_WindowsDirectory varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_userAccountPK PRIMARY KEY (dc_SerialNumber,dc_userName,dc_machineName,df_creationDate)
)

alter procedure spi_inventory_OperativeSystem(
@dc_serialNumber varchar(80), -----SerialNumber
@dc_userName varchar(100),
@dc_machineName varchar(100),
@dg_BootDevice varchar(100),
@dg_BuildNumber varchar(100),
@dg_BuildType varchar(100),
@dg_Caption varchar(100),
@dg_CodeSet varchar(100),
@dg_CountryCode varchar(100),
@dg_CSDVersion varchar(100), ----integer 16
@dg_CSCreationClassName varchar(100),
@dg_CSName varchar(100),
@dg_CurrentTimeZone varchar(100), ----integer 16
@dg_Description varchar(100),
@dg_FreePhysicalMemory varchar(100),
@dg_FreeSpaceInPagingFiles varchar(100),
@dg_FreeVirtualMemory varchar(100),
@dg_InstallDate varchar(100),
@dg_LastBootUpTime varchar(100),
@dc_LocalDateTime varchar(100),
@dc_Locale varchar(100),
@dc_Manufacturer varchar(100),
@dc_MaxNumberOfProcesses varchar(100),
@dc_MUILanguages varchar(100),
@dc_Name varchar(100),
@dc_NumberOfLicensedUsers varchar(100),
@dc_NumberOfProcesses varchar(100),
@dc_NumberOfUsers varchar(100),
@dc_OperatingSystemSKU varchar(100),
@dc_Organization varchar(100),
@dc_MOSArchitecture varchar(100),
@dc_OSLanguage varchar(100),
@dc_OSProductSuite varchar(100),
@dc_OSType varchar(100),
@dc_ProductType varchar(100),
@dc_RServicePackMajorVersion varchar(100),
@dc_ServicePackMinorVersion varchar(100),
@dc_Status varchar(100),
@dc_SystemDevice varchar(100),
@dc_SystemDirectory varchar(100),
@dc_SystemDrive varchar(100),
@dc_TotalSwapSpaceSize varchar(100),
@dc_TotalVirtualMemorySize varchar(100),
@dc_TotalVisibleMemorySize varchar(100),
@dc_Version varchar(100),
@dc_WindowsDirectory varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_OperativeSystem where dc_serialNumber = @dc_serialNumber and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_OperativeSystem values( 
		@dc_serialNumber, -----SerialNumber
		@dc_userName,
		@dc_machineName,
		@dg_BootDevice,
		@dg_BuildNumber,
		@dg_BuildType,
		@dg_Caption,
		@dg_CodeSet,
		@dg_CountryCode,
		@dg_CSDVersion, ----integer 16
		@dg_CSCreationClassName,
		@dg_CSName,
		@dg_CurrentTimeZone, ----integer 16
		@dg_Description,
		@dg_FreePhysicalMemory,
		@dg_FreeSpaceInPagingFiles,
		@dg_FreeVirtualMemory,
		@dg_InstallDate,
		@dg_LastBootUpTime,
		@dc_LocalDateTime,
		@dc_Locale,
		@dc_Manufacturer,
		@dc_MaxNumberOfProcesses,
		@dc_MUILanguages,
		@dc_Name,
		@dc_NumberOfLicensedUsers,
		@dc_NumberOfProcesses,
		@dc_NumberOfUsers,
		@dc_OperatingSystemSKU,
		@dc_Organization,
		@dc_MOSArchitecture,
		@dc_OSLanguage,
		@dc_OSProductSuite,
		@dc_OSType,
		@dc_ProductType,
		@dc_RServicePackMajorVersion,
		@dc_ServicePackMinorVersion,
		@dc_Status,
		@dc_SystemDevice,
		@dc_SystemDirectory,
		@dc_SystemDrive,
		@dc_TotalSwapSpaceSize,
		@dc_TotalVirtualMemorySize,
		@dc_TotalVisibleMemorySize,
		@dc_Version,
		@dc_WindowsDirectory,
		getdate())
	end
end
go

---------------------------------------------------
---------------------------------------------------

--drop table tb_inventory_networkInterfaceCard

select * from tb_inventory_networkInterfaceCard

create table tb_inventory_networkInterfaceCard(
dc_MacAdrress varchar(50),
dc_IPv4 varchar(20),
dc_IPv6 varchar(50),
dg_MacAdrressInBytes varchar(50),
dg_Mask varchar(50),
dg_Gateway varchar(50),
dg_Dns1Ipv4 varchar(50),
dg_Dns2Ipv4 varchar(50),
dg_Dns1Ipv6 varchar(50),
dg_Dns2Ipv6 varchar(50),
dg_NetworkInterfaceType varchar(50),
dg_IsReceiveOnly varchar(50),
dg_SupportsMulticast varchar(50),
dg_Description varchar(50),
dg_Id varchar(50),
dg_Name varchar(50),
dg_OperationalStatus varchar(50),
dg_Speed varchar(50),
dg_Index varchar(50),
dg_IsAutomaticPAI varchar(50),
dg_IsDnsEnabled varchar(50),
dg_IsDynamicDnsEnabled varchar(50),
df_creationDate datetime,
CONSTRAINT pk_inventory_networkInterfaceCard PRIMARY KEY (dc_MacAdrress,dc_IPv4,dc_IPv6,df_creationDate)
)               //ListNetworkInterfaceCard.Add(IsDnsEnabledList);
----------------------------------------------------------------------
----------------------------------------------------------------------
alter procedure spi_inventory_NetworkInterfaceCard(
@dc_MacAdrress varchar(50),
@dc_IPv4 varchar(20),
@dc_IPv6 varchar(50),
@dg_MacAdrressInBytes varchar(50),
@dg_Mask varchar(50),
@dg_Gateway varchar(50),
@dg_Dns1Ipv4 varchar(50),
@dg_Dns2Ipv4 varchar(50),
@dg_Dns1Ipv6 varchar(50),
@dg_Dns2Ipv6 varchar(50),
@dg_NetworkInterfaceType varchar(50),
@dg_IsReceiveOnly varchar(50),
@dg_SupportsMulticast varchar(50),
@dg_Description varchar(50),
@dg_Id varchar(50),
@dg_Name varchar(50),
@dg_OperationalStatus varchar(50),
@dg_Speed varchar(50),
@dg_Index varchar(50),
@dg_IsAutomaticPAI varchar(50),
@dg_IsDynamicDnsEnabled varchar(50),
@dg_IsDnsEnabled varchar(50),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_networkInterfaceCard where dc_MacAdrress = @dc_MacAdrress and dc_IPv4=@dc_IPv4 and dc_IPv6=@dc_IPv6 and  (select cast(df_creationDate as date)) = @DateHoy )
	begin	
		insert into tb_inventory_networkInterfaceCard values(
		@dc_MacAdrress,
		@dc_IPv4,
		@dc_IPv6,
		@dg_MacAdrressInBytes,
		@dg_Mask,
		@dg_Gateway,
		@dg_Dns1Ipv4,
		@dg_Dns2Ipv4,
		@dg_Dns1Ipv6,
		@dg_Dns2Ipv6,
		@dg_NetworkInterfaceType,
		@dg_IsReceiveOnly,
		@dg_SupportsMulticast,
		@dg_Description,
		@dg_Id,
		@dg_Name,
		@dg_OperationalStatus,
		@dg_Speed,
		@dg_Index,
		@dg_IsAutomaticPAI,
		@dg_IsDynamicDnsEnabled,
		@dg_IsDnsEnabled,
		getdate())
	end
end
go

---------------------------------------------------
---------------------------------------------------
select * from tb_inventory_hardDisk
drop table tb_inventory_hardDisk

create table tb_inventory_hardDisk(
dc_hardDiskSerialNumber varchar(80), ----SerialNumber
dc_machineName varchar(100),
dg_Manufacturer varchar(100),
dg_size varchar(100),
dg_Name varchar(100),
dg_Description varchar(100),
dg_Partitions varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_hardDis PRIMARY KEY (dc_hardDiskSerialNumber,dc_machineName,df_creationDate)
)

alter procedure spi_inventory_hardDisk(
@dc_hardDiskSerialNumber varchar(80), ----SerialNumber
@dc_machineName varchar(100),
@dg_Manufacturer varchar(100),
@dg_size varchar(100),
@dg_Name varchar(100),
@dg_Description varchar(100),
@dg_Partitions varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_hardDisk where dc_hardDiskSerialNumber = @dc_hardDiskSerialNumber and dc_machineName=@dc_machineName and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_hardDisk values( 
		@dc_hardDiskSerialNumber, ----SerialNumber
		@dc_machineName,
		@dg_Manufacturer,
		@dg_size,
		@dg_Name,
		@dg_Description,
		@dg_Partitions,
		getdate())
	end
end
go


---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

select DISTINCT dc_userName from tb_inventory_software where df_creationDate >='20161229'

SELECT DISTINCT dc_machineName from tb_inventory_software 


select 

SELECT DISTINCT dc_userName from tb_inventory_software 

where dc_machineName

sp_help tb_inventory_software


select * from tb_inventory_software where dg_Description like'Microsoft%'
select * from tb_inventory_software where dg_Description ='Microsoft Office SharePoint Designer 2007'
select * from tb_inventory_software where dg_Description ='Kaspersky Endpoint Security 10 para Windows'
select * from tb_inventory_software where dg_Description ='Microsoft Office Professional Plus 2010'
select * from tb_inventory_software where dg_Description ='Microsoft Office SharePoint Designer 2007'
select * from tb_inventory_software where dg_Description ='Microsoft Office SharePoint Designer 2007'
select * from tb_inventory_software where dg_Description ='Microsoft Office SharePoint Designer 2007'


delete from tb_inventory_software where dc_userName='CMORIS'
select * from tb_inventory_software where dc_machineName='ves'

select * from tb_inventory_software where dc_userName='rhidalgo'
select * from tb_inventory_software where dc_userName='crosas'



select * from tb_inventory_software where dc_userName='CMORIS'

--dc_userName

----drop table tb_inventory_software

create table tb_inventory_software(
dc_machineName varchar(100),
dc_userName varchar(100),
dg_Name varchar(100),
dg_Version varchar(100),
dg_Language varchar(100),
dg_Description varchar(100),
dg_Caption varchar(100),
dg_IdentifyingNumber varchar(100),
dg_InstallDate varchar(100),
dg_InstallLocation varchar(100),
dg_ProductID varchar(100),
dg_PackageName varchar(100),
dg_InstallSource varchar(100),
dg_RegOwner varchar(100),
dg_RegCompany varchar(100),
dg_SKUNumber varchar(100),
df_creationDate datetime,
CONSTRAINT pk_inventory_software PRIMARY KEY (dc_machineName,dc_userName,dg_Name,df_creationDate)
)

----ALTER TABLE tb_inventory_software ALTER COLUMN dc_machineName varchar(100) NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dc_userName varchar(100) NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dg_Name varchar(100) NOT NULL
----ALTER TABLE tb_inventory_software ALTER COLUMN dg_Version varchar(100) NOT NULL

----ALTER TABLE tb_inventory_software
----DROP CONSTRAINT pk_inventory_software

----ALTER TABLE tb_inventory_software
----ADD CONSTRAINT pk_inventory_softwarepk PRIMARY KEY (dc_machineName,dc_userName,dg_Name,df_creationDate)

alter procedure spi_inventory_software(
@dc_machineName varchar(100),
@dc_userName varchar(100),
@dg_Name varchar(100),
@dg_Version varchar(100),
@dg_Language varchar(100),
@dg_Description varchar(100),
@dg_Caption varchar(100),
@dg_IdentifyingNumber varchar(100),
@dg_InstallDate varchar(100),
@dg_InstallLocation varchar(100),
@dg_ProductID varchar(100),
@dg_PackageName varchar(100),
@dg_InstallSource varchar(100),
@dg_RegOwner varchar(100),
@dg_RegCompany varchar(100),
@dg_SKUNumber varchar(100),
@df_creationDate datetime
)as
begin
declare @DateHoy date
set @DateHoy = (select cast(getdate() as date))
	IF NOT EXISTS(select * from tb_inventory_software where dc_machineName = @dc_machineName and dc_userName=@dc_userName and dg_Name = @dg_Name and  (select cast(df_creationDate as date)) = @DateHoy )
	begin
		insert into dbo.tb_inventory_software values( 
		@dc_machineName,
		@dc_userName,
		@dg_Name,
		@dg_Version,
		@dg_Language,
		@dg_Description,
		@dg_Caption,
		@dg_IdentifyingNumber,
		@dg_InstallDate,
		@dg_InstallLocation,
		@dg_ProductID,
		@dg_PackageName,
		@dg_InstallSource ,
		@dg_RegOwner,
		@dg_RegCompany,
		@dg_SKUNumber,
		getdate())
	end
end
go

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

--create table tb_inventory_monitorDetails(

--)
create table tb_inventory_errorLog(
dc_userName varchar(80), 
dc_machineName varchar(100),
dg_description varchar(1000),
df_creationDate datetime
)


create procedure spi_inventory_errorLog(
@dc_userName varchar(80), 
@dc_machineName varchar(100),
@dg_description varchar(1000),
@df_creationDate datetime
)as
begin
insert into dbo.tb_inventory_errorLog values( 
@dc_userName, 
@dc_machineName,
@dg_description,
getdate()
)
end
go


create procedure Sp_insertar_Rptcinfo2(
@dc_RutEnvio varchar(13),
@dc_IdentEnvio varchar(50),
@df_FechaRecep datetime,
@dg_EstEnvio varchar(50),
@dn_TipDoc varchar(25),
@dn_NroDoc int,
@dn_MonTotal int,
@dc_RutEmisor varchar(13),
@dg_NomEmisor varchar(80),
@dc_RutReceptor varchar(13),
@dg_NomReceptor varchar(80),
@df_DocCedFechaEmision datetime,
@dc_RutCedente varchar(13),
@dg_NomCedente varchar(80),
@dg_DirecCedente varchar(80),
@dg_EmailCedente varchar(50),
@dg_RutCesionario varchar(80),
@dg_NomCesionario varchar(80),
@df_FechaCesion datetime,
@dg_DeclJurada varchar(5),
@dn_MontoCedido int,
@df_UltimoVenc datetime,
@dc_IdentCesion varchar(80),
@df_FechaReg datetime
)as
begin
insert into dbo.tb_rptc_info values( 
@dc_RutEnvio,
@dc_IdentEnvio,
@df_FechaRecep,
@dg_EstEnvio,
@dn_TipDoc,
@dn_NroDoc,
@dn_MonTotal,
@dc_RutEmisor,
@dg_NomEmisor,
@dc_RutReceptor,
@dg_NomReceptor,
@df_DocCedFechaEmision,
@dc_RutCedente,
@dg_NomCedente ,
@dg_DirecCedente,
@dg_EmailCedente,
@dg_RutCesionario,
@dg_NomCesionario,
@df_FechaCesion,
@dg_DeclJurada,
@dn_MontoCedido,
@df_UltimoVenc,
@dc_IdentCesion,
getdate()
)end
go