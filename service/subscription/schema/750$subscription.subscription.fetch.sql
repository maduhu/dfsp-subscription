CREATE OR REPLACE FUNCTION subscription."subscription.fetch"(
  "@actorId" CHARACTER varying,
  "@phoneNumber" CHARACTER varying,
  "@primary" BOOLEAN
) RETURNS TABLE(
  "actorId" CHARACTER varying(25),
  "phoneNumber" CHARACTER varying(25),
  "primary" boolean
)
AS
$body$
  SELECT
    s."actorId" AS "actorId",
    p."phoneNumber" AS "phoneNumber",
    s."primary" AS "primary"
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
      AND
    ("@primary" is NULL or s."primary" = "@primary")
$body$
LANGUAGE SQL