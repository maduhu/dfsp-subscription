CREATE OR REPLACE FUNCTION notification."notification.add"(
    "@notificationTemplateId" INTEGER,
    "@actorId" VARCHAR(25),
    "@destinations" VARCHAR(25)[],
    "@content" TEXT,
    "@params" JSONB
) RETURNS TABLE (
    "addedRecords" BIGINT
)
AS
$BODY$
DECLARE
    "@notificationId" BIGINT;
BEGIN
	CREATE TEMP TABLE "phoneNumbers" (
        "phoneNumber" VARCHAR(25)
    )
    ON COMMIT DROP;
    
    IF "@destinations" IS NULL THEN
        INSERT INTO "phoneNumbers" SELECT "phoneNumber" FROM subscription."subscription.fetch"("@actorId");
    ELSE
        INSERT INTO "phoneNumbers" SELECT unnest("@destinations") as "phoneNumber";
    END IF;
    
    INSERT INTO notification."notification" (
            "notificationTemplateId",
            "notificationStatusId",
            "destination",
            "content",
            "params",
            "createdOn",
            "updatedOn"
        )
    SELECT 
        "@notificationTemplateId",
        (SELECT s."notificationStatusId" FROM notification."notificationStatus" AS s WHERE lower(s."name") = 'pending'),
        ph."phoneNumber",
        "@content",
        "@params",
        now(),
        now()
    FROM
        "phoneNumbers" AS ph;

	RETURN QUERY
    SELECT COUNT(*) FROM "phoneNumbers";
END
$BODY$
LANGUAGE plpgsql;