CREATE OR REPLACE FUNCTION notification."template.edit"(
    "@templateId" INTEGER,
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
BEGIN
    IF "@templateId" IS NULL THEN
        RAISE EXCEPTION 'notification.templateIdMissing';
    END IF;
    
    UPDATE notification."template" AS nt
    SET
        "name" = COALESCE("@name", nt."name"),
        "channelId" = COALESCE("@channelId", nt."channelId"),
        "operationId" = COALESCE("@operationId", nt."operationId"),
        "targetId" = COALESCE("@targetId", nt."targetId"),
        "content" = COALESCE("@content", nt."content")
    WHERE
        nt."templateId" = "@templateId";

    RETURN QUERY
    SELECT
        t."templateId",
        t."name",
        t."channelId",
        t."operationId",
        t."targetId",
        t."content",
        true as "isSingleResult"
    FROM
        notification."template" AS t
    WHERE
        t."templateId" = "@templateId";
END
$BODY$
LANGUAGE plpgsql;