<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, description, address, phone1, phone2, phone3, fax FROM about;");
    if ($r['rows'] !== 0) {
        $about = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}