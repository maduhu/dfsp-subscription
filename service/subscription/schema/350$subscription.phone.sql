CREATE TABLE subscription."phone"
(
  "phoneId" serial NOT NULL,
  "phoneNumber" character varying(25) NOT NULL,
  CONSTRAINT pkSubsciptionPhonePhoneId PRIMARY KEY ("phoneId"),
  CONSTRAINT ukSubsciptionPhonePhoneNumber UNIQUE ("phoneNumber")
)