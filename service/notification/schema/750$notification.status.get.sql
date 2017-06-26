CREATE OR REPLACE FUNCTION notification."status.get"(
  "@statusId" INTEGER
) RETURNS TABLE(
  "statusId" SMALLINT,
  "name" CHARACTER VARYING(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)
AS
$body$
  SELECT
    ns."statusId" AS "statusId",
    ns."name" AS "name",
    ns."description" AS "description",
    true AS "isSingleResult"
  FROM
    notification."status" AS ns
  WHERE
    ns."statusId" = "@statusId"
$body$
LANGUAGE SQL