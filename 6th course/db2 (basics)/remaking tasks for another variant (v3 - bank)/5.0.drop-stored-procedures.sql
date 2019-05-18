-- ------------------------ Removing stored procedures ------------------------

CONNECT TO LABSV3;

DROP PROCEDURE GET_CLIENT_BY_ACCOUNT_NUMBER;
DROP PROCEDURE GET_DEPOSIT_BY_CLIENT_ID;

CONNECT RESET;
