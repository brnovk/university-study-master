<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'database.php';

	$valid = true;
	$requestType = '';
	$errors = '';
	$appendChairName = null;
	$appendFacultyName = null;
	$appendChairHead = null;
	$appendChairPhone = null;
	$facultyList = null;

	try {
		$pdo = Database::connect();
		$sql = 'SELECT facultyName FROM faculties;';
		$facultyList = $pdo->query($sql);
		if ($facultyList->rowCount() == 0) {
			$errors .= 'В таблице факультатов нет ни одной записи.<br>';
		} else {
			$facultyList = $facultyList->fetchAll();
		}
		Database::disconnect();
	} catch(PDOException $e) {
		$errors .= 'Произошла ошибка при работе с БД.<br>'.$e->getMessage();
	}

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawAppendChairName = 
			filter_input($requestType, 'appendChairName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendFacultyName = 
			filter_input($requestType, 'appendFacultyName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairHead = 
			filter_input($requestType, 'appendChairHead', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairPhone = 
			filter_input($requestType, 'appendChairPhone', FILTER_SANITIZE_SPECIAL_CHARS);

		$appendChairName = normalizeText($rawAppendChairName);
		if (empty($appendChairName) && $appendChairName !== '0') {
			$errors .= 'Не указано название кафедры.<br>';
			$valid = false;
		}

		$appendFacultyName = normalizeText($rawAppendFacultyName);
		if (empty($appendFacultyName) && $appendFacultyName !== '0') {
			$errors .= 'Не указан факультет.<br>';
			$valid = false;
		}

		$appendChairHead = normalizeText($rawAppendChairHead);
		if (empty($appendChairHead) && $appendChairHead !== '0') {
			// Поле не обязательное, поэтому null
			$appendChairHead = null;
		}

		$appendChairPhone = normalizeText($rawAppendChairPhone);
		if (empty($appendChairPhone) && $appendChairPhone !== '0') {
			// Поле не обязательное, поэтому null
			$appendChairPhone = null;
		}

		if ($valid) {
			try {
				$pdo = Database::connect();
				$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$sql = "INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
						VALUES (?, ?, ?, (SELECT faculties.id FROM faculties 
							WHERE faculties.facultyName = ?));";
				$q = $pdo->prepare($sql);
				$q->execute(array(
					$appendChairName,
					$appendChairHead,
					$appendChairPhone,
					$appendFacultyName));
				Database::disconnect();
				header("Location: chairs-view.php");
			} catch(PDOException $e) {
				$errors .= 'Произошла ошибка при работе с БД.<br>'.$e->getMessage();
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
	<title>Работа №3, Добавление кафедры</title>
	<meta name="keywords" content="кафедры, php"/>
	<meta name="description" content="Страница с работой №3"/>
	<link rel="stylesheet" href="../../../styles/style.css">
</head>
<body>
<div class="page-wrapper">

	<header class="page-header clearfix">

		<div class="header-left-link float-left" title="На страницу с заданием">
			<a href="../lab3-index.html">
				&lt; К заданию
			</a>
		</div><!-- header-left-link-->

		<div class="description-header-page float-left">
			<strong>№ работы:</strong> 3<br>
			<strong>Способ храния данных на сервере:</strong> база данных
		</div><!-- description-header-page -->

		<div class="header-right-link float-rigth">
			<a href="../../lab2/lab/faculties-view.php" title="На страницу с работой №2">&lt; Работа №2</a>
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

		<h1 class="page-title">Добавление кафедры</h1>

		<?php if (!empty($errors)): ?>
			<div class="append-error-block">
				<?php echo $errors;?>
			</div>
		<?php endif; ?>

		<div class="task3-form-wrapper">

			<form class="append-form" action="chairs-add.php" method="POST">
				<div class="clearfix">
					<label for="idAppendChairName">
						<span class="asterics-mandatory">*</span> Название кафедры:</label>
					<input type="text" id="idAppendChairName" 
						name="appendChairName" placeholder="Название кафедры" required
						value="<?php echo !is_null($appendChairName)?$appendChairName:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendFacultyName">
						<span class="asterics-mandatory">*</span> Факультет:</label>
					<select name="appendFacultyName" id="idAppendFacultyName" required>
					<?php 
						if (!is_null($facultyList)) {
							foreach ($facultyList as $currentFaculty) {
								echo '<option value="'
									.$currentFaculty['facultyName']
									.'">'.$currentFaculty['facultyName']
									.'</option>';
							}
						}
					 ?>
					</select>
				</div>
				<div class="clearfix">
					<label for="idAppendChairHead">Заведующий кафедрой:</label>
					<input type="text" id="idAppendChairHead" 
						name="appendChairHead" placeholder="Заведующий кафедрой"
						value="<?php echo !is_null($appendChairHead)?$appendChairHead:'';?>">
				</div>
				<div class="clearfix">
					<label for="idAppendChairPhone">Телефон кафедры:</label>
					<input type="text" id="idAppendChairPhone" 
						name="appendChairPhone" placeholder="Телефон кафедры"
						value="<?php echo !is_null($appendChairPhone)?$appendChairPhone:'';?>">
				</div>
				<div class="clearfix">
					<input type="submit" value="Добававить кафедру" />
				</div>
			</form>
		</div><!--task3-form-wrapper-->
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>