CREATE OR REPLACE FUNCTION notification."notification.remove"(
    "@notificationId" BIGINT
) RETURNS TABLE (
    "notificationId" BIGINT,
    "notificationTemplateId" SMALLINT,
    "notificationStatusId" SMALLINT,
    "destination" VARCHAR(100),
    "content" TEXT,
    "params" JSONB,
    "createdOn" TIMESTAMP WITHOUT TIME ZONE,
    "updatedOn" TIMESTAMP WITHOUT TIME ZONE,
    "isSingleResult" BOOLEAN
)
AS
$BODY$
DECLARE
    "@notificationId" BIGINT;
BEGIN
    
END
$BODY$
LANGUAGE plpgsql;