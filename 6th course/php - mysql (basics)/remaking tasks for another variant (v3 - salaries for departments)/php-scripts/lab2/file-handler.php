<?php

	function addChair($chairName,$chairHead,$chairPhone) {
		if (!is_null($chairName)) {
			$chairName = trim($chairName);
		}
		if (!is_null($chairHead)) {
			$chairHead = trim($chairHead);
		}
		if (!is_null($chairPhone)) {
			$chairPhone = trim($chairPhone);
		}
		if (empty($chairName) && $chairName !== '0') {
			return 'Не указано название кафедры.';
		}
		
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		// Блокировка с запретом «подвисания»
		$lockInstance = fopen('lock-instance', 'r'); 
		while(!flock($lockInstance, LOCK_EX+LOCK_NB)) {
			sleep(1);
		}
		$chairs = getChairs();
		foreach ($chairs as $current) {
			if (strcmp(mb_strtolower($chairName,'UTF-8'), 
						mb_strtolower($current['chairName'],'UTF-8')) == 0) {
				flock($lockInstance, LOCK_UN); 
				fclose($lockInstance);
				return 'Кафедра с таким названием уже есть в файле.';
			}
		}
		$id = -1; // empty value
		foreach ($chairs as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$chairs[] = array(
			"id"=>$id,
			"chairName"=>$chairName,
			"chairHead"=>$chairHead,
			"chairPhone"=>$chairPhone);
		file_put_contents('chairs.txt', serialize($chairs), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addEmployee($employeeLastName,$post,$homeAddress,$phone,$chairName) {
		if (!is_null($employeeLastName)) {
			$employeeLastName = trim($employeeLastName);
		}
		if (!is_null($post)) {
			$post = trim($post);
		}
		if (!is_null($homeAddress)) {
			$homeAddress = trim($homeAddress);
		}
		if (!is_null($phone)) {
			$phone = trim($phone);
		}
		if (!is_null($chairName)) {
			$chairName = trim($chairName);
		}
		if (empty($employeeLastName) && $employeeLastName !== '0') {
			return 'Не указана фамилия сотрудника.';
		}
		if (empty($chairName) && $chairName !== '0') {
			return 'Не указана кафедра.';
		}
		$chairs = getChairs();
		$chairExist = false;
		foreach ($chairs as $current) {
			if (strcmp(mb_strtolower($chairName,'UTF-8'), 
						mb_strtolower($current['chairName'],'UTF-8')) == 0) {
				$chairExist = true;
				break;
			}
		}
		if (!$chairExist) {
			return 'Указанная кафедра отсутствует в списке кафедр.';
		}
		
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		// Блокировка с запретом «подвисания»
		$lockInstance = fopen('lock-instance', 'r'); 
		while(!flock($lockInstance, LOCK_EX+LOCK_NB)) {
			sleep(1);
		}

		$employees = getEmployees();
		$id = -1; // empty value
		foreach ($employees as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$employees[] = array(
			"id"=>$id,
			"employeeLastName"=>$employeeLastName,
			"post"=>$post,
			"homeAddress"=>$homeAddress,
			"phone"=>$phone,
			"chairName"=>$chairName);
		file_put_contents('employees.txt', serialize($employees), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addWage($salary,$credited,$withheld,$employeeLastName) {
		if (!is_null($employeeLastName)) {
			$employeeLastName = trim($employeeLastName);
		}
		if (empty($salary) && $salary !== '0') {
			return 'Не указан оклад.';
		} elseif (!is_numeric($salary) 
			|| (int)$salary != $salary 
			|| (int)$salary <= 0 ) {
				return 'Оклад должен быть положительным целым числом.';
		}
		if (empty($credited) && $credited !== '0') {
			// Поле не обязательное, поэтому ничего не делаем
		} elseif (!is_numeric($credited) 
			|| (int)$credited != $credited 
			|| (int)$credited <= 0 ) {
				return '"Начислено" должно быть положительным целым числом.';
		}
		if (empty($withheld) && $withheld !== '0') {
			// Поле не обязательное, поэтому ничего не делаем
		} elseif (!is_numeric($withheld) 
			|| (int)$withheld != $withheld 
			|| (int)$withheld <= 0 ) {
				return '"Удержано" должно быть положительным целым числом.';
		}
		if (empty($employeeLastName) && $employeeLastName !== '0') {
			return 'Не указана фамилия сотрудника.';
		}
		$employees = getEmployees();
		$employeeExist = false;
		foreach ($employees as $current) {
			if (strcmp(mb_strtolower($employeeLastName,'UTF-8'), 
						mb_strtolower($current['employeeLastName'],'UTF-8')) == 0) {
				$employeeExist = true;
				break;
			}
		}
		if (!$employeeExist) {
			return 'Указанный сотрудник отсутствует в списке сотрудников.';
		}
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		// Блокировка с запретом «подвисания»
		$lockInstance = fopen('lock-instance', 'r'); 
		while(!flock($lockInstance, LOCK_EX+LOCK_NB)) {
			sleep(1);
		}

		$wages = getWages();

		$id = -1; // empty value
		foreach ($wages as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
			if (strcmp(mb_strtolower($employeeLastName,'UTF-8'), 
						mb_strtolower($current['employeeLastName'],'UTF-8')) == 0) {
				flock($lockInstance, LOCK_UN); 
				fclose($lockInstance);
				return 'В таблице зарплат уже есть заплата для указанного сотрудника.';
			}
		}
		$id++; // new id;
		$wages[] = array(
			"id"=>$id,
			"salary"=>$salary,
			"credited"=>$credited,
			"withheld"=>$withheld,
			"employeeLastName"=>$employeeLastName);
		file_put_contents('wages.txt', serialize($wages), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function searchChairs($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'chairName') != 0)  {
			if (strcmp($searchField, 'chairHead') != 0)  {
				if (strcmp($searchField, 'chairPhone') != 0)  {
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
		$chairs = getChairs();
		$result = null;
		foreach ($chairs as $current) {
			if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
						mb_strtolower($searchValue,'UTF-8')) !== false) {
				$result[] = $current;
			}
		}
		return $result;
	}

	function searchEmployees($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'employeeLastName') != 0)  {
			if (strcmp($searchField, 'post') != 0)  {
				if (strcmp($searchField, 'homeAddress') != 0)  {
					if (strcmp($searchField, 'phone') != 0)  {
						if (strcmp($searchField, 'chairName') != 0)  {
							$error = 'Неизвестный тип поля поиска.';
							return;
						}
					}
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

		$employees = getEmployees();
		$result = null;
		foreach ($employees as $current) {
			if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
						mb_strtolower($searchValue,'UTF-8')) !== false) {
				$result[] = $current;
			}
		}
		return $result;
	}

	function searchWages($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'salary') != 0)  {
			if (strcmp($searchField, 'credited') != 0)  {
				if (strcmp($searchField, 'withheld') != 0)  {
					if (strcmp($searchField, 'employeeLastName') != 0)  {
						$error = 'Неизвестный тип поля поиска.';
						return;
					}
				}
			}
		}
		if (!is_null($searchValue)) {
			if (strcmp($searchField, 'employeeLastName') == 0) {
				$searchValue = trim($searchValue);
			}
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}

		$wages = getWages();
		$result = null;
		foreach ($wages as $current) {

			// Если поле поиска - фамилия (строковое)
			if (strcmp($searchField, 'employeeLastName') == 0) {
				if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
							mb_strtolower($searchValue,'UTF-8')) !== false) {
					$result[] = $current;
				}

			// Если поле поиска не фамилия (целое число)
			} else {
				if ($current[$searchField] == $searchValue) {
					$result[] = $current;
				}
			}

		}
		return $result;
	}

	// Получение масиивов кафедр, сотрудников и зарплат.

	function getChairs() {
		if ((!file_exists('chairs.txt')) 
			|| (!file_exists('employees.txt'))
			|| (!file_exists('wages.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('chairs.txt'));
	}

	function getEmployees() {
		if ((!file_exists('chairs.txt')) 
			|| (!file_exists('employees.txt'))
			|| (!file_exists('wages.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('employees.txt'));
	}

	function getWages() {
		if ((!file_exists('chairs.txt')) 
			|| (!file_exists('employees.txt'))
			|| (!file_exists('wages.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('wages.txt'));
	}

	/**
	 * Первичная инициализация файлов кафедр, сотрудников и зарплат.
	 */
	function initializeFiles() {

		// Первичная инициализация chairs.txt
		$chairs = null;
		$idx = 1;
		$chairs[] = array("id"=>$idx++,"chairName"=>"Вычислительной математики и программирования","chairHead"=>"Кузьменков Дмитрий Сергеевич","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Математических проблем управления","chairHead"=>"Смородин Виктор Сергеевич","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Дифференциальных уравнений и теории функций","chairHead"=>"Старовойтов Александр Павлович","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Алгебры и геометрии","chairHead"=>"Селькин Вадим Михайлович","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Экономической кибернетики и теории вероятностей","chairHead"=>"Малинковский Юрий Владимирович","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Высшей математики","chairHead"=>"Семенчук Владимир Николаевич","chairPhone"=> NULL);
		$chairs[] = array("id"=>$idx++,"chairName"=>"Математического анализа","chairHead"=>"Миротин Адольф Рувимович","chairPhone"=> NULL);
		file_put_contents('chairs.txt', serialize($chairs), LOCK_EX);

		// Первичная инициализация employees.txt
		$employees = null;
		$idx = 1;
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Бычков","post"=>"ассистент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Жадан","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Карасева","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Дудовская","post"=>"ассистент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Экономической кибернетики и теории вероятностей");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Якубович","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Экономической кибернетики и теории вероятностей");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Монахов","post"=>"профессор","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Алгебры и геометрии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Ходалевич","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Алгебры и геометрии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Горский","post"=>"ассистент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Математического анализа");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Кульбакова","post"=>"ассистент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Математического анализа");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Демуськов","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Математических проблем управления");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Маслович","post"=>"доцент","homeAddress"=> NULL,"phone"=> NULL,"chairName"=> "Математических проблем управления");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Малдер","post"=>"профессор","homeAddress"=> "Садовая, д.18","phone"=> "555-555","chairName"=> "Математического анализа");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Скалли","post"=>"доцент","homeAddress"=> "Садовая, д.17","phone"=> "666-666","chairName"=> "Математического анализа");
		file_put_contents('employees.txt', serialize($employees), LOCK_EX);

		// Первичная инициализация wages.txt
		$employees = null;
		$idx = 1;
		$wages[] = array("id"=>$idx++,"salary"=>6000000,"credited"=>8300000,"withheld"=>1150000,"employeeLastName"=> "Бычков");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Жадан");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Карасева");
		$wages[] = array("id"=>$idx++,"salary"=>6000000,"credited"=>8300000,"withheld"=>1150000,"employeeLastName"=> "Дудовская");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Якубович");
		$wages[] = array("id"=>$idx++,"salary"=>10000000,"credited"=>12000000,"withheld"=>1700000,"employeeLastName"=> "Монахов");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Ходалевич");
		$wages[] = array("id"=>$idx++,"salary"=>6000000,"credited"=>8300000,"withheld"=>1150000,"employeeLastName"=> "Горский");
		$wages[] = array("id"=>$idx++,"salary"=>6000000,"credited"=>8300000,"withheld"=>1150000,"employeeLastName"=> "Кульбакова");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Демуськов");
		$wages[] = array("id"=>$idx++,"salary"=>7500000,"credited"=>10100000,"withheld"=>1500000,"employeeLastName"=> "Маслович");
		file_put_contents('wages.txt', serialize($wages), LOCK_EX);
	}

	function makeSortFunction($field) {
	    $code = "return strnatcasecmp(
	      Mb_strtolower(\$a['$field'],'UTF-8'), 
	      Mb_strtolower(\$b['$field'],'UTF-8'));";
	    return create_function('$a,$b', $code);
	}
?>