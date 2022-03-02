CREATE TABLE Currency(
   IdCurrency INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   COUNTRY           TEXT    NOT NULL,
);

CREATE TABLE Subscription(
   IDSubscription INT PRIMARY KEY     NOT NULL,
   Title           TEXT    NOT NULL,
   Description           TEXT    NOT NULL,
   Cost                 DOUBLE NOT NULL,
   IdCurrency INT NOT NULL,
   CONSTRAINT fk_currency
      FOREIGN KEY(Currency) 
	  REFERENCES Currency(IdCurrency)
);

CREATE TABLE Order(
   IDSubscription INT  NOT NULL,
   Subscriber           TEXT    NOT NULL,
   SubscribedOn           DATETIME    NOT NULL,
   ExpiresOn                 DATETIME,
   PaymentDay   INT,
   Cost         MONEY,
   PRIMARY KEY (Subscriber, IDSubscription)
);

