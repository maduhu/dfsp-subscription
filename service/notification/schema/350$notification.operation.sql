CREATE TABLE notification."operation"
(
    "operationId" SMALLINT NOT NULL,
    "name" CHARACTER VARYING(25) NOT NULL,
    "description" TEXT NULL,
    "params" VARCHAR(25)[],
    CONSTRAINT "pkNotificationOperationOperationId" PRIMARY KEY ("operationId")
)