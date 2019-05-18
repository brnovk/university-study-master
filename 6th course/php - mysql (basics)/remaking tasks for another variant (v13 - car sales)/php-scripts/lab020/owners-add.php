<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';
	$valid = true;
	$requestType = '';
	$errors = '';
	$fullName = null;
	$address = null;
	$phone = null;
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawFullName = filter_input($requestType, 'fullName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAddress = filter_input($requestType, 'address', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawPhone = filter_input($requestType, 'phone', FILTER_SANITIZE_SPECIAL_CHARS);

		$fullName = normalizeText($rawFullName);
		if (empty($fullName) && $fullName !== '0') {
			$errors .= 'Не указано ФИО.<br>';
			$valid = false;
		}
		$address = normalizeText($rawAddress);
		if (empty($address) && $address !== '0') {
			// Поле не обязательное, поэтому null
			$address = null;
		}
		$phone = normalizeText($rawPhone);
		if (empty($phone) && $phone !== '0') {
			// Поле не обязательное, поэтому null
			$phone = null;
		}
		if ($valid) {
			$res = addOwner($fullName, $address, $phone);
			if (!is_null($res)) {
				$errors .= 'Ошибка добавления продавца: '.$res.'<br>';
			} else {
				header("Location: owners.php");
			}
		}
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
            <h4>Работа 2, Добавление владельца</h4>
        </div>
    </div>
</div>
<?php if (!empty($errors)): ?>
	<br><div class="total"><div class="site-center"><div class="cell">
		<?php echo $errors;?>
	</div></div></div>
<?php endif; ?>

<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="buyers-add.php" method="POST">
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="fullName"><strong>*</strong> ФИО:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="fullName" name="fullName" type="text" placeholder="ФИО"
                        	required value="<?php echo !is_null($fullName)?$fullName:'';?>" />
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
                        <input id="address" name="address" type="text" placeholder="Адрес"
                        	value="<?php echo !is_null($address)?$address:'';?>" />
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
                        <input id="phone" name="phone" type="text" placeholder="Телефон"
                        	value="<?php echo !is_null($phone)?$phone:'';?>" />
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div style="margin: 10px;">
                        <a class="dowload" href="owners.php">Назад</a>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input type="submit" value="Добавить владельца" />
                    </div>
                </div>
            </div>
        </form>
	</div>
</div>
</div>
</body>
</html>