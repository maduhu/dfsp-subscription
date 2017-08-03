CREATE TABLE subscription."subscription"
(
  "subscriptionId" serial NOT NULL,
  "phoneId" integer NOT NULL,
  "actorId" character varying(25) NOT NULL,
  "primary" boolean,
  CONSTRAINT pkSubsciptionSubsciptionSubsciptionId PRIMARY KEY ("subscriptionId"),
  CONSTRAINT "fkSubscriptionSubscription_SubscriptionPhone" FOREIGN KEY ("phoneId") REFERENCES subscription."phone" ("phoneId") MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
