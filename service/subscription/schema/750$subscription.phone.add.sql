CREATE OR REPLACE FUNCTION subscription."phone.add"(
  "@phoneNumber" CHARACTER VARYING(25)
) RETURNS TABLE(
  "phoneId" INTEGER,
  "phoneNumber" CHARACTER VARYING(25),
  "primary" BOOLEAN,
  "isSingleResult" BOOLEAN
)
AS
$BODY$
#variable_conflict use_column
DECLARE
  "@primary" BOOLEAN := true;
BEGIN
  IF EXISTS (SELECT 1 FROM subscription.phone sp WHERE sp."phoneNumber" = "@phoneNumber") THEN
    "@primary" = false;
  ELSE
    INSERT INTO subscription.phone ("phoneNumber")
    VALUES ("@phoneNumber");
  END IF;
RETURN QUERY
  SELECT
    sp."phoneId",
    "@phoneNumber" as "phoneNumber",
    "@primary" as "primary",
    true AS "isSingleResult"
  FROM 
    subscription.phone sp
  WHERE 
    sp."phoneNumber" = "@phoneNumber";
END
$BODY$
LANGUAGE plpgsql;
