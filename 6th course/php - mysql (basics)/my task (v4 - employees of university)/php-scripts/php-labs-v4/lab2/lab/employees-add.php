<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';

	$valid = true;
	$requestType = '';
	$errors = '';
	$appendEmployeeLastName = null;
	$appendChairName = null;
	$appendHomeAddress = null;
	$appendAge = null;
	$appendPhone = null;

	$chairList = getChairs();
	if (empty($chairList) || count($chairList) == 0) { 
		$errors .= 'В таблице кафедр нет ни одной записи.<br>';
		$chairList = null;
	}

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawAppendEmployeeLastName = 
			filter_input($requestType, 'appendEmployeeLastName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairName = 
			filter_input($requestType, 'appendChairName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendHomeAddress = 
			filter_input($requestType, 'appendHomeAddress', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendAge = 
			filter_input($requestType, 'appendAge', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendPhone = 
			filter_input($requestType, 'appendPhone', FILTER_SANITIZE_SPECIAL_CHARS);

		$appendEmployeeLastName = normalizeText($rawAppendEmployeeLastName);
		if (empty($appendEmployeeLastName) && $appendEmployeeLastName !== '0') {
			$errors .= 'Не указана фамилия сотрудника.<br>';
			$valid = false;
		}

		$appendChairName = normalizeText($rawAppendChairName);
		if (empty($appendChairName) && $appendChairName !== '0') {
			$errors .= 'Не указана кафедра.<br>';
			$valid = false;
		}

		$appendHomeAddress = normalizeText($rawAppendHomeAddress);
		if (empty($appendHomeAddress) && $appendHomeAddress !== '0') {
			// Поле не обязательное, поэтому null
			$appendHomeAddress = null;
		}

		$appendAge = normalizeText($rawAppendAge);
		if (empty($appendAge) && $appendAge !== '0') {
			// Поле не обязательное, поэтому null
			$appendAge = null;
		} elseif (!is_numeric($appendAge) 
			|| (int)$appendAge != $appendAge 
			|| (int)$appendAge <= 0 ) {

			$errors .= 'Возраст должен быть положительным целым числом.<br>';
			$valid = false;
		}

		$appendPhone = normalizeText($rawAppendPhone);
		if (empty($appendPhone) && $appendPhone !== '0') {
			// Поле не обязательное, поэтому null
			$appendPhone = null;
		}

		if ($valid) {
			$res = addEmployee($appendEmployeeLastName,$appendHomeAddress,$appendAge,$appendPhone,
					$appendChairName);
			if (!is_null($res)) {
				$errors .= 'Ошибка добавления сотрудника: '.$res.'<br>';
			} else {
				header("Location: employees-view.php");
			}
		}
	}

	function normalizeText($rawString) {
	    $result = preg_replace('/\s\s+/', ' ', $rawString);
	    return trim(strip_tags(htmlspecialchars($result)));
	}

?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--[if lt IE 9]>
		<script src="../../../js/html5shiv.js"></script>
		<script src="../../../js/IE9.js"></script>
		<noscript>
			<strong>Внимание!</strong>
			Так как ваш браузер не поддерживает HTML5, некоторые элементы 
			моделируются с помощью JavaScript. К сожалению, в вашем браузере
			отключено исполнение JavaScript-сценариев. Пожалуйста, включите
			поддержку скриптов для этой страницы.
		</noscript>
	<![endif]-->
	<title>Работа №2, Добавление сотрудника</title>
	<meta name="keywords" content="сотрудники, php"/>
	<meta name="description" content="Страница с работой №2"/>
	<link rel="stylesheet" href="../../../styles/style.css">
</head>
<body>
<div class="page-wrapper">

	<header class="page-header clearfix">

		<div class="header-left-link float-left" title="На страницу с заданием">
			<a href="../lab2-index.html">
				&lt; К заданию
			</a>
		</div><!-- header-left-link-->

		<div class="description-header-page float-left">
			<strong>№ работы:</strong> 2<br>
			<strong>Хранение данных: </strong>в файлах
		</div><!-- description-header-page -->

		<div class="header-right-link float-rigth">
			<a href="../../lab3/lab/faculties-view.php" title="На страницу с работой №3">Работа №3 &gt;</a>
		</div><!-- header-right-link -->

		<div class="header-right-link float-rigth">
			<a href="../../lab1/subType1/subtype1-facultet.php" 
				title="На страницу с работой №1">&lt; Работа №1</a>
		</div><!-- header-right-link -->
	</header><!-- page-header -->

	<main class="page-main">

		<div class="horizontal-menu-wrapper">
			<ul class="menu-list clearfix">
				<li class="float-left"><a href="faculties-view.php">Факультеты</a></li>
				<li class="float-left"><a href="chairs-view.php">Кафедры</a></li>
				<li class="float-left"><a href="employees-view.php">Сотрудники</a></li>
			</ul>
		</div>

		<h1 class="page-title">Добавление сотрудника</h1>

		<?php if (!empty($errors)): ?>
			<div class="append-error-block">
				<?php echo $errors;?>
			</div>
		<?php endif; ?>

		<div class="task3-form-wrapper">

			<form class="append-form" action="employees-add.php" method="POST">
				<div class="clearfix">
					<label for="idAppendEmployeeLastName">
						<span class="asterics-mandatory">*</span> Фамилия сотрудника:</label>
					<input type="text" id="idAppendEmployeeLastName" 
						name="appendEmployeeLastName" placeholder="Фамилия сотрудника" required
						value="<?php echo !is_null($appendEmployeeLastName)?$appendEmployeeLastName:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendChairName">
						<span class="asterics-mandatory">*</span> Кафедра:</label>
					<select name="appendChairName" id="idAppendChairName" required>
					<?php 
						if (!is_null($chairList)) {
							foreach ($chairList as $currentChair) {
								echo '<option value="'
									.$currentChair['chairName']
									.'">'.$currentChair['chairName']
									.'</option>';
							}
						}
					 ?>
					</select>
				</div>
				<div class="clearfix">
					<label for="idAppendHomeAddress">Домашний адрес:</label>
					<input type="text" id="idAppendHomeAddress" 
						name="appendHomeAddress" placeholder="Домашний адрес"
						value="<?php echo !is_null($appendHomeAddress)?$appendHomeAddress:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendAge">Возраст:</label>
					<input type="text" id="idAppendAge" 
						name="appendAge" placeholder="Возраст"
						value="<?php echo !is_null($appendAge)?$appendAge:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendPhone">Телефон сотрудника:</label>
					<input type="text" id="idAppendPhone" 
						name="appendPhone" placeholder="Телефон сотрудника"
						value="<?php echo !is_null($appendPhone)?$appendPhone:'';?>">
				</div>
				<div class="clearfix">
					<input type="submit" value="Добававить сотрудника" />
				</div>
			</form>
		</div><!--task3-form-wrapper-->
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>