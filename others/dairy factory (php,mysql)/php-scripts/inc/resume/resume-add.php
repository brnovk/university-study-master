<?php

$message = nl2br(htmlspecialchars($_POST["message"]),'<br>');
$vacancies = htmlspecialchars($_POST["vacancies"]);

if (empty(trim($message))) {
    $_SESSION["errormsg"] = "Текст резюме пустой";
    header('Location: '.'vacancies');
    exit;
} else if (strlen($message) > 5000) {
    $_SESSION["errormsg"] = "Текст резюме не должен превышать 5000 символов";
    header('Location: '.'vacancies');
    exit;
}

try {
    if (isset($vacancies) && trim($vacancies) !== '-1') {
        DB::getInstance()->executeQuery("INSERT INTO resume (message, vacanciesId) VALUES (:message, :vacanciesId);",
            array(array(':message', $message), array(':vacanciesId', (int)$vacancies)));
    } else {
        DB::getInstance()->executeQuery("INSERT INTO resume (message) VALUES (:message);",
            array(array(':message', $message)));
    }
    header('Location: '.'vacancies');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}
