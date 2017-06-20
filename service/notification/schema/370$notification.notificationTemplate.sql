CREATE TABLE notification."notificationTemplate"
(
    "notificationTemplateId" SERIAL NOT NULL,
    "name" VARCHAR(25),
    "notificationChannelId" SMALLINT,
    "notificationOperationId" SMALLINT,
    "notificationTargetId" SMALLINT,
    "content" TEXT,
    CONSTRAINT "pkNotificationNotificationTemplateNotificationTemplateId" PRIMARY KEY ("notificationTemplateId"),
    CONSTRAINT "ukNotificationNotificationTemplate" UNIQUE ("notificationTemplateId", "notificationChannelId", "notificationOperationId", "notificationTargetId"),
    CONSTRAINT "fkNotificationNotificationTemplate_NotificationNotificationChannelId" FOREIGN KEY ("notificationChannelId")
        REFERENCES notification."notificationChannel" ("notificationChannelId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fkNotificationNotificationTemplate_NotificationNotificationOperationId" FOREIGN KEY ("notificationOperationId")
        REFERENCES notification."notificationOperation" ("notificationOperationId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fkNotificationNotificationTemplate_NotificationNotificationTargetId" FOREIGN KEY ("notificationTargetId")
        REFERENCES notification."notificationTarget" ("notificationTargetId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
