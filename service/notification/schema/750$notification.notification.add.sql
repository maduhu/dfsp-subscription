CREATE OR REPLACE FUNCTION notification."notification.add"(
    "@notificationTemplateId" SMALLINT,
    "@destination" VARCHAR(100),
    "@content" TEXT,
    "@params" JSONB
) RETURNS TABLE (
    "notificationId" BIGINT,
    "notificationTemplateId" INTEGER,
    "notificationStatusId" SMALLINT,
    "destination" VARCHAR(100),
    "content" TEXT,
    "params" JSONB,
    "createdOn" TIMESTAMP WITHOUT TIME ZONE,
    "updatedOn" TIMESTAMP WITHOUT TIME ZONE,
    "isSingleResult" BOOLEAN
)
AS
$BODY$
DECLARE
    "@notificationId" BIGINT;
BEGIN
    WITH
    n as (
        INSERT INTO subsription."notification" (
            "notificationTemplateId",  
            "notificationStatusId",  
            "destination",  
            "content",  
            "params",  
            "createdOn",  
            "updatedOn"
        )
        VALUES (
            "@notificationTemplateId", 
            (SELECT s."notificationStatusId" FROM notification."notificationStatus" AS s WHERE lower(s."name") = 'pending'), 
            "@destination", 
            "@content", 
            "@params", 
            now(), 
            now()
        )
        RETURNING *
    )
    SELECT 
    	n."notificationId"
    FROM
    	n
    INTO
    	"@notificationId";
        
    RETURN QUERY
    SELECT
        "notificationId",
        "notificationTemplateId",
        "notificationStatusId",
        "destination",
        "content",
        "params",
        "createdOn",
        "updatedOn",
        true as "isSingleResult" 
    FROM 
        notification."notification" as sn
    WHERE
    	sn."notificationId" = "@notificationId";
END
$BODY$
LANGUAGE plpgsql;