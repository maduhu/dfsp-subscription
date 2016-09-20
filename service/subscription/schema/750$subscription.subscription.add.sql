CREATE OR REPLACE FUNCTION subscription."subscription.add"(
  "@actorId" CHARACTER varying(25),
  "@phone" CHARACTER varying(25)
) RETURNS TABLE(
  "actorId" CHARACTER varying(25),
  "phone" CHARACTER varying(25)
)
AS
$body$
  WITH x as (
    INSERT INTO subscription.subscription ("actorId", "phone")
    VALUES ("@actorId", "@phone")
    RETURNING *
  )
  SELECT
    *
  FROM x
$body$
LANGUAGE SQL