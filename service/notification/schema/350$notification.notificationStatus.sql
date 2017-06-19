CREATE TABLE notification."notificationStatus"
(
    "notificationStatusId" SMALLINT NOT NULL,
    "name" CHARACTER VARYING(25) NOT NULL,
    "description" TEXT NULL,
    CONSTRAINT "pkNotificationNotificationStatusNotificationStatusId" PRIMARY KEY ("notificationStatusId")
)