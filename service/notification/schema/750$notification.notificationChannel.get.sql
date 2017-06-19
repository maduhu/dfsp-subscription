CREATE OR REPLACE FUNCTION notification."notificationChannel.get"(
    "@notificationChannelId" INT
) RETURNS TABLE(
  "notificationChannelId" SMALLINT,
  "name" VARCHAR(25),
  "description" TEXT,
  "isSingleResult" BOOLEAN
)AS
$body$
    SELECT
        nc."notificationChannelId" AS "notificationChannelId",
        nc."name" AS "name",
        nc."description" AS "description",
        true as "isSingleResult"
    FROM
        notification."notificationChannel" AS nc
    WHERE
        nc."notificationChannelId" = "@notificationChannelId"
$body$
LANGUAGE SQL