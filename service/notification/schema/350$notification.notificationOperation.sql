CREATE TABLE notification."notificationOperation"
(
    "notificationOperationId" SMALLINT NOT NULL,
    "name" CHARACTER VARYING(25) NOT NULL,
    "description" TEXT NULL,
    "params" VARCHAR(25)[],
    CONSTRAINT "pkNotificationNotificationOperationNotificationOperationId" PRIMARY KEY ("notificationOperationId")
)