<?php

$login = htmlspecialchars($_POST["login"]);
$password = htmlspecialchars($_POST["password"]);

try {
    if (empty(trim($login)) || empty(trim($password))) {
        $_SESSION["errormsg"] = "Пустой логин или пароль";
        header('Location: '.'auth');
        exit;
    }
    $result = DB::getInstance()->executeQuery('SELECT id FROM users WHERE login=:login
      AND password=:password;', array(array(':login', $login), array(':password', $password)));
    if ($result["rows"] === 1) {
        $_SESSION['$isAdmin'] = true;
        header('Location: '.'news');
        exit;
    } else {
        $_SESSION["errormsg"] = "Неверный логин или пароль";
        header('Location: '.'auth');
        exit;
    }
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
    header('Location: '.'auth');
    exit;
}