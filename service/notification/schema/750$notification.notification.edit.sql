CREATE OR REPLACE FUNCTION notification."notification.edit"(
    "@notificationId" BIGINT,
    "@notificationStatusId" SMALLINT,
    "@destination" VARCHAR(100),
    "@content" TEXT
) RETURNS TABLE(
    "notificationId" BIGINT,
    "notificationTemplateId" SMALLINT,
    "notificationStatusId" SMALLINT,
    "destination" VARCHAR(100),
    "content" TEXT,
    "params" JSONB,
    "createdOn" TIMESTAMP WITHOUT TIME ZONE,
    "updatedOn" TIMESTAMP WITHOUT TIME ZONE,
    "isSingleResult" bool
)
AS
$body$
BEGIN
	UPDATE notification."notification"
    SET
    	"notificationStatusId" = COALESCE("@notificationStatusId", "notificationStatusId"),
        "destination" = COALESCE("@destination", "destination"),
        "content" = COALESCE("@content", "content"),
        "updatedOn" = now()
    WHERE
    	"notificationId" = "@notificationId";
        
    RETURN QUERY
    SELECT
    	"notificationId",
        "notificationTemplateId",
        "notificationStatusId",
        "destination",
        "content",
        "params",
        "createdOn",
        "updatedOn",
        true AS "isSingleResult"
    FROM
    	notification."notification"
    WHERE
    	"notificationId" = "@notificationId";
END
$body$
LANGUAGE plpgsql