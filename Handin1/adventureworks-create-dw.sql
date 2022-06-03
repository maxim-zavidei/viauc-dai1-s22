USE [master]
GO

/****** Object:  Database [AdventureWorks2019DW]    Script Date: 03/03/2022 07:58:34 PM ******/
CREATE DATABASE [AdventureWorks2019DW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AdventureWorks2019DW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019DW.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AdventureWorks2019DW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019DW_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AdventureWorks2019DW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [AdventureWorks2019DW] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ARITHABORT OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [AdventureWorks2019DW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [AdventureWorks2019DW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET  DISABLE_BROKER 
GO

ALTER DATABASE [AdventureWorks2019DW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [AdventureWorks2019DW] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET RECOVERY FULL 
GO

ALTER DATABASE [AdventureWorks2019DW] SET  MULTI_USER 
GO

ALTER DATABASE [AdventureWorks2019DW] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [AdventureWorks2019DW] SET DB_CHAINING OFF 
GO

ALTER DATABASE [AdventureWorks2019DW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [AdventureWorks2019DW] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [AdventureWorks2019DW] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [AdventureWorks2019DW] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [AdventureWorks2019DW] SET QUERY_STORE = OFF
GO

ALTER DATABASE [AdventureWorks2019DW] SET  READ_WRITE 
GO

USE [AdventureWorks2019DW]
CREATE SCHEMA [stage]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Customer]') AND type in (N'U'))

CREATE TABLE stage.Dim_Customer (
 C_ID INT NOT NULL,
 CustomerID INT NOT NULL,
 CompanyName NVARCHAR(50) NOT NULL,
 CustomerName NVARCHAR(150),
 CustomerType NVARCHAR(2) NOT NULL,
 City NVARCHAR(30) NOT NULL,
 Region NVARCHAR(50) NOT NULL,
 PostalCode NVARCHAR(15) NOT NULL,
 Country NVARCHAR(50) NOT NULL,
 Address NVARCHAR(60)
);

ALTER TABLE stage.Dim_Customer ADD CONSTRAINT PK_Dim_Customer PRIMARY KEY (C_ID);

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Date]') AND type in (N'U'))

CREATE TABLE stage.Dim_Date (
 DateId INT NOT NULL,
 DayOfWeek NVARCHAR(15) NOT NULL,
 Day INT NOT NULL,
 Month INT NOT NULL,
 MonthName NVARCHAR(15),
 Year INT NOT NULL,
 Quarter NCHAR(2) NOT NULL
);

ALTER TABLE stage.Dim_Date ADD CONSTRAINT PK_Dim_Date PRIMARY KEY (DateId);

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Employee]') AND type in (N'U'))

CREATE TABLE stage.Dim_Employee (
 E_ID INT NOT NULL,
 EmployeeID INT,
 EmployeeType NCHAR(2) NOT NULL,
 EmployeeName NVARCHAR(150) NOT NULL,
 JobTitle NVARCHAR(50) NOT NULL,
 City NVARCHAR(30) NOT NULL,
 Region NVARCHAR(50) NOT NULL,
 PostalCode NVARCHAR(15) NOT NULL,
 Country NVARCHAR(10) NOT NULL
);

ALTER TABLE stage.Dim_Employee ADD CONSTRAINT PK_Dim_Employee PRIMARY KEY (E_ID);


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Location]') AND type in (N'U'))


CREATE TABLE stage.Dim_Location (
 L_ID INT NOT NULL,
 TerritoryId INT NOT NULL,
 City NVARCHAR(30) NOT NULL,
 Region NVARCHAR(50) NOT NULL,
 PostalCode NVARCHAR(15) NOT NULL,
 Country NVARCHAR(50) NOT NULL
);

ALTER TABLE stage.Dim_Location ADD CONSTRAINT PK_Dim_Location PRIMARY KEY (L_ID);


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Order]') AND type in (N'U'))

CREATE TABLE stage.Dim_Order (
 O_ID INT NOT NULL,
 OrderID INT NOT NULL,
 BillingAddress NVARCHAR(60),
 DeliveryAddress NVARCHAR(60),
 OnlineOrderFlag BIT NOT NULL
);

ALTER TABLE stage.Dim_Order ADD CONSTRAINT PK_Dim_Order PRIMARY KEY (O_ID);


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Dim_Product]') AND type in (N'U'))

CREATE TABLE stage.Dim_Product (
 P_ID INT NOT NULL,
 ProductID INT,
 ProductName NVARCHAR(50) NOT NULL,
 ProductNumber NVARCHAR(25) NOT NULL,
 ManufacturerName NVARCHAR(50),
 CategoryName NVARCHAR(50) NOT NULL,
 Subcategory NVARCHAR(50) NOT NULL,
 DiscontinuedDate DateTime
);

ALTER TABLE stage.Dim_Product ADD CONSTRAINT PK_Dim_Product PRIMARY KEY (P_ID);


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stage].[Fact_Sale]') AND type in (N'U'))

CREATE TABLE stage.Fact_Sale (
 P_ID INT NOT NULL,
 C_ID INT NOT NULL,
 E_ID INT NOT NULL,
 O_ID INT NOT NULL,
 DateId INT NOT NULL,
 L_ID INT NOT NULL,
 TotalAmountInEU NUMERIC(38,6) NOT NULL,
 Quantity SMALLINT NOT NULL,
 TaxRate DECIMAL(10)
);

ALTER TABLE stage.Fact_Sale ADD CONSTRAINT PK_Fact_Sale PRIMARY KEY (P_ID,C_ID,E_ID,O_ID,DateId,L_ID);


ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_0 FOREIGN KEY (P_ID) REFERENCES Dim_Product (P_ID);
ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_1 FOREIGN KEY (C_ID) REFERENCES Dim_Customer (C_ID);
ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_2 FOREIGN KEY (E_ID) REFERENCES Dim_Employee (E_ID);
ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_3 FOREIGN KEY (O_ID) REFERENCES Dim_Order (O_ID);
ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_4 FOREIGN KEY (DateId) REFERENCES Dim_Date (DateId);
ALTER TABLE Fact_Sale ADD CONSTRAINT FK_Fact_Sale_5 FOREIGN KEY (L_ID) REFERENCES Dim_Location (L_ID);