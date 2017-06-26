CREATE OR REPLACE FUNCTION notification."template.get"(
    "@channelId" INT,
    "@operationId" INT,
    "@targetId" INT
) RETURNS TABLE (
    "templateId" INTEGER,
    "name" VARCHAR(25),
    "channelId" SMALLINT,
    "operationId" SMALLINT,
    "targetId" SMALLINT,
    "content" TEXT,
    "isSingleResult" BOOLEAN
) AS
$BODY$
BEGIN
    IF "@channelId" IS NULL THEN
        RAISE EXCEPTION 'notification.channelIdMissing';
    END IF;
    IF "@operationId" IS NULL THEN
        RAISE EXCEPTION 'notification.operationIdMissing';
    END IF;
    IF "@targetId" IS NULL THEN
        RAISE EXCEPTION 'notification.targetIdMissing';
    END IF;

	RETURN QUERY
    SELECT
        n."templateId",
        n."name",
        n."channelId",
        n."operationId",
        n."targetId",
        n."content",
        true as "isSingleResult"
    FROM
        notification."template" AS n
    WHERE
        n."channelId" = "@channelId"
        AND n."operationId" = "@operationId"
        AND n."targetId" = "@targetId";
END
$BODY$
LANGUAGE plpgsql;