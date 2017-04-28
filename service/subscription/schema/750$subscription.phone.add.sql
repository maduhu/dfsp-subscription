CREATE OR REPLACE FUNCTION subscription."phone.add"(
  "@phoneNumber" CHARACTER VARYING(25)
) RETURNS TABLE(
  "phoneId" INTEGER,
  "phoneNumber" CHARACTER VARYING(25),
  "isSingleResult" BOOLEAN
)
AS
$BODY$
#variable_conflict use_column
BEGIN
  INSERT INTO subscription.phone ("phoneNumber")
  VALUES ("@phoneNumber")
  ON CONFLICT DO NOTHING;
RETURN QUERY
  SELECT
    sp."phoneId",
    "@phoneNumber" as "phoneNumber",
    true AS "isSingleResult"
  FROM 
    subscription.phone sp
  WHERE 
    sp."phoneNumber" = "@phoneNumber";
END
$BODY$
LANGUAGE plpgsql;
