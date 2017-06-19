CREATE OR REPLACE FUNCTION notification."notificationStatus.get"(
  "@notificationStatusId" INTEGER
) RETURNS TABLE(
  "notificationStatusId" SMALLINT,
  "name" CHARACTER VARYING(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)
AS
$body$
  SELECT
    ns."notificationStatusId" AS "notificationStatusId",
    ns."name" AS "name",
    ns."description" AS "description",
    true AS "isSingleResult"
  FROM
    notification."notificationStatus" AS ns
  WHERE
    ns."notificationStatusId" = "@notificationStatusId"
$body$
LANGUAGE SQL