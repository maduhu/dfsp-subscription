CREATE OR REPLACE FUNCTION notification."notificationOperation.fetch"(
    "@notificationOperationId" INT
) RETURNS TABLE(
    "notificationOperationId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."notificationOperationId",
        ns."name",
        ns."description"
    FROM
    	notification."notificationOperation" AS ns
    WHERE
    	("@notificationOperationId" IS NULL OR ns."notificationOperationId" = "@notificationOperationId");
END
$BODY$
LANGUAGE plpgsql;