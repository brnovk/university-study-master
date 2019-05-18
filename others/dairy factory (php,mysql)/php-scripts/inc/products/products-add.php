<?php

$name = htmlspecialchars($_POST["name"]);
$description = nl2br(htmlspecialchars($_POST["description"]),'<br>');
$type = htmlspecialchars($_POST["type"]);

if (empty(trim($name)) || empty(trim($description))) {
    $_SESSION["errormsg"] = "Пустое название или описание продукта";
    header('Location: '.'products');
    exit;
} else if (strlen($description) > 500) {
    $_SESSION["errormsg"] = "Описание не должно превышать 500 символов";
    header('Location: '.'products');
    exit;
} else if (strlen($header) > 255) {
    $_SESSION["errormsg"] = "Название продукта не должно превышать 255 символов";
    header('Location: '.'products');
    exit;
}

try {
    DB::getInstance()->executeQuery("INSERT INTO products (name, description, type)
      VALUES (:name, :description, (SELECT id FROM typeproduct WHERE id = :id));",
        array(array(':name', $name), array(':description', $description), array(':id', (int)$type)));
    header('Location: '.'products');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
