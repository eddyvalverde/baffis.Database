

CREATE TABLE Currency(
   IdCurrency INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   COUNTRY           TEXT    NOT NULL
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

