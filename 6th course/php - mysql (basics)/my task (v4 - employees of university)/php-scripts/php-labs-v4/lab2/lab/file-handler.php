<?php

	function addFaculty($facultyName, $facultyDean, $deanPhone, $numberChairs) {
		if (!is_null($facultyName)) {
			$facultyName = trim($facultyName);
		}
		if (!is_null($facultyDean)) {
			$facultyDean = trim($facultyDean);
		}
		if (!is_null($deanPhone)) {
			$deanPhone = trim($deanPhone);
		}
		if (empty($facultyName) && $facultyName !== '0') {
			return 'Не указано название факультета.';
		}
		if (empty($facultyDean) && $facultyDean !== '0') {
			return 'Не указан декан факультета.';
		}
		if (empty($numberChairs) && $numberChairs !== '0') {
			// Поле не обязательное, поэтому ничего не делаем
		} elseif (!is_numeric($numberChairs) 
			|| (int)$numberChairs != $numberChairs 
			|| (int)$numberChairs <= 0 ) {
				return 'Количество кафедр должно быть положительным целым числом.';
		}
		
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

		$faculties = getFaculties();
		foreach ($faculties as $current) {
			if (strcmp(mb_strtolower($facultyName,'UTF-8'), 
						mb_strtolower($current['facultyName'],'UTF-8')) == 0) {
				flock($lockInstance, LOCK_UN); 
				fclose($lockInstance);
				return 'Факультет с таким названием уже есть в файле.';
			}
		}
		$id = -1; // empty value
		foreach ($faculties as $current) {
			if ($current['id'] > $id) {
				$id = $current['id'];
			}
		}
		$id++; // new id;
		$faculties[] = array(
			"id"=>$id,
			"facultyName"=>$facultyName,
			"facultyDean"=>$facultyDean,
			"deanPhone"=>$deanPhone,
			"numberChairs"=>$numberChairs);
		file_put_contents('faculties.txt', serialize($faculties), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addChair($chairName,$chairHead,$chairPhone,$facultyName) {
		if (!is_null($chairName)) {
			$chairName = trim($chairName);
		}
		if (!is_null($chairHead)) {
			$chairHead = trim($chairHead);
		}
		if (!is_null($chairPhone)) {
			$chairPhone = trim($chairPhone);
		}
		if (!is_null($facultyName)) {
			$facultyName = trim($facultyName);
		}
		if (empty($chairName) && $chairName !== '0') {
			return 'Не указано название кафедры.';
		}
		if (empty($facultyName) && $facultyName !== '0') {
			return 'Не указан факультет.';
		}
		$faculties = getFaculties();
		$facultyExist = false;
		foreach ($faculties as $current) {
			if (strcmp(mb_strtolower($facultyName,'UTF-8'), 
						mb_strtolower($current['facultyName'],'UTF-8')) == 0) {
				$facultyExist = true;
				break;
			}
		}
		if (!$facultyExist) {
			return 'Указанный факультет отсутствует в списке факультетов.';
		}
		
		if (!file_exists('lock-instance')) {
			$lockInstance = fopen('lock-instance', 'w');
			fclose($lockInstance);
		}
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

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
			"chairPhone"=>$chairPhone,
			"facultyName"=>$facultyName);
		file_put_contents('chairs.txt', serialize($chairs), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function addEmployee($employeeLastName,$homeAddress,$age,$phone,$chairName) {
		if (!is_null($employeeLastName)) {
			$employeeLastName = trim($employeeLastName);
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
		if (empty($age) && $age !== '0') {
			// Поле не обязательное, поэтому ничего не делаем
		} elseif (!is_numeric($age) 
			|| (int)$age != $age 
			|| (int)$age <= 0 ) {
				return 'Возраст должен быть положительным целым числом.';
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
		$lockInstance = fopen('lock-instance', 'r'); 
		flock($lockInstance, LOCK_EX);

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
			"homeAddress"=>$homeAddress,
			"age"=>$age,
			"phone"=>$phone,
			"chairName"=>$chairName);
		file_put_contents('employees.txt', serialize($employees), LOCK_EX);

		flock($lockInstance, LOCK_UN); 
		fclose($lockInstance);
	}

	function searchFaculties($searchField, $searchValue, &$error) {
		if (!is_null($searchField)) {
			$searchField = trim($searchField);
		}
		if (empty($searchField) && $searchField !== '0') {
			$error = 'Не указано поле для поиска.';
			return;
		}
		if (strcmp($searchField, 'facultyName') != 0)  {
			if (strcmp($searchField, 'facultyDean') != 0)  {
				if (strcmp($searchField, 'deanPhone') != 0)  {
					if (strcmp($searchField, 'numberChairs') != 0)  {
						$error = 'Неизвестный тип поля поиска.';
						return;
					}
				}
			}
		}
		if (!is_null($searchValue)) {
			if (strcmp($searchField, 'numberChairs') != 0) {
				$searchValue = trim($searchValue);
			}
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}

		$faculties = getFaculties();
		$result = null;
		foreach ($faculties as $current) {

			// Если поле поиска не количество кафедр (строковое)
			if (strcmp($searchField, 'numberChairs') != 0) {
				if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
							mb_strtolower($searchValue,'UTF-8')) !== false) {
					$result[] = $current;
				}

			// Если поле поиска количество кафедр (целое число)
			} else {
				if ($current[$searchField] == $searchValue) {
					$result[] = $current;
				}
			}

		}
		return $result;
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
					if (strcmp($searchField, 'facultyName') != 0)  {
						$error = 'Неизвестный тип поля поиска.';
						return;
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
			if (strcmp($searchField, 'homeAddress') != 0)  {
				if (strcmp($searchField, 'age') != 0)  {
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
			if (strcmp($searchField, 'age') != 0) {
				$searchValue = trim($searchValue);
			}
		}
		if (empty($searchValue) && $searchValue !== '0') {
			$error = 'Не указано значение для поиска.<br>';
			return;
		}

		$employees = getEmployees();
		$result = null;
		foreach ($employees as $current) {

			// Если поле поиска не возраст (строковое)
			if (strcmp($searchField, 'age') != 0) {
				if (strpos(mb_strtolower(($current[$searchField]),'UTF-8'), 
							mb_strtolower($searchValue,'UTF-8')) !== false) {
					$result[] = $current;
				}

			// Если поле поиска - возраст (целое число)
			} else {
				if ($current[$searchField] == $searchValue) {
					$result[] = $current;
				}
			}

		}
		return $result;
	}


	// Получение масиивов факультетов, кафедр и сотрудников

	function getFaculties() {
		if ((!file_exists('faculties.txt')) 
			|| (!file_exists('chairs.txt'))
			|| (!file_exists('employees.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('faculties.txt'));
	}

	function getChairs() {
		if ((!file_exists('faculties.txt')) 
			|| (!file_exists('chairs.txt'))
			|| (!file_exists('employees.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('chairs.txt'));
	}

	function getEmployees() {
		if ((!file_exists('faculties.txt')) 
			|| (!file_exists('chairs.txt'))
			|| (!file_exists('employees.txt'))) {
				initializeFiles();
		}
		return unserialize(file_get_contents('employees.txt'));
	}

	/**
	 * Первичная инициализация файлов факультетов, кафедр и сотрудников.
	 */
	function initializeFiles() {

		// Первичная инициализация faculties.txt
		$faculties = null;
		$idx = 1;
		$faculties[] = array("id"=>$idx++,"facultyName"=>"Математический","facultyDean"=>"Жогаль Сергей Петрович","deanPhone"=>"+375(232) 60-75-12","numberChairs"=>7);
		$faculties[] = array("id"=>$idx++,"facultyName"=>"Физический","facultyDean"=>"Коваленко Дмитрий Леонидович","deanPhone"=>"+375(232) 57-54-65","numberChairs"=>5);
		$faculties[] = array("id"=>$idx++,"facultyName"=>"Биологический","facultyDean"=>"Аверин Виктор Сергеевич","deanPhone"=>"+375(232) 56-75-61","numberChairs"=>4);
		file_put_contents('faculties.txt', serialize($faculties), LOCK_EX);

		// Первичная инициализация chairs.txt
		$chairs = null;
		$idx = 1;
		$chairs[] = array("id"=>$idx++,"chairName"=>"Вычислительной математики и программирования","chairHead"=>"Кузьменков Дмитрий Сергеевич","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Математических проблем управления","chairHead"=>"Смородин Виктор Сергеевич","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Дифференциальных уравнений и теории функций","chairHead"=>"Старовойтов Александр Павлович","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Алгебры и геометрии","chairHead"=>"Селькин Вадим Михайлович","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Экономической кибернетики и теории вероятностей","chairHead"=>"Малинковский Юрий Владимирович","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Высшей математики","chairHead"=>"Семенчук Владимир Николаевич","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Математического анализа","chairHead"=>"Миротин Адольф Рувимович","chairPhone"=> NULL,"facultyName"=> "Математический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Оптики","chairHead"=>"Алешкевич Николай Александрович","chairPhone"=> "+375(232) 57-79-97","facultyName"=> "Физический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Теоретической физики","chairHead"=>"Андреев Виктор Васильевич","chairPhone"=> NULL,"facultyName"=> "Физический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Общей физики","chairHead"=>"Шершнев Евгений Борисович","chairPhone"=> NULL,"facultyName"=> "Физический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Радиофизики и электроники","chairHead"=>"Мышковец Виктор Николаевич","chairPhone"=> NULL,"facultyName"=> "Физический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Автоматизированных систем обработки информации","chairHead"=>"Левчук Виктор Дмитриевич","chairPhone"=> NULL,"facultyName"=> "Физический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Ботаники и физиологии растений","chairHead"=>"Дайнеко Николай Михайлович","chairPhone"=> "+375(232) 57-89-05","facultyName"=> "Биологический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Зоологии, физиологии и генетики","chairHead"=> NULL,"chairPhone"=> NULL,"facultyName"=> "Биологический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Химии","chairHead"=>"Дроздова Наталья Ивановна","chairPhone"=> "+375(232) 60-14-03","facultyName"=> "Биологический");
		$chairs[] = array("id"=>$idx++,"chairName"=>"Лесохозяйственных дисциплин","chairHead"=>"Лазарева Марина Сергеевна","chairPhone"=> NULL,"facultyName"=> "Биологический");
		file_put_contents('chairs.txt', serialize($chairs), LOCK_EX);

		// Первичная инициализация employees.txt
		$employees = null;
		$idx = 1;
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Бычков","homeAddress"=> NULL,"age"=>33,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Жадан","homeAddress"=> NULL,"age"=>65,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Карасева","homeAddress"=> NULL,"age"=>57,"phone"=> NULL,"chairName"=> "Вычислительной математики и программирования");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Дудовская","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Экономической кибернетики и теории вероятностей");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Якубович","homeAddress"=> NULL,"age"=>42,"phone"=> NULL,"chairName"=> "Экономической кибернетики и теории вероятностей");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Монахов","homeAddress"=> NULL,"age"=>69,"phone"=> NULL,"chairName"=> "Алгебры и геометрии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Ходалевич","homeAddress"=> NULL,"age"=>59,"phone"=> NULL,"chairName"=> "Алгебры и геометрии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Горский","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Математического анализа");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Кульбакова","homeAddress"=> NULL,"age"=>44,"phone"=> NULL,"chairName"=> "Математического анализа");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Демуськов","homeAddress"=> NULL,"age"=>62,"phone"=> NULL,"chairName"=> "Математических проблем управления");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Маслович","homeAddress"=> NULL,"age"=>35,"phone"=> NULL,"chairName"=> "Математических проблем управления");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Щеголихина","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Лесохозяйственных дисциплин");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Воробьева","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Химии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Хаданович","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Химии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Беляева","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Химии");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Пугачева","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Автоматизированных систем обработки информации");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Дробышевская","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Общей физики");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Орлова","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Общей физики");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Новикова","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Теоретической физики");
		$employees[] = array("id"=>$idx++,"employeeLastName"=>"Лукашевич","homeAddress"=> NULL,"age"=> NULL,"phone"=> NULL,"chairName"=> "Теоретической физики");
		file_put_contents('employees.txt', serialize($employees), LOCK_EX);
	}

	function makeSortFunction($field) {
	    $code = "return strnatcasecmp(
	      Mb_strtolower(\$a['$field'],'UTF-8'), 
	      Mb_strtolower(\$b['$field'],'UTF-8'));";
	    return create_function('$a,$b', $code);
	}
?>