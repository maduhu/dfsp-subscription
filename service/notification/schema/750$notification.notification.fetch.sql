CREATE OR REPLACE FUNCTION notification."notification.fetch"(
    "@notificationId" INT = NULL, 
    "@templateId" INT = NULL,
    "@statusId" INT = NULL,
    "@destination" VARCHAR(25) = NULL,
    "@from" TIMESTAMP = NULL,
    "@to" TIMESTAMP = NULL,
    "@pageSize" INTEGER = 25,
    "@pageNumber" INTEGER = 1
) RETURNS TABLE (
  "data" JSON,
  "pagination" JSON,
  "isSingleResult" BOOLEAN
)
AS
$BODY$
DECLARE
    "@pageSize" INTEGER := COALESCE("@pageSize", 25);
    "@pageNumber" INTEGER := COALESCE("@pageNumber", 1);
    "@notifications" JSON;
    "@pagination" JSON;
BEGIN
    with a AS (
        SELECT
            n."notificationId",
            n."templateId",
            n."statusId",
            stat."name" as "statusName",
            n."destination",
            n."content",
            n."params",
            n."createdOn",
            n."updatedOn"
        FROM
            notification."notification" AS n
        JOIN
            notification."status" AS stat 
        ON
            stat."statusId" = n."statusId"
        WHERE
            ("@notificationId" IS NULL OR n."notificationId" = "@notificationId")
            AND
            ("@templateId" IS NULL OR n."templateId" = "@templateId")
            AND
            ("@statusId" IS NULL OR n."statusId" = "@statusId")
            AND
            ("@destination" IS NULL OR n."destination" ~* "@destination")
            AND
            ("@from" IS NULL OR n."updatedOn" >= "@from")
            AND
            ("@to" IS NULL OR n."updatedOn" <= "@to")
    )

	SELECT
        json_agg(row_to_json(aa)) as "notifications",
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
    INTO "@notifications", "@pagination";

    RETURN QUERY
    SELECT
        COALESCE("@notifications", '[]') AS "data",
        "@pagination" AS "pagination",
        true AS "isSingleResult";
END
$BODY$
LANGUAGE plpgsql;