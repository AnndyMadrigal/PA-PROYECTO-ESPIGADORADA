USE [master]
GO
/****** Object:  Database [Espiga_DB]    Script Date: 30/3/2026 12:12:48 ******/
CREATE DATABASE [Espiga_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Espiga_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Espiga_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Espiga_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Espiga_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Espiga_DB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Espiga_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Espiga_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Espiga_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Espiga_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Espiga_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Espiga_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [Espiga_DB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Espiga_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Espiga_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Espiga_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Espiga_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Espiga_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Espiga_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Espiga_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Espiga_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Espiga_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Espiga_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Espiga_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Espiga_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Espiga_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Espiga_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Espiga_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Espiga_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Espiga_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Espiga_DB] SET  MULTI_USER 
GO
ALTER DATABASE [Espiga_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Espiga_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Espiga_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Espiga_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Espiga_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Espiga_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Espiga_DB] SET QUERY_STORE = ON
GO
ALTER DATABASE [Espiga_DB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Espiga_DB]
GO
/****** Object:  Schema [core]    Script Date: 30/3/2026 12:12:48 ******/
CREATE SCHEMA [core]
GO
/****** Object:  Schema [geo]    Script Date: 30/3/2026 12:12:48 ******/
CREATE SCHEMA [geo]
GO
/****** Object:  Schema [inventory]    Script Date: 30/3/2026 12:12:48 ******/
CREATE SCHEMA [inventory]
GO
/****** Object:  Schema [purchasing]    Script Date: 30/3/2026 12:12:48 ******/
CREATE SCHEMA [purchasing]
GO
/****** Object:  Schema [sales]    Script Date: 30/3/2026 12:12:48 ******/
CREATE SCHEMA [sales]
GO
/****** Object:  Table [core].[product_categories]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[product_categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](120) NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[products]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[sku] [varchar](60) NULL,
	[product_name] [nvarchar](150) NOT NULL,
	[description] [nvarchar](500) NULL,
	[image_url] [varchar](500) NULL,
	[category_id] [int] NOT NULL,
	[unit_of_measure] [varchar](10) NOT NULL,
	[min_stock] [decimal](18, 3) NOT NULL,
	[tax_id] [int] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
	[unit_price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[promotions]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[promotions](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_name] [nvarchar](150) NOT NULL,
	[promotion_type] [varchar](20) NOT NULL,
	[promotion_value] [decimal](18, 4) NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[roles]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_code] [varchar](40) NOT NULL,
	[role_name] [varchar](80) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[settings]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[settings](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [nvarchar](150) NOT NULL,
	[currency_symbol] [varchar](5) NOT NULL,
	[support_email] [varchar](100) NOT NULL,
	[low_stock_threshold] [int] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[taxes]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[taxes](
	[tax_id] [int] IDENTITY(1,1) NOT NULL,
	[tax_name] [varchar](40) NOT NULL,
	[tax_rate] [decimal](4, 2) NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[user_addresses]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[user_addresses](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[address_type] [varchar](20) NOT NULL,
	[district_id] [int] NOT NULL,
	[address_line_1] [nvarchar](255) NOT NULL,
	[address_line_2] [nvarchar](255) NULL,
	[zip_code] [varchar](12) NULL,
	[is_primary] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[user_phones]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[user_phones](
	[phone_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[phone_type] [varchar](20) NOT NULL,
	[country_code] [varchar](6) NOT NULL,
	[phone_number] [varchar](30) NOT NULL,
	[is_primary] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[users]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[identification] [varchar](15) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [geo].[cantons]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [geo].[cantons](
	[canton_id] [int] IDENTITY(1,1) NOT NULL,
	[province_id] [int] NOT NULL,
	[canton_name] [nvarchar](80) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[canton_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [geo].[districts]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [geo].[districts](
	[district_id] [int] IDENTITY(1,1) NOT NULL,
	[canton_id] [int] NOT NULL,
	[district_name] [nvarchar](80) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [geo].[provinces]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [geo].[provinces](
	[province_id] [int] IDENTITY(1,1) NOT NULL,
	[province_name] [nvarchar](80) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[province_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [inventory].[inventory_movements]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inventory].[inventory_movements](
	[movement_id] [int] IDENTITY(1,1) NOT NULL,
	[movement_datetime] [datetime] NOT NULL,
	[movement_type] [varchar](20) NOT NULL,
	[product_id] [int] NOT NULL,
	[qty_signed] [decimal](18, 3) NOT NULL,
	[reference_table] [varchar](50) NULL,
	[reference_id] [int] NULL,
	[notes] [nvarchar](250) NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[movement_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [inventory].[inventory_stock]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [inventory].[inventory_stock](
	[inventory_stock_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[qty_available] [decimal](18, 3) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [purchasing].[payment_terms]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [purchasing].[payment_terms](
	[term_id] [int] IDENTITY(1,1) NOT NULL,
	[term_name] [varchar](60) NOT NULL,
	[days_due] [int] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[term_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [purchasing].[purchase_invoice_lines]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [purchasing].[purchase_invoice_lines](
	[purchase_invoice_line_id] [int] IDENTITY(1,1) NOT NULL,
	[purchase_invoice_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[qty] [decimal](18, 3) NOT NULL,
	[unit_cost] [decimal](18, 4) NOT NULL,
	[tax_id] [int] NOT NULL,
	[tax_amount] [decimal](18, 2) NOT NULL,
	[line_total] [decimal](18, 2) NOT NULL,
	[lot_reference] [nvarchar](80) NULL,
	[expiration_date] [date] NULL,
	[received_date] [date] NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchase_invoice_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [purchasing].[purchase_invoices]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [purchasing].[purchase_invoices](
	[purchase_invoice_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[invoice_number] [nvarchar](60) NOT NULL,
	[invoice_date] [date] NOT NULL,
	[term_id] [int] NOT NULL,
	[due_date] [date] NOT NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
	[tax_total] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[notes] [nvarchar](250) NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[purchase_invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [purchasing].[supplier_payments]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [purchasing].[supplier_payments](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[purchase_invoice_id] [int] NOT NULL,
	[payment_date] [datetime] NOT NULL,
	[amount_paid] [decimal](18, 2) NOT NULL,
	[payment_method] [varchar](30) NOT NULL,
	[reference_number] [nvarchar](80) NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [purchasing].[suppliers]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [purchasing].[suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](30) NULL,
	[is_active] [tinyint] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[sales_invoice_lines]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[sales_invoice_lines](
	[sales_invoice_line_id] [int] IDENTITY(1,1) NOT NULL,
	[sales_invoice_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[qty_sold] [decimal](18, 3) NOT NULL,
	[unit_price_list] [decimal](18, 4) NOT NULL,
	[unit_price_final] [decimal](18, 4) NOT NULL,
	[promotion_id] [int] NULL,
	[discount_amount] [decimal](18, 2) NOT NULL,
	[tax_id] [int] NOT NULL,
	[tax_amount] [decimal](18, 2) NOT NULL,
	[line_subtotal] [decimal](18, 2) NOT NULL,
	[line_total] [decimal](18, 2) NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[sales_invoice_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[sales_invoices]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[sales_invoices](
	[sales_invoice_id] [int] IDENTITY(1,1) NOT NULL,
	[sales_number] [nvarchar](50) NULL,
	[sales_datetime] [datetime] NOT NULL,
	[user_id] [int] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[payment_method] [varchar](30) NOT NULL,
	[payment_reference] [nvarchar](80) NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
	[discount_total] [decimal](18, 2) NOT NULL,
	[tax_total] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[notes] [nvarchar](250) NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[sales_invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [core].[product_categories] ON 
GO
INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'Panadería', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
GO
INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'Repostería', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
GO
INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (3, N'Bebidas', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [core].[product_categories] OFF
GO
SET IDENTITY_INSERT [core].[roles] ON 
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'SYS_ADMIN', N'Administrador del Sistema', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'APP_ADMIN', N'Administrador de la App', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (3, N'APP_USER', N'Usuario Cliente', NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [core].[roles] OFF
GO
SET IDENTITY_INSERT [core].[settings] ON 
GO
INSERT [core].[settings] ([setting_id], [company_name], [currency_symbol], [support_email], [low_stock_threshold], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'Espiga Dorada', N'?', N'soporte@espigadorada.com', 5, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.810' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [core].[settings] OFF
GO
SET IDENTITY_INSERT [core].[taxes] ON 
GO
INSERT [core].[taxes] ([tax_id], [tax_name], [tax_rate], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'IVA 13%', CAST(13.00 AS Decimal(4, 2)), 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.800' AS DateTime), NULL)
GO
INSERT [core].[taxes] ([tax_id], [tax_name], [tax_rate], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'Exento', CAST(0.00 AS Decimal(4, 2)), 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.800' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [core].[taxes] OFF
GO
SET IDENTITY_INSERT [core].[users] ON 
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, 3, N'118290068', N'MADRIGAL DELGADO ANNDY JOSSUE', N'amadrigal90068@ufide.ac.cr', N'1234', 1, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:43:05.783' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, 3, N'118290067', N'GUTIERREZ CERSOSIMO JORGE FABRICIO', N'jgutierrez90067@ufide.ac.cr', N'12345', 1, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:43:06.633' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (3, 3, N'118290066', N'SALAZAR AVALOS KEILYN JEANNETH', N'ksalazar90066@ufide.ac.cr', N'12', 0, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:19:13.430' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (4, 3, N'208680839', N'ALFARO RIVERA CAMILA ALEXANDRA', N'calfaro80839@ufide.ac.cr', N'1234', 1, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (5, 2, N'109320181', N'DELGADO MORA ANA JULIA', N'adelgado0181@ufide.ac.cr', N'123', 1, N'MADRIGAL DELGADO ANNDY JOSSUE', NULL, N'UPDATE', CAST(N'2026-03-19T20:49:28.973' AS DateTime), CAST(N'2026-03-19T20:49:28.977' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (6, 3, N'118290053', N'ALVARADO CASTILLO BIANCA LUNA', N'balvarado90053@ufide.ac.cr', N'123', 0, N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-19T23:21:46.690' AS DateTime), CAST(N'2026-03-19T23:44:10.790' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (7, 3, N'119290015', N'CAMPOS KOCHER MARIANA', N'mcampos90015@ufide.ac.cr', N'123', 1, N'DELGADO MORA ANA JULIA', NULL, N'UPDATE', CAST(N'2026-03-19T23:27:05.077' AS DateTime), CAST(N'2026-03-19T23:27:05.077' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (8, 3, N'119970413', N'DELGADO MORA NATALY SOFIA', N'ndelgado70413@ufide.ac.cr', N'123', 1, N'Usuario_Desconocido', NULL, N'UPDATE', CAST(N'2026-03-21T11:50:15.703' AS DateTime), CAST(N'2026-03-21T11:50:15.703' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (9, 3, N'118290018', N'ARAYA GOMEZ CKRISTIAN', N'caraya90018@ufide.ac.cr', N'123', 0, N'Usuario_Desconocido', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-21T12:00:37.557' AS DateTime), CAST(N'2026-03-21T12:01:45.567' AS DateTime))
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (10, 3, N'118290019', N'MORALES SILES ARTURO JOSUE', N'amorales90019@ufide.ac.cr', N'123', 1, N'DELGADO MORA ANA JULIA', NULL, N'INSERT', CAST(N'2026-03-21T12:01:33.097' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [core].[users] OFF
GO
ALTER TABLE [core].[product_categories] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[products] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[products] ADD  CONSTRAINT [DF_products_unit_price]  DEFAULT ((0)) FOR [unit_price]
GO
ALTER TABLE [core].[promotions] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[taxes] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[user_addresses] ADD  DEFAULT ((0)) FOR [is_primary]
GO
ALTER TABLE [core].[user_phones] ADD  DEFAULT ((0)) FOR [is_primary]
GO
ALTER TABLE [purchasing].[suppliers] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_product_categories] FOREIGN KEY([category_id])
REFERENCES [core].[product_categories] ([category_id])
GO
ALTER TABLE [core].[products] CHECK CONSTRAINT [FK_products_product_categories]
GO
ALTER TABLE [core].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
GO
ALTER TABLE [core].[products] CHECK CONSTRAINT [FK_products_taxes]
GO
ALTER TABLE [core].[user_addresses]  WITH CHECK ADD  CONSTRAINT [FK_user_addresses_districts] FOREIGN KEY([district_id])
REFERENCES [geo].[districts] ([district_id])
GO
ALTER TABLE [core].[user_addresses] CHECK CONSTRAINT [FK_user_addresses_districts]
GO
ALTER TABLE [core].[user_addresses]  WITH CHECK ADD  CONSTRAINT [FK_user_addresses_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
GO
ALTER TABLE [core].[user_addresses] CHECK CONSTRAINT [FK_user_addresses_users]
GO
ALTER TABLE [core].[user_phones]  WITH CHECK ADD  CONSTRAINT [FK_user_phones_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
GO
ALTER TABLE [core].[user_phones] CHECK CONSTRAINT [FK_user_phones_users]
GO
ALTER TABLE [core].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([role_id])
REFERENCES [core].[roles] ([role_id])
GO
ALTER TABLE [core].[users] CHECK CONSTRAINT [FK_users_roles]
GO
ALTER TABLE [geo].[cantons]  WITH CHECK ADD  CONSTRAINT [FK_cantons_provinces] FOREIGN KEY([province_id])
REFERENCES [geo].[provinces] ([province_id])
GO
ALTER TABLE [geo].[cantons] CHECK CONSTRAINT [FK_cantons_provinces]
GO
ALTER TABLE [geo].[districts]  WITH CHECK ADD  CONSTRAINT [FK_districts_cantons] FOREIGN KEY([canton_id])
REFERENCES [geo].[cantons] ([canton_id])
GO
ALTER TABLE [geo].[districts] CHECK CONSTRAINT [FK_districts_cantons]
GO
ALTER TABLE [inventory].[inventory_movements]  WITH CHECK ADD  CONSTRAINT [FK_inventory_movements_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
GO
ALTER TABLE [inventory].[inventory_movements] CHECK CONSTRAINT [FK_inventory_movements_products]
GO
ALTER TABLE [inventory].[inventory_stock]  WITH CHECK ADD  CONSTRAINT [FK_inventory_stock_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
GO
ALTER TABLE [inventory].[inventory_stock] CHECK CONSTRAINT [FK_inventory_stock_products]
GO
ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
GO
ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_products]
GO
ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_purchase_invoices] FOREIGN KEY([purchase_invoice_id])
REFERENCES [purchasing].[purchase_invoices] ([purchase_invoice_id])
GO
ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_purchase_invoices]
GO
ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
GO
ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_taxes]
GO
ALTER TABLE [purchasing].[purchase_invoices]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoices_payment_terms] FOREIGN KEY([term_id])
REFERENCES [purchasing].[payment_terms] ([term_id])
GO
ALTER TABLE [purchasing].[purchase_invoices] CHECK CONSTRAINT [FK_purchase_invoices_payment_terms]
GO
ALTER TABLE [purchasing].[purchase_invoices]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoices_suppliers] FOREIGN KEY([supplier_id])
REFERENCES [purchasing].[suppliers] ([supplier_id])
GO
ALTER TABLE [purchasing].[purchase_invoices] CHECK CONSTRAINT [FK_purchase_invoices_suppliers]
GO
ALTER TABLE [purchasing].[supplier_payments]  WITH CHECK ADD  CONSTRAINT [FK_supplier_payments_purchase_invoices] FOREIGN KEY([purchase_invoice_id])
REFERENCES [purchasing].[purchase_invoices] ([purchase_invoice_id])
GO
ALTER TABLE [purchasing].[supplier_payments] CHECK CONSTRAINT [FK_supplier_payments_purchase_invoices]
GO
ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
GO
ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_products]
GO
ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_promotions] FOREIGN KEY([promotion_id])
REFERENCES [core].[promotions] ([promotion_id])
GO
ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_promotions]
GO
ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_sales_invoices] FOREIGN KEY([sales_invoice_id])
REFERENCES [sales].[sales_invoices] ([sales_invoice_id])
GO
ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_sales_invoices]
GO
ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
GO
ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_taxes]
GO
ALTER TABLE [sales].[sales_invoices]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoices_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
GO
ALTER TABLE [sales].[sales_invoices] CHECK CONSTRAINT [FK_sales_invoices_users]
GO
/****** Object:  StoredProcedure [core].[GetUserById]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [core].[GetUserById]
    @UserId INT
AS
BEGIN
    SELECT  user_id, 
            role_id, 
            identification, 
            name, 
            email, 
            is_active
    FROM    core.users
    WHERE   user_id = @UserId;
END
GO
/****** Object:  StoredProcedure [core].[LoginUser]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [core].[LoginUser]
	@Email varchar(100),
	@Password varchar(255)
AS
BEGIN
	
	SELECT	U.user_id,
			identification,
			name,
			email,
			U.role_id,
			R.role_name
	FROM	users U
	INNER	JOIN roles R ON U.role_id = R.role_id
	WHERE	email = @Email
		AND password = @Password
		AND is_active = 1

END
GO
/****** Object:  StoredProcedure [core].[RegisterProduct]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 2. Crear o actualizar SP para registrar productos */
CREATE   PROCEDURE [core].[RegisterProduct]
    @Sku VARCHAR(60),
    @ProductName NVARCHAR(150),
    @Description NVARCHAR(500),
    @ImageUrl VARCHAR(500),
    @CategoryId INT,
    @UnitOfMeasure VARCHAR(10),
    @MinStock DECIMAL(18,3),
    @TaxId INT,
    @UnitPrice DECIMAL(18,2),
    @CreatedBy VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO core.products
    (
        sku,
        product_name,
        description,
        image_url,
        category_id,
        unit_of_measure,
        min_stock,
        tax_id,
        unit_price,
        is_active,
        created_by
    )
    VALUES
    (
        @Sku,
        @ProductName,
        @Description,
        @ImageUrl,
        @CategoryId,
        @UnitOfMeasure,
        @MinStock,
        @TaxId,
        @UnitPrice,
        1,
        @CreatedBy
    );
END
GO
/****** Object:  StoredProcedure [core].[RegisterUser]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [core].[RegisterUser]
    @RoleId INT,
    @Identification varchar(15),
    @Name varchar(100),
    @Email varchar(100),
    @Password varchar(255),
    @CreatedBy varchar(100)
AS
BEGIN
    Declare @Is_Active INT = 1
    
    INSERT INTO core.users (role_id, identification, name, email, password, is_active, created_by)
    VALUES (@RoleId, @Identification, @Name, @Email, @Password, @Is_Active, @CreatedBy)
END
GO
/****** Object:  StoredProcedure [core].[UpdatePassword]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [core].[UpdatePassword]
	@Password VARCHAR(255),
	@User_id INT,
	@ModifiedBy varchar(100)
AS
BEGIN
	
	UPDATE	core.users
	SET		password = @Password,
			modified_by = @ModifiedBy
	WHERE	user_id = @User_id

END
GO
/****** Object:  StoredProcedure [core].[UpdateUser]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [core].[UpdateUser]
    @UserId INT,
    @Identification VARCHAR(15),
    @Name VARCHAR(100),
    @Email VARCHAR(100),
    @ModifiedBy VARCHAR(100)
AS
BEGIN
    UPDATE  core.users
    SET     identification = @Identification,
            name = @Name,
            email = @Email,
            modified_by = @ModifiedBy
    WHERE   user_id = @UserId;
END
GO
/****** Object:  StoredProcedure [core].[ValidateEmail]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [core].[ValidateEmail]
	@Email varchar(100)
AS
BEGIN
	
	SELECT	user_id,
			identification,
			name,
			email
	FROM	users
	WHERE	email = @Email
		AND is_active = 1

END
GO
/****** Object:  StoredProcedure [purchasing].[AdministerPaymentTerms]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [purchasing].[AdministerPaymentTerms]
    @Accion       VARCHAR(10),
    @TermId       INT = NULL,
    @TermName     VARCHAR(100) = NULL,
    @DaysDue      INT = NULL,
    @CreatedBy    VARCHAR(100) = NULL,
    @ModifiedBy   VARCHAR(100) = NULL,
    @ActionValue  VARCHAR(1) = NULL,
    @CreatedAt    DATETIME = NULL,
    @ModifiedAt   DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Codigo INT = 0,
            @Mensaje VARCHAR(200) = '',
            @Ahora DATETIME = GETDATE();

    SET @Accion = UPPER(ISNULL(@Accion, ''));
    SET @TermName = LTRIM(RTRIM(ISNULL(@TermName, '')));

    BEGIN TRY

        IF @Accion = 'READ'
        BEGIN
            SELECT
                1 AS Codigo,
                'OK' AS Tag,
                'Consulta exitosa' AS Mensaje,
                term_id AS TermId,
                term_name AS TermName,
                days_due AS DaysDue,
                created_by AS CreatedBy,
                modified_by AS ModifiedBy,
                [action] AS ActionValue,
                created_at AS CreatedAt,
                modified_at AS ModifiedAt
            FROM [Espiga_DB].[purchasing].[payment_terms]
            ORDER BY term_id DESC;

            RETURN;
        END

        IF @Accion NOT IN ('INSERT', 'UPDATE', 'DELETE')
            SET @Mensaje = 'La acción enviada no es válida.';

        IF @Mensaje = ''
           AND @Accion IN ('UPDATE', 'DELETE')
           AND (
                ISNULL(@TermId, 0) = 0
                OR NOT EXISTS (
                    SELECT 1
                    FROM [Espiga_DB].[purchasing].[payment_terms]
                    WHERE term_id = @TermId
                )
           )
        BEGIN
            SET @Mensaje = 'El término de pago no existe.';
        END

        IF @Mensaje = ''
           AND @Accion IN ('INSERT', 'UPDATE')
        BEGIN
            IF @TermName = ''
                SET @Mensaje = 'El nombre del término es requerido.';
            ELSE IF @DaysDue IS NULL OR @DaysDue < 0
                SET @Mensaje = 'Los días de vencimiento son requeridos.';
            ELSE IF EXISTS (
                SELECT 1
                FROM [Espiga_DB].[purchasing].[payment_terms]
                WHERE term_name = @TermName
                  AND ISNULL([action], 'I') <> 'D'
                  AND (@Accion = 'INSERT' OR term_id <> @TermId)
            )
                SET @Mensaje = 'Ya existe un término de pago con ese nombre.';
        END

        IF @Mensaje = ''
        BEGIN
            IF @Accion = 'INSERT'
            BEGIN
                INSERT INTO [Espiga_DB].[purchasing].[payment_terms]
                (
                    term_name,
                    days_due,
                    created_by,
                    modified_by,
                    [action],
                    created_at,
                    modified_at
                )
                VALUES
                (
                    @TermName,
                    @DaysDue,
                    ISNULL(@CreatedBy, 'system'),
                    ISNULL(@ModifiedBy, ISNULL(@CreatedBy, 'system')),
                    ISNULL(@ActionValue, 'I'),
                    ISNULL(@CreatedAt, @Ahora),
                    ISNULL(@ModifiedAt, @Ahora)
                );

                SET @Codigo = 1;
                SET @Mensaje = 'Término de pago registrado correctamente.';
            END

            IF @Accion = 'UPDATE'
            BEGIN
                UPDATE [Espiga_DB].[purchasing].[payment_terms]
                SET
                    term_name = @TermName,
                    days_due = @DaysDue,
                    modified_by = ISNULL(@ModifiedBy, 'system'),
                    [action] = ISNULL(@ActionValue, 'U'),
                    modified_at = ISNULL(@ModifiedAt, @Ahora)
                WHERE term_id = @TermId;

                SET @Codigo = 1;
                SET @Mensaje = 'Término de pago actualizado correctamente.';
            END

            IF @Accion = 'DELETE'
            BEGIN
                UPDATE [Espiga_DB].[purchasing].[payment_terms]
                SET
                    [action] = ISNULL(@ActionValue, 'D'),
                    modified_by = ISNULL(@ModifiedBy, 'system'),
                    modified_at = ISNULL(@ModifiedAt, @Ahora)
                WHERE term_id = @TermId;

                SET @Codigo = 1;
                SET @Mensaje = 'Término de pago eliminado correctamente.';
            END
        END

    END TRY
    BEGIN CATCH
        SET @Codigo = 0;
        SET @Mensaje = ERROR_MESSAGE();
    END CATCH

    SELECT
        @Codigo AS Codigo,
        CASE WHEN @Codigo = 1 THEN 'OK' ELSE 'ERROR' END AS Tag,
        @Mensaje AS Mensaje,
        CAST(NULL AS INT) AS TermId,
        CAST(NULL AS VARCHAR(100)) AS TermName,
        CAST(NULL AS INT) AS DaysDue,
        CAST(NULL AS VARCHAR(100)) AS CreatedBy,
        CAST(NULL AS VARCHAR(100)) AS ModifiedBy,
        CAST(NULL AS VARCHAR(1)) AS ActionValue,
        CAST(NULL AS DATETIME) AS CreatedAt,
        CAST(NULL AS DATETIME) AS ModifiedAt;
END
GO
/****** Object:  Trigger [core].[trg_product_categories_insert]    Script Date: 30/3/2026 12:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 6. core.product_categories
-- ==========================================
CREATE TRIGGER [core].[trg_product_categories_insert]
ON [core].[product_categories]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.product_categories t
    INNER JOIN inserted i ON t.category_id = i.category_id;
END;
GO
ALTER TABLE [core].[product_categories] ENABLE TRIGGER [trg_product_categories_insert]
GO
/****** Object:  Trigger [core].[trg_product_categories_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 5. core.product_categories
-- ==========================================
CREATE TRIGGER [core].[trg_product_categories_update]
ON [core].[product_categories]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.product_categories t
    INNER JOIN inserted i ON t.category_id = i.category_id;
END;
GO
ALTER TABLE [core].[product_categories] ENABLE TRIGGER [trg_product_categories_update]
GO
/****** Object:  Trigger [core].[trg_products_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 8. core.products
-- ==========================================
CREATE TRIGGER [core].[trg_products_insert]
ON [core].[products]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.products t
    INNER JOIN inserted i ON t.product_id = i.product_id;
END;
GO
ALTER TABLE [core].[products] ENABLE TRIGGER [trg_products_insert]
GO
/****** Object:  Trigger [core].[trg_products_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 7. core.products
-- ==========================================
CREATE TRIGGER [core].[trg_products_update]
ON [core].[products]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.products t
    INNER JOIN inserted i ON t.product_id = i.product_id;
END;
GO
ALTER TABLE [core].[products] ENABLE TRIGGER [trg_products_update]
GO
/****** Object:  Trigger [core].[trg_promotions_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 9. core.promotions
-- ==========================================
CREATE TRIGGER [core].[trg_promotions_insert]
ON [core].[promotions]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.promotions t
    INNER JOIN inserted i ON t.promotion_id = i.promotion_id;
END;
GO
ALTER TABLE [core].[promotions] ENABLE TRIGGER [trg_promotions_insert]
GO
/****** Object:  Trigger [core].[trg_promotions_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 8. core.promotions
-- ==========================================
CREATE TRIGGER [core].[trg_promotions_update]
ON [core].[promotions]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.promotions t
    INNER JOIN inserted i ON t.promotion_id = i.promotion_id;
END;
GO
ALTER TABLE [core].[promotions] ENABLE TRIGGER [trg_promotions_update]
GO
/****** Object:  Trigger [core].[trg_roles_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. core.roles
-- ==========================================
CREATE TRIGGER [core].[trg_roles_insert]
ON [core].[roles]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.roles t
    INNER JOIN inserted i ON t.role_id = i.role_id;
END;
GO
ALTER TABLE [core].[roles] ENABLE TRIGGER [trg_roles_insert]
GO
/****** Object:  Trigger [core].[trg_roles_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. core.roles
-- ==========================================
CREATE TRIGGER [core].[trg_roles_update]
ON [core].[roles]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.roles t
    INNER JOIN inserted i ON t.role_id = i.role_id;
END;
GO
ALTER TABLE [core].[roles] ENABLE TRIGGER [trg_roles_update]
GO
/****** Object:  Trigger [core].[trg_settings_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 1. core.settings
-- ==========================================
CREATE TRIGGER [core].[trg_settings_insert]
ON [core].[settings]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.settings t
    INNER JOIN inserted i ON t.setting_id = i.setting_id;
END;
GO
ALTER TABLE [core].[settings] ENABLE TRIGGER [trg_settings_insert]
GO
/****** Object:  Trigger [core].[trg_settings_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [core].[trg_settings_update]
ON [core].[settings]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.settings t
    INNER JOIN inserted i ON t.setting_id = i.setting_id;
END;
GO
ALTER TABLE [core].[settings] ENABLE TRIGGER [trg_settings_update]
GO
/****** Object:  Trigger [core].[trg_taxes_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 7. core.taxes
-- ==========================================
CREATE TRIGGER [core].[trg_taxes_insert]
ON [core].[taxes]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.taxes t
    INNER JOIN inserted i ON t.tax_id = i.tax_id;
END;
GO
ALTER TABLE [core].[taxes] ENABLE TRIGGER [trg_taxes_insert]
GO
/****** Object:  Trigger [core].[trg_taxes_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 6. core.taxes
-- ==========================================
CREATE TRIGGER [core].[trg_taxes_update]
ON [core].[taxes]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.taxes t
    INNER JOIN inserted i ON t.tax_id = i.tax_id;
END;
GO
ALTER TABLE [core].[taxes] ENABLE TRIGGER [trg_taxes_update]
GO
/****** Object:  Trigger [core].[trg_user_addresses_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 5. core.user_addresses
-- ==========================================
CREATE TRIGGER [core].[trg_user_addresses_insert]
ON [core].[user_addresses]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.user_addresses t
    INNER JOIN inserted i ON t.address_id = i.address_id;
END;
GO
ALTER TABLE [core].[user_addresses] ENABLE TRIGGER [trg_user_addresses_insert]
GO
/****** Object:  Trigger [core].[trg_user_addresses_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 4. core.user_addresses
-- ==========================================
CREATE TRIGGER [core].[trg_user_addresses_update]
ON [core].[user_addresses]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.user_addresses t
    INNER JOIN inserted i ON t.address_id = i.address_id;
END;
GO
ALTER TABLE [core].[user_addresses] ENABLE TRIGGER [trg_user_addresses_update]
GO
/****** Object:  Trigger [core].[trg_user_phones_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 4. core.user_phones
-- ==========================================
CREATE TRIGGER [core].[trg_user_phones_insert]
ON [core].[user_phones]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.user_phones t
    INNER JOIN inserted i ON t.phone_id = i.phone_id;
END;
GO
ALTER TABLE [core].[user_phones] ENABLE TRIGGER [trg_user_phones_insert]
GO
/****** Object:  Trigger [core].[trg_user_phones_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 3. core.user_phones
-- ==========================================
CREATE TRIGGER [core].[trg_user_phones_update]
ON [core].[user_phones]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.user_phones t
    INNER JOIN inserted i ON t.phone_id = i.phone_id;
END;
GO
ALTER TABLE [core].[user_phones] ENABLE TRIGGER [trg_user_phones_update]
GO
/****** Object:  Trigger [core].[trg_users_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 3. core.users
-- ==========================================
CREATE TRIGGER [core].[trg_users_insert]
ON [core].[users]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM core.users t
    INNER JOIN inserted i ON t.user_id = i.user_id;
END;
GO
ALTER TABLE [core].[users] ENABLE TRIGGER [trg_users_insert]
GO
/****** Object:  Trigger [core].[trg_users_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [core].[trg_users_update]
ON [core].[users]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- EL FRENO: Si este trigger fue invocado por el trigger de INSERT (efecto dominó), 
    -- abortamos la ejecución inmediatamente.
    IF (TRIGGER_NESTLEVEL() > 1)
        RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM core.users t
    INNER JOIN inserted i ON t.user_id = i.user_id;
END;

GO
ALTER TABLE [core].[users] ENABLE TRIGGER [trg_users_update]
GO
/****** Object:  Trigger [geo].[trg_cantons_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. geo.cantons
-- ==========================================
CREATE TRIGGER [geo].[trg_cantons_insert]
ON [geo].[cantons]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM geo.cantons t
    INNER JOIN inserted i ON t.canton_id = i.canton_id;
END;
GO
ALTER TABLE [geo].[cantons] ENABLE TRIGGER [trg_cantons_insert]
GO
/****** Object:  Trigger [geo].[trg_cantons_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [geo].[trg_cantons_update]
ON [geo].[cantons]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM geo.cantons t
    INNER JOIN inserted i ON t.canton_id = i.canton_id;
END;
GO
ALTER TABLE [geo].[cantons] ENABLE TRIGGER [trg_cantons_update]
GO
/****** Object:  Trigger [geo].[trg_districts_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 3. geo.districts
-- ==========================================
CREATE TRIGGER [geo].[trg_districts_insert]
ON [geo].[districts]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM geo.districts t
    INNER JOIN inserted i ON t.district_id = i.district_id;
END;
GO
ALTER TABLE [geo].[districts] ENABLE TRIGGER [trg_districts_insert]
GO
/****** Object:  Trigger [geo].[trg_districts_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [geo].[trg_districts_update]
ON [geo].[districts]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM geo.districts t
    INNER JOIN inserted i ON t.district_id = i.district_id;
END;
GO
ALTER TABLE [geo].[districts] ENABLE TRIGGER [trg_districts_update]
GO
/****** Object:  Trigger [geo].[trg_provinces_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 1. geo.provinces
-- ==========================================
CREATE TRIGGER [geo].[trg_provinces_insert]
ON [geo].[provinces]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM geo.provinces t
    INNER JOIN inserted i ON t.province_id = i.province_id;
END;
GO
ALTER TABLE [geo].[provinces] ENABLE TRIGGER [trg_provinces_insert]
GO
/****** Object:  Trigger [geo].[trg_provinces_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [geo].[trg_provinces_update]
ON [geo].[provinces]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM geo.provinces t
    INNER JOIN inserted i ON t.province_id = i.province_id;
END;
GO
ALTER TABLE [geo].[provinces] ENABLE TRIGGER [trg_provinces_update]
GO
/****** Object:  Trigger [inventory].[trg_inventory_movements_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. inventory.inventory_movements
-- ==========================================
CREATE TRIGGER [inventory].[trg_inventory_movements_insert]
ON [inventory].[inventory_movements]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM inventory.inventory_movements t
    INNER JOIN inserted i ON t.movement_id = i.movement_id;
END;

GO
ALTER TABLE [inventory].[inventory_movements] ENABLE TRIGGER [trg_inventory_movements_insert]
GO
/****** Object:  Trigger [inventory].[trg_inventory_movements_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- ESQUEMA: INVENTORY
-- ==========================================

CREATE TRIGGER [inventory].[trg_inventory_movements_update]
ON [inventory].[inventory_movements]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM inventory.inventory_movements t
    INNER JOIN inserted i ON t.movement_id = i.movement_id;
END;
GO
ALTER TABLE [inventory].[inventory_movements] ENABLE TRIGGER [trg_inventory_movements_update]
GO
/****** Object:  Trigger [inventory].[trg_inventory_stock_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---END PURCHASING---
-- ==========================================
-- 1. inventory.inventory_stock
-- ==========================================
CREATE TRIGGER [inventory].[trg_inventory_stock_insert]
ON [inventory].[inventory_stock]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM inventory.inventory_stock t
    INNER JOIN inserted i ON t.inventory_stock_id = i.inventory_stock_id;
END;

GO
ALTER TABLE [inventory].[inventory_stock] ENABLE TRIGGER [trg_inventory_stock_insert]
GO
/****** Object:  Trigger [inventory].[trg_inventory_stock_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [inventory].[trg_inventory_stock_update]
ON [inventory].[inventory_stock]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM inventory.inventory_stock t
    INNER JOIN inserted i ON t.inventory_stock_id = i.inventory_stock_id;
END;
GO
ALTER TABLE [inventory].[inventory_stock] ENABLE TRIGGER [trg_inventory_stock_update]
GO
/****** Object:  Trigger [purchasing].[trg_payment_terms_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. purchasing.payment_terms
-- ==========================================
CREATE TRIGGER [purchasing].[trg_payment_terms_insert]
ON [purchasing].[payment_terms]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM purchasing.payment_terms t
    INNER JOIN inserted i ON t.term_id = i.term_id;
END;
GO
ALTER TABLE [purchasing].[payment_terms] ENABLE TRIGGER [trg_payment_terms_insert]
GO
/****** Object:  Trigger [purchasing].[trg_payment_terms_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- ESQUEMA: PURCHASING
-- ==========================================

CREATE TRIGGER [purchasing].[trg_payment_terms_update]
ON [purchasing].[payment_terms]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM purchasing.payment_terms t
    INNER JOIN inserted i ON t.term_id = i.term_id;
END;
GO
ALTER TABLE [purchasing].[payment_terms] ENABLE TRIGGER [trg_payment_terms_update]
GO
/****** Object:  Trigger [purchasing].[trg_purchase_invoice_lines_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 4. purchasing.purchase_invoice_lines
-- ==========================================
CREATE TRIGGER [purchasing].[trg_purchase_invoice_lines_insert]
ON [purchasing].[purchase_invoice_lines]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM purchasing.purchase_invoice_lines t
    INNER JOIN inserted i ON t.purchase_invoice_line_id = i.purchase_invoice_line_id;
END;
GO
ALTER TABLE [purchasing].[purchase_invoice_lines] ENABLE TRIGGER [trg_purchase_invoice_lines_insert]
GO
/****** Object:  Trigger [purchasing].[trg_purchase_invoice_lines_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [purchasing].[trg_purchase_invoice_lines_update]
ON [purchasing].[purchase_invoice_lines]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM purchasing.purchase_invoice_lines t
    INNER JOIN inserted i ON t.purchase_invoice_line_id = i.purchase_invoice_line_id;
END;
GO
ALTER TABLE [purchasing].[purchase_invoice_lines] ENABLE TRIGGER [trg_purchase_invoice_lines_update]
GO
/****** Object:  Trigger [purchasing].[trg_purchase_invoices_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 3. purchasing.purchase_invoices
-- ==========================================
CREATE TRIGGER [purchasing].[trg_purchase_invoices_insert]
ON [purchasing].[purchase_invoices]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM purchasing.purchase_invoices t
    INNER JOIN inserted i ON t.purchase_invoice_id = i.purchase_invoice_id;
END;
GO
ALTER TABLE [purchasing].[purchase_invoices] ENABLE TRIGGER [trg_purchase_invoices_insert]
GO
/****** Object:  Trigger [purchasing].[trg_purchase_invoices_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [purchasing].[trg_purchase_invoices_update]
ON [purchasing].[purchase_invoices]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM purchasing.purchase_invoices t
    INNER JOIN inserted i ON t.purchase_invoice_id = i.purchase_invoice_id;
END;
GO
ALTER TABLE [purchasing].[purchase_invoices] ENABLE TRIGGER [trg_purchase_invoices_update]
GO
/****** Object:  Trigger [purchasing].[trg_supplier_payments_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. TRIGGER PARA INSERT
-- ==========================================
CREATE TRIGGER [purchasing].[trg_supplier_payments_insert]
ON [purchasing].[supplier_payments]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM purchasing.supplier_payments t
    INNER JOIN inserted i ON t.payment_id = i.payment_id;
END;

GO
ALTER TABLE [purchasing].[supplier_payments] ENABLE TRIGGER [trg_supplier_payments_insert]
GO
/****** Object:  Trigger [purchasing].[trg_supplier_payments_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 9. purchasing.supplier_payments
-- ==========================================
CREATE TRIGGER [purchasing].[trg_supplier_payments_update]
ON [purchasing].[supplier_payments]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM purchasing.supplier_payments t
    INNER JOIN inserted i ON t.payment_id = i.payment_id;
END;
GO
ALTER TABLE [purchasing].[supplier_payments] ENABLE TRIGGER [trg_supplier_payments_update]
GO
/****** Object:  Trigger [purchasing].[trg_suppliers_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 1. purchasing.suppliers
-- ==========================================
CREATE TRIGGER [purchasing].[trg_suppliers_insert]
ON [purchasing].[suppliers]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM purchasing.suppliers t
    INNER JOIN inserted i ON t.supplier_id = i.supplier_id;
END;
GO
ALTER TABLE [purchasing].[suppliers] ENABLE TRIGGER [trg_suppliers_insert]
GO
/****** Object:  Trigger [purchasing].[trg_suppliers_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [purchasing].[trg_suppliers_update]
ON [purchasing].[suppliers]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM purchasing.suppliers t
    INNER JOIN inserted i ON t.supplier_id = i.supplier_id;
END;
GO
ALTER TABLE [purchasing].[suppliers] ENABLE TRIGGER [trg_suppliers_update]
GO
/****** Object:  Trigger [sales].[trg_sales_invoice_lines_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- 2. sales.sales_invoice_lines
-- ==========================================
CREATE TRIGGER [sales].[trg_sales_invoice_lines_insert]
ON [sales].[sales_invoice_lines]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM sales.sales_invoice_lines t
    INNER JOIN inserted i ON t.sales_invoice_line_id = i.sales_invoice_line_id;
END;
GO
ALTER TABLE [sales].[sales_invoice_lines] ENABLE TRIGGER [trg_sales_invoice_lines_insert]
GO
/****** Object:  Trigger [sales].[trg_sales_invoice_lines_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [sales].[trg_sales_invoice_lines_update]
ON [sales].[sales_invoice_lines]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM sales.sales_invoice_lines t
    INNER JOIN inserted i ON t.sales_invoice_line_id = i.sales_invoice_line_id;
END;
GO
ALTER TABLE [sales].[sales_invoice_lines] ENABLE TRIGGER [trg_sales_invoice_lines_update]
GO
/****** Object:  Trigger [sales].[trg_sales_invoices_insert]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [sales].[trg_sales_invoices_insert]
ON [sales].[sales_invoices]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    
    UPDATE t
    SET 
        -- 1. Campos de Auditoría que ya teníamos
        t.created_at = GETDATE(),
        t.action = 'INSERT',
        
        -- 2. Generación automática del Número de Factura
        -- FORMAT extrae el AñoMesDía de la fecha de la factura.
        -- RIGHT con '00000' asegura que el ID siempre tenga al menos 5 dígitos de ancho.
        t.sales_number = FORMAT(i.sales_datetime, 'yyyyMMdd') + RIGHT('00000' + CAST(i.sales_invoice_id AS VARCHAR(10)), 5)
        
    FROM sales.sales_invoices t
    INNER JOIN inserted i ON t.sales_invoice_id = i.sales_invoice_id;
END;

GO
ALTER TABLE [sales].[sales_invoices] ENABLE TRIGGER [trg_sales_invoices_insert]
GO
/****** Object:  Trigger [sales].[trg_sales_invoices_update]    Script Date: 30/3/2026 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==========================================
-- ESQUEMA: SALES
-- ==========================================

CREATE TRIGGER [sales].[trg_sales_invoices_update]
ON [sales].[sales_invoices]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM sales.sales_invoices t
    INNER JOIN inserted i ON t.sales_invoice_id = i.sales_invoice_id;
END;
GO
ALTER TABLE [sales].[sales_invoices] ENABLE TRIGGER [trg_sales_invoices_update]
GO
USE [master]
GO
ALTER DATABASE [Espiga_DB] SET  READ_WRITE 
GO
