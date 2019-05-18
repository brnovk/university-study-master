<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';

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
		$rawChairsSearchValue = 
			filter_input($requestType, 'chairsSearchValue', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawChairSearchField = 
			filter_input($requestType, 'chairSearchField', FILTER_SANITIZE_SPECIAL_CHARS);

		$chairsSearchValue = normalizeText($rawChairsSearchValue);
		if (empty($chairsSearchValue) && $chairsSearchValue !== '0') {
			$errors .= 'Не указано значение для поиска.<br>';
			$valid = false;
		}
		$displaySearchValue = $chairsSearchValue;

		$chairSearchField = normalizeText($rawChairSearchField);
		if (empty($chairSearchField) && $chairSearchField !== '0') {
			$errors .= 'Не указано поле для поиска.<br>';
			$valid = false;
		}
		if (strcmp($chairSearchField, 'CHAIR_NAME') == 0) {
			$chairSearchField = 'chairName';
			$displaySearchField = 'Название кафедры';
		} elseif (strcmp($chairSearchField, 'FACULTY_NAME') == 0) {
			$chairSearchField = 'facultyName';
			$displaySearchField = 'Название факультета';
		} elseif (strcmp($chairSearchField, 'CHAIR_HEAD') == 0) {
			$chairSearchField = 'chairHead';
			$displaySearchField = 'Заведующий кафедрой';
		} elseif (strcmp($chairSearchField, 'CHAIR_PHONE') == 0) {
			$chairSearchField = 'chairPhone';
			$displaySearchField = 'Телефон кафедры';
		} else {
			$errors .= 'Неизвестный тип поля поиска.<br>';
			$valid = false;
		}
		
		if ($valid) {
			$searchError = null;
			$searchResult = searchChairs($chairSearchField, $chairsSearchValue, $searchError);
			if (!is_null($searchError)) {
				$errors .= 'Произошла ошибка поиска: '.$searchError.'<br>';
			} else {
				if (!is_null($searchResult)) {
					$existSearchResult = true;
				}
			}
		}
	} else {
		$errors .= 'Ошибка загрузки параметров поиска. 
			Повторите загрузку результатов со страницы "Кафедр"';
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
	<title>Работа №2, Результат поиска кафедры</title>
	<meta name="keywords" content="кафедры, php"/>
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

		<h1 class="page-title">Результат поиска кафедр</h1>

		<?php if (!empty($errors)): ?>
			<div class="append-error-block">
				<?php echo $errors;?>
			</div>
		<?php endif; ?>

		<?php if ($existSearchResult) { ?>
			<table>
			<caption>
				Таблица кафедр содержащих 
				<span style="font-weight: bold;"><?php echo $displaySearchValue; ?></span>
				в поле 
				<span style="font-weight: bold;"><?php echo $displaySearchField; ?></span>
			</caption>
			<thead>
			<tr>
				<td>Кафедра</td>
				<td>Факультет</td>
				<td>Заведующий</td>
	        	<td>Телефон</td>
			</tr>
			</thead>
			<tbody>
			<?php
				foreach ($searchResult as $row) {
					echo '<tr>';
					echo '<td>'. $row['chairName'] . '</td>';
					echo '<td>'. $row['facultyName'] . '</td>';
					echo '<td>'. $row['chairHead'] . '</td>';
					echo '<td>'. $row['chairPhone'] . '</td>';
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