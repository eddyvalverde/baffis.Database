CREATE OR REPLACE FUNCTION USP_LISTSUBSCRIPTION() 
RETURNS TABLE(
   IDSubscription INT,
   Title TEXT,Description TEXT,
   Cost  money,
   IdCurrency INT,
   COUNTRY TEXT,
   NAME TEXT,
   CODE CHAR(5),
   SYMBOL CHAR(5)
)
AS    $$
   SELECT 
   SUBSCRIPTION.IdSUBSCRIPTION AS IdSUBSCRIPTION,
   SUBSCRIPTION.Title AS Title,
   SUBSCRIPTION.Description AS Description,
   SUBSCRIPTION.Cost AS Cost,
   SUBSCRIPTION.IdCurrency AS IdCurrency,
   Currency.COUNTRY as COUNTRY,
   Currency.NAME as NAME,
   Currency.CODE as CODE,
   Currency.SYMBOL as SYMBOL
   FROM SUBSCRIPTION, Currency WHERE SUBSCRIPTION.IdCurrency = CURRENCY.IdCurrency;
$$
LANGUAGE SQL;

CREATE PROCEDURE USP_CREATESUBSCRIPTION(
   Title_val           TEXT,
   Description_val           TEXT,
   Cost_val                 money,
   IdCurrency_val INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   INSERT INTO SUBSCRIPTION(Title,Description,Cost,IdCurrency) VALUES(Title_val,Description_val,Cost_val,IdCurrency_val);
END
$proc$;

CREATE PROCEDURE USP_READSUBSCRIPTION(
   IdSUBSCRIPTION_val           INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   SELECT IdSUBSCRIPTION,
        Title,
        Description,
        Cost,
        IdCurrency
   FROM SUBSCRIPTION WHERE IdSUBSCRIPTION=IdSUBSCRIPTION_val;
END
$proc$;

CREATE PROCEDURE USP_UPDATESUBSCRIPTION(
   IdSUBSCRIPTION_val           INT,
   Title_val           TEXT,
   Description_val           TEXT,
   Cost_val                 money,
   IdCurrency_val INT
)
  LANGUAGE plpgsql AS
$proc$
BEGIN
   UPDATE SUBSCRIPTION
   SET Title=Title_val, Description=Description_val, Cost=Cost_val,IdCurrency=IdCurrency_val
   WHERE IdSUBSCRIPTION = IdSUBSCRIPTION_val;
END
$proc$;

