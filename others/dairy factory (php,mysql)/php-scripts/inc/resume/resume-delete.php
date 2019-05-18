<?php

$id = htmlspecialchars($_POST["id"]);
try {
    DB::getInstance()->executeQuery("DELETE FROM resume WHERE (id = :id);", array(array(':id', (int)$id)));
    header('Location: '.'resume');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
