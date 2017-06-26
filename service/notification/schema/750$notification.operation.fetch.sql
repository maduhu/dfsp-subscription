CREATE OR REPLACE FUNCTION notification."operation.fetch"(
    "@operationId" INT
) RETURNS TABLE(
    "operationId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT,
    "params" VARCHAR(25)[]
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."operationId",
        ns."name",
        ns."description",
        ns."params"
    FROM
    	notification."operation" AS ns
    WHERE
    	("@operationId" IS NULL OR ns."operationId" = "@operationId");
END
$BODY$
LANGUAGE plpgsql;