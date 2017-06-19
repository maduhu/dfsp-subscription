CREATE OR REPLACE FUNCTION notification."notificationTarget.get"(
    "@notificationTargetId" INT
) RETURNS TABLE(
  "notificationTargetId" SMALLINT,
  "name" VARCHAR(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        nc."notificationTargetId" AS "notificationTargetId",
        nc."name" AS "name",
        nc."description" AS "description",
        true as "isSingleResult"
    FROM
        notification."notificationTarget" AS nc
    WHERE
        nc."notificationTargetId" = "@notificationTargetId"
$body$
LANGUAGE SQL