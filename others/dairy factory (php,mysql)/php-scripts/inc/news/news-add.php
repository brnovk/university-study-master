<?php

$header = htmlspecialchars($_POST["header"]);
$body = nl2br(htmlspecialchars($_POST["body"]),'<br>');
if (empty(trim($header)) || empty(trim($body))) {
    $_SESSION["errormsg"] = "Пустой заголовок или текст новости";
    header('Location: '.'news');
    exit;
} else if (strlen($body) > 2500) {
    $_SESSION["errormsg"] = "Текст новости не должен превышать 2500 символов";
    header('Location: '.'news');
    exit;
} else if (strlen($header) > 255) {
    $_SESSION["errormsg"] = "Заголовок новости не должен превышать 255 символов";
    header('Location: '.'news');
    exit;
}

try {
    DB::getInstance()->executeQuery("INSERT INTO news(header, body, dateTime) VALUES (:header, :body, :dateTime);",
        array(array(':header', $header), array(':body', $body), array(':dateTime', date("Y-m-d H:i:s", time()))));
    header('Location: '.'news');
} catch (Exception $e) {
    // TODO err
    echo 'Выброшено исключение: ',  $e->getMessage(), "\n";
}