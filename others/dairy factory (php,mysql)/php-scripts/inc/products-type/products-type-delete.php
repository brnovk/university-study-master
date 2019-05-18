<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM typeproduct WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'products-type');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
