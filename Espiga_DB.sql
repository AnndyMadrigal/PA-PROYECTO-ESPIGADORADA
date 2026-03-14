USE [master]
GO

CREATE DATABASE [Espiga_DB]
 
GO

USE [Espiga_DB]
GO
/****** Object:  Schema [core]    Script Date: 14/3/2026 14:33:35 ******/
CREATE SCHEMA [core]
GO
/****** Object:  Schema [geo]    Script Date: 14/3/2026 14:33:35 ******/
CREATE SCHEMA [geo]
GO
/****** Object:  Schema [inventory]    Script Date: 14/3/2026 14:33:35 ******/
CREATE SCHEMA [inventory]
GO
/****** Object:  Schema [purchasing]    Script Date: 14/3/2026 14:33:35 ******/
CREATE SCHEMA [purchasing]
GO
/****** Object:  Schema [sales]    Script Date: 14/3/2026 14:33:35 ******/
CREATE SCHEMA [sales]
GO
/****** Object:  Table [core].[product_categories]    Script Date: 14/3/2026 14:33:35 ******/
CREATE TABLE [core].[product_categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](120) NOT NULL,
	[is_active] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[promotions](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_name] [nvarchar](150) NOT NULL,
	[promotion_type] [varchar](20) NOT NULL,
	[promotion_value] [decimal](18, 4) NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[is_active] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_code] [varchar](40) NOT NULL,
	[role_name] [varchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[settings](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [nvarchar](150) NOT NULL,
	[currency_symbol] [varchar](5) NOT NULL,
	[support_email] [varchar](100) NOT NULL,
	[low_stock_threshold] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[taxes](
	[tax_id] [int] IDENTITY(1,1) NOT NULL,
	[tax_name] [varchar](40) NOT NULL,
	[tax_rate] [decimal](4, 2) NOT NULL,
	[is_active] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tax_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[user_phones](
	[phone_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[phone_type] [varchar](20) NOT NULL,
	[country_code] [varchar](6) NOT NULL,
	[phone_number] [varchar](30) NOT NULL,
	[is_primary] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [core].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[identification] [varchar](15) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[is_active] [tinyint] NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [geo].[cantons](
	[canton_id] [int] IDENTITY(1,1) NOT NULL,
	[province_id] [int] NOT NULL,
	[canton_name] [nvarchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[canton_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [geo].[districts](
	[district_id] [int] IDENTITY(1,1) NOT NULL,
	[canton_id] [int] NOT NULL,
	[district_name] [nvarchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[district_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [geo].[provinces](
	[province_id] [int] IDENTITY(1,1) NOT NULL,
	[province_name] [nvarchar](80) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[province_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[movement_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [inventory].[inventory_stock](
	[inventory_stock_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[qty_available] [decimal](18, 3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[inventory_stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [purchasing].[payment_terms](
	[term_id] [int] IDENTITY(1,1) NOT NULL,
	[term_name] [varchar](60) NOT NULL,
	[days_due] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[term_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[purchase_invoice_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[purchase_invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [purchasing].[suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](30) NULL,
	[is_active] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[sales_invoice_line_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
PRIMARY KEY CLUSTERED 
(
	[sales_invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [core].[roles] ON 
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name]) VALUES (1, N'SYS_ADMIN', N'Administrador del Sistema')
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name]) VALUES (2, N'APP_ADMIN', N'Administrador de la App')
GO
INSERT [core].[roles] ([role_id], [role_code], [role_name]) VALUES (3, N'APP_USER', N'Usuario Cliente')
GO
SET IDENTITY_INSERT [core].[roles] OFF
GO
SET IDENTITY_INSERT [core].[users] ON 
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active]) VALUES (1, 3, N'118290068', N'MADRIGAL DELGADO ANNDY JOSSUE', N'amadrigal90068@ufide.ac.cr', N'123', 1)
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active]) VALUES (2, 3, N'118290067', N'GUTIERREZ CERSOSIMO JORGE FABRICIO', N'jgutierrez90067@ufide.ac.cr', N'12345', 1)
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active]) VALUES (3, 3, N'118290066', N'SALAZAR AVALOS KEILYN JEANNETH', N'ksalazar90066@ufide.ac.cr', N'12345', 1)
GO
INSERT [core].[users] ([user_id], [role_id], [identification], [name], [email], [password], [is_active]) VALUES (4, 3, N'208680839', N'ALFARO RIVERA CAMILA ALEXANDRA', N'calfaro80839@ufide.ac.cr', N'1234', 1)
GO
SET IDENTITY_INSERT [core].[users] OFF
GO
ALTER TABLE [core].[product_categories] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [core].[products] ADD  DEFAULT ((1)) FOR [is_active]
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

CREATE PROCEDURE [core].[RegisterUser]
	@Identification varchar(15),
	@Name varchar(100),
	@Email varchar(100),
	@Password varchar(255)
	
	
AS
BEGIN

	Declare @Role_id INT = 3,
			@Is_Active INT = 1
	
    INSERT INTO core.users (role_id, identification, name, email, password, is_active)
    VALUES (@Role_id, @Identification,@Name,@Email,@Password,@Is_Active)

END
GO

CREATE PROCEDURE [core].[UpdatePassword]
	@Password VARCHAR(15),
	@User_id INT
AS
BEGIN
	
	UPDATE	core.users
	SET		password = @Password
	WHERE	user_id = @User_id

END
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
USE [master]
GO
ALTER DATABASE [Espiga_DB] SET  READ_WRITE 
GO
