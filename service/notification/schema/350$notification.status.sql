CREATE TABLE notification."status"
(
    "statusId" SMALLINT NOT NULL,
    "name" CHARACTER VARYING(25) NOT NULL,
    "description" TEXT NULL,
    CONSTRAINT "pkNotificationStatusStatusId" PRIMARY KEY ("statusId")
)