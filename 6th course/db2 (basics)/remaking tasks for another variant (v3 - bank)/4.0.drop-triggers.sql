-- ------------------------- Removing triggers --------------------------------

CONNECT TO LABSV3;

DROP TRIGGER TRIGGER_DELETE_DEPOSIT;
DROP TRIGGER TRIGGER_DELETE_OPERATION;

CONNECT RESET;
