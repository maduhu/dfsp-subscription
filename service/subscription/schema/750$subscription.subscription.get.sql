CREATE OR REPLACE FUNCTION subscription."subscription.get"(
  "@actorId" CHARACTER varying,
  "@phone" CHARACTER varying
) RETURNS TABLE(
  "actorId" CHARACTER varying(25),
  "phone" CHARACTER varying(25)
)
AS
$body$
  SELECT *
  FROM subscription.subscription AS a
  WHERE
  	("@actorId" IS NULL OR a."actorId" = "@actorId")
	    AND
	  ("@phone" is NULL or a."phone" = "@phone")
$body$
LANGUAGE SQL