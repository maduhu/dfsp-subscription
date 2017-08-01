CREATE OR REPLACE FUNCTION subscription."subscription.get"(
  "@actorId" CHARACTER varying,
  "@phoneNumber" CHARACTER varying
) RETURNS TABLE(
  "actorId" CHARACTER varying(25),
  "phoneNumber" CHARACTER varying(25),
  "primary" boolean,
  "isSingleResult" boolean
)
AS
$body$
  SELECT
    s."actorId" AS "actorId",
    p."phoneNumber" AS "phoneNumber",
    s."primary" AS "primary",
    true AS "isSingleResult"
  FROM
    subscription.subscription AS s
  JOIN
    subscription.phone AS p
  ON
    s."phoneId" = p."phoneId"
  WHERE
    ("@actorId" IS NULL OR s."actorId" = "@actorId")
      AND
    ("@phoneNumber" is NULL or p."phoneNumber" = "@phoneNumber")
$body$
LANGUAGE SQL