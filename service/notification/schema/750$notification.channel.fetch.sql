CREATE OR REPLACE FUNCTION notification."channel.fetch"(
    "@channelId" INT
) RETURNS TABLE(
    "channelId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."channelId",
        ns."name",
        ns."description"
    FROM
    	notification."channel" AS ns
    WHERE
    	("@channelId" IS NULL OR ns."channelId" = "@channelId");
END
$BODY$
LANGUAGE plpgsql;