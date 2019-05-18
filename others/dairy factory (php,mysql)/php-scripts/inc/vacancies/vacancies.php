<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, header, body, date FROM vacancies;");
    if ($r['rows'] !== 0) {
        $vacancies = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
