CREATE OR REPLACE FUNCTION notification."target.get"(
    "@targetId" INT
) RETURNS TABLE(
  "targetId" SMALLINT,
  "name" VARCHAR(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        nc."targetId" AS "targetId",
        nc."name" AS "name",
        nc."description" AS "description",
        true as "isSingleResult"
    FROM
        notification."target" AS nc
    WHERE
        nc."targetId" = "@targetId"
$body$
LANGUAGE SQL