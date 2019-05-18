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
$rawChairsHead = 
	filter_input($requestType, 'chairsHead', FILTER_SANITIZE_SPECIAL_CHARS);
$rawChairsPhone = 
    filter_input($requestType, 'chairsPhone', FILTER_SANITIZE_SPECIAL_CHARS);

$chairsName = normalizeText($rawChairsName);
$chairsName = (empty($chairsName) ? '<Не указан>' : $chairsName);

$chairsHead = normalizeText($rawChairsHead);
$chairsHead = (empty($chairsHead) ? '<Не указан>' : $chairsHead);

$chairsPhone = normalizeText($rawChairsPhone);
$chairsPhone = (empty($chairsPhone) ? '<Не указан>' : $chairsPhone);

if (!defined('ROW_DELIMETER')) {
    define('ROW_DELIMETER', '~');
}
if (!defined('COL_DELIMETER')) {
    define('COL_DELIMETER', '===');
}

$tableRow = $chairsName.COL_DELIMETER
    .$chairsHead.COL_DELIMETER
    .$chairsPhone.ROW_DELIMETER;
$_SESSION['task1-chair-table'] .= $tableRow;

// Перенаправление назад на chairs.php
header('Location: chairs.php');

function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}