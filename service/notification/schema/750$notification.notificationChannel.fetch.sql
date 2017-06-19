CREATE OR REPLACE FUNCTION notification."notificationChannel.fetch"(
    "@notificationChannelId" INT
) RETURNS TABLE(
    "notificationChannelId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."notificationChannelId",
        ns."name",
        ns."description"
    FROM
    	notification."notificationChannel" AS ns
    WHERE
    	("@notificationChannelId" IS NULL OR ns."notificationChannelId" = "@notificationChannelId");
END
$BODY$
LANGUAGE plpgsql;