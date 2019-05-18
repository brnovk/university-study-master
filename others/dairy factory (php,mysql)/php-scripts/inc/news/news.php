<?php
try {
    $r = DB::getInstance()->executeQuery("SELECT id, header, body, dateTime FROM news");
    if ($r['rows'] !== 0) {
        $news = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
