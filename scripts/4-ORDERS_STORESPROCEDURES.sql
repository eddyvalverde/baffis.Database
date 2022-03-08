CREATE PROCEDURE USP_LISTORDERS()
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IDSubscription,
   Subscriber,
   SubscribedOn,
   ExpiresOn,
   PaymentDay,
   Cost
   FROM ORDERS;
END
$proc$;

CREATE PROCEDURE USP_CREATEORDERS(
   IDSubscription_val INT,
   Subscriber_val           TEXT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   INSERT INTO ORDERS(IDSubscription,Subscriber,SubscribedOn) 
   VALUES(IDSubscription_val,Subscriber_val,NOW());
END
$proc$;

CREATE PROCEDURE USP_READORDERS(
   IDOrder_val INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IDSubscription,
   Subscriber,
   SubscribedOn,
   PaymentDay,
   Cost
   FROM ORDERS WHERE IDOrder=IDOrder_val;
END
$proc$;

CREATE PROCEDURE USP_DELETEORDERS(
   IDOrder_val INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   UPDATE ORDERS
   SET REMOVED = TRUE, UnsubscribedOn = NOW()
   WHERE IDOrder_val = IDOrder_val;
END
$proc$;

