<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';

	$valid = true;
	$requestType = '';
	$errors = '';
	$appendFacultyName = null;
	$appendFacultyDean = null;
	$appendDeanPhone = null;
	$appendNumberChairs = null;

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawAppendFacultyName = 
			filter_input($requestType, 'appendFacultyName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendFacultyDean = 
			filter_input($requestType, 'appendFacultyDean', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendDeanPhone = 
			filter_input($requestType, 'appendDeanPhone', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendNumberChairs = 
			filter_input($requestType, 'appendNumberChairs', FILTER_SANITIZE_SPECIAL_CHARS);

		$appendFacultyName = normalizeText($rawAppendFacultyName);
		if (empty($appendFacultyName) && $appendFacultyName !== '0') {
			$errors .= 'Не указано название факультета.<br>';
			$valid = false;
		}

		$appendFacultyDean = normalizeText($rawAppendFacultyDean);
		if (empty($appendFacultyDean) && $appendFacultyDean !== '0') {
			$errors .= 'Не указан декан факультета.<br>';
			$valid = false;
		}

		$appendDeanPhone = normalizeText($rawAppendDeanPhone);
		if (empty($appendDeanPhone) && $appendDeanPhone !== '0') {
			// Поле не обязательное, поэтому null
			$appendDeanPhone = null;
		}

		$appendNumberChairs = normalizeText($rawAppendNumberChairs);
		if (empty($appendNumberChairs) && $appendNumberChairs !== '0') {
			// Поле не обязательное, поэтому null
			$appendNumberChairs = null;
		} elseif (!is_numeric($appendNumberChairs) 
			|| (int)$appendNumberChairs != $appendNumberChairs 
			|| (int)$appendNumberChairs <= 0 ) {

			$errors .= 'Количество кафедр должно быть положительным целым числом.<br>';
			$valid = false;
		}

		if ($valid) {
			$res = addFaculty($appendFacultyName,$appendFacultyDean,$appendDeanPhone,$appendNumberChairs);
			if (!is_null($res)) {
				$errors .= 'Ошибка добавления факультета: '.$res.'<br>';
			} else {
				header("Location: faculties-view.php");
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
	<title>Работа №2, Добавление факультета</title>
	<meta name="keywords" content="факультеты, php"/>
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

		<h1 class="page-title">Добавление факультета</h1>

		<?php if (!empty($errors)): ?>
			<div class="append-error-block">
				<?php echo $errors;?>
			</div>
		<?php endif; ?>

		<div class="task3-form-wrapper">

			<form class="append-form" action="faculties-add.php" method="POST">
				<div class="clearfix">
					<label for="idAppendFacultyName">
						<span class="asterics-mandatory">*</span> Название факультата:</label>
					<input type="text" id="idAppendFacultyName" 
						name="appendFacultyName" placeholder="Название факультата" required
						value="<?php echo !is_null($appendFacultyName)?$appendFacultyName:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendFacultyDean">
						<span class="asterics-mandatory">*</span> Декан факультата:</label>
					<input type="text" id="idAppendFacultyDean" 
						name="appendFacultyDean" placeholder="Декан факультата" required
						value="<?php echo !is_null($appendFacultyDean)?$appendFacultyDean:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendDeanPhone">Телефон деканата:</label>
					<input type="text" id="idAppendDeanPhone" 
						name="appendDeanPhone" placeholder="Телефон деканата"
						value="<?php echo !is_null($appendDeanPhone)?$appendDeanPhone:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendNumberChairs">Количество кафедр:</label>
					<input type="text" id="idAppendNumberChairs" 
						name="appendNumberChairs" placeholder="Количество кафедр"
						value="<?php echo !is_null($appendNumberChairs)?$appendNumberChairs:'';?>">
				</div>
				<div class="clearfix">
					<input type="submit" value="Добававить факультет" />
				</div>
			</form>
		</div><!--task3-form-wrapper-->
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>