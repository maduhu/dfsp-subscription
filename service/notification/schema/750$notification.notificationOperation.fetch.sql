CREATE OR REPLACE FUNCTION notification."notificationOperation.fetch"(
    "@notificationOperationId" INT
) RETURNS TABLE(
    "notificationOperationId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT,
    "params" VARCHAR(25)[]
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."notificationOperationId",
        ns."name",
        ns."description",
        ns."params"
    FROM
    	notification."notificationOperation" AS ns
    WHERE
    	("@notificationOperationId" IS NULL OR ns."notificationOperationId" = "@notificationOperationId");
END
$BODY$
LANGUAGE plpgsql;