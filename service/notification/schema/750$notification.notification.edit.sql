CREATE OR REPLACE FUNCTION notification."notification.edit"(
    "@notificationId" BIGINT,
    "@notificationStatusId" INTEGER,
    "@destination" VARCHAR(100),
    "@content" TEXT
) RETURNS TABLE(
    "notificationId" BIGINT,
    "notificationTemplateId" INTEGER,
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
	UPDATE notification."notification" AS un
    SET
    	"notificationStatusId" = COALESCE("@notificationStatusId", un."notificationStatusId"),
        "destination" = COALESCE("@destination", un."destination"),
        "content" = COALESCE("@content", un."content"),
        "updatedOn" = now()
    WHERE
    	un."notificationId" = "@notificationId";
        
    RETURN QUERY
    SELECT
    	n."notificationId",
        n."notificationTemplateId",
        n."notificationStatusId",
        n."destination",
        n."content",
        n."params",
        n."createdOn",
        n."updatedOn",
        true AS "isSingleResult"
    FROM
    	notification."notification" AS n
    WHERE
    	n."notificationId" = "@notificationId";
END
$body$
LANGUAGE plpgsql