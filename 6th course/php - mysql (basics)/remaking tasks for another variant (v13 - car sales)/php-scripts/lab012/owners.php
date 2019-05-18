<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
    $isFirstRequest = false;
    
    $requestType = '';
    if (filter_input_array(INPUT_POST)) {
        $requestType = INPUT_POST;
    } else if (filter_input_array(INPUT_GET)) {
        $requestType = INPUT_GET;
    } else {
        $isFirstRequest = true;
    }
    if (!$isFirstRequest) {
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

        $arrayRow = array(
            'fullName'=>$fullName, 
            'address'=>$address, 
            'phone'=>$phone);

        $arrayParams;
        if (isset($_SESSION['task1-owner-table'])) {
            $arrayParams = $_SESSION['task1-owner-table'];
        }
        $arrayParams[] = $arrayRow;
        $_SESSION['task1-owner-table'] = $arrayParams;
    }

    function normalizeText($rawString) {
        $result = preg_replace('/\s\s+/', ' ', $rawString);
        return trim(strip_tags(htmlspecialchars($result)));
    }
?>
<!DOCTYPE html>
<html>
<?php include "../header_menu.php"; ?>
<div class="masthead">
    <div class="site-center">
        <div class="cell">
            <h4>Работа 1.2, Владельцы, в одном файле, в ассоциативном массиве</h4>
        </div>
    </div>
</div>
<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="owners.php" method="POST">
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="fullName"><strong>*</strong> ФИО:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="fullName" name="fullName" type="text" placeholder="ФИО" required autofocus/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="address">Адрес:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="address" name="address" type="text" placeholder="Адрес"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="phone">Телефон:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="phone" name="phone" type="text" placeholder="Телефон"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div style="margin: 10px;">
                    	<input type="reset" name="reset" value="Очистить">
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <button type="submit">Добавить владельца</button>
                    </div>
                </div>
            </div>
        </form>
	</div>
</div>
</div>
<?php
	if (!isset($_SESSION['task1-owner-table'])) {
		echo '<div class="masthead"><div class="site-center"><div class="cell">';
		echo "<strong>Оповещение:</strong> отсутствуют данные в таблице владельцев.";
		echo '</div></div></div>';
	} else { 
?>
<table class="border" cellspacing="0" cellpadding="0" >
<caption><h3>Таблица владельцев</h3></caption>
<thead>
<tr>
	<th>ФИО</th>
	<th>Адрес</th>
	<th>Телефон</th>
</tr>
</thead>
<tbody>
<?php
	$table = $_SESSION['task1-owner-table'];
	foreach ($table as $row) {
		echo '<tr>';
		foreach ($row as $currentValue) {
			echo '<td>'. $currentValue . '</td>';
		}
		echo '</tr>';
	}
?>
</tbody>
</table>
<?php } ?>
</body>
</html>