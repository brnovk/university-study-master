<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM news WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'news');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
