<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, header, body FROM partners");
    if ($r['rows'] !== 0) {
        $partners = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
