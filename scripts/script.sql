

CREATE TABLE Currency(
   IdCurrency SERIAL PRIMARY KEY,
   COUNTRY           TEXT    NOT NULL,
   NAME           TEXT    NOT NULL,
   CODE           CHAR(5)    NOT NULL,
   SYMBOL           CHAR(5)    NOT NULL
);

CREATE TABLE Subscription(
   IDSubscription INT PRIMARY KEY     NOT NULL,
   Title           TEXT    NOT NULL,
   Description           TEXT    NOT NULL,
   Cost                 money NOT NULL,
   IdCurrency INT NOT NULL,
   CONSTRAINT fk_currency
      FOREIGN KEY(IdCurrency) 
	  REFERENCES Currency(IdCurrency)
);

CREATE TABLE Orders(
   IDSubscription INT  NOT NULL,
   Subscriber           TEXT    NOT NULL,
   SubscribedOn           TIMESTAMP    NOT NULL,
   ExpiresOn                 TIMESTAMP,
   PaymentDay   INT,
   Cost         MONEY,
   PRIMARY KEY (Subscriber, IDSubscription),
   CONSTRAINT fk_order
      FOREIGN KEY(IDSubscription) 
	  REFERENCES Subscription(IDSubscription)
);

CREATE TABLE Payment(
   IdPayment SERIAL PRIMARY KEY,
   IDSubscription INT  NOT NULL,
   Subscriber           TEXT    NOT NULL,
   PaymentDate           TIMESTAMP    NOT NULL,
   Cost         MONEY,
   CONSTRAINT fk_payment
      FOREIGN KEY(Subscriber, IDSubscription) 
	  REFERENCES Orders(Subscriber, IDSubscription)
);

CREATE PROCEDURE USP_LISTCURRENCY()
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IdCurrency,
         COUNTRY,
         NAME,
         CODE,
         SYMBOL
   FROM CURRENCY;
END
$proc$;

CREATE PROCEDURE USP_CREATECURRENCY(
   COUNTRY_val           TEXT,
   NAME_val           TEXT,
   CODE_val           CHAR(5),
   SYMBOL_val           CHAR(5)
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   INSERT INT CURRENCY(COUNTRY,NAME,CODE,SYMBOL) VALUES(COUNTRY_val,NAME_val,CODE_val,SYMBOL_val);
END
$proc$;

CREATE PROCEDURE USP_READCURRENCY(
   IdCurrency_val           INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IdCurrency,
         COUNTRY,
         NAME,
         CODE,
         SYMBOL
   FROM CURRENCY WHERE IdCurrency=IdCurrency_val;
END
$proc$;

CREATE PROCEDURE USP_UPDATECURRENCY(
   IdCurrency_val           INT,
   COUNTRY_val           TEXT,
   NAME_val           TEXT,
   CODE_val           CHAR(5),
   SYMBOL_val           CHAR(5)
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   UPDATE Currency
   SET COUNTRY=COUNTRY_val, NAME=NAME_val, CODE=CODE_val,SYMBOL=SYMBOL_val
   WHERE IdCurrency = IdCurrency_val;
END
$proc$;

create or replace procedure USP_CREATECURRENCY(
   sender int,
   receiver int,
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$