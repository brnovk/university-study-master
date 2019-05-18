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
			filter_input($requestType, 'wagesSortedField', FILTER_SANITIZE_SPECIAL_CHARS);
		if (strcmp($rawChairSortedField, 'SALARY') == 0) {
			$activeSortedField = 'salary';
		} elseif (strcmp($rawChairSortedField, 'CREDITED') == 0) {
			$activeSortedField = 'credited';
		} elseif (strcmp($rawChairSortedField, 'WITHHELD') == 0) {
			$activeSortedField = 'withheld';
		}
	}
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8">
	<title>Лабораторная №3, Зарплата</title>
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
								<li><a href="../lab2/chairs.php">Кафедры</a></li>
								<li><a href="../lab2/employees.php">Сотрудники</a></li>
								<li><a href="../lab2/wages.php">Зарплата</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="">Лабораторная №3<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="chairs.php">Кафедры</a></li>
								<li><a href="employees.php">Сотрудники</a></li>
								<li><a href="wages.php">Зарплата</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<h3><span class="label label-success">Лабораторная №3 [БД]</span>
			<span class="label label-success">Зарплата</span></h3>
		<hr class="soften" />
		<form class="form-inline" role="form" action="wages.php" method="POST">
			<div class="form-group">
				<label for="idWagesSortedField">Сортировать по полю:</label>
				<select class="form-control" name="wagesSortedField" id="idWagesSortedField" required>
					<option value="EMPLOYEE_LAST_NAME"
						<?php echo $activeSortedField == 'employeeLastName' ? 'selected' : ''?>>
						Фамилия сотрудника
					</option>
					<option value="SALARY"
						<?php echo $activeSortedField == 'salary' ? 'selected' : ''?>>
						Оклад
					</option>
					<option value="CREDITED"
						<?php echo $activeSortedField == 'credited' ? 'selected' : ''?>>
						Начислено
					</option>
					<option value="WITHHELD"
						<?php echo $activeSortedField == 'withheld' ? 'selected' : ''?>>
						Удержано
					</option>
				</select>
			</div>
			<button type="submit" class="btn btn-warning">Сортировать</button>
		</form>
		<p>
			<form class="form-inline" role="form" action="wages-search.php" method="POST">
				<div class="form-group">
					<input type="text" class="form-control" required
						name="wagesSearchValue" placeholder="Искомое значение">
					<select name="wagesSearchField" class="form-control" required>
						<option value="EMPLOYEE_LAST_NAME">Фамилия сотрудника</option>
						<option value="SALARY">Оклад</option>
						<option value="CREDITED">Начислено</option>
						<option value="WITHHELD">Удержано</option>
					</select>
				</div>
				<button type="submit" class="btn btn-warning">Искать</button>
			</form>
		</p>
		<p>
			<a href="wages-add.php" class="btn btn-warning">Добавить зарплату</a>
		</p>
		<hr class="soften" />
		<?php
			try {
				include 'database.php';
				$pdo = Database::connect();
				$sql = 'SELECT (SELECT employees.employeeLastName FROM employees 
						WHERE wages.employeeId = employees.id) AS employeeLastName,
						salary, credited, withheld FROM wages;';
				$res = $pdo->query($sql);
				if ($res->rowCount() == 0) { 
					echo '<div class="alert alert-warning">';
					echo '<strong>Оповещение:</strong> отсутствуют данные в таблице зарплат.';
					echo '</div>';
				} else { 
		?>
		<table class="table table-condensed table-bordered">
		<caption>
			Таблица зарплат
		</caption>
		<thead>
		<tr class="success">
			<th>Фамилия</th>
			<th>Оклад</th>
			<th>Начислено</th>
			<th>Удержано</th>
		</tr>
		</thead>
		<tbody>
		<?php
				$res = $res->fetchAll();
				usort($res, Database::makeSortFunction($activeSortedField));
				foreach ($res as $row) {
					echo '<tr>';
					echo '<td>'. $row['employeeLastName'] . '</td>';
					echo '<td>'. $row['salary'] . '</td>';
					echo '<td>'. $row['credited'] . '</td>';
					echo '<td>'. $row['withheld'] . '</td>';
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
				echo '<div class="alert alert-danger">';
				echo "<strong>Ошибка соединения с БД:</strong> ". $e->getMessage();
				echo '</div>';
			}
		?>
	</div><!-- container-fluid -->
</body>
</html>