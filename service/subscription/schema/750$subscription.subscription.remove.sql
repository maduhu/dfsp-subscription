CREATE OR REPLACE FUNCTION subscription."subscription.remove"(
  "@subscriptionId" integer
) RETURNS TABLE(
  "subscriptionId" integer
)
AS
$body$
  WITH
  s as (
    DELETE FROM subscription."subscription"
    WHERE "subscriptionId" = "@subscriptionId"
    RETURNING *
  ),
  p as (
    DELETE FROM subscription."phone"
    WHERE "phoneId" = (SELECT "phoneId" FROM s)
    RETURNING *
  )
  SELECT
    s."subscriptionId"
  FROM s, p
$body$
LANGUAGE SQL
