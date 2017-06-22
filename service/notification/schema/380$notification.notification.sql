CREATE TABLE notification."notification"
(
  "notificationId" BIGSERIAL NOT NULL,
  "notificationTemplateId" INTEGER,
  "notificationStatusId" SMALLINT,
  "destination" CHARACTER VARYING(25),
  "content" Text,
  "params" jsonb,
  "createdOn" TIMESTAMP WITHOUT TIME ZONE,
  "updatedOn" TIMESTAMP WITHOUT TIME ZONE,
  CONSTRAINT "pkNotificationNotificationNotificationId" PRIMARY KEY ("notificationId"),
  CONSTRAINT "fkNotificationNotification_NotificationNotificationTemplate" FOREIGN KEY ("notificationTemplateId") REFERENCES notification."notificationTemplate" ("notificationTemplateId") MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "fkNotificationNotification_NotificationNotificationStatus" FOREIGN KEY ("notificationStatusId") REFERENCES notification."notificationStatus" ("notificationStatusId") MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)