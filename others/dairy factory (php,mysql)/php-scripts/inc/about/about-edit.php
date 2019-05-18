<?php

$id = htmlspecialchars($_GET["id"]);
$description = nl2br(htmlspecialchars($_GET["description"]),'<br>');
$address = nl2br(htmlspecialchars($_GET["address"]),'<br>');
$phone1 = htmlspecialchars($_GET["phone1"]);
$phone2 = htmlspecialchars($_GET["phone2"]);
$phone3 = htmlspecialchars($_GET["phone3"]);
$fax = htmlspecialchars($_GET["fax"]);

if (empty(trim($description)) || empty(trim($address))) {
    $_SESSION["errormsg"] = "Пустое описание или адрес";
    header('Location: '.'about');
    exit;
} else if (strlen($description) > 5000) {
    $_SESSION["errormsg"] = "Описание не должно превышать 5000 символов";
    header('Location: '.'about');
    exit;
} else if (strlen($address) > 255) {
    $_SESSION["errormsg"] = "Адрес не должен превышать 255 символов";
    header('Location: '.'about');
    exit;
}

try {
    if ($id === '') {
        $queryInsert = 'INSERT INTO about (description, address, phone1, phone2, phone3, fax)
          VALUES (:description, :address, :phone1, :phone2, :phone3, :fax);';
        DB::getInstance()->executeQuery($queryInsert, array(array(':description', $description),
            array(':address', $address), array(':phone1', $phone1), array(':phone2', $phone2),
            array(':phone3', $phone3), array(':fax', $fax)));
    } else {
        $queryUpdate = 'UPDATE about SET description = :description, address = :address,
          phone1 = :phone1, phone2 = :phone2, phone3 = :phone3, fax = :fax WHERE id = :id;';
        DB::getInstance()->executeQuery($queryUpdate, array(array(':description', $description),
            array(':address', $address), array(':phone1', $phone1), array(':phone2', $phone2),
            array(':phone3', $phone3), array(':fax', $fax), array(':id', (int)$id)));
    }
    header('Location: '.'about');
} catch (Exception $e) {
    $_SESSION["errormsg"] = $e->getMessage();
}