<?php

class Database {

	private static $dbName = 'db_car_sales';

	private static $dbHost = 'localhost';

	private static $dbUserName = 'root';

	private static $dbUserPassword = '1234';

  	private static $cont = null;

  function __construct() {
    die('Init function is not allowed');
  }

  public static function connect() {

    if (null == self::$cont) {
        self::$cont = new PDO( "mysql:host=".self::$dbHost.";"."dbname=".self::$dbName,
        self::$dbUserName,
        self::$dbUserPassword); 
    }
    return self::$cont;
  }

  public static function disconnect() {
    self::$cont = null;
  }

  public static function makeSortFunction($field) {
    $code = "return strnatcasecmp(
      Mb_strtolower(\$a['$field'],'UTF-8'), 
      Mb_strtolower(\$b['$field'],'UTF-8'));";
    return create_function('$a,$b', $code);
  }
  
}
