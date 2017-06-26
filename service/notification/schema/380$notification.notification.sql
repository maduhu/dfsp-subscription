CREATE TABLE notification."notification"
(
  "notificationId" BIGSERIAL NOT NULL,
  "templateId" INTEGER,
  "statusId" SMALLINT,
  "destination" CHARACTER VARYING(25),
  "content" Text,
  "params" jsonb,
  "createdOn" TIMESTAMP WITHOUT TIME ZONE,
  "updatedOn" TIMESTAMP WITHOUT TIME ZONE,
  CONSTRAINT "pkNotificationNotificationNotificationId" PRIMARY KEY ("notificationId"),
  CONSTRAINT "fkNotificationNotification_NotificationTemplate" FOREIGN KEY ("templateId") REFERENCES notification."template" ("templateId") MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "fkNotificationNotification_NotificationStatus" FOREIGN KEY ("statusId") REFERENCES notification."status" ("statusId") MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)