CREATE TABLE notification."notificationTarget"
(
    "notificationTargetId" SMALLINT NOT NULL,
    "name" VARCHAR(25) NOT NULL,
    "description" TEXT,
    CONSTRAINT "pkNotificationNotificationTargetNotificationTargetId" PRIMARY KEY ("notificationTargetId")
)