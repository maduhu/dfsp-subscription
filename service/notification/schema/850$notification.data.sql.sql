-- initial notification status records
INSERT INTO
  notification."status" ("statusId", "name", "description")
VALUES
  (1, 'pending', 'pending status'),
  (2, 'sent', 'sent status'),
  (3, 'failed', 'failed status')
ON CONFLICT ("statusId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial notification target records
INSERT INTO
  notification."target" ("targetId", "name", "description")
VALUES
  (1, 'source', 'notification will be sent to the initiator of the performed operation'),
  (2, 'destination', 'notification will be sent to the target of the performed operation')
ON CONFLICT ("targetId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial notification channel records
INSERT INTO
  notification."channel" ("channelId", "name", "description")
VALUES
  (1, 'sms', 'sms notification channel')
ON CONFLICT ("channelId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description";

-- initial test operation
INSERT INTO
  notification."operation" ("operationId", "name", "description", "params")
VALUES
  (1, 'p2p', 'desc for test p2p operation!', '{"paymentId", "receiver", "sourceAccount", "destinationAmount", "sourceIdentifier"}'),
  (2, 'invoice', 'desc for test invoce operation!', '{"amount", "currency"}'),
  (3, 'cashIn', 'desc for test cashIn operation!', '{"amount", "currency"}'),
  (4, 'cashOut', 'desc for test cashOut operation!', '{"amount", "currency"}'),
  (5, 'bulkPayment', 'desc for test bulkPayment operation!', '{"amount", "currency"}'),
  (6, 'invoiceCancel', 'desc for test invoiceCancel operation!', '{"invoiceNotificationId", "invoiceUrl", "identifier", "status", "memo"}'),
  (7, 'addHolder', 'desc for test addHolder operation!', '{"actorId", "accountNumber", "isDefault", "isSignatory", "identifier"}'),
  (8, 'removeHolder', 'desc for test removeHolder operation!', '{"actorAccountId"}'),
  (9, 'walletAdd', 'desc for test walletAdd operation!', '{"actor"}')
ON CONFLICT ("operationId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "params" = EXCLUDED."params";

-- initial test templates
INSERT INTO
  notification."template" ("templateId", "name", "channelId", "operationId", "targetId", "content")
VALUES
  (1, 'p2p send', 1, 1, 1, 'You have sent ${amount} ${currency}'),
  (2, 'p2p receive', 1, 1, 2, 'You have received ${amount} ${currency}'),
  (3, 'invoice send', 1, 2, 1, 'You have sent invoice payment for ${amount} ${currency}'),
  (4, 'invoice receive', 1, 2, 2, 'You have received invoice payment for ${amount} ${currency}'),
  (5, 'cash in', 1, 3, 1, 'You have sent cash in for ${amount} ${currency}'),
  (6, 'cash in', 1, 3, 2, 'You have received cash in for ${amount} ${currency}'),
  (7, 'cash out', 1, 4, 1, 'You have sent cash out request for ${amount} ${currency}'),
  (8, 'cash out', 1, 4, 2, 'You have received cash out request for ${amount} ${currency}'),
  (9, 'bulk payment', 1, 5, 1, 'You have sent payment for ${amount} ${currency}'),
  (10, 'bulk payment', 1, 5, 2, 'You have received payment for ${amount} ${currency}'),
  (11, 'invoice cancel', 1, 6, 1, 'Your invoice to ${identifier} has been cancelled'),
  (12, 'invoice cancel', 1, 6, 2, 'Your invoice to ${identifier} has been cancelled'),
  (13, 'add account holder', 1, 7, 2, 'You have been added as account holder to ${accountNumber}'),
  (14, 'remove account holder', 1, 8, 2, 'You have been removed as account holder from ${accountNumber}'),
  (15, 'account create', 1, 9, 1, 'You created new account')
ON CONFLICT ("templateId") DO UPDATE SET
  "name" = EXCLUDED."name",
  "channelId" = EXCLUDED."channelId",
  "operationId" = EXCLUDED."operationId",
  "targetId" = EXCLUDED."targetId",
  "content" = EXCLUDED."content";