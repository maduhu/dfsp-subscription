CREATE OR REPLACE FUNCTION notification."target.fetch"(
    "@targetId" INT
) RETURNS TABLE(
    "targetId" SMALLINT,
    "name" VARCHAR(25),
    "description" TEXT
)
AS
$BODY$
BEGIN
	RETURN QUERY
	SELECT
    	ns."targetId",
        ns."name",
        ns."description"
    FROM
    	notification."target" AS ns
    WHERE
    	("@targetId" IS NULL OR ns."targetId" = "@targetId");
END
$BODY$
LANGUAGE plpgsql;