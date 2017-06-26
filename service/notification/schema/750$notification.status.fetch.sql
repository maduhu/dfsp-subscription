CREATE OR REPLACE FUNCTION notification."status.fetch"(
    "@statusId" INT
) RETURNS TABLE(
    "statusId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."statusId",
        ns."name",
        ns."description"
    FROM
    	notification."status" AS ns
    WHERE
    	("@statusId" IS NULL OR ns."statusId" = "@statusId");
END
$BODY$
LANGUAGE plpgsql;