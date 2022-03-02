CREATE TABLE Currency(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   COUNTRY           TEXT    NOT NULL,
);

CREATE TABLE Subscription(
   ID INT PRIMARY KEY     NOT NULL,
   Title           TEXT    NOT NULL,
   Description           TEXT    NOT NULL,
   Cost                 DOUBLE NOT NULL,
   Currency INT NOT NULL,
   CONSTRAINT fk_currency
      FOREIGN KEY(Currency) 
	  REFERENCES Currency(ID)
);

CREATE TABLE Order(
   Subscription INT  NOT NULL,
   Subscriber           TEXT    NOT NULL,
   SubscribedOn           DATETIME    NOT NULL,
   ExpiresOn                 DATETIME,
   PaymentDay   INT,
   Cost         MONEY,
   PRIMARY KEY (Subscriber, field2)
);

