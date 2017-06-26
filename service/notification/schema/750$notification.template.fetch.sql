CREATE OR REPLACE FUNCTION notification."template.fetch"(
    "@templateId" INT = NULL,
    "@channelId" INT = NULL,
    "@operationId" INT = NULL,
    "@targetId" INT = NULL,
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
    "@templates" JSON;
    "@pagination" JSON;
BEGIN
	with a AS (
        SELECT
            n."templateId",
            n."name",
            n."channelId",
            n."operationId",
            n."targetId",
            n."content"
        FROM
            notification."template" AS n
        WHERE
            ("@templateId" IS NULL OR n."templateId" = "@templateId")
            AND
            ("@channelId" IS NULL OR n."channelId" = "@channelId")
            AND
            ("@operationId" IS NULL OR n."operationId" = "@operationId")
            AND
            ("@targetId" IS NULL OR n."targetId" = "@targetId")
    )

    SELECT
        json_agg(row_to_json(aa)) as "templates",
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
    INTO "@templates", "@pagination";

    RETURN QUERY
    SELECT
        "@templates" AS "data",
        "@pagination" AS "pagination",
        true AS "isSingleResult";
END
$BODY$
LANGUAGE plpgsql;