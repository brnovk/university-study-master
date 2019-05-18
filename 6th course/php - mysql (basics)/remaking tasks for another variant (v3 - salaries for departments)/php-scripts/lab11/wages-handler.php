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
$rawSalary = 
	filter_input($requestType, 'salary', FILTER_SANITIZE_SPECIAL_CHARS);
$rawCredited = 
    filter_input($requestType, 'credited', FILTER_SANITIZE_SPECIAL_CHARS);
$rawWithheld = 
    filter_input($requestType, 'withheld', FILTER_SANITIZE_SPECIAL_CHARS);

$employeeLastName = normalizeText($rawEmployeeLastName);
$employeeLastName = (empty($employeeLastName) ? '<Не указан>' : $employeeLastName);

$salary = normalizeText($rawSalary);
$salary = (empty($salary) ? '<Не указан>' : $salary);

$credited = normalizeText($rawCredited);
$credited = (empty($credited) ? '<Не указан>' : $credited);

$withheld = normalizeText($rawWithheld);
$withheld = (empty($withheld) ? '<Не указан>' : $withheld);

$arrayRow = array(
    'employeeLastName'=>$employeeLastName, 
    'salary'=>$salary, 
    'credited'=>$credited,
    'withheld'=>$withheld);

$arrayParams;
if (isset($_SESSION['task1-wages-table'])) {
    $arrayParams = $_SESSION['task1-wages-table'];
}
$arrayParams[] = $arrayRow;
$_SESSION['task1-wages-table'] = $arrayParams;

// Перенаправление назад на wages.php
header('Location: wages.php');

function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}