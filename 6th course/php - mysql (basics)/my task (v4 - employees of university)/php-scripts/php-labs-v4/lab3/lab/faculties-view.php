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
	$activeSortedField = 'facultyName';
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawFacultetSortedField = filter_input($requestType, 'facultetSortedField', FILTER_SANITIZE_SPECIAL_CHARS);
		if (strcmp($rawFacultetSortedField, 'FACULTY_DEAN') == 0) {
			$activeSortedField = 'facultyDean';
		} elseif (strcmp($rawFacultetSortedField, 'DEAN_PHONE') == 0) {
			$activeSortedField = 'deanPhone';
		} elseif (strcmp($rawFacultetSortedField, 'NUMBER_CHAIRS') == 0) {
			$activeSortedField = 'numberChairs';
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
	<title>Работа №3, Факультеты</title>
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
				<li class="active float-left"><a href="#">Факультеты</a></li>
				<li class="float-left"><a href="chairs-view.php">Кафедры</a></li>
				<li class="float-left"><a href="employees-view.php">Сотрудники</a></li>
			</ul>
		</div>

		<h1 class="page-title">Факультеты</h1>

		<div class="task3-form-wrapper">

			<form action="faculties-view.php" method="POST">
				<div class="clearfix">
					<label for="idFacultetSortedField">Сортировать по полю:</label>

					<select name="facultetSortedField" id="idFacultetSortedField" required>
						<option value="FACULTY_NAME"
							<?php echo $activeSortedField == 'facultyName' ? 'selected' : ''?>>Название
						</option>
						<option value="FACULTY_DEAN"
							<?php echo $activeSortedField == 'facultyDean' ? 'selected' : ''?>>Декан
						</option>
						<option value="DEAN_PHONE"
							<?php echo $activeSortedField == 'deanPhone' ? 'selected' : ''?>>Телефон деканата
						</option>
						<option value="NUMBER_CHAIRS"
							<?php echo $activeSortedField == 'numberChairs' ? 'selected' : ''?>>Число кафедр
						</option>
					</select>
				</div>
				<div class="clearfix">
					<input type="submit" value="Сортировать" />
				</div>
			</form>

			<form action="faculties-search-result.php" method="post">
				<div class="clearfix">
					<label for="idFacultiesSearchValue">Искать значение:</label>
					<input type="text" id="idFacultiesSearchValue" required
						name="facultiesSearchValue" placeholder="Искомое значение">
				</div>
				<div class="clearfix">
					<label for="idFacultetSearchField">Поле для поиска:</label>
					<select name="facultetSearchField" id="idFacultetSearchField" required>
						<option value="FACULTY_NAME">Название</option>
						<option value="FACULTY_DEAN">Декан</option>
						<option value="DEAN_PHONE">Телефон деканата</option>
						<option value="NUMBER_CHAIRS">Число кафедр</option>
					</select>
				</div>
				<div>
					<input type="submit" value="Искать" />
				</div>
			</form>
			<button onclick="location.href='faculties-add.php'">
				Добавить факультет
			</button>
		</div><!--task3-form-wrapper-->

		<?php
			try {
				include 'database.php';
				$pdo = Database::connect();
				$sql = 'SELECT facultyName, facultyDean, deanPhone, numberChairs FROM faculties;';
				$res = $pdo->query($sql);
				if ($res->rowCount() == 0) { 
					echo '<div class="append-error-block">';
					echo 'Отсутствуют данные в таблице факультетов.';
					echo '</div>';
				} else { 
		?>
		<table>
		<caption>
			Таблица факультетов
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
				$res = $res->fetchAll();
				usort($res, Database::makeSortFunction($activeSortedField));
				foreach ($res as $row) {
					echo '<tr>';
					echo '<td>'. $row['facultyName'] . '</td>';
					echo '<td>'. $row['facultyDean'] . '</td>';
					echo '<td>'. $row['deanPhone'] . '</td>';
					echo '<td>'. $row['numberChairs'] . '</td>';
					echo '</tr>';
				}
			}
			Database::disconnect();
		?>
		</tbody>
		</table>
		<?php
			}
			catch(PDOException $e) {
				echo '<div class="append-error-block">';
				echo "Ошибка соединения с БД: " . $e->getMessage();
				echo '</div>';
			}
		?>
		
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>