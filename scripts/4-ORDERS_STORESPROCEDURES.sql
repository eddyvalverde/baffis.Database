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
   Subscriber_val           TEXT,
   SubscribedOn_val           TIMESTAMP,
   ExpiresOn_val                 TIMESTAMP,
   PaymentDay_val   INT,
   Cost_val         MONEY
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   INSERT INTO ORDERS(IDSubscription,Subscriber,SubscribedOn,ExpiresOn,PaymentDay,Cost) 
   VALUES(IDSubscription_val,Subscriber_val,SubscribedOn_val,ExpiresOn_val,PaymentDay_val,Cost_val);
END
$proc$;

CREATE PROCEDURE USP_READORDERS(
   IDSubscription_val INT,
   Subscriber_val           TEXT,
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IDSubscription,
   Subscriber,
   SubscribedOn,
   ExpiresOn,
   PaymentDay,
   Cost
   FROM ORDERS WHERE IDSubscription=IDSubscription_val AND Subscriber=Subscriber_val;
END
$proc$;

CREATE PROCEDURE USP_UPDATEORDERS(
   IDSubscription_val INT,
   Subscriber_val           TEXT,
   SubscribedOn_val           TIMESTAMP,
   ExpiresOn_val                 TIMESTAMP,
   PaymentDay_val   INT,
   Cost_val         MONEY
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   UPDATE ORDERS
   SET ExpiresOn=ExpiresOn_val
   WHERE IDSubscription = IDSubscription_val AND Subscriber=Subscriber_val;
END
$proc$;

