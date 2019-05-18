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

$rawFullName = 
    filter_input($requestType, 'fullName', FILTER_SANITIZE_SPECIAL_CHARS);
$rawAddress = 
    filter_input($requestType, 'address', FILTER_SANITIZE_SPECIAL_CHARS);
$rawPhone = 
    filter_input($requestType, 'phone', FILTER_SANITIZE_SPECIAL_CHARS);

$fullName = normalizeText($rawFullName);
$fullName = (empty($fullName) ? '<Не указан>' : $fullName);

$address = normalizeText($rawAddress);
$address = (empty($address) ? '<Не указан>' : $address);

$phone = normalizeText($rawPhone);
$phone = (empty($phone) ? '<Не указан>' : $phone);


$arrayRow = array($fullName, $address, $phone);

$arrayParams;
if (isset($_SESSION['task1-buyer-table'])) {
    $arrayParams = $_SESSION['task1-buyer-table'];
}
$arrayParams[] = $arrayRow;
$_SESSION['task1-buyer-table'] = $arrayParams;

// Перенаправление назад
header('Location: buyers.php');

function normalizeText($rawString) {
    $result = preg_replace('/\s\s+/', ' ', $rawString);
    return trim(strip_tags(htmlspecialchars($result)));
}