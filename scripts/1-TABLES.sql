

CREATE TABLE Currency(
   IdCurrency SERIAL PRIMARY KEY,
   COUNTRY           TEXT    NOT NULL,
   NAME           TEXT    NOT NULL,
   CODE           CHAR(5)    NOT NULL,
   SYMBOL           CHAR(5)    NOT NULL,
   REMOVED        BOOLEAN DEFAULT FALSE
);

CREATE TABLE Subscription(
   IDSubscription SERIAL PRIMARY KEY,
   Title           TEXT    NOT NULL,
   Description           TEXT    NOT NULL,
   Cost                 money NOT NULL,
   IdCurrency INT NOT NULL,
   REMOVED        BOOLEAN DEFAULT FALSE,
   CONSTRAINT fk_currency
      FOREIGN KEY(IdCurrency) 
	  REFERENCES Currency(IdCurrency)
);

CREATE TABLE Orders(
   IDOrder SERIAL PRIMARY KEY,
   IDSubscription INT  NOT NULL,
   Subscriber           TEXT    NOT NULL,
   SubscribedOn           TIMESTAMP    NOT NULL,
   UnsubscribedOn           TIMESTAMP,
   PaymentDay   INT,
   Cost         MONEY,
   REMOVED        BOOLEAN DEFAULT FALSE,
   CONSTRAINT fk_order
      FOREIGN KEY(IDSubscription) 
	  REFERENCES Subscription(IDSubscription)
);

CREATE TABLE Payment(
   IdPayment SERIAL PRIMARY KEY,
   IDOrder INT NOT NULL,
   PaymentDate           TIMESTAMP    NOT NULL,
   Cost         MONEY,
   REMOVED        BOOLEAN DEFAULT FALSE,
   CONSTRAINT fk_payment
      FOREIGN KEY(IDOrder) 
	  REFERENCES Orders(IDOrder)
);

CREATE OR REPLACE FUNCTION add_created_at_function()
  RETURNS trigger AS $BODY$
BEGIN
  NEW.Cost := (SELECT COST FROM public.Orders WHERE IDOrder = NEW.IDOrder);
  RETURN NEW;
END $BODY$
LANGUAGE plpgsql;

CREATE TRIGGER add_created_at_trigger
AFTER INSERT
ON public.Payment
FOR EACH ROW
EXECUTE PROCEDURE add_created_at_function();

CREATE OR REPLACE FUNCTION not_allow_multiple_subscriptions()
  RETURNS "trigger" AS $BODY$

BEGIN
        IF EXISTS (SELECT IDSubscription FROM public.Subscription WHERE REMOVED=FALSE) THEN
            RAISE EXCEPTION 'You cannot less or more than one Subscription to offer to your customers';
        END IF;
        RETURN NEW;
    END $BODY$

  LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER sett_one_subscription_trigger
  BEFORE INSERT OR DELETE
  ON public.Subscription
  FOR EACH ROW
  EXECUTE PROCEDURE public.not_allow_multiple_orders();

  CREATE OR REPLACE FUNCTION not_allow_multiple_enrollments()
  RETURNS "trigger" AS $BODY$

BEGIN
        IF EXISTS (SELECT IDOrder FROM public.Orders WHERE Subscriber = NEW.Subscriber AND IDSubscription=NEW.IDSubscription AND REMOVED = FALSE) THEN
            RAISE EXCEPTION 'You cannot have multiple enrollments to the same subscription';
        END IF;
        RETURN NEW;
    END $BODY$

  LANGUAGE 'plpgsql' VOLATILE;

  CREATE TRIGGER sett_one_subscription_order_trigger
  BEFORE INSERT OR DELETE
  ON public.Orders
  FOR EACH ROW
  EXECUTE PROCEDURE public.not_allow_multiple_enrollments();