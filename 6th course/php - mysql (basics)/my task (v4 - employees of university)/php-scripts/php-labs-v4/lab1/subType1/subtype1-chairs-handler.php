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

$rawFacultyName = 
	filter_input($requestType, 'facultyName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawChairsName = 
	filter_input($requestType, 'chairsName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawChairsHead = 
	filter_input($requestType, 'chairsHead', FILTER_SANITIZE_SPECIAL_CHARS);
$rawChairsPhone = 
	filter_input($requestType, 'chairsPhone', FILTER_SANITIZE_SPECIAL_CHARS);

$facultyName = normalizeText($rawFacultyName);
$facultyName = (empty($facultyName) ? '<Не указан>' : $facultyName);

$chairsName = normalizeText($rawChairsName);
$chairsName = (empty($chairsName) ? '<Не указан>' : $chairsName);

$chairsHead = normalizeText($rawChairsHead);
$chairsHead = (empty($chairsHead) ? '<Не указан>' : $chairsHead);

$chairsPhone = normalizeText($rawChairsPhone);
$chairsPhone = (empty($chairsPhone) ? '<Не указан>' : $chairsPhone);

$arrayRow = array($facultyName, $chairsName, $chairsHead, $chairsPhone);

$arrayParams;
if (isset($_SESSION['task1-chairs-table'])) {
    $arrayParams = $_SESSION['task1-chairs-table'];
}
$arrayParams[] = $arrayRow;
$_SESSION['task1-chairs-table'] = $arrayParams;

// Перенаправление назад на subtype1-chairs.php
header('Location: subtype1-chairs.php');

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