CREATE OR ALTER PROCEDURE [purchasing].[SP_AdministrarPaymentTerms]
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