CREATE OR REPLACE FUNCTION notification."notificationTarget.fetch"(
    "@notificationTargetId" INT
) RETURNS TABLE(
    "notificationTargetId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."notificationTargetId",
        ns."name",
        ns."description"
    FROM
    	notification."notificationTarget" AS ns
    WHERE
    	("@notificationTargetId" IS NULL OR ns."notificationTargetId" = "@notificationTargetId");
END
$BODY$
LANGUAGE plpgsql;