<?php

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

$requestType = '';
if (filter_input_array(INPUT_POST)) {
    $requestType = INPUT_POST;
} else if (filter_input_array(INPUT_GET)) {
    $requestType = INPUT_GET;
}

$rawEmployeeLastName = 
	filter_input($requestType, 'employeeLastName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawChairName = 
	filter_input($requestType, 'chairName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPost = 
    filter_input($requestType, 'post', FILTER_SANITIZE_SPECIAL_CHARS);
$rawHomeAddress = 
    filter_input($requestType, 'homeAddress', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPhone = 
    filter_input($requestType, 'phone', FILTER_SANITIZE_SPECIAL_CHARS);

$employeeLastName = normalizeText($rawEmployeeLastName);
$employeeLastName = (empty($employeeLastName) ? '<Не указан>' : $employeeLastName);

$chairName = normalizeText($rawChairName);
$chairName = (empty($chairName) ? '<Не указан>' : $chairName);

$post = normalizeText($rawPost);
$post = (empty($post) ? '<Не указан>' : $post);

$homeAddress = normalizeText($rawHomeAddress);
$homeAddress = (empty($homeAddress) ? '<Не указан>' : $homeAddress);

$phone = normalizeText($rawPhone);
$phone = (empty($phone) ? '<Не указан>' : $phone);

$arrayRow = array($employeeLastName, $chairName, $post, $homeAddress, $phone);

$arrayParams;
if (isset($_SESSION['task1-employee-table'])) {
    $arrayParams = $_SESSION['task1-employee-table'];
}
$arrayParams[] = $arrayRow;
$_SESSION['task1-employee-table'] = $arrayParams;

// Перенаправление назад на employees.php
header('Location: employees.php');

function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}