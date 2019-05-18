<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'database.php';

	$valid = true;
	$requestType = '';
	$errors = '';
	$existSearchResult = false;
	$displaySearchValue = '';
	$displaySearchField = '';

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawFacultiesSearchValue = 
			filter_input($requestType, 'facultiesSearchValue', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawFacultetSearchField = 
			filter_input($requestType, 'facultetSearchField', FILTER_SANITIZE_SPECIAL_CHARS);

		$facultiesSearchValue = normalizeText($rawFacultiesSearchValue);
		if (empty($facultiesSearchValue) && $facultiesSearchValue !== '0') {
			$errors .= 'Не указано значение для поиска.<br>';
			$valid = false;
		}
		$displaySearchValue = $facultiesSearchValue;

		$facultetSearchField = normalizeText($rawFacultetSearchField);
		if (empty($facultetSearchField) && $facultetSearchField !== '0') {
			$errors .= 'Не указано поле для поиска.<br>';
			$valid = false;
		}
		if (strcmp($facultetSearchField, 'FACULTY_NAME') == 0) {
			$facultetSearchField = 'facultyName';
			$displaySearchField = 'Название факультета';
		} elseif (strcmp($facultetSearchField, 'FACULTY_DEAN') == 0) {
			$facultetSearchField = 'facultyDean';
			$displaySearchField = 'Декан факультета';
		} elseif (strcmp($facultetSearchField, 'DEAN_PHONE') == 0) {
			$facultetSearchField = 'deanPhone';
			$displaySearchField = 'Телефон деканата';
		} elseif (strcmp($facultetSearchField, 'NUMBER_CHAIRS') == 0) {
			$facultetSearchField = 'numberChairs';
			$displaySearchField = 'Число кафедр';
		} else {
			$errors .= 'Неизвестный тип поля поиска.<br>';
			$valid = false;
		}

		if ($valid) {

			try {
				$pdo = Database::connect();
				$sql = 'SELECT facultyName, facultyDean, deanPhone, numberChairs 
					FROM faculties WHERE '.$facultetSearchField.' LIKE :keyword;';
				$searchResult = $pdo->prepare($sql);
				$searchResult->bindValue(':keyword','%'.$facultiesSearchValue.'%');
				$searchResult->execute();
				if ($searchResult->rowCount() != 0) {
					$existSearchResult = true;
					$searchResult = $searchResult->fetchAll();
				}
				Database::disconnect();
			} catch(PDOException $e) {
				$errors .= 'Произошла ошибка при работе с БД.<br>'.$e->getMessage();
			}
		}
	} else {
		$errors .= 'Ошибка загрузки параметров поиска. 
			Повторите загрузку результатов со страницы "Факультеты"';
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
	<title>Работа №3, Результат поиска факультета</title>
	<meta name="keywords" content="факультеты, php"/>
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

		<h1 class="page-title">Результат поиска факультета</h1>

		<?php if (!empty($errors)): ?>
			<div class="append-error-block">
				<?php echo $errors;?>
			</div>
		<?php endif; ?>

		<?php if ($existSearchResult) { ?>
			<table>
			<caption>
				Таблица факультетов содержащих 
				<span style="font-weight: bold;"><?php echo $displaySearchValue; ?></span>
				в поле 
				<span style="font-weight: bold;"><?php echo $displaySearchField; ?></span>
			</caption>
			<thead>
			<tr>
				<td>Название</td>
				<td>Декан</td>
				<td>Телефон деканата</td>
	        	<td>Число кафедр</td>
			</tr>
			</thead>
			<tbody>
			<?php
				foreach ($searchResult as $row) {
					echo '<tr>';
					echo '<td>'. $row['facultyName'] . '</td>';
					echo '<td>'. $row['facultyDean'] . '</td>';
					echo '<td>'. $row['deanPhone'] . '</td>';
					echo '<td>'. $row['numberChairs'] . '</td>';
					echo '</tr>';
				}
			?>
			</tbody>
			</table>
			<?php } else { ?>
			<?php if (!empty($displaySearchValue)): ?>
				<h2 class="empty-search">
					Записей содеращих <strong><?php echo $displaySearchValue; ?></strong> 
					в поле <strong><?php echo $displaySearchField; ?></strong> не найдено
				</h2>
			<?php endif; ?>
			<?php } ?>
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>