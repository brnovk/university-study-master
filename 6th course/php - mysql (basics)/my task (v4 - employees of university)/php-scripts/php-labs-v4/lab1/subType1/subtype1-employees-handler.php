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

$rawChairsName = 
    filter_input($requestType, 'chairsName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawEmployeeName = 
    filter_input($requestType, 'employeeName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawHomeAddress = 
    filter_input($requestType, 'homeAddress', FILTER_SANITIZE_SPECIAL_CHARS);
$rawEmployeeAge = 
    filter_input($requestType, 'employeeAge', FILTER_SANITIZE_SPECIAL_CHARS);
$rawEmployeePhone = 
    filter_input($requestType, 'employeePhone', FILTER_SANITIZE_SPECIAL_CHARS);

$chairsName = normalizeText($rawChairsName);
$chairsName = (empty($chairsName) ? '<Не указан>' : $chairsName);

$employeeName = normalizeText($rawEmployeeName);
$employeeName = (empty($employeeName) ? '<Не указан>' : $employeeName);

$homeAddress = normalizeText($rawHomeAddress);
$homeAddress = (empty($homeAddress) ? '<Не указан>' : $homeAddress);

$employeeAge = normalizeText($rawEmployeeAge);
$employeeAge = (empty($employeeAge) ? '<Не указан>' : $employeeAge);

$employeePhone = normalizeText($rawEmployeePhone);
$employeePhone = (empty($employeePhone) ? '<Не указан>' : $employeePhone);

$arrayRow = array(
	'chairsName'=>$chairsName, 
	'employeeName'=>$employeeName, 
	'homeAddress'=>$homeAddress, 
	'employeeAge'=>$employeeAge, 
	'employeePhone'=>$employeePhone);

$arrayParams;
if (isset($_SESSION['task1-employees-table'])) {
    $arrayParams = $_SESSION['task1-employees-table'];
}
$arrayParams[] = $arrayRow;
$_SESSION['task1-employees-table'] = $arrayParams;

// Перенаправление назад на subtype1-employees.php
header('Location: subtype1-employees.php');

/**
 * Функция удаляет из введённого пользователем теста переводы строки, 
 * а также начальные и конечные пробелы.
 * @param string $rawString Строка для преобразования.
 * @return string Исправленый текст 
 */
function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}