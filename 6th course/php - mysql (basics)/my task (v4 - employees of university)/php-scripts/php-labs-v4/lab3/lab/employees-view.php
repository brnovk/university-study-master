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
	$activeSortedField = 'employeeLastName';
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawEmployeeSortedField = 
			filter_input($requestType, 'employeeSortedField', FILTER_SANITIZE_SPECIAL_CHARS);

		if (strcmp($rawEmployeeSortedField, 'CHAIR_NAME') == 0) {
			$activeSortedField = 'chairName';
		} elseif (strcmp($rawEmployeeSortedField, 'HOME_ADDRESS') == 0) {
			$activeSortedField = 'homeAddress';
		} elseif (strcmp($rawEmployeeSortedField, 'AGE') == 0) {
			$activeSortedField = 'age';
		} elseif (strcmp($rawEmployeeSortedField, 'PHONE') == 0) {
			$activeSortedField = 'phone';
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
	<title>Работа №3, Сотрудники</title>
	<meta name="keywords" content="сотрудники, php"/>
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
				<li class="active float-left"><a href="#">Сотрудники</a></li>
			</ul>
		</div>

		<h1 class="page-title">Сотрудники</h1>

		<div class="task3-form-wrapper">

			<form action="employees-view.php" method="POST">
				<div class="clearfix">
					<label for="idEmployeeSortedField">Сортировать по полю:</label>

					<select name="employeeSortedField" id="idEmployeeSortedField" required>
						<option value="EMPLOYEE_LAST_NAME"
							<?php echo $activeSortedField == 'employeeLastName' ? 'selected' : ''?>>
							Фамилия сотрудника
						</option>
						<option value="CHAIR_NAME"
							<?php echo $activeSortedField == 'chairName' ? 'selected' : ''?>>
							Название кафедры
						</option>
						<option value="HOME_ADDRESS"
							<?php echo $activeSortedField == 'homeAddress' ? 'selected' : ''?>>
							Домашний адрес
						</option>
						<option value="AGE"
							<?php echo $activeSortedField == 'age' ? 'selected' : ''?>>
							Возраст
						</option>
						<option value="PHONE"
							<?php echo $activeSortedField == 'phone' ? 'selected' : ''?>>
							Телефон сотрудника
						</option>
					</select>
				</div>
				<div class="clearfix">
					<input type="submit" value="Сортировать" />
				</div>
			</form>

			<form action="employees-search-result.php" method="post">
				<div class="clearfix">
					<label for="idEmployeesSearchValue">Искать значение:</label>
					<input type="text" id="idEmployeesSearchValue" required
						name="employeesSearchValue" placeholder="Искомое значение">
				</div>
				<div class="clearfix">
					<label for="idEmployeeSearchField">Поле для поиска:</label>
					<select name="employeeSearchField" id="idEmployeeSearchField" required>
						<option value="EMPLOYEE_LAST_NAME">Фамилия сотрудника</option>
						<option value="CHAIR_NAME">Название кафедры</option>
						<option value="HOME_ADDRESS">Домашний адрес</option>
						<option value="AGE">Возраст</option>
						<option value="PHONE">Телефон сотрудника</option>
					</select>
				</div>
				<div>
					<input type="submit" value="Искать" />
				</div>
			</form>
			<button onclick="location.href='employees-add.php'">
				Добавить сотрудника
			</button>
		</div><!--task3-form-wrapper-->

		<?php
			try {
				include 'database.php';
				$pdo = Database::connect();
				$sql = "SELECT employeeLastName, 
						(SELECT chairs.chairName FROM chairs 
							WHERE employees.chairId = chairs.id ) AS chairName, 
						homeAddress, age, phone 
						FROM employees;";
				$res = $pdo->query($sql);
				if ($res->rowCount() == 0) { 
					echo '<div class="append-error-block">';
					echo 'Отсутствуют данные в таблице сотрудников.';
					echo '</div>';
				} else { 
		?>
		<table>
		<caption>
			Таблица сотрудников
		</caption>
		<thead>
		<tr>
			<td>Фамилия</td>
			<td>Кафедра</td>
			<td>Адрес</td>
        	<td>Возраст</td>
        	<td>Телефон</td>
		</tr>
		</thead>
		<tbody>
		<?php
				$res = $res->fetchAll();
				usort($res, Database::makeSortFunction($activeSortedField));
				foreach ($res as $row) {
					echo '<tr>';
					echo '<td>'. $row['employeeLastName'] . '</td>';
					echo '<td>'. $row['chairName'] . '</td>';
					echo '<td>'. $row['homeAddress'] . '</td>';
					echo '<td>'. $row['age'] . '</td>';
					echo '<td>'. $row['phone'] . '</td>';
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