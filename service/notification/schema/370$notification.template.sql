CREATE TABLE notification."template"
(
    "templateId" SERIAL NOT NULL,
    "name" VARCHAR(25),
    "channelId" SMALLINT,
    "operationId" SMALLINT,
    "targetId" SMALLINT,
    "content" TEXT,
    CONSTRAINT "pkNotificationTemplateTemplateId" PRIMARY KEY ("templateId"),
    CONSTRAINT "ukNotificationTemplateChannelOperationTarget" UNIQUE ("channelId", "operationId", "targetId"),
    CONSTRAINT "fkNotificationTemplate_NotificationChannelId" FOREIGN KEY ("channelId")
        REFERENCES notification."channel" ("channelId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fkNotificationTemplate_NotificationOperationId" FOREIGN KEY ("operationId")
        REFERENCES notification."operation" ("operationId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fkNotificationTemplate_NotificationTargetId" FOREIGN KEY ("targetId")
        REFERENCES notification."target" ("targetId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
