<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM vacancies WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'vacancies');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
