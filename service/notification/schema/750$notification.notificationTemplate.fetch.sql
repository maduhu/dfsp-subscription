CREATE OR REPLACE FUNCTION notification."notificationTemplate.fetch"(
    "@notificationTemplateId" INT = NULL,
    "@notificationChannelId" INT = NULL,
    "@notificationOperationId" INT = NULL,
    "@notificationTargetId" INT = NULL,
    "@pageSize" INTEGER = 25,
    "@pageNumber" INTEGER = 1
) RETURNS TABLE (
    "data" JSON,
    "pagination" JSON,
    "isSingleResult" BOOLEAN
) AS
$BODY$
DECLARE
    "@pageSize" INTEGER := COALESCE("@pageSize", 25);
    "@pageNumber" INTEGER := COALESCE("@pageNumber", 1);
    "@notificationTemplates" JSON;
    "@pagination" JSON;
BEGIN
	with a AS (
        SELECT
            n."notificationTemplateId",
            n."name",
            n."notificationChannelId",
            n."notificationOperationId",
            n."notificationTargetId",
            n."content"
        FROM
            notification."notificationTemplate" AS n
        WHERE
            ("@notificationTemplateId" IS NULL OR n."notificationTemplateId" = "@notificationTemplateId")
            AND
            ("@notificationChannelId" IS NULL OR n."notificationChannelId" = "@notificationChannelId")
            AND
            ("@notificationOperationId" IS NULL OR n."notificationOperationId" = "@notificationOperationId")
            AND
            ("@notificationTargetId" IS NULL OR n."notificationTargetId" = "@notificationTargetId")
    )

    SELECT
        json_agg(row_to_json(aa)) as "notificationTemplates",
        json_build_object(
            'pageNumber', "@pageNumber",
            'pageSize', "@pageSize",
            'pagesTotal', (SELECT CEIL(COUNT(a)::numeric / "@pageSize") FROM a),
            'recordsTotal', (SELECT COUNT(a) FROM a)
        ) AS "pagination"
    FROM
    (
        SELECT a.*
        FROM a
        LIMIT "@pageSize" OFFSET ("@pageNumber" - 1) * "@pageSize"
    ) aa
    INTO "@notificationTemplates", "@pagination";

    RETURN QUERY
    SELECT
        "@notificationTemplates" AS "data",
        "@pagination" AS "pagination",
        true AS "isSingleResult";
END
$BODY$
LANGUAGE plpgsql;