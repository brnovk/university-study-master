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

$rawModel = 
    filter_input($requestType, 'model', FILTER_SANITIZE_SPECIAL_CHARS);
$rawColor = 
    filter_input($requestType, 'color', FILTER_SANITIZE_SPECIAL_CHARS);
$rawManufactureDate = 
    filter_input($requestType, 'manufactureDate', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPrice = 
    filter_input($requestType, 'price', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPercentDeduction = 
    filter_input($requestType, 'percentDeduction', FILTER_SANITIZE_SPECIAL_CHARS);
$rawOwner = 
    filter_input($requestType, 'owner', FILTER_SANITIZE_SPECIAL_CHARS);
$rawBuyer = 
    filter_input($requestType, 'buyer', FILTER_SANITIZE_SPECIAL_CHARS);

$model = normalizeText($rawModel);
$model = (empty($model) ? '<Не указан>' : $model);

$color = normalizeText($rawColor);
$color = (empty($color) ? '<Не указан>' : $color);

$manufactureDate = normalizeText($rawManufactureDate);
$manufactureDate = (empty($manufactureDate) ? '<Не указан>' : $manufactureDate);

$price = normalizeText($rawPrice);
$price = (empty($price) ? '<Не указан>' : $price);

$percentDeduction = normalizeText($rawPercentDeduction);
$percentDeduction = (empty($percentDeduction) ? '<Не указан>' : $percentDeduction);

$owner = normalizeText($rawOwner);
$owner = (empty($owner) ? '<Не указан>' : $owner);

$buyer = normalizeText($rawBuyer);
$buyer = (empty($buyer) ? '<Не указан>' : $buyer);

if (!defined('ROW_DELIMETER')) {
    define('ROW_DELIMETER', '~');
}
if (!defined('COL_DELIMETER')) {
    define('COL_DELIMETER', '===');
}

$tableRow = $model.COL_DELIMETER
    .$color.COL_DELIMETER
    .$manufactureDate.COL_DELIMETER
    .$price.COL_DELIMETER
    .$percentDeduction.COL_DELIMETER
    .$owner.COL_DELIMETER
    .$buyer.ROW_DELIMETER;
$_SESSION['task1-car-table'] .= $tableRow;

// Перенаправление назад
header('Location: cars.php');

function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}