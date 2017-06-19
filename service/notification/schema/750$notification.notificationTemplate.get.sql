CREATE OR REPLACE FUNCTION notification."notificationTemplate.get"(
    "@notificationTemplateId" INT
) RETURNS TABLE (
    "notificationTemplateId" SMALLINT,
    "name" VARCHAR(25),
    "notificationChannelId" SMALLINT,
    "notificationOperationId" SMALLINT,
    "notificationTargetId" SMALLINT,
    "content" TEXT,
    "isSingleResult" BOOLEAN
) AS
$BODY$
BEGIN
	RETURN QUERY
    SELECT
        "notificationTemplateId",
        "name",
        "notificationChannelId",
        "notificationOperationId",
        "notificationTargetId"
        "content",
        true as "isSingleResult"
    FROM
        notification."notificationTemplate" AS n
    WHERE
        n."notificationTemplateId" = "@notificationTemplateId";
END
$BODY$
LANGUAGE plpgsql;