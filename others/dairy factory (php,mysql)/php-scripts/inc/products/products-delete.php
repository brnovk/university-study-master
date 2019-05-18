<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM products WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'products');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
