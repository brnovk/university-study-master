<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';
	$valid = true;
	$requestType = '';
	$errors = '';

	$model = null;
	$color = null;
	$manufactureDate = null;
	$price = null;
	$percentDeduction = null;
	$owner = null;
	$buyer = null;

	$ownerList = getOwners();
	if (empty($ownerList) || count($ownerList) == 0) { 
		$errors .= 'В таблице продавцов нет ни одной записи.<br>';
		$ownerList = null;
	}
	$buyerList = getBuyers();
	if (empty($buyerList) || count($buyerList) == 0) { 
		$errors .= 'В таблице покупателей нет ни одной записи.<br>';
		$buyerList = null;
	}

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawModel = filter_input($requestType, 'model', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawColor = filter_input($requestType, 'color', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawManufactureDate = filter_input($requestType, 'manufactureDate',FILTER_SANITIZE_SPECIAL_CHARS);
		$rawPrice = filter_input($requestType, 'price', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawPercentDeduction = filter_input($requestType, 'percentDeduction', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawOwner = filter_input($requestType, 'owner', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawBuyer = filter_input($requestType, 'buyer', FILTER_SANITIZE_SPECIAL_CHARS);

		$model = normalizeText($rawModel);
		if (empty($model) && $model !== '0') {
			$errors .= 'Не указана марка.<br>';
			$valid = false;
		}
		$color = normalizeText($rawColor);
		if (empty($color) && $color !== '0') {
			// Поле не обязательное, поэтому null
			$color = null;
		}

		$manufactureDate = normalizeText($rawManufactureDate);
		if (empty($manufactureDate) || (!validateDate($manufactureDate))) {
			$errors .= 'Некорректная дата выпуска. Корректный вариант: 2012-12-21.<br>';
			$valid = false;
		}

		$price = normalizeText($rawPrice);
		if (empty($price) && $price !== '0') {
			$errors .= 'Не указана цена.<br>';
			$valid = false;
		} elseif (!is_numeric($price) 
			|| (int)$price != $price 
			|| (int)$price <= 0 ) {

			$errors .= 'Цена должна быть положительным целым числом не больше 2147483647.<br>';
			$valid = false;
		} else {
			$price = intval($price); 
		}

		$percentDeduction = normalizeText($rawPercentDeduction);
		if (empty($percentDeduction) && $percentDeduction !== '0') {
			// Поле не обязательное, поэтому null
			$percentDeduction = null;
		} elseif (!is_numeric($percentDeduction) 
			|| $percentDeduction <= 0 
			|| $percentDeduction > 100 ) {

			$errors .= 'Процент фирме должен быть положительным числом не больше 100.<br>';
			$valid = false;
		} else {
			$price = floatval($price);
		}

		$owner = normalizeText($rawOwner);
		if (empty($owner) && $owner !== '0') {
			$errors .= 'Не указан продавец.<br>';
			$valid = false;
		}
		$buyer = normalizeText($rawBuyer);
		if (empty($buyer) && $buyer !== '0') {
			$errors .= 'Не указан покупатель.<br>';
			$valid = false;
		}
		if ($valid) {
			$res = addCar($model,$color,$manufactureDate,$price,$percentDeduction,$owner,$buyer);
			if (!is_null($res)) {
				$errors .= 'Ошибка добавления автомобиля: '.$res.'<br>';
			} else {
				header("Location: cars.php");
			}
		}
	}
	function normalizeText($rawString) {
	    $result = preg_replace('/\s\s+/', ' ', $rawString);
	    return trim(strip_tags(htmlspecialchars($result)));
	}
	function validateDate($date) {
		$d = DateTime::createFromFormat('Y-m-d', $date);
		return $d && $d->format('Y-m-d') == $date;
	}
?>
<!DOCTYPE html>
<html>
<?php include "../header_menu.php"; ?>
<div class="masthead">
    <div class="site-center">
        <div class="cell">
            <h4>Работа 2, Добавление автомобиля</h4>
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
		<form action="cars-add.php" method="POST">

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="model"><strong>*</strong> Марка:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="model" name="model" type="text" placeholder="Марка"
                        	required value="<?php echo !is_null($model)?$model:'';?>" />
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="color">Цвет:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="color" name="color" type="text" placeholder="Цвет"
                        	value="<?php echo !is_null($color)?$color:'';?>" />
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="manufactureDate">
                        	<strong>*</strong> Дата выпуска:
                    	</label>
                	 	<label for="manufactureDate" style="width: 240px;">
                        	(Пример правильной даты: 2012-12-21)
                    	</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="manufactureDate" name="manufactureDate" type="text" 
                        	placeholder="2012-12-21" required 
                        	value="<?php echo !is_null($manufactureDate)?$manufactureDate:'';?>"/>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="price"><strong>*</strong> Цена:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="price" name="price" type="text" placeholder="Цена"
                        	required value="<?php echo !is_null($price)?$price:'';?>" />
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="percentDeduction">Процент фирме:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="percentDeduction" name="percentDeduction" type="text" 
                        	placeholder="Процент фирме"
                        	value="<?php echo !is_null($percentDeduction)?$percentDeduction:'';?>" />
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="owner"><strong>*</strong> Продавец:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
						<select name="owner" id="owner" required>
						<?php 
							if (!is_null($ownerList)) {
								foreach ($ownerList as $currentOwner) {
									echo '<option value="'
										.$currentOwner['fullName']
										.'">'.$currentOwner['fullName']
										.'</option>';
								}
							}
						 ?>
						</select>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="buyer"><strong>*</strong> Покупатель:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
						<select name="buyer" id="buyer" required>
						<?php 
							if (!is_null($buyerList)) {
								foreach ($buyerList as $currentBuyer) {
									echo '<option value="'
										.$currentBuyer['fullName']
										.'">'.$currentBuyer['fullName']
										.'</option>';
								}
							}
						 ?>
						</select>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div style="margin: 10px;">
                        <a class="dowload" href="cars.php">Назад</a>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input type="submit" value="Добавить автомобиль" />
                    </div>
                </div>
            </div>
        </form>
	</div>
</div>
</div>
</body>
</html>