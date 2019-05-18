<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM partners WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'partners');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
