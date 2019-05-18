<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, name, description,
      (SELECT name FROM typeproduct WHERE typeproduct.id = products.type) AS type FROM products;");
    if ($r['rows'] !== 0) {
        $products = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
