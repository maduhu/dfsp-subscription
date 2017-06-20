CREATE OR REPLACE FUNCTION notification."notificationTemplate.add"(
    "@notificationChannelId" INTEGER,
    "@notificationOperationId" INTEGER,
    "@notificationTargetId" INTEGER,
    "@content" TEXT
) RETURNS TABLE(
    "notificationTemplateId" INTEGER,
    "name" VARCHAR(25),
    "notificationChannelId" SMALLINT,
    "notificationOperationId" SMALLINT,
    "notificationTargetId" SMALLINT,
    "content" TEXT,
    "isSingleResult" BOOLEAN
)
AS
$BODY$
DECLARE
    "@notificationTemplateId" INTEGER;
BEGIN
    WITH n AS (
        INSERT INTO notification."notificationTemplate" (
            "name",
            "notificationChannelId",
            "notificationOperationId",
            "notificationTargetId",
            "content"
        )
        VALUES (
            "@name",
            "@notificationChannelId",
            "@notificationOperationId",
            "@notificationTargetId",
            "@content"
        )
        RETURNING *
    )
    SELECT
        n."notificationTemplateId"
    FROM
        n
    INTO
        "@notificationTemplateId";

    RETURN QUERY
    SELECT
        nt."notificationTemplateId",
        nt."name",
        nt."notificationChannelId",
        nt."notificationOperationId",
        nt."notificationTargetId",
        nt."content",
        true as "isSingleResult"
    FROM
        notification."notificationTemplate" AS nt
    WHERE
        nt."notificationTemplateId" = "@notificationTemplateId";
END
$BODY$
LANGUAGE plpgsql;