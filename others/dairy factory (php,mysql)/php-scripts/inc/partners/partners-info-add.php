<?php

$header = htmlspecialchars($_POST["header"]);
$body = nl2br(htmlspecialchars($_POST["body"]),'<br>');

if (empty(trim($header)) || empty(trim($body))) {
    $_SESSION["errormsg"] = "Пустой заголовок или текст";
    header('Location: '.'partners');
    exit;
} else if (strlen($body) > 2500) {
    $_SESSION["errormsg"] = "Текст не должен превышать 2500 символов";
    header('Location: '.'partners');
    exit;
} else if (strlen($header) > 255) {
    $_SESSION["errormsg"] = "Заголовок новости не должен превышать 255 символов";
    header('Location: '.'partners');
    exit;
}

try {
    DB::getInstance()->executeQuery("INSERT INTO partners (header, body) VALUES (:header, :body);",
        array(array(':header', $header), array(':body', $body)));
    header('Location: '.'partners');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
