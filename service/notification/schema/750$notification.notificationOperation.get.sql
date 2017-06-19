CREATE OR REPLACE FUNCTION notification."notificationOperation.get"(
    "@notificationOperationId" INT
) RETURNS TABLE (
    "notificationOperationId" SMALLINT,
    "name" CHARACTER VARYING(25),
    "description" TEXT,
    "params" VARCHAR(25)[],
    "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        no."notificationOperationId" AS "notificationOperationId",
        no."name" AS "name",
        no."description" AS "description",
        no."params" AS "params",
        true AS "isSingleResult"
    FROM
        notification."notificationOperation" AS no
    WHERE
        no."notificationOperationId" = "@notificationOperationId"
$body$
LANGUAGE SQL