<?php

try {
    $r = DB::getInstance()->executeQuery("SELECT id, message, (SELECT header FROM vacancies
      WHERE resume.vacanciesId = vacancies.id) AS vacancies FROM resume;");
    if ($r['rows'] !== 0) {
        $resume = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
