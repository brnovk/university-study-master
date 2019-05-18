<?php

$header = htmlspecialchars($_POST["header"]);
$body = nl2br(htmlspecialchars($_POST["body"]),'<br>');

if (empty(trim($header)) || empty(trim($body))) {
    $_SESSION["errormsg"] = "Пустое название или описание вакансии";
    header('Location: '.'vacancies');
    exit;
} else if (strlen($body) > 2500) {
    $_SESSION["errormsg"] = "Описание вакансии не должно превышать 2500 символов";
    header('Location: '.'vacancies');
    exit;
} else if (strlen($header) > 255) {
    $_SESSION["errormsg"] = "Название вакансии не должно превышать 255 символов";
    header('Location: '.'vacancies');
    exit;
}

try {
    DB::getInstance()->executeQuery("INSERT INTO vacancies (header, body, date) VALUES (:header, :body, :date);",
        array(array(':header', $header), array(':body', $body), array(':date', date("Y-m-d", time()))));
    header('Location: '.'vacancies');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
