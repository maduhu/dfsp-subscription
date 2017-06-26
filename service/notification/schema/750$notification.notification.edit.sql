CREATE OR REPLACE FUNCTION notification."notification.edit"(
    "@notificationId" BIGINT,
    "@statusId" INTEGER,
    "@destination" VARCHAR(25),
    "@content" TEXT
) RETURNS TABLE(
    "notificationId" BIGINT,
    "templateId" INTEGER,
    "statusId" SMALLINT,
    "destination" VARCHAR(25),
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
        "statusId" = COALESCE("@statusId", un."statusId"),
        "destination" = COALESCE("@destination", un."destination"),
        "content" = COALESCE("@content", un."content"),
        "updatedOn" = now()
    WHERE
    	un."notificationId" = "@notificationId";
        
    RETURN QUERY
    SELECT
    	n."notificationId",
        n."templateId",
        n."statusId",
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