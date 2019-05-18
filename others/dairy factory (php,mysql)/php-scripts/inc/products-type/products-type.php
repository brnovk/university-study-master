<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, name FROM typeproduct;");
    if ($r['rows'] !== 0) {
        $types = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
