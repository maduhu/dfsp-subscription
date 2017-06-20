-- initial notification status records
INSERT INTO
  notification."notificationStatus" ("notificationStatusId", "name", "description")
VALUES
  (1, 'pending', 'pending status'),
  (2, 'sent', 'sent status'),
  (3, 'failed', 'failed status')
ON CONFLICT ("notificationStatusId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial notification target records
INSERT INTO
  notification."notificationTarget" ("notificationTargetId", "name", "description")
VALUES
  (1, 'source', 'notification will be sent to the initiator of the performed operation'),
  (2, 'destination', 'notification will be sent to the target of the performed operation')
ON CONFLICT ("notificationTargetId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial notification channel records
INSERT INTO
  notification."notificationChannel" ("notificationChannelId", "name", "description")
VALUES
  (1, 'sms', 'sms notification channel')
ON CONFLICT ("notificationChannelId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial test operation
INSERT INTO
  notification."notificationOperation" ("notificationOperationId", "name", "description", "params")
VALUES
  (1, 'p2p', 'desc for test p2p operation!', '{"amount", "currency"}')
ON CONFLICT ("notificationOperationId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "params" = EXCLUDED."params";