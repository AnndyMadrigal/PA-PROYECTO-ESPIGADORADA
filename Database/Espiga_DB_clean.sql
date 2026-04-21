/* =========================================================
   BASE DE DATOS
   ========================================================= */
IF DB_ID(N'Espiga_DB') IS NULL
BEGIN
    CREATE DATABASE [Espiga_DB];
END
GO

USE [Espiga_DB]
GO

/* =========================================================
   ESQUEMAS
   ========================================================= */
IF SCHEMA_ID(N'core') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [core]');
END
GO

IF SCHEMA_ID(N'geo') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [geo]');
END
GO

IF SCHEMA_ID(N'inventory') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [inventory]');
END
GO

IF SCHEMA_ID(N'purchasing') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [purchasing]');
END
GO

IF SCHEMA_ID(N'sales') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [sales]');
END
GO

/* =========================================================
   TABLAS
   ========================================================= */
-- Tabla: [core].[product_categories]
IF OBJECT_ID(N'[core].[product_categories]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[products]
IF OBJECT_ID(N'[core].[products]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[promotions]
IF OBJECT_ID(N'[core].[promotions]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[roles]
IF OBJECT_ID(N'[core].[roles]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[settings]
IF OBJECT_ID(N'[core].[settings]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[taxes]
IF OBJECT_ID(N'[core].[taxes]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[user_addresses]
IF OBJECT_ID(N'[core].[user_addresses]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[user_phones]
IF OBJECT_ID(N'[core].[user_phones]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [core].[users]
IF OBJECT_ID(N'[core].[users]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [geo].[cantons]
IF OBJECT_ID(N'[geo].[cantons]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [geo].[districts]
IF OBJECT_ID(N'[geo].[districts]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [geo].[provinces]
IF OBJECT_ID(N'[geo].[provinces]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [inventory].[inventory_movements]
IF OBJECT_ID(N'[inventory].[inventory_movements]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [inventory].[inventory_stock]
IF OBJECT_ID(N'[inventory].[inventory_stock]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [purchasing].[payment_terms]
IF OBJECT_ID(N'[purchasing].[payment_terms]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [purchasing].[purchase_invoice_lines]
IF OBJECT_ID(N'[purchasing].[purchase_invoice_lines]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [purchasing].[purchase_invoices]
IF OBJECT_ID(N'[purchasing].[purchase_invoices]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [purchasing].[supplier_payments]
IF OBJECT_ID(N'[purchasing].[supplier_payments]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [purchasing].[suppliers]
IF OBJECT_ID(N'[purchasing].[suppliers]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [sales].[sales_invoice_lines]
IF OBJECT_ID(N'[sales].[sales_invoice_lines]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [sales].[sales_invoices]
IF OBJECT_ID(N'[sales].[sales_invoices]', N'U') IS NULL
BEGIN
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
END
GO

-- Tabla: [sales].[shopping_cart]
IF OBJECT_ID(N'[sales].[shopping_cart]', N'U') IS NULL
BEGIN
CREATE TABLE [sales].[shopping_cart](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[added_at] [datetime] NOT NULL,
	[created_by] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[action] [varchar](100) NULL,
	[created_at] [datetime] NULL,
	[modified_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/* =========================================================
   DATOS INICIALES
   ========================================================= */
-- Datos para: [core].[product_categories]
SET IDENTITY_INSERT [core].[product_categories] ON
GO

IF NOT EXISTS (SELECT 1 FROM [core].[product_categories] WHERE [category_id] = 1)
BEGIN
    INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'Panadería', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
END
GO

IF NOT EXISTS (SELECT 1 FROM [core].[product_categories] WHERE [category_id] = 2)
BEGIN
    INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'Repostería', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
END
GO

IF NOT EXISTS (SELECT 1 FROM [core].[product_categories] WHERE [category_id] = 3)
BEGIN
    INSERT [core].[product_categories] ([category_id], [category_name], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (3, N'Bebidas', 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.790' AS DateTime), NULL)
END
GO

SET IDENTITY_INSERT [core].[product_categories] OFF
GO

-- Datos para: [core].[products]
SET IDENTITY_INSERT [core].[products] ON
GO

IF NOT EXISTS (SELECT 1 FROM [core].[products] WHERE [product_id] = 1)
BEGIN
    INSERT [core].[products] ([product_id], [sku], [product_name], [description], [image_url], [category_id], [unit_of_measure], [min_stock], [tax_id], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at], [unit_price]) VALUES (1, N'REP-CUP-001', N'Cupcake', N'Cupcake con sabor a fresa', N'/Template/img/products/0d17ba78-5746-4bb5-bf36-8ce178758943_cupcake.png', 2, N'Unidades', CAST(2.000 AS Decimal(18, 3)), 1, 1, N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-04-05T15:09:13.800' AS DateTime), CAST(N'2026-04-05T19:35:10.710' AS DateTime), CAST(2000.00 AS Decimal(18, 2)))
END
GO

INSERT INTO [Espiga_DB].[core].[products]
(
    [sku],
    [product_name],
    [description],
    [image_url],
    [category_id],
    [unit_of_measure],
    [min_stock],
    [tax_id],
    [is_active],
    [created_by],
    [modified_by],
    [action],
    [created_at],
    [modified_at],
    [unit_price]
)
VALUES
('REP-DON-001', 'Donas con chocolate surtidas', 'Paquete de donas cubiertas con chocolate y confites de colores', '/Template/img/products/donas_chocolate_surtidas.png', 2, 'Unidades', 2.000, 1, 1, 'DELGADO MORA ANA JULIA', 'DELGADO MORA ANA JULIA', 'INSERT', GETDATE(), GETDATE(), 4500.00),
('REP-POR-001', 'Porción de pastel con cereza', 'Porción de pastel con cobertura de chocolate y cereza', '/Template/img/products/porcion_pastel_cereza_chocolate.png', 2, 'Unidades', 2.000, 1, 1, 'DELGADO MORA ANA JULIA', 'DELGADO MORA ANA JULIA', 'INSERT', GETDATE(), GETDATE(), 2800.00),
('REP-PAS-001', 'Pastel entero de chocolate', 'Pastel entero con cobertura de chocolate', '/Template/img/products/pastel_entero_chocolate.png', 2, 'Unidades', 2.000, 1, 1, 'DELGADO MORA ANA JULIA', 'DELGADO MORA ANA JULIA', 'INSERT', GETDATE(), GETDATE(), 12000.00),
('REP-PAS-002', 'Pastel mixto chocolate y frutas', 'Pastel entero combinado de chocolate y vainilla decorado con frutas', '/Template/img/products/pastel_mixto_chocolate_frutas.png', 2, 'Unidades', 2.000, 1, 1, 'DELGADO MORA ANA JULIA', 'DELGADO MORA ANA JULIA', 'INSERT', GETDATE(), GETDATE(), 13500.00);


SET IDENTITY_INSERT [core].[products] OFF
GO

-- Datos para: [core].[roles]
SET IDENTITY_INSERT [core].[roles] ON
GO

IF NOT EXISTS (SELECT 1 FROM [core].[roles] WHERE [role_id] = 1)
BEGIN
    INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'SYS_ADMIN', N'Administrador del Sistema', NULL, NULL, NULL, NULL, NULL)
END
GO

IF NOT EXISTS (SELECT 1 FROM [core].[roles] WHERE [role_id] = 2)
BEGIN
    INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'APP_ADMIN', N'Administrador de la App', NULL, NULL, NULL, NULL, NULL)
END
GO

IF NOT EXISTS (SELECT 1 FROM [core].[roles] WHERE [role_id] = 3)
BEGIN
    INSERT [core].[roles] ([role_id], [role_code], [role_name], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (3, N'APP_USER', N'Usuario Cliente', NULL, NULL, NULL, NULL, NULL)
END
GO

SET IDENTITY_INSERT [core].[roles] OFF
GO

-- Datos para: [core].[settings]
SET IDENTITY_INSERT [core].[settings] ON
GO

IF NOT EXISTS (SELECT 1 FROM [core].[settings] WHERE [setting_id] = 1)
BEGIN
    INSERT [core].[settings] ([setting_id], [company_name], [currency_symbol], [support_email], [low_stock_threshold], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'Espiga Dorada', N'¢', N'soporte@espigadorada.com', 0, N'seed_sql', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-24T16:22:11.810' AS DateTime), CAST(N'2026-04-05T19:34:19.097' AS DateTime))
END
GO

SET IDENTITY_INSERT [core].[settings] OFF
GO

-- Datos para: [core].[taxes]
SET IDENTITY_INSERT [core].[taxes] ON
GO

IF NOT EXISTS (SELECT 1 FROM [core].[taxes] WHERE [tax_id] = 1)
BEGIN
    INSERT [core].[taxes] ([tax_id], [tax_name], [tax_rate], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, N'IVA 13%', CAST(13.00 AS Decimal(4, 2)), 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.800' AS DateTime), NULL)
END
GO

IF NOT EXISTS (SELECT 1 FROM [core].[taxes] WHERE [tax_id] = 2)
BEGIN
    INSERT [core].[taxes] ([tax_id], [tax_name], [tax_rate], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (2, N'Exento', CAST(0.00 AS Decimal(4, 2)), 1, N'seed_sql', NULL, N'INSERT', CAST(N'2026-03-24T16:22:11.800' AS DateTime), NULL)
END
GO

SET IDENTITY_INSERT [core].[taxes] OFF
GO

-- Datos para: [core].[users]
SET IDENTITY_INSERT [core].[users] ON
GO

INSERT INTO [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active], [created_by], [modified_by], [action], [created_at], [modified_at])
VALUES
(1, 3, N'118290068', N'MADRIGAL DELGADO ANNDY JOSSUE', N'amadrigal90068@ufide.ac.cr', N'1234', 1, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:43:05.783' AS DATETIME)),
(2, 3, N'206690870', N'MORA MONGE MANUEL', N'mmmonge@upide.ac.cr', N'1234', 1, N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'INSERT', GETDATE(), GETDATE()),
(3, 3, N'118290066', N'SALAZAR AVALOS KEILYN JEANNETH', N'ksalazar90066@ufide.ac.cr', N'12', 0, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:19:13.430' AS DATETIME)),
(4, 3, N'208680839', N'ALFARO RIVERA CAMILA ALEXANDRA', N'calfaro80839@ufide.ac.cr', N'1234', 1, NULL, NULL, NULL, NULL, NULL),
(5, 2, N'109320181', N'DELGADO MORA ANA JULIA', N'adelgado0181@ufide.ac.cr', N'123', 1, N'MADRIGAL DELGADO ANNDY JOSSUE', NULL, N'UPDATE', CAST(N'2026-03-19T20:49:28.973' AS DATETIME), CAST(N'2026-03-19T20:49:28.977' AS DATETIME)),
(6, 3, N'118290053', N'ALVARADO CASTILLO BIANCA LUNA', N'balvarado90053@ufide.ac.cr', N'123', 0, N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-19T23:21:46.690' AS DATETIME), CAST(N'2026-03-19T23:44:10.790' AS DATETIME)),
(7, 3, N'119290015', N'CAMPOS KOCHER MARIANA', N'mcampos90015@ufide.ac.cr', N'123', 1, N'DELGADO MORA ANA JULIA', NULL, N'UPDATE', CAST(N'2026-03-19T23:27:05.077' AS DATETIME), CAST(N'2026-03-19T23:27:05.077' AS DATETIME)),
(8, 3, N'119970413', N'DELGADO MORA NATALY SOFIA', N'ndelgado70413@ufide.ac.cr', N'123', 1, N'Usuario_Desconocido', NULL, N'UPDATE', CAST(N'2026-03-21T11:50:15.703' AS DATETIME), CAST(N'2026-03-21T11:50:15.703' AS DATETIME)),
(9, 3, N'118290018', N'ARAYA GOMEZ CKRISTIAN', N'caraya90018@ufide.ac.cr', N'123', 0, N'Usuario_Desconocido', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-21T12:00:37.557' AS DATETIME), CAST(N'2026-03-21T12:01:45.567' AS DATETIME)),
(10, 3, N'118290019', N'MORALES SILES ARTURO JOSUE', N'amorales90019@ufide.ac.cr', N'123', 0, N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-03-21T12:01:33.097' AS DATETIME), CAST(N'2026-03-31T15:12:35.243' AS DATETIME)),
(11, 3, N'118290067', N'GUTIERREZ CERSOSIMO JORGE FABRICIO', N'jgutierrez90067@ufide.ac.cr', N'12345', 1, NULL, N'DELGADO MORA ANA JULIA', N'UPDATE', NULL, CAST(N'2026-03-19T23:43:06.633' AS DATETIME));

SET IDENTITY_INSERT [core].[users] OFF
GO

-- Datos para: [inventory].[inventory_stock]
SET IDENTITY_INSERT [inventory].[inventory_stock] ON
GO

IF NOT EXISTS (SELECT 1 FROM [inventory].[inventory_stock] WHERE [inventory_stock_id] = 1)
BEGIN
    INSERT [inventory].[inventory_stock] ([inventory_stock_id], [product_id], [qty_available], [created_by], [modified_by], [action], [created_at], [modified_at]) VALUES (1, 1, CAST(2.000 AS Decimal(18, 3)), N'DELGADO MORA ANA JULIA', N'DELGADO MORA ANA JULIA', N'UPDATE', CAST(N'2026-04-05T18:49:33.833' AS DateTime), CAST(N'2026-04-05T19:35:10.720' AS DateTime))
END
GO

INSERT INTO [Espiga_DB].[inventory].[inventory_stock]
(
    [product_id],
    [qty_available],
    [created_by],
    [modified_by],
    [action],
    [created_at],
    [modified_at]
)
SELECT
    p.product_id,
    v.qty_available,
    'MORA MONGE MANUEL',
    'MORA MONGE MANUEL',
    'INSERT',
    GETDATE(),
    GETDATE()
FROM [Espiga_DB].[core].[products] p
INNER JOIN
(
    VALUES
        ('REP-DON-001', 8.000),
        ('REP-POR-001', 12.000),
        ('REP-PAS-001', 16.000),
        ('REP-PAS-002', 6.000)
) v(sku, qty_available)
    ON p.sku = v.sku
WHERE NOT EXISTS
(
    SELECT 1
    FROM [Espiga_DB].[inventory].[inventory_stock] s
    WHERE s.product_id = p.product_id
);

SET IDENTITY_INSERT [inventory].[inventory_stock] OFF
GO

/* =========================================================
   VALORES POR DEFECTO
   ========================================================= */
IF COL_LENGTH(N'[core].[product_categories]', N'is_active') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[product_categories]')
         AND c.name = N'is_active'
   )
BEGIN
    ALTER TABLE [core].[product_categories] ADD  DEFAULT ((1)) FOR [is_active]
END
GO

IF COL_LENGTH(N'[core].[products]', N'is_active') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[products]')
         AND c.name = N'is_active'
   )
BEGIN
    ALTER TABLE [core].[products] ADD  DEFAULT ((1)) FOR [is_active]
END
GO

IF COL_LENGTH(N'[core].[products]', N'unit_price') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[products]')
         AND c.name = N'unit_price'
   )
BEGIN
    ALTER TABLE [core].[products] ADD  CONSTRAINT [DF_products_unit_price]  DEFAULT ((0)) FOR [unit_price]
END
GO

IF COL_LENGTH(N'[core].[promotions]', N'is_active') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[promotions]')
         AND c.name = N'is_active'
   )
BEGIN
    ALTER TABLE [core].[promotions] ADD  DEFAULT ((1)) FOR [is_active]
END
GO

IF COL_LENGTH(N'[core].[taxes]', N'is_active') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[taxes]')
         AND c.name = N'is_active'
   )
BEGIN
    ALTER TABLE [core].[taxes] ADD  DEFAULT ((1)) FOR [is_active]
END
GO

IF COL_LENGTH(N'[core].[user_addresses]', N'is_primary') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[user_addresses]')
         AND c.name = N'is_primary'
   )
BEGIN
    ALTER TABLE [core].[user_addresses] ADD  DEFAULT ((0)) FOR [is_primary]
END
GO

IF COL_LENGTH(N'[core].[user_phones]', N'is_primary') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[core].[user_phones]')
         AND c.name = N'is_primary'
   )
BEGIN
    ALTER TABLE [core].[user_phones] ADD  DEFAULT ((0)) FOR [is_primary]
END
GO

IF COL_LENGTH(N'[purchasing].[suppliers]', N'is_active') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[purchasing].[suppliers]')
         AND c.name = N'is_active'
   )
BEGIN
    ALTER TABLE [purchasing].[suppliers] ADD  DEFAULT ((1)) FOR [is_active]
END
GO

IF COL_LENGTH(N'[sales].[shopping_cart]', N'added_at') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.default_constraints dc
       JOIN sys.columns c
           ON c.object_id = dc.parent_object_id
          AND c.column_id = dc.parent_column_id
       WHERE dc.parent_object_id = OBJECT_ID(N'[sales].[shopping_cart]')
         AND c.name = N'added_at'
   )
BEGIN
    ALTER TABLE [sales].[shopping_cart] ADD  DEFAULT (getdate()) FOR [added_at]
END
GO

/* =========================================================
   CLAVES FORANEAS
   ========================================================= */
IF OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[product_categories]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_products_product_categories'
         AND parent_object_id = OBJECT_ID(N'[core].[products]')
   )
BEGIN
    ALTER TABLE [core].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_product_categories] FOREIGN KEY([category_id])
REFERENCES [core].[product_categories] ([category_id])
END
GO

IF OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[taxes]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_products_taxes'
         AND parent_object_id = OBJECT_ID(N'[core].[products]')
   )
BEGIN
    ALTER TABLE [core].[products]  WITH CHECK ADD  CONSTRAINT [FK_products_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
END
GO

IF OBJECT_ID(N'[core].[user_addresses]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[geo].[districts]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_user_addresses_districts'
         AND parent_object_id = OBJECT_ID(N'[core].[user_addresses]')
   )
BEGIN
    ALTER TABLE [core].[user_addresses]  WITH CHECK ADD  CONSTRAINT [FK_user_addresses_districts] FOREIGN KEY([district_id])
REFERENCES [geo].[districts] ([district_id])
END
GO

IF OBJECT_ID(N'[core].[user_addresses]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[users]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_user_addresses_users'
         AND parent_object_id = OBJECT_ID(N'[core].[user_addresses]')
   )
BEGIN
    ALTER TABLE [core].[user_addresses]  WITH CHECK ADD  CONSTRAINT [FK_user_addresses_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
END
GO

IF OBJECT_ID(N'[core].[user_phones]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[users]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_user_phones_users'
         AND parent_object_id = OBJECT_ID(N'[core].[user_phones]')
   )
BEGIN
    ALTER TABLE [core].[user_phones]  WITH CHECK ADD  CONSTRAINT [FK_user_phones_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
END
GO

IF OBJECT_ID(N'[core].[users]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[roles]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_users_roles'
         AND parent_object_id = OBJECT_ID(N'[core].[users]')
   )
BEGIN
    ALTER TABLE [core].[users]  WITH CHECK ADD  CONSTRAINT [FK_users_roles] FOREIGN KEY([role_id])
REFERENCES [core].[roles] ([role_id])
END
GO

IF OBJECT_ID(N'[geo].[cantons]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[geo].[provinces]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_cantons_provinces'
         AND parent_object_id = OBJECT_ID(N'[geo].[cantons]')
   )
BEGIN
    ALTER TABLE [geo].[cantons]  WITH CHECK ADD  CONSTRAINT [FK_cantons_provinces] FOREIGN KEY([province_id])
REFERENCES [geo].[provinces] ([province_id])
END
GO

IF OBJECT_ID(N'[geo].[districts]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[geo].[cantons]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_districts_cantons'
         AND parent_object_id = OBJECT_ID(N'[geo].[districts]')
   )
BEGIN
    ALTER TABLE [geo].[districts]  WITH CHECK ADD  CONSTRAINT [FK_districts_cantons] FOREIGN KEY([canton_id])
REFERENCES [geo].[cantons] ([canton_id])
END
GO

IF OBJECT_ID(N'[inventory].[inventory_movements]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_inventory_movements_products'
         AND parent_object_id = OBJECT_ID(N'[inventory].[inventory_movements]')
   )
BEGIN
    ALTER TABLE [inventory].[inventory_movements]  WITH CHECK ADD  CONSTRAINT [FK_inventory_movements_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
END
GO

IF OBJECT_ID(N'[inventory].[inventory_stock]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_inventory_stock_products'
         AND parent_object_id = OBJECT_ID(N'[inventory].[inventory_stock]')
   )
BEGIN
    ALTER TABLE [inventory].[inventory_stock]  WITH CHECK ADD  CONSTRAINT [FK_inventory_stock_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
END
GO

IF OBJECT_ID(N'[purchasing].[purchase_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_purchase_invoice_lines_products'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
   )
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
END
GO

IF OBJECT_ID(N'[purchasing].[purchase_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[purchasing].[purchase_invoices]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_purchase_invoice_lines_purchase_invoices'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
   )
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_purchase_invoices] FOREIGN KEY([purchase_invoice_id])
REFERENCES [purchasing].[purchase_invoices] ([purchase_invoice_id])
END
GO

IF OBJECT_ID(N'[purchasing].[purchase_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[taxes]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_purchase_invoice_lines_taxes'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
   )
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoice_lines_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
END
GO

IF OBJECT_ID(N'[purchasing].[purchase_invoices]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[purchasing].[payment_terms]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_purchase_invoices_payment_terms'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoices]')
   )
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoices_payment_terms] FOREIGN KEY([term_id])
REFERENCES [purchasing].[payment_terms] ([term_id])
END
GO

IF OBJECT_ID(N'[purchasing].[purchase_invoices]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[purchasing].[suppliers]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_purchase_invoices_suppliers'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoices]')
   )
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices]  WITH CHECK ADD  CONSTRAINT [FK_purchase_invoices_suppliers] FOREIGN KEY([supplier_id])
REFERENCES [purchasing].[suppliers] ([supplier_id])
END
GO

IF OBJECT_ID(N'[purchasing].[supplier_payments]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[purchasing].[purchase_invoices]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_supplier_payments_purchase_invoices'
         AND parent_object_id = OBJECT_ID(N'[purchasing].[supplier_payments]')
   )
BEGIN
    ALTER TABLE [purchasing].[supplier_payments]  WITH CHECK ADD  CONSTRAINT [FK_supplier_payments_purchase_invoices] FOREIGN KEY([purchase_invoice_id])
REFERENCES [purchasing].[purchase_invoices] ([purchase_invoice_id])
END
GO

IF OBJECT_ID(N'[sales].[sales_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_sales_invoice_lines_products'
         AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
   )
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
END
GO

IF OBJECT_ID(N'[sales].[sales_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[promotions]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_sales_invoice_lines_promotions'
         AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
   )
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_promotions] FOREIGN KEY([promotion_id])
REFERENCES [core].[promotions] ([promotion_id])
END
GO

IF OBJECT_ID(N'[sales].[sales_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[sales].[sales_invoices]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_sales_invoice_lines_sales_invoices'
         AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
   )
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_sales_invoices] FOREIGN KEY([sales_invoice_id])
REFERENCES [sales].[sales_invoices] ([sales_invoice_id])
END
GO

IF OBJECT_ID(N'[sales].[sales_invoice_lines]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[taxes]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_sales_invoice_lines_taxes'
         AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
   )
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoice_lines_taxes] FOREIGN KEY([tax_id])
REFERENCES [core].[taxes] ([tax_id])
END
GO

IF OBJECT_ID(N'[sales].[sales_invoices]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[users]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_sales_invoices_users'
         AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoices]')
   )
BEGIN
    ALTER TABLE [sales].[sales_invoices]  WITH CHECK ADD  CONSTRAINT [FK_sales_invoices_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
END
GO

IF OBJECT_ID(N'[sales].[shopping_cart]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[products]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_shopping_cart_products'
         AND parent_object_id = OBJECT_ID(N'[sales].[shopping_cart]')
   )
BEGIN
    ALTER TABLE [sales].[shopping_cart]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_products] FOREIGN KEY([product_id])
REFERENCES [core].[products] ([product_id])
END
GO

IF OBJECT_ID(N'[sales].[shopping_cart]', N'U') IS NOT NULL
   AND OBJECT_ID(N'[core].[users]', N'U') IS NOT NULL
   AND NOT EXISTS (
       SELECT 1
       FROM sys.foreign_keys
       WHERE name = N'FK_shopping_cart_users'
         AND parent_object_id = OBJECT_ID(N'[sales].[shopping_cart]')
   )
BEGIN
    ALTER TABLE [sales].[shopping_cart]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_users] FOREIGN KEY([user_id])
REFERENCES [core].[users] ([user_id])
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_products_product_categories'
      AND parent_object_id = OBJECT_ID(N'[core].[products]')
)
BEGIN
    ALTER TABLE [core].[products] CHECK CONSTRAINT [FK_products_product_categories]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_products_taxes'
      AND parent_object_id = OBJECT_ID(N'[core].[products]')
)
BEGIN
    ALTER TABLE [core].[products] CHECK CONSTRAINT [FK_products_taxes]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_user_addresses_districts'
      AND parent_object_id = OBJECT_ID(N'[core].[user_addresses]')
)
BEGIN
    ALTER TABLE [core].[user_addresses] CHECK CONSTRAINT [FK_user_addresses_districts]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_user_addresses_users'
      AND parent_object_id = OBJECT_ID(N'[core].[user_addresses]')
)
BEGIN
    ALTER TABLE [core].[user_addresses] CHECK CONSTRAINT [FK_user_addresses_users]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_user_phones_users'
      AND parent_object_id = OBJECT_ID(N'[core].[user_phones]')
)
BEGIN
    ALTER TABLE [core].[user_phones] CHECK CONSTRAINT [FK_user_phones_users]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_users_roles'
      AND parent_object_id = OBJECT_ID(N'[core].[users]')
)
BEGIN
    ALTER TABLE [core].[users] CHECK CONSTRAINT [FK_users_roles]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_cantons_provinces'
      AND parent_object_id = OBJECT_ID(N'[geo].[cantons]')
)
BEGIN
    ALTER TABLE [geo].[cantons] CHECK CONSTRAINT [FK_cantons_provinces]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_districts_cantons'
      AND parent_object_id = OBJECT_ID(N'[geo].[districts]')
)
BEGIN
    ALTER TABLE [geo].[districts] CHECK CONSTRAINT [FK_districts_cantons]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_inventory_movements_products'
      AND parent_object_id = OBJECT_ID(N'[inventory].[inventory_movements]')
)
BEGIN
    ALTER TABLE [inventory].[inventory_movements] CHECK CONSTRAINT [FK_inventory_movements_products]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_inventory_stock_products'
      AND parent_object_id = OBJECT_ID(N'[inventory].[inventory_stock]')
)
BEGIN
    ALTER TABLE [inventory].[inventory_stock] CHECK CONSTRAINT [FK_inventory_stock_products]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_purchase_invoice_lines_products'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
)
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_products]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_purchase_invoice_lines_purchase_invoices'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
)
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_purchase_invoices]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_purchase_invoice_lines_taxes'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoice_lines]')
)
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines] CHECK CONSTRAINT [FK_purchase_invoice_lines_taxes]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_purchase_invoices_payment_terms'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoices]')
)
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices] CHECK CONSTRAINT [FK_purchase_invoices_payment_terms]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_purchase_invoices_suppliers'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[purchase_invoices]')
)
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices] CHECK CONSTRAINT [FK_purchase_invoices_suppliers]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_supplier_payments_purchase_invoices'
      AND parent_object_id = OBJECT_ID(N'[purchasing].[supplier_payments]')
)
BEGIN
    ALTER TABLE [purchasing].[supplier_payments] CHECK CONSTRAINT [FK_supplier_payments_purchase_invoices]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_sales_invoice_lines_products'
      AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
)
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_products]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_sales_invoice_lines_promotions'
      AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
)
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_promotions]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_sales_invoice_lines_sales_invoices'
      AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
)
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_sales_invoices]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_sales_invoice_lines_taxes'
      AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoice_lines]')
)
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] CHECK CONSTRAINT [FK_sales_invoice_lines_taxes]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_sales_invoices_users'
      AND parent_object_id = OBJECT_ID(N'[sales].[sales_invoices]')
)
BEGIN
    ALTER TABLE [sales].[sales_invoices] CHECK CONSTRAINT [FK_sales_invoices_users]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_shopping_cart_products'
      AND parent_object_id = OBJECT_ID(N'[sales].[shopping_cart]')
)
BEGIN
    ALTER TABLE [sales].[shopping_cart] CHECK CONSTRAINT [FK_shopping_cart_products]
END
GO

IF EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_shopping_cart_users'
      AND parent_object_id = OBJECT_ID(N'[sales].[shopping_cart]')
)
BEGIN
    ALTER TABLE [sales].[shopping_cart] CHECK CONSTRAINT [FK_shopping_cart_users]
END
GO

/* =========================================================
   PROCEDIMIENTOS ALMACENADOS
   ========================================================= */
-- Procedimiento: [core].[GetUserById]
CREATE OR ALTER PROCEDURE [core].[GetUserById]
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

-- Procedimiento: [core].[InsertProduct]
CREATE OR ALTER PROCEDURE [core].[InsertProduct]
    @product_name NVARCHAR(150),
    @sku NVARCHAR(60),
    @description NVARCHAR(500),
    @image_url NVARCHAR(500),
    @category_id INT,
    @unit_of_measure NVARCHAR(10),
    @min_stock DECIMAL(18,3),
    @tax_id INT,
    @is_active BIT,
    @user NVARCHAR(100)
AS
BEGIN
    INSERT INTO core.products (
        product_name,
        sku,
        description,
        image_url,
        category_id,
        unit_of_measure,
        min_stock,
        tax_id,
        is_active,
        created_by,
        created_at
    )
    VALUES (
        @product_name,
        @sku,
        @description,
        @image_url,
        @category_id,
        @unit_of_measure,
        @min_stock,
        @tax_id,
        @is_active,
        @user,
        GETDATE()
    )
END;
GO

-- Procedimiento: [core].[LoginUser]
CREATE OR ALTER PROCEDURE [core].[LoginUser]
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

-- Procedimiento: [core].[RegisterProduct]
CREATE OR ALTER PROCEDURE [core].[RegisterProduct]
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

-- Procedimiento: [core].[RegisterUser]
CREATE OR ALTER PROCEDURE [core].[RegisterUser]
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

-- Procedimiento: [core].[ToggleProductStatus]
CREATE OR ALTER PROCEDURE [core].[ToggleProductStatus]
    @product_id INT,
    @user NVARCHAR(100)
AS
BEGIN
    UPDATE core.products
    SET 
        is_active = CASE WHEN is_active = 1 THEN 0 ELSE 1 END,
        modified_by = @user,
        modified_at = GETDATE()
    WHERE product_id = @product_id
END;
GO

-- Procedimiento: [core].[UpdatePassword]
CREATE OR ALTER PROCEDURE [core].[UpdatePassword]
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

-- Procedimiento: [core].[UpdateProduct]
CREATE OR ALTER PROCEDURE [core].[UpdateProduct]
    @product_id INT,
    @product_name NVARCHAR(150),
    @sku NVARCHAR(60),
    @description NVARCHAR(500),
    @image_url NVARCHAR(500),
    @category_id INT,
    @unit_of_measure NVARCHAR(10),
    @min_stock DECIMAL(18,3),
    @tax_id INT,
    @is_active BIT,
    @user NVARCHAR(100)
AS
BEGIN
    UPDATE core.products
    SET 
        product_name = @product_name,
        sku = @sku,
        description = @description,
        image_url = @image_url,
        category_id = @category_id,
        unit_of_measure = @unit_of_measure,
        min_stock = @min_stock,
        tax_id = @tax_id,
        is_active = @is_active,
        modified_by = @user,
        modified_at = GETDATE()
    WHERE product_id = @product_id
END;
GO

-- Procedimiento: [core].[UpdateUser]
CREATE OR ALTER PROCEDURE [core].[UpdateUser]
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

-- Procedimiento: [core].[ValidateEmail]
CREATE OR ALTER PROCEDURE [core].[ValidateEmail]
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

-- Procedimiento: [purchasing].[AdministerPaymentTerms]
CREATE OR ALTER PROCEDURE [purchasing].[AdministerPaymentTerms]
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

/* =========================================================
   TRIGGERS
   ========================================================= */
-- Trigger: [core].[trg_product_categories_insert]
CREATE OR ALTER TRIGGER [core].[trg_product_categories_insert]
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

-- Trigger: [core].[trg_product_categories_update]
CREATE OR ALTER TRIGGER [core].[trg_product_categories_update]
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

-- Trigger: [core].[trg_products_insert]
CREATE OR ALTER TRIGGER [core].[trg_products_insert]
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

-- Trigger: [core].[trg_products_update]
CREATE OR ALTER TRIGGER [core].[trg_products_update]
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

-- Trigger: [core].[trg_promotions_insert]
CREATE OR ALTER TRIGGER [core].[trg_promotions_insert]
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

-- Trigger: [core].[trg_promotions_update]
CREATE OR ALTER TRIGGER [core].[trg_promotions_update]
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

-- Trigger: [core].[trg_roles_insert]
CREATE OR ALTER TRIGGER [core].[trg_roles_insert]
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

-- Trigger: [core].[trg_roles_update]
CREATE OR ALTER TRIGGER [core].[trg_roles_update]
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

-- Trigger: [core].[trg_settings_insert]
CREATE OR ALTER TRIGGER [core].[trg_settings_insert]
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

-- Trigger: [core].[trg_settings_update]
CREATE OR ALTER TRIGGER [core].[trg_settings_update]
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

-- Trigger: [core].[trg_taxes_insert]
CREATE OR ALTER TRIGGER [core].[trg_taxes_insert]
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

-- Trigger: [core].[trg_taxes_update]
CREATE OR ALTER TRIGGER [core].[trg_taxes_update]
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

-- Trigger: [core].[trg_user_addresses_insert]
CREATE OR ALTER TRIGGER [core].[trg_user_addresses_insert]
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

-- Trigger: [core].[trg_user_addresses_update]
CREATE OR ALTER TRIGGER [core].[trg_user_addresses_update]
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

-- Trigger: [core].[trg_user_phones_insert]
CREATE OR ALTER TRIGGER [core].[trg_user_phones_insert]
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

-- Trigger: [core].[trg_user_phones_update]
CREATE OR ALTER TRIGGER [core].[trg_user_phones_update]
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

-- Trigger: [core].[trg_users_insert]
CREATE OR ALTER TRIGGER [core].[trg_users_insert]
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

-- Trigger: [core].[trg_users_update]
CREATE OR ALTER TRIGGER [core].[trg_users_update]
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

-- Trigger: [geo].[trg_cantons_insert]
CREATE OR ALTER TRIGGER [geo].[trg_cantons_insert]
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

-- Trigger: [geo].[trg_cantons_update]
CREATE OR ALTER TRIGGER [geo].[trg_cantons_update]
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

-- Trigger: [geo].[trg_districts_insert]
CREATE OR ALTER TRIGGER [geo].[trg_districts_insert]
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

-- Trigger: [geo].[trg_districts_update]
CREATE OR ALTER TRIGGER [geo].[trg_districts_update]
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

-- Trigger: [geo].[trg_provinces_insert]
CREATE OR ALTER TRIGGER [geo].[trg_provinces_insert]
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

-- Trigger: [geo].[trg_provinces_update]
CREATE OR ALTER TRIGGER [geo].[trg_provinces_update]
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

-- Trigger: [inventory].[trg_inventory_movements_insert]
CREATE OR ALTER TRIGGER [inventory].[trg_inventory_movements_insert]
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

-- Trigger: [inventory].[trg_inventory_movements_update]
CREATE OR ALTER TRIGGER [inventory].[trg_inventory_movements_update]
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

-- Trigger: [inventory].[trg_inventory_stock_insert]
CREATE OR ALTER TRIGGER [inventory].[trg_inventory_stock_insert]
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

-- Trigger: [inventory].[trg_inventory_stock_update]
CREATE OR ALTER TRIGGER [inventory].[trg_inventory_stock_update]
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

-- Trigger: [purchasing].[trg_payment_terms_insert]
CREATE OR ALTER TRIGGER [purchasing].[trg_payment_terms_insert]
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

-- Trigger: [purchasing].[trg_payment_terms_update]
CREATE OR ALTER TRIGGER [purchasing].[trg_payment_terms_update]
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

-- Trigger: [purchasing].[trg_purchase_invoice_lines_insert]
CREATE OR ALTER TRIGGER [purchasing].[trg_purchase_invoice_lines_insert]
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

-- Trigger: [purchasing].[trg_purchase_invoice_lines_update]
CREATE OR ALTER TRIGGER [purchasing].[trg_purchase_invoice_lines_update]
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

-- Trigger: [purchasing].[trg_purchase_invoices_insert]
CREATE OR ALTER TRIGGER [purchasing].[trg_purchase_invoices_insert]
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

-- Trigger: [purchasing].[trg_purchase_invoices_update]
CREATE OR ALTER TRIGGER [purchasing].[trg_purchase_invoices_update]
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

-- Trigger: [purchasing].[trg_supplier_payments_insert]
CREATE OR ALTER TRIGGER [purchasing].[trg_supplier_payments_insert]
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

-- Trigger: [purchasing].[trg_supplier_payments_update]
CREATE OR ALTER TRIGGER [purchasing].[trg_supplier_payments_update]
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

-- Trigger: [purchasing].[trg_suppliers_insert]
CREATE OR ALTER TRIGGER [purchasing].[trg_suppliers_insert]
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

-- Trigger: [purchasing].[trg_suppliers_update]
CREATE OR ALTER TRIGGER [purchasing].[trg_suppliers_update]
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

-- Trigger: [sales].[trg_sales_invoice_lines_insert]
CREATE OR ALTER TRIGGER [sales].[trg_sales_invoice_lines_insert]
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

-- Trigger: [sales].[trg_sales_invoice_lines_update]
CREATE OR ALTER TRIGGER [sales].[trg_sales_invoice_lines_update]
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

-- Trigger: [sales].[trg_sales_invoices_insert]
CREATE OR ALTER TRIGGER [sales].[trg_sales_invoices_insert]
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

-- Trigger: [sales].[trg_sales_invoices_update]
CREATE OR ALTER TRIGGER [sales].[trg_sales_invoices_update]
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

-- Trigger: [sales].[trg_shopping_cart_insert]
CREATE OR ALTER TRIGGER [sales].[trg_shopping_cart_insert]
ON [sales].[shopping_cart]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 
    UPDATE t
    SET t.created_at = GETDATE(),
        t.action = 'INSERT'
    FROM sales.shopping_cart t
    INNER JOIN inserted i ON t.cart_item_id = i.cart_item_id;
END;
GO

-- Trigger: [sales].[trg_shopping_cart_update]
CREATE OR ALTER TRIGGER [sales].[trg_shopping_cart_update]
ON [sales].[shopping_cart]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Freno para evitar el efecto dominó (Recursividad)
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE t
    SET t.modified_at = GETDATE(),
        t.action = 'UPDATE'
    FROM sales.shopping_cart t
    INNER JOIN inserted i ON t.cart_item_id = i.cart_item_id;
END;
GO

/* =========================================================
   HABILITACION DE TRIGGERS
   ========================================================= */
IF OBJECT_ID(N'[core].[trg_product_categories_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[product_categories] ENABLE TRIGGER [trg_product_categories_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_product_categories_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[product_categories] ENABLE TRIGGER [trg_product_categories_update]
END
GO

IF OBJECT_ID(N'[core].[trg_products_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[products] ENABLE TRIGGER [trg_products_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_products_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[products] ENABLE TRIGGER [trg_products_update]
END
GO

IF OBJECT_ID(N'[core].[trg_promotions_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[promotions] ENABLE TRIGGER [trg_promotions_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_promotions_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[promotions] ENABLE TRIGGER [trg_promotions_update]
END
GO

IF OBJECT_ID(N'[core].[trg_roles_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[roles] ENABLE TRIGGER [trg_roles_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_roles_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[roles] ENABLE TRIGGER [trg_roles_update]
END
GO

IF OBJECT_ID(N'[core].[trg_settings_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[settings] ENABLE TRIGGER [trg_settings_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_settings_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[settings] ENABLE TRIGGER [trg_settings_update]
END
GO

IF OBJECT_ID(N'[core].[trg_taxes_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[taxes] ENABLE TRIGGER [trg_taxes_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_taxes_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[taxes] ENABLE TRIGGER [trg_taxes_update]
END
GO

IF OBJECT_ID(N'[core].[trg_user_addresses_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[user_addresses] ENABLE TRIGGER [trg_user_addresses_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_user_addresses_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[user_addresses] ENABLE TRIGGER [trg_user_addresses_update]
END
GO

IF OBJECT_ID(N'[core].[trg_user_phones_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[user_phones] ENABLE TRIGGER [trg_user_phones_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_user_phones_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[user_phones] ENABLE TRIGGER [trg_user_phones_update]
END
GO

IF OBJECT_ID(N'[core].[trg_users_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[users] ENABLE TRIGGER [trg_users_insert]
END
GO

IF OBJECT_ID(N'[core].[trg_users_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [core].[users] ENABLE TRIGGER [trg_users_update]
END
GO

IF OBJECT_ID(N'[geo].[trg_cantons_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[cantons] ENABLE TRIGGER [trg_cantons_insert]
END
GO

IF OBJECT_ID(N'[geo].[trg_cantons_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[cantons] ENABLE TRIGGER [trg_cantons_update]
END
GO

IF OBJECT_ID(N'[geo].[trg_districts_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[districts] ENABLE TRIGGER [trg_districts_insert]
END
GO

IF OBJECT_ID(N'[geo].[trg_districts_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[districts] ENABLE TRIGGER [trg_districts_update]
END
GO

IF OBJECT_ID(N'[geo].[trg_provinces_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[provinces] ENABLE TRIGGER [trg_provinces_insert]
END
GO

IF OBJECT_ID(N'[geo].[trg_provinces_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [geo].[provinces] ENABLE TRIGGER [trg_provinces_update]
END
GO

IF OBJECT_ID(N'[inventory].[trg_inventory_movements_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [inventory].[inventory_movements] ENABLE TRIGGER [trg_inventory_movements_insert]
END
GO

IF OBJECT_ID(N'[inventory].[trg_inventory_movements_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [inventory].[inventory_movements] ENABLE TRIGGER [trg_inventory_movements_update]
END
GO

IF OBJECT_ID(N'[inventory].[trg_inventory_stock_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [inventory].[inventory_stock] ENABLE TRIGGER [trg_inventory_stock_insert]
END
GO

IF OBJECT_ID(N'[inventory].[trg_inventory_stock_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [inventory].[inventory_stock] ENABLE TRIGGER [trg_inventory_stock_update]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_payment_terms_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[payment_terms] ENABLE TRIGGER [trg_payment_terms_insert]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_payment_terms_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[payment_terms] ENABLE TRIGGER [trg_payment_terms_update]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_purchase_invoice_lines_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines] ENABLE TRIGGER [trg_purchase_invoice_lines_insert]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_purchase_invoice_lines_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_invoice_lines] ENABLE TRIGGER [trg_purchase_invoice_lines_update]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_purchase_invoices_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices] ENABLE TRIGGER [trg_purchase_invoices_insert]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_purchase_invoices_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_invoices] ENABLE TRIGGER [trg_purchase_invoices_update]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_supplier_payments_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[supplier_payments] ENABLE TRIGGER [trg_supplier_payments_insert]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_supplier_payments_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[supplier_payments] ENABLE TRIGGER [trg_supplier_payments_update]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_suppliers_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[suppliers] ENABLE TRIGGER [trg_suppliers_insert]
END
GO

IF OBJECT_ID(N'[purchasing].[trg_suppliers_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [purchasing].[suppliers] ENABLE TRIGGER [trg_suppliers_update]
END
GO

IF OBJECT_ID(N'[sales].[trg_sales_invoice_lines_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] ENABLE TRIGGER [trg_sales_invoice_lines_insert]
END
GO

IF OBJECT_ID(N'[sales].[trg_sales_invoice_lines_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[sales_invoice_lines] ENABLE TRIGGER [trg_sales_invoice_lines_update]
END
GO

IF OBJECT_ID(N'[sales].[trg_sales_invoices_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[sales_invoices] ENABLE TRIGGER [trg_sales_invoices_insert]
END
GO

IF OBJECT_ID(N'[sales].[trg_sales_invoices_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[sales_invoices] ENABLE TRIGGER [trg_sales_invoices_update]
END
GO

IF OBJECT_ID(N'[sales].[trg_shopping_cart_insert]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[shopping_cart] ENABLE TRIGGER [trg_shopping_cart_insert]
END
GO

IF OBJECT_ID(N'[sales].[trg_shopping_cart_update]', N'TR') IS NOT NULL
BEGIN
    ALTER TABLE [sales].[shopping_cart] ENABLE TRIGGER [trg_shopping_cart_update]
END
GO











CREATE OR ALTER PROCEDURE [sales].[ProcessOrder]
    @UserId INT,
    @PaymentMethod VARCHAR(30),
    @PaymentReference NVARCHAR(80) = NULL,
    @Notes NVARCHAR(250) = NULL,
    @CreatedBy VARCHAR(100),
    @ItemsXml XML
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRAN;

        DECLARE @SalesInvoiceId INT;
        DECLARE @Subtotal DECIMAL(18, 2) = 0;
        DECLARE @DiscountTotal DECIMAL(18, 2) = 0;
        DECLARE @TaxTotal DECIMAL(18, 2) = 0;
        DECLARE @Total DECIMAL(18, 2) = 0;

        DECLARE @OrderItems TABLE
        (
            product_id INT NOT NULL,
            qty DECIMAL(18, 3) NOT NULL,
            unit_price DECIMAL(18, 4) NOT NULL
        );

        DECLARE @InvoiceLines TABLE
        (
            product_id INT NOT NULL,
            qty_sold DECIMAL(18, 3) NOT NULL,
            unit_price_list DECIMAL(18, 4) NOT NULL,
            unit_price_final DECIMAL(18, 4) NOT NULL,
            promotion_id INT NULL,
            discount_amount DECIMAL(18, 2) NOT NULL,
            tax_id INT NOT NULL,
            tax_amount DECIMAL(18, 2) NOT NULL,
            line_subtotal DECIMAL(18, 2) NOT NULL,
            line_total DECIMAL(18, 2) NOT NULL
        );

        IF @PaymentMethod IS NULL OR LTRIM(RTRIM(@PaymentMethod)) = ''
        BEGIN
            RAISERROR('Debe indicar el método de pago.', 16, 1);
        END;

        IF @ItemsXml IS NULL
        BEGIN
            RAISERROR('No se recibió el detalle del pedido.', 16, 1);
        END;

        ;WITH ParsedItems AS
        (
            SELECT
                T.Item.value('@product_id', 'int') AS product_id,
                T.Item.value('@qty', 'decimal(18,3)') AS qty,
                T.Item.value('@unit_price', 'decimal(18,4)') AS unit_price
            FROM @ItemsXml.nodes('/items/item') AS T(Item)
        )
        INSERT INTO @OrderItems (product_id, qty, unit_price)
        SELECT
            product_id,
            SUM(qty) AS qty,
            MAX(unit_price) AS unit_price
        FROM ParsedItems
        GROUP BY product_id;

        IF NOT EXISTS (SELECT 1 FROM @OrderItems)
        BEGIN
            RAISERROR('No hay productos para procesar en el pedido.', 16, 1);
        END;

        IF EXISTS (SELECT 1 FROM @OrderItems WHERE qty <= 0)
        BEGIN
            RAISERROR('Hay cantidades inválidas en el pedido.', 16, 1);
        END;

        IF EXISTS (SELECT 1 FROM @OrderItems WHERE unit_price < 0)
        BEGIN
            RAISERROR('Hay precios inválidos en el pedido.', 16, 1);
        END;

        IF EXISTS
        (
            SELECT 1
            FROM @OrderItems OI
            LEFT JOIN core.products P
                ON P.product_id = OI.product_id
            LEFT JOIN inventory.inventory_stock S
                ON S.product_id = OI.product_id
            WHERE P.product_id IS NULL
               OR P.is_active = 0
               OR ISNULL(S.qty_available, 0) < OI.qty
        )
        BEGIN
            RAISERROR('Uno o más productos no tienen stock suficiente o no están disponibles.', 16, 1);
        END;

        INSERT INTO @InvoiceLines
        (
            product_id,
            qty_sold,
            unit_price_list,
            unit_price_final,
            promotion_id,
            discount_amount,
            tax_id,
            tax_amount,
            line_subtotal,
            line_total
        )
        SELECT
            OI.product_id,
            OI.qty,
            OI.unit_price,
            OI.unit_price,
            NULL,
            0,
            P.tax_id,
            ROUND((OI.qty * OI.unit_price) * (ISNULL(T.tax_rate, 0) / 100.0), 2),
            ROUND(OI.qty * OI.unit_price, 2),
            ROUND(
                (OI.qty * OI.unit_price) +
                ((OI.qty * OI.unit_price) * (ISNULL(T.tax_rate, 0) / 100.0)),
                2
            )
        FROM @OrderItems OI
        INNER JOIN core.products P
            ON P.product_id = OI.product_id
        LEFT JOIN core.taxes T
            ON T.tax_id = P.tax_id;

        SELECT
            @Subtotal = ISNULL(SUM(line_subtotal), 0),
            @DiscountTotal = ISNULL(SUM(discount_amount), 0),
            @TaxTotal = ISNULL(SUM(tax_amount), 0),
            @Total = ISNULL(SUM(line_total), 0)
        FROM @InvoiceLines;

        INSERT INTO sales.sales_invoices
        (
            sales_datetime,
            user_id,
            status,
            payment_method,
            payment_reference,
            subtotal,
            discount_total,
            tax_total,
            total,
            notes,
            created_by
        )
        VALUES
        (
            GETDATE(),
            @UserId,
            'CONFIRMED',
            @PaymentMethod,
            @PaymentReference,
            @Subtotal,
            @DiscountTotal,
            @TaxTotal,
            @Total,
            @Notes,
            @CreatedBy
        );

        SET @SalesInvoiceId = SCOPE_IDENTITY();

        INSERT INTO sales.sales_invoice_payments
        (
            sales_invoice_id,
            payment_method,
            notes,
            created_by
        )
        VALUES
        (
            @SalesInvoiceId,
            @PaymentMethod,
            @Notes,
            @CreatedBy
        );

        INSERT INTO sales.sales_invoice_lines
        (
            sales_invoice_id,
            product_id,
            qty_sold,
            unit_price_list,
            unit_price_final,
            promotion_id,
            discount_amount,
            tax_id,
            tax_amount,
            line_subtotal,
            line_total,
            created_by
        )
        SELECT
            @SalesInvoiceId,
            product_id,
            qty_sold,
            unit_price_list,
            unit_price_final,
            promotion_id,
            discount_amount,
            tax_id,
            tax_amount,
            line_subtotal,
            line_total,
            @CreatedBy
        FROM @InvoiceLines;

        UPDATE S
        SET
            S.qty_available = S.qty_available - IL.qty_sold,
            S.modified_by = @CreatedBy
        FROM inventory.inventory_stock S
        INNER JOIN @InvoiceLines IL
            ON IL.product_id = S.product_id;

        INSERT INTO inventory.inventory_movements
        (
            movement_datetime,
            movement_type,
            product_id,
            qty_signed,
            reference_table,
            reference_id,
            notes,
            created_by
        )
        SELECT
            GETDATE(),
            'SALE',
            product_id,
            qty_sold * -1,
            'sales.sales_invoices',
            @SalesInvoiceId,
            'Salida por venta ' + CAST(@SalesInvoiceId AS VARCHAR(20)),
            @CreatedBy
        FROM @InvoiceLines;

        COMMIT TRAN;

        SELECT
            SI.sales_invoice_id AS SalesInvoiceId,
            SI.sales_number AS SalesNumber,
            SI.status AS Status,
            CAST('Pedido generado correctamente.' AS NVARCHAR(250)) AS Message
        FROM sales.sales_invoices SI
        WHERE SI.sales_invoice_id = @SalesInvoiceId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        SELECT
            CAST(0 AS INT) AS SalesInvoiceId,
            CAST(NULL AS NVARCHAR(50)) AS SalesNumber,
            CAST('ERROR' AS VARCHAR(20)) AS Status,
            ERROR_MESSAGE() AS Message;
    END CATCH
END
GO












IF OBJECT_ID(N'[sales].[sales_invoice_payments]', N'U') IS NULL
BEGIN
    CREATE TABLE [sales].[sales_invoice_payments]
    (
        [sales_invoice_payment_id] [int] IDENTITY(1,1) NOT NULL,
        [sales_invoice_id] [int] NOT NULL,
        [payment_method] [varchar](30) NOT NULL,
        [notes] [nvarchar](250) NULL,
        [created_by] [varchar](100) NULL,
        [modified_by] [varchar](100) NULL,
        [action] [varchar](100) NULL,
        [created_at] [datetime] NULL,
        [modified_at] [datetime] NULL,
        CONSTRAINT [PK_sales_invoice_payments] PRIMARY KEY CLUSTERED
        (
            [sales_invoice_payment_id] ASC
        )
    );
END
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_sales_invoice_payments_sales_invoices'
)
BEGIN
    ALTER TABLE [sales].[sales_invoice_payments]
    ADD CONSTRAINT [FK_sales_invoice_payments_sales_invoices]
        FOREIGN KEY ([sales_invoice_id])
        REFERENCES [sales].[sales_invoices]([sales_invoice_id]);
END
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_sales_invoice_payments_sales_invoice_id'
      AND object_id = OBJECT_ID(N'[sales].[sales_invoice_payments]')
)
BEGIN
    CREATE NONCLUSTERED INDEX [IX_sales_invoice_payments_sales_invoice_id]
        ON [sales].[sales_invoice_payments]([sales_invoice_id]);
END
GO

CREATE OR ALTER TRIGGER [sales].[trg_sales_invoice_payments_insert]
ON [sales].[sales_invoice_payments]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE T
    SET
        T.created_at = GETDATE(),
        T.action = 'INSERT'
    FROM [sales].[sales_invoice_payments] T
    INNER JOIN inserted I
        ON T.sales_invoice_payment_id = I.sales_invoice_payment_id;
END;
GO

CREATE OR ALTER TRIGGER [sales].[trg_sales_invoice_payments_update]
ON [sales].[sales_invoice_payments]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF (TRIGGER_NESTLEVEL() > 1) RETURN;

    UPDATE T
    SET
        T.modified_at = GETDATE(),
        T.action = 'UPDATE'
    FROM [sales].[sales_invoice_payments] T
    INNER JOIN inserted I
        ON T.sales_invoice_payment_id = I.sales_invoice_payment_id;
END;
GO
