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
   INSERT INTO CURRENCY(COUNTRY,NAME,CODE,SYMBOL) VALUES(COUNTRY_val,NAME_val,CODE_val,SYMBOL_val);
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

