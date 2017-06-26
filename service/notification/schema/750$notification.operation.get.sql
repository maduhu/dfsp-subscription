CREATE OR REPLACE FUNCTION notification."operation.get"(
    "@operationId" INT
) RETURNS TABLE (
    "operationId" SMALLINT,
    "name" CHARACTER VARYING(25),
    "description" TEXT,
    "params" VARCHAR(25)[],
    "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        no."operationId" AS "operationId",
        no."name" AS "name",
        no."description" AS "description",
        no."params" AS "params",
        true AS "isSingleResult"
    FROM
        notification."operation" AS no
    WHERE
        no."operationId" = "@operationId"
$body$
LANGUAGE SQL