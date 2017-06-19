CREATE OR REPLACE FUNCTION notification."notificationStatus.fetch"(
    "@notificationStatusId" INT
) RETURNS TABLE(
    "notificationStatusId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."notificationStatusId",
        ns."name",
        ns."description"
    FROM
    	notification."notificationStatus" AS ns
    WHERE
    	("@notificationStatusId" IS NULL OR ns."notificationStatusId" = "@notificationStatusId");
END
$BODY$
LANGUAGE plpgsql;