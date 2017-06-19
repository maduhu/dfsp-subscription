CREATE TABLE notification."notificationChannel"
(
	"notificationChannelId" SMALLINT NOT NULL,
  "name" CHARACTER VARYING(25),
  "description" TEXT NULL,
  CONSTRAINT "pkNotificationNotificationChannelNotificationChannelId" PRIMARY KEY ("notificationChannelId")
)