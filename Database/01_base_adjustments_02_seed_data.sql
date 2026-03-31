/* =========================================================
   01_base_adjustments.sql
   Ajustes estructurales requeridos por el proyecto
   Ejecutar después de Espiga_DB.sql
   ========================================================= */

USE Espiga_DB;
GO

/* 1. Agregar precio unitario a productos */
IF COL_LENGTH('core.products', 'unit_price') IS NULL
BEGIN
    ALTER TABLE core.products
    ADD unit_price DECIMAL(18,2) NOT NULL CONSTRAINT DF_products_unit_price DEFAULT (0);
END
GO

/* 2. Crear o actualizar SP para registrar productos */
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

/* =========================================================
   02_seed_data.sql
   Datos semilla mínimos del sistema
   Ejecutar después de 01_base_adjustments.sql
   ========================================================= */

USE Espiga_DB;
GO

/* 1. Categorías base */
IF NOT EXISTS (SELECT 1 FROM core.product_categories)
BEGIN
    INSERT INTO core.product_categories
    (
        category_name,
        is_active,
        created_by
    )
    VALUES
    ('Panadería', 1, 'seed_sql'),
    ('Repostería', 1, 'seed_sql'),
    ('Bebidas', 1, 'seed_sql');
END
GO

/* 2. Impuestos base */
IF NOT EXISTS (SELECT 1 FROM core.taxes)
BEGIN
    INSERT INTO core.taxes
    (
        tax_name,
        tax_rate,
        is_active,
        created_by
    )
    VALUES
    ('IVA 13%', 13.00, 1, 'seed_sql'),
    ('Exento', 0.00, 1, 'seed_sql');
END
GO

/* 3. Configuración general inicial */
IF NOT EXISTS (SELECT 1 FROM core.settings)
BEGIN
    INSERT INTO core.settings
    (
        company_name,
        currency_symbol,
        support_email,
        low_stock_threshold,
        created_by
    )
    VALUES
    ('Espiga Dorada', '?', 'soporte@espigadorada.com', 5, 'seed_sql');
END
GO