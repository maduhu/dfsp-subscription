CREATE TABLE notification."channel"
(
	"channelId" SMALLINT NOT NULL,
  "name" CHARACTER VARYING(25),
  "description" TEXT NULL,
  CONSTRAINT "pkNotificationChannelChannelId" PRIMARY KEY ("channelId")
)