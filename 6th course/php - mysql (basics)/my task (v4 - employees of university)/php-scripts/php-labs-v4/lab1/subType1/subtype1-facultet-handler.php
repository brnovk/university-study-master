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

$rawFacultyName = filter_input($requestType, 'facultyName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawFacultyDean = filter_input($requestType, 'facultyDean', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPhoneDean = filter_input($requestType, 'phoneDean', FILTER_SANITIZE_SPECIAL_CHARS);
$rawNumberChairs = filter_input($requestType, 'numberChairs', FILTER_SANITIZE_SPECIAL_CHARS);
$rawHiddenListNumberChairs = 
    filter_input($requestType, 'hiddenFieldNumberChairs', FILTER_SANITIZE_SPECIAL_CHARS);

$facultyName = normalizeText($rawFacultyName);
$facultyName = (empty($facultyName) ? '<Не указан>' : $facultyName);

$facultyDean = normalizeText($rawFacultyDean);
$facultyDean = (empty($facultyDean) ? '<Не указан>' : $facultyDean);

$phoneDean = normalizeText($rawPhoneDean);
$phoneDean = (empty($phoneDean) ? '<Не указан>' : $phoneDean);

$numberChairs = normalizeText($rawNumberChairs);
$numberChairs = (empty($numberChairs) ? '<Не указан>' : $numberChairs);

$hiddenListNumberChairs = normalizeText($rawHiddenListNumberChairs);

if (!defined('ROW_DELIMETER')) {
    define('ROW_DELIMETER', '~');
}
if (!defined('COL_DELIMETER')) {
    define('COL_DELIMETER', '===');
}

$tableRow = $facultyName.COL_DELIMETER
	.$facultyDean.COL_DELIMETER
	.$phoneDean.COL_DELIMETER
	.$numberChairs.ROW_DELIMETER;
$_SESSION['task1-facultet-table'] .= $tableRow;


$_SESSION['task1-facultet-hiddenList'] = 
    preg_split('/\s/', $hiddenListNumberChairs, NULL, PREG_SPLIT_NO_EMPTY);;

// Перенаправление назад на subtype1-facultet.php
header('Location: subtype1-facultet.php');

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