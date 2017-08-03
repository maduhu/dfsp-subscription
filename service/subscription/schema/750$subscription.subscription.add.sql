CREATE OR REPLACE FUNCTION subscription."subscription.add"(
  "@actorId" CHARACTER varying(25),
  "@phoneNumber" CHARACTER varying(25)
) RETURNS TABLE(
  "subscriptionId" integer,
  "actorId" CHARACTER varying(25),
  "phoneNumber" CHARACTER varying(25),
  "primary" boolean,
  "isSingleResult" boolean
)
AS
$BODY$
DECLARE
  "@phoneId" INTEGER;
  "@primary" BOOLEAN;
  "@subscriptionId" INTEGER;
BEGIN
    IF "@actorId" IS NULL THEN
        RAISE EXCEPTION 'subscription.actorIdMissing';
    END IF;
    IF "@phoneNumber" IS NULL THEN
        RAISE EXCEPTION 'subscription.phoneNumberMissing';
    END IF;

    SELECT
      ph."phoneId",
      ph."primary"
    FROM 
      subscription."phone.add"("@phoneNumber") ph
    INTO
      "@phoneId",
      "@primary";
 WITH
   s as (
      INSERT INTO subscription.subscription ("phoneId", "actorId", "primary")
      VALUES ("@phoneId", "@actorId", "@primary")
      RETURNING *
    )
    SELECT
      s."subscriptionId"
    INTO
      "@subscriptionId"
    FROM s;
RETURN QUERY
  SELECT
    "@subscriptionId" as "subscriptionId",
    "@actorId" as "actorId",
    "@phoneNumber" as "phoneNumber",
    "@primary" as "primary",
    true AS "isSingleResult";
END
$BODY$
LANGUAGE plpgsql;
