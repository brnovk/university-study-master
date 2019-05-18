<?php

$name = htmlspecialchars($_POST["name"]);

if (empty(trim($name))) {
    $_SESSION["errormsg"] = "Пустое название типа продукта";
    header('Location: '.'products-type');
    exit;
} else if (strlen($name) > 255) {
    $_SESSION["errormsg"] = "Тип продукции не должен превышать 255 символов";
    header('Location: '.'products-type');
    exit;
}

try {
    DB::getInstance()->executeQuery("INSERT INTO typeproduct (name) VALUES (:name);", array(array(':name', $name)));
    header('Location: '.'products-type');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
