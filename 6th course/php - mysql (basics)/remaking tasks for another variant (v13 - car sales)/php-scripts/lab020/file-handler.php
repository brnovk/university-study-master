<?php

	function addBuyer($fullName,$address,$phone) {
		if (!is_null($fullName)) {
			$fullName = trim($fullName);
		}
		if (!is_null($address)) {
			$address = trim($address);
		}
		if (!is_null($phone)) {
			$phone = trim($phone);
		}
		if (empty($fullName) && $fullName !== '0') {
			return 'Не указано ФИО.';
		}
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

		$buyers = getBuyers();
		$id = -1; // empty value
		foreach ($buyers as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$buyers[] = array(
			"id"=>$id,
			"fullName"=>$fullName,
			"address"=>$address,
			"phone"=>$phone);
		file_put_contents('buyers.txt', serialize($buyers), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addOwner($fullName,$address,$phone) {
		if (!is_null($fullName)) {
			$fullName = trim($fullName);
		}
		if (!is_null($address)) {
			$address = trim($address);
		}
		if (!is_null($phone)) {
			$phone = trim($phone);
		}
		if (empty($fullName) && $fullName !== '0') {
			return 'Не указано ФИО.';
		}
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

		$owners = getOwners();
		$id = -1; // empty value
		foreach ($owners as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$owners[] = array(
			"id"=>$id,
			"fullName"=>$fullName,
			"address"=>$address,
			"phone"=>$phone);
		file_put_contents('owners.txt', serialize($owners), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addCar($model,$color,$manufactureDate,$price,$percentDeduction,$owner,$buyer) {
		if (!is_null($model)) {
			$model = trim($model);
		}
		if (!is_null($color)) {
			$color = trim($color);
		}
		if (!is_null($homeAddress)) {
			$homeAddress = trim($homeAddress);
		}
		if (!is_null($owner)) {
			$owner = trim($owner);
		}
		if (!is_null($buyer)) {
			$buyer = trim($buyer);
		}
		if (empty($model) && $model !== '0') {
			return 'Не указана марка.';
		}
		if (empty($owner) && $owner !== '0') {
			return 'Не указан продавец.';
		}
		if (empty($price) && $price !== '0') {
			return 'Не указана цена.';
		} elseif (!is_numeric($price) 
			|| (int)$price != $price 
			|| (int)$price <= 0 ) {
				return 'Цена должна быть положительным целым числом.';
		}
		if (empty($percentDeduction) && $percentDeduction !== '0') {
			// Поле не обязательное, поэтому ничего не делаем
		} elseif (!is_numeric($percentDeduction) 
			|| $percentDeduction <= 0 
			|| $percentDeduction > 100 ) {

			return 'Процент фирме должен быть положительным числом не больше 100.<br>';
		}
		if (empty($manufactureDate) || (!validateDate($manufactureDate))) {
			return 'Некорректная дата выпуска. Корректный вариант: 2012-12-21.<br>';
		}
		$owners = getOwners();
		$ownerExist = false;
		foreach ($owners as $current) {
			if (strcmp(mb_strtolower($owner,'UTF-8'), 
						mb_strtolower($current['fullName'],'UTF-8')) == 0) {
				$ownerExist = true;
				break;
			}
		}
		if (!$ownerExist) {
			return 'Указанный продавец отсутствует в списке продавцов.';
		}
		$buyers = getBuyers();
		$buyerExist = false;
		foreach ($buyers as $current) {
			if (strcmp(mb_strtolower($buyer,'UTF-8'), 
						mb_strtolower($current['fullName'],'UTF-8')) == 0) {
				$buyerExist = true;
				break;
			}
		}
		if (!$buyerExist) {
			return 'Указанный покупатель отсутствует в списке покупателей.';
		}
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

		$cars = getCars();
		$id = -1; // empty value
		foreach ($cars as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$cars[] = array(
			"id"=>$id,
			"model"=>$model,
			"color"=>$color,
			"manufactureDate"=>strtotime($manufactureDate),
			"price"=>$price,
			"percentDeduction"=>$percentDeduction,
			"owner"=>$owner,
			"buyer"=>$buyer);
		file_put_contents('cars.txt', serialize($cars), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function searchBuyers($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'fullName') != 0)  {
			if (strcmp($searchField, 'address') != 0)  {
				if (strcmp($searchField, 'phone') != 0)  {
					$error = 'Неизвестный тип поля поиска.';
					return;
				}
			}
		}
		if (!is_null($searchValue)) {
			$searchValue = trim($searchValue);
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}
		$buyers = getBuyers();
		$result = null;
		foreach ($buyers as $current) {
			if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
						mb_strtolower($searchValue,'UTF-8')) !== false) {
				$result[] = $current;
			}
		}
		return $result;
	}

	function searchOwners($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'fullName') != 0)  {
			if (strcmp($searchField, 'address') != 0)  {
				if (strcmp($searchField, 'phone') != 0)  {
					$error = 'Неизвестный тип поля поиска.';
					return;
				}
			}
		}
		if (!is_null($searchValue)) {
			$searchValue = trim($searchValue);
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}
		$owners = getOwners();
		$result = null;
		foreach ($owners as $current) {
			if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
						mb_strtolower($searchValue,'UTF-8')) !== false) {
				$result[] = $current;
			}
		}
		return $result;
	}

	function searchCars($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'model') != 0)  {
			if (strcmp($searchField, 'color') != 0)  {
				if (strcmp($searchField, 'manufactureDate') != 0)  {
					if (strcmp($searchField, 'price') != 0)  {
						if (strcmp($searchField, 'percentDeduction') != 0)  {
							if (strcmp($searchField, 'owner') != 0)  {
								if (strcmp($searchField, 'buyer') != 0)  {
									$error = 'Неизвестный тип поля поиска.';
									return;
								}
							}
						}
					}
				}
			}
		}
		if (!is_null($searchValue)) {
			if (strcmp($searchField, 'model') == 0) {
				$searchValue = trim($searchValue);
			}
			if (strcmp($searchField, 'color') == 0) {
				$searchValue = trim($searchValue);
			}
			if (strcmp($searchField, 'manufactureDate') == 0) {
				$searchValue = trim($searchValue);
			}
			if (strcmp($searchField, 'owner') == 0) {
				$searchValue = trim($searchValue);
			}
			if (strcmp($searchField, 'buyer') == 0) {
				$searchValue = trim($searchValue);
			}
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}
		$cars = getCars();
		$result = null;
		foreach ($cars as $current) {
			// Если поле поиска - строковое
			if ((strcmp($searchField, 'model') == 0)||(strcmp($searchField, 'color') == 0)||(strcmp($searchField, 'owner') == 0)||(strcmp($searchField, 'buyer') == 0)) {
				if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
							mb_strtolower($searchValue,'UTF-8')) !== false) {
					$result[] = $current;
				}
			// Если поле поиска - число
			} else if ((strcmp($searchField, 'price') == 0)||(strcmp($searchField, 'percentDeduction') == 0)) {
				if ($current[$searchField] == $searchValue) {
					$result[] = $current;
				}
			// Если поле поиска - дата
			} else {
				if (strpos(mb_strtolower(date('Y-m-d',($current[$searchField])),'UTF-8'), 
							mb_strtolower($searchValue,'UTF-8')) !== false) {
					$result[] = $current;
				}
			}
		}
		return $result;
	}

	// Получение масcивов

	function getBuyers() {
		if ((!file_exists('buyers.txt')) 
			|| (!file_exists('owners.txt'))
			|| (!file_exists('cars.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('buyers.txt'));
	}

	function getOwners() {
		if ((!file_exists('buyers.txt')) 
			|| (!file_exists('owners.txt'))
			|| (!file_exists('cars.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('owners.txt'));
	}

	function getCars() {
		if ((!file_exists('buyers.txt')) 
			|| (!file_exists('owners.txt'))
			|| (!file_exists('cars.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('cars.txt'));
	}

	/**
	 * Первичная инициализация файлов.
	 */
	function initializeFiles() {

		// Первичная инициализация buyers.txt
		$buyers = null;
		$idx = 1;
		$buyers[] = array("id"=>$idx++,"fullName"=>'Матвеенко Ольга Владимировна',"address"=>'Гомель, ул.Павлова, д.14, кв.13',"phone"=>'+375(29)545-54-10');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Копатков Игорь Алексеевич',"address"=>'Гомель, ул.Ветрова, д.12',"phone"=>'+375(29)784-88-24');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Фомичев Евгений Андреевич',"address"=>'Гомель, ул.Ленина, д.12, кв.2',"phone"=>NULL);
		$buyers[] = array("id"=>$idx++,"fullName"=>'Юрченко Николай Николаевич',"address"=>'Речица, ул.Шаферова, д.6',"phone"=>'+375(44)874-97-67');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Волкова Екатерина Витальевна',"address"=>'Гомель, ул.Краснецова, д.70',"phone"=>'+375(33)879-37-19');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Горелик Алена Филиповна',"address"=>NULL,"phone"=>'+375(29)454-00-78');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Аксёнов Роман Константинович',"address"=>'Гомель, ул.Белорусская, д.8',"phone"=>'+375(44)574-15-15');
		$buyers[] = array("id"=>$idx++,"fullName"=>'Малашенко Андрей Михайлович',"address"=>'Гомель, ул.Кропоткина, д.1',"phone"=>'+375(44)187-78-01');
		file_put_contents('buyers.txt', serialize($buyers), LOCK_EX);

		// Первичная инициализация owners.txt
		$owners = null;
		$idx = 1;
		$owners[] = array("id"=>$idx++,"fullName"=>'Макаров Владислав Петрович',"address"=>'Гомель, ул.Ленина, д.18',"phone"=>'+375(29)234-43-32');
		$owners[] = array("id"=>$idx++,"fullName"=>'Громова Лариса Борисовна',"address"=>'Гомель, ул.Ильича, д.1',"phone"=>'+375(33)789-44-74');
		$owners[] = array("id"=>$idx++,"fullName"=>'Гуд Сергей Викторович',"address"=>'Гомель, ул.Мира, д.80, кв.13',"phone"=>'+375(29)123-54-12');
		$owners[] = array("id"=>$idx++,"fullName"=>'Шаповаленко Андрей Андреевич',"address"=>'Речица, ул.Нефтянников, д.3',"phone"=>'+375(67)768-97-67');
		$owners[] = array("id"=>$idx++,"fullName"=>'Талин Василий Игоревич',"address"=>'Речица, ул.Красная, д.8, кв.45',"phone"=>NULL);
		$owners[] = array("id"=>$idx++,"fullName"=>'Тарасов Николай Андреевич',"address"=>NULL,"phone"=>'+375(33)575-00-78');
		$owners[] = array("id"=>$idx++,"fullName"=>'Рогозов Андрей Васильевич',"address"=>NULL,"phone"=> NULL);
		$owners[] = array("id"=>$idx++,"fullName"=>'Жадченко Павел Сергеевич',"address"=>'Гомель, ул.Белорусская, д.16',"phone"=>'+375(44)780-04-12');
		$owners[] = array("id"=>$idx++,"fullName"=>'Клименок Роман Борисович',"address"=>'Гомель, ул.Ленина, д.16',"phone"=>'+375(44)742-45-01');
		file_put_contents('owners.txt', serialize($owners), LOCK_EX);

		// Первичная инициализация cars.txt
		$cars = null;
		$idx = 1;
		$cars[] = array("id"=>$idx++,"model"=>"Nissan Pathfinder","color"=>"Зелёный","manufactureDate"=>strtotime('2009-01-10'),"price"=>139050000,"percentDeduction"=>0.5,"owner"=>"Громова Лариса Борисовна","buyer"=>"Аксёнов Роман Константинович");
		$cars[] = array("id"=>$idx++,"model"=>"Audi 100","color"=>"Красный","manufactureDate"=>strtotime('1987-06-28'),"price"=>27810000,"percentDeduction"=>2.3,"owner"=>"Макаров Владислав Петрович","buyer"=>"Матвеенко Ольга Владимировна");
		$cars[] = array("id"=>$idx++,"model"=>"Volkswagen Polo","color"=>"Фиолетовый","manufactureDate"=>strtotime('2015-03-02'),"price"=>152950000,"percentDeduction"=>NULL,"owner"=>"Гуд Сергей Викторович","buyer"=>"Копатков Игорь Алексеевич");
		$cars[] = array("id"=>$idx++,"model"=>"Mercedes E W211","color"=>NULL,"manufactureDate"=>strtotime('2003-11-20'),"price"=>168840000,"percentDeduction"=>1.5,"owner"=>"Гуд Сергей Викторович","buyer"=>"Фомичев Евгений Андреевич");
		$cars[] = array("id"=>$idx++,"model"=>"Mercedes E W210","color"=>"Чёрный","manufactureDate"=>strtotime('2000-02-10'),"price"=>128120000,"percentDeduction"=>1.7,"owner"=>"Шаповаленко Андрей Андреевич","buyer"=>"Фомичев Евгений Андреевич");
		$cars[] = array("id"=>$idx++,"model"=>"Dacia Sandero","color"=>"Красный","manufactureDate"=>strtotime('2009-07-01'),"price"=>108260000,"percentDeduction"=>0.7,"owner"=>"Талин Василий Игоревич","buyer"=>"Фомичев Евгений Андреевич");
		$cars[] = array("id"=>$idx++,"model"=>"Honda Insight","color"=>"Белый","manufactureDate"=>strtotime('2009-04-05'),"price"=>158910000,"percentDeduction"=>NULL,"owner"=>"Тарасов Николай Андреевич","buyer"=>"Юрченко Николай Николаевич");
		$cars[] = array("id"=>$idx++,"model"=>"BMW X6","color"=>NULL,"manufactureDate"=>strtotime('2010-11-05'),"price"=>554210000,"percentDeduction"=>0.4,"owner"=>"Тарасов Николай Андреевич","buyer"=>"Юрченко Николай Николаевич");
		$cars[] = array("id"=>$idx++,"model"=>"BMW M5","color"=>NULL,"manufactureDate"=>strtotime('2006-03-08'),"price"=>327760000,"percentDeduction"=>1.0,"owner"=>"Тарасов Николай Андреевич","buyer"=>"Волкова Екатерина Витальевна");
		$cars[] = array("id"=>$idx++,"model"=>"Kia Sorento","color"=>"Розовый","manufactureDate"=>strtotime('2005-05-15'),"price"=>172220000,"percentDeduction"=>1.1,"owner"=>"Рогозов Андрей Васильевич","buyer"=>"Горелик Алена Филиповна");
		$cars[] = array("id"=>$idx++,"model"=>"Mitsubishi Lancer","color"=>"Бардовый","manufactureDate"=>strtotime('2008-11-20'),"price"=>113220000,"percentDeduction"=>0.3,"owner"=>"Жадченко Павел Сергеевич","buyer"=>"Горелик Алена Филиповна");
		$cars[] = array("id"=>$idx++,"model"=>"Opel Astra - G","color"=>"Фиолетовый","manufactureDate"=>strtotime('2000-07-01'),"price"=>69520000,"percentDeduction"=>1.8,"owner"=>"Жадченко Павел Сергеевич","buyer"=>"Малашенко Андрей Михайлович");
		$cars[] = array("id"=>$idx++,"model"=>"Opel Omega","color"=>"Серый","manufactureDate"=>strtotime('2003-02-17'),"price"=>95350000,"percentDeduction"=>1.2,"owner"=>"Жадченко Павел Сергеевич","buyer"=>"Волкова Екатерина Витальевна");
		$cars[] = array("id"=>$idx++,"model"=>"Opel Vectra","color"=>"Чёрный","manufactureDate"=>strtotime('2005-11-28'),"price"=>103290000,"percentDeduction"=>0.6,"owner"=>"Клименок Роман Борисович","buyer"=>"Малашенко Андрей Михайлович");
		file_put_contents('cars.txt', serialize($cars), LOCK_EX);
	}

	function makeSortFunction($field) {
	    $code = "return strnatcasecmp(
	      Mb_strtolower(\$a['$field'],'UTF-8'), 
	      Mb_strtolower(\$b['$field'],'UTF-8'));";
	    return create_function('$a,$b', $code);
	}
?>