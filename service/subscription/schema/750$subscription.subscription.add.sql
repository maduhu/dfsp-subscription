CREATE OR REPLACE FUNCTION subscription."subscription.add"(
  "@actorId" CHARACTER varying(25),
  "@phoneNumber" CHARACTER varying(25)
) RETURNS TABLE(
  "subscriptionId" integer,
  "actorId" CHARACTER varying(25),
  "phoneNumber" CHARACTER varying(25),
  "isSingleResult" boolean
)
AS
$body$
  WITH
  p as (
    INSERT INTO subscription.phone ("phoneNumber")
    VALUES ("@phoneNumber")
    RETURNING *
  ),
  s as (
    INSERT INTO subscription.subscription ("phoneId", "actorId")
    VALUES ((SELECT "phoneId" FROM p), "@actorId")
    RETURNING *
  )

  SELECT
    s."subscriptionId",
    s."actorId",
    p."phoneNumber",
    true AS "isSingleResult"
  FROM s, p
$body$
LANGUAGE SQL