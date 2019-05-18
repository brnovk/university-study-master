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
		$rawChairSortedField = 
			filter_input($requestType, 'employeeSortedField', FILTER_SANITIZE_SPECIAL_CHARS);
		if (strcmp($rawChairSortedField, 'CHAIR_NAME') == 0) {
			$activeSortedField = 'chairName';
		} elseif (strcmp($rawChairSortedField, 'POST') == 0) {
			$activeSortedField = 'post';
		} elseif (strcmp($rawChairSortedField, 'HOME_ADDRESS') == 0) {
			$activeSortedField = 'homeAddress';
		} elseif (strcmp($rawChairSortedField, 'PHONE') == 0) {
			$activeSortedField = 'phone';
		}
	}
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8">
	<title>Лабораторная №2, Сотрудники</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--[if lt IE 9]>
		<strong>Внимание!</strong><br>Internet Explorer версии ниже 9-ой не поддерживаются сайтом!
	<![endif]-->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" 
		type="text/javascript" charset="utf-8" async defer></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" 
		type="text/javascript" charset="utf-8" async defer></script>
</head>
<body>
	<div class="container-fluid">

		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header"><a class="navbar-brand" href="../index.html">Главная</a></div>
				<div>
					<ul class="nav navbar-nav">
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="">Лабораторная №1.1<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="../lab11/chairs.php">Кафедры</a></li>
								<li><a href="../lab11/employees.php">Сотрудники</a></li>
								<li><a href="../lab11/wages.php">Зарплата</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="">Лабораторная №1.2<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="../lab12/chairs.php">Кафедры</a></li>
								<li><a href="../lab12/employees.php">Сотрудники</a></li>
								<li><a href="../lab12/wages.php">Зарплата</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="">Лабораторная №2<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="chairs.php">Кафедры</a></li>
								<li><a href="employees.php">Сотрудники</a></li>
								<li><a href="wages.php">Зарплата</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="">Лабораторная №3<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="../lab3/chairs.php">Кафедры</a></li>
								<li><a href="../lab3/employees.php">Сотрудники</a></li>
								<li><a href="../lab3/wages.php">Зарплата</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<h3><span class="label label-success">Лабораторная №2 [Файл]</span>
			<span class="label label-success">Сотрудники</span></h3>
		<hr class="soften" />
		<form class="form-inline" role="form" action="employees.php" method="POST">
			<div class="form-group">
				<label for="idEmployeeSortedField">Сортировать по полю:</label>
				<select class="form-control" name="employeeSortedField" id="idEmployeeSortedField" required>
					<option value="EMPLOYEE_LAST_NAME"
						<?php echo $activeSortedField == 'employeeLastName' ? 'selected' : ''?>>
						Фамилия сотрудника
					</option>
					<option value="CHAIR_NAME"
						<?php echo $activeSortedField == 'chairName' ? 'selected' : ''?>>
						Название кафедры
					</option>
					<option value="POST"
						<?php echo $activeSortedField == 'post' ? 'selected' : ''?>>
						Должность
					</option>
					<option value="HOME_ADDRESS"
						<?php echo $activeSortedField == 'homeAddress' ? 'selected' : ''?>>
						Домашний адрес
					</option>
					<option value="PHONE"
						<?php echo $activeSortedField == 'phone' ? 'selected' : ''?>>
						Телефон сотрудника
					</option>
				</select>
			</div>
			<button type="submit" class="btn btn-warning">Сортировать</button>
		</form>
		<p>
			<form class="form-inline" role="form" action="employees-search.php" method="POST">
				<div class="form-group">
					<input type="text" class="form-control" required
						name="employeesSearchValue" placeholder="Искомое значение">
					<select name="employeeSearchField" class="form-control" required>
						<option value="EMPLOYEE_LAST_NAME">Фамилия сотрудника</option>
						<option value="CHAIR_NAME">Название кафедры</option>
						<option value="POST">Должность</option>
						<option value="HOME_ADDRESS">Адрес</option>
						<option value="PHONE">Телефон сотрудника</option>
					</select>
				</div>
				<button type="submit" class="btn btn-warning">Искать</button>
			</form>
		</p>
		<p>
			<a href="employees-add.php" class="btn btn-warning">Добавить сотрудника</a>
		</p>
		<hr class="soften" />
		<?php
			require 'file-handler.php';
			$res = getEmployees();
			if (empty($res) || count($res) == 0) { 
				echo '<div class="alert alert-warning">';
				echo '<strong>Оповещение:</strong> отсутствуют данные в таблице сотрудников.';
				echo '</div>';
			} else { 
		?>
		<table class="table table-condensed table-bordered">
		<caption>
			Таблица сотрудников
		</caption>
		<thead>
		<tr class="success">
			<th>Фамилия</th>
			<th>Кафедра</th>
			<th>Должность</th>
			<th>Адрес</th>
			<th>Телефон</th>
		</tr>
		</thead>
		<tbody>
		<?php
			usort($res, makeSortFunction($activeSortedField));
			foreach ($res as $row) {
				echo '<tr>';
				echo '<td>'. $row['employeeLastName'] . '</td>';
				echo '<td>'. $row['chairName'] . '</td>';
				echo '<td>'. $row['post'] . '</td>';
				echo '<td>'. $row['homeAddress'] . '</td>';
				echo '<td>'. $row['phone'] . '</td>';
				echo '</tr>';
			}
		?>
		</tbody>
		</table>
		<?php } ?>
	</div><!-- container-fluid -->
</body>
</html>