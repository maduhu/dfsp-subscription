CREATE OR REPLACE FUNCTION notification."channel.get"(
    "@channelId" INT
) RETURNS TABLE(
  "channelId" SMALLINT,
  "name" VARCHAR(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        nc."channelId" AS "channelId",
        nc."name" AS "name",
        nc."description" AS "description",
        true as "isSingleResult"
    FROM
        notification."channel" AS nc
    WHERE
        nc."channelId" = "@channelId"
$body$
LANGUAGE SQL