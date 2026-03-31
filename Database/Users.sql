CREATE OR ALTER PROCEDURE [core].[GetSystemUsers]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        user_id,
        role_id,
        identification,
        name,
        email,
        is_active,
        [action],
        created_at,
        modified_at
    FROM [Espiga_DB].[core].[users]
    WHERE [action] <> 'D'
      AND role_id = 3
    ORDER BY user_id DESC;
END
GO;










CREATE OR ALTER PROCEDURE [core].[DeleteUserLogical]
    @UserId INT,
    @ModifiedBy VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE [Espiga_DB].[core].[users]
        SET
            [action] = 'D',
            is_active = 0,
            modified_by = @ModifiedBy,
            modified_at = GETDATE()
        WHERE user_id = @UserId
          AND [action] <> 'D';

        SELECT 1 AS Code, 'User deleted successfully.' AS Message;
    END TRY
    BEGIN CATCH
        SELECT 0 AS Code, ERROR_MESSAGE() AS Message;
    END CATCH
END
GO;


