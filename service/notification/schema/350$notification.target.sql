CREATE TABLE notification."target"
(
    "targetId" SMALLINT NOT NULL,
    "name" VARCHAR(25) NOT NULL,
    "description" TEXT,
    CONSTRAINT "pkNotificationTargetTargetId" PRIMARY KEY ("targetId")
)