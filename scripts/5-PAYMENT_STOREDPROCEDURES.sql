CREATE PROCEDURE USP_LISTPAYMENT()
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IdPayment ,
   IDSubscription,
   Subscriber,
   PaymentDate,
   Cost,
   FROM PAYMENT;
END
$proc$;

CREATE PROCEDURE USP_CREATEPAYMENT(
   IDSubscription_val INT  NOT NULL,
   Subscriber_val           TEXT    NOT NULL,
   PaymentDate_val           TIMESTAMP    NOT NULL,
   Cost_val         MONEY,
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   INSERT INTO PAYMENT(IDSubscription,Subscriber,PaymentDate,Cost) 
   VALUES(IDSubscription_val,Subscriber_val,PaymentDate_val,Cost_val);
END
$proc$;

CREATE PROCEDURE USP_READPAYMENT(
   IdPayment_val INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IdPayment ,
   IDSubscription,
   Subscriber,
   PaymentDate,
   Cost
   FROM PAYMENT WHERE IdPayment=IdPayment_val;
END
$proc$;


