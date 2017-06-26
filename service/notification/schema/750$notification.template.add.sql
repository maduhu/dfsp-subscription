CREATE OR REPLACE FUNCTION notification."template.add"(
    "@name" VARCHAR(25),
    "@channelId" INTEGER,
    "@operationId" INTEGER,
    "@targetId" INTEGER,
    "@content" TEXT
) RETURNS TABLE(
    "templateId" INTEGER,
    "name" VARCHAR(25),
    "channelId" SMALLINT,
    "operationId" SMALLINT,
    "targetId" SMALLINT,
    "content" TEXT,
    "isSingleResult" BOOLEAN
)
AS
$BODY$
DECLARE
    "@templateId" INTEGER;
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
    
    WITH n AS (
        INSERT INTO notification."template" (
            "name",
            "channelId",
            "operationId",
            "targetId",
            "content"
        )
        VALUES (
            "@name",
            "@channelId",
            "@operationId",
            "@targetId",
            "@content"
        )
        RETURNING *
    )
    SELECT
        n."templateId"
    FROM
        n
    INTO
        "@templateId";

    RETURN QUERY
    SELECT
        nt."templateId",
        nt."name",
        nt."channelId",
        nt."operationId",
        nt."targetId",
        nt."content",
        true as "isSingleResult"
    FROM
        notification."template" AS nt
    WHERE
        nt."templateId" = "@templateId";
END
$BODY$
LANGUAGE plpgsql;