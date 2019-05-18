<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}

	$requestType = '';
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	$activeSortedField = 'chairName';
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawChairSortedField = 
			filter_input($requestType, 'chairSortedField', FILTER_SANITIZE_SPECIAL_CHARS);

		if (strcmp($rawChairSortedField, 'FACULTY_NAME') == 0) {
			$activeSortedField = 'facultyName';
		} elseif (strcmp($rawChairSortedField, 'CHAIR_HEAD') == 0) {
			$activeSortedField = 'chairHead';
		} elseif (strcmp($rawChairSortedField, 'CHAIR_PHONE') == 0) {
			$activeSortedField = 'chairPhone';
		}
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
	<title>Работа №2, Кафедры</title>
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
				<li class="active float-left"><a href="#">Кафедры</a></li>
				<li class="float-left"><a href="employees-view.php">Сотрудники</a></li>
			</ul>
		</div>

		<h1 class="page-title">Кафедры</h1>

		<div class="task3-form-wrapper">

			<form action="chairs-view.php" method="POST">
				<div class="clearfix">
					<label for="idChairSortedField">Сортировать по полю:</label>

					<select name="chairSortedField" id="idChairSortedField" required>
						<option value="CHAIR_NAME"
							<?php echo $activeSortedField == 'chairName' ? 'selected' : ''?>>
							Название кафедры
						</option>
						<option value="FACULTY_NAME"
							<?php echo $activeSortedField == 'facultyName' ? 'selected' : ''?>>
							Название факультета
						</option>
						<option value="CHAIR_HEAD"
							<?php echo $activeSortedField == 'chairHead' ? 'selected' : ''?>>
							Заведующий кафедрой
						</option>
						<option value="CHAIR_PHONE"
							<?php echo $activeSortedField == 'chairPhone' ? 'selected' : ''?>>
							Телефон кафедры
						</option>
					</select>
				</div>
				<div class="clearfix">
					<input type="submit" value="Сортировать" />
				</div>
			</form>

			<form action="chairs-search-result.php" method="post">
				<div class="clearfix">
					<label for="idChairsSearchValue">Искать значение:</label>
					<input type="text" id="idChairsSearchValue" required
						name="chairsSearchValue" placeholder="Искомое значение">
				</div>
				<div class="clearfix">
					<label for="idChairSearchField">Поле для поиска:</label>
					<select name="chairSearchField" id="idChairSearchField" required>
						<option value="CHAIR_NAME">Название кафедры</option>
						<option value="FACULTY_NAME">Название факультета</option>
						<option value="CHAIR_HEAD">Заведующий кафедрой</option>
						<option value="CHAIR_PHONE">Телефон кафедры</option>
					</select>
				</div>
				<div>
					<input type="submit" value="Искать" />
				</div>
			</form>
			<button onclick="location.href='chairs-add.php'">
				Добавить кафедру
			</button>
		</div><!--task3-form-wrapper-->

		<?php
			require 'file-handler.php';
			$res = getChairs();
			if (empty($res) || count($res) == 0) { 
				echo '<div class="append-error-block">';
				echo 'Отсутствуют данные в таблице кафедр.';
				echo '</div>';
			} else { 
		?>
		<table>
		<caption>
			Таблица кафедр
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
			usort($res, makeSortFunction($activeSortedField));
			foreach ($res as $row) {
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
		<?php } ?>
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>