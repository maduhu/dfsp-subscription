CREATE OR REPLACE FUNCTION notification."notificationTemplate.get"(
    "@notificationChannelId" INT,
    "@notificationOperationId" INT,
    "@notificationTargetId" INT
) RETURNS TABLE (
    "notificationTemplateId" INTEGER,
    "name" VARCHAR(25),
    "notificationChannelId" SMALLINT,
    "notificationOperationId" SMALLINT,
    "notificationTargetId" SMALLINT,
    "content" TEXT,
    "isSingleResult" BOOLEAN
) AS
$BODY$
BEGIN
    IF "@notificationChannelId" IS NULL THEN
        RAISE EXCEPTION 'notification.notificationChannelIdMissing';
    END IF;
    IF "@notificationOperationId" IS NULL THEN
        RAISE EXCEPTION 'notification.notificationOperationIdMissing';
    END IF;
    IF "@notificationTargetId" IS NULL THEN
        RAISE EXCEPTION 'notification.notificationTargetIdMissing';
    END IF;

	RETURN QUERY
    SELECT
        n."notificationTemplateId",
        n."name",
        n."notificationChannelId",
        n."notificationOperationId",
        n."notificationTargetId",
        n."content",
        true as "isSingleResult"
    FROM
        notification."notificationTemplate" AS n
    WHERE
        n."notificationChannelId" = "@notificationChannelId"
        AND n."notificationOperationId" = "@notificationOperationId"
        AND n."notificationTargetId" = "@notificationTargetId";
END
$BODY$
LANGUAGE plpgsql;