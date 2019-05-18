<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}

	$isFirstRequest = false;
	
	$requestType = '';
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	} else {
		$isFirstRequest = true;
	}
	if (!$isFirstRequest) {
		$rawEmployeeLastName = 
			filter_input($requestType, 'employeeLastName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawSalary = 
			filter_input($requestType, 'salary', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawCredited = 
		    filter_input($requestType, 'credited', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawWithheld = 
		    filter_input($requestType, 'withheld', FILTER_SANITIZE_SPECIAL_CHARS);

		$employeeLastName = normalizeText($rawEmployeeLastName);
		$employeeLastName = (empty($employeeLastName) ? '<Не указан>' : $employeeLastName);

		$salary = normalizeText($rawSalary);
		$salary = (empty($salary) ? '<Не указан>' : $salary);

		$credited = normalizeText($rawCredited);
		$credited = (empty($credited) ? '<Не указан>' : $credited);

		$withheld = normalizeText($rawWithheld);
		$withheld = (empty($withheld) ? '<Не указан>' : $withheld);

		$arrayRow = array(
		    'employeeLastName'=>$employeeLastName, 
		    'salary'=>$salary, 
		    'credited'=>$credited,
		    'withheld'=>$withheld);

		$arrayParams;
		if (isset($_SESSION['task1-wages-table'])) {
		    $arrayParams = $_SESSION['task1-wages-table'];
		}
		$arrayParams[] = $arrayRow;
		$_SESSION['task1-wages-table'] = $arrayParams;
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
	<title>Лабораторная №1.2, Зарплаты</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--[if lt IE 9]>
		<strong>Внимание!</strong><br>Internet Explorer версии ниже 9-ой не поддерживаются сайтом!
	<![endif]-->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js" 
		type="text/javascript" charset="utf-8" async defer></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" 
		type="text/javascript" charset="utf-8" async defer></script>
	<script type="text/javascript">

		/**
		 * Проверка при отправке
		 */
		function checkedOnSend(idEmployeeLastName, idSalary, idCredited, idWithheld) {
			var employeeLastName = document.getElementById(idEmployeeLastName).value;
			var salary = document.getElementById(idSalary).value;
			var credited = document.getElementById(idCredited).value;
			var withheld = document.getElementById(idWithheld).value;
			var valid = true;
			var errors = "";
			var err = document.getElementById('er');
			while(err.firstChild) {
			    err.removeChild(err.firstChild);
			}
			if (isBlank(employeeLastName)) {
				errors += "<strong>Фамилия сотрудника</strong> не указана.<br>";
				valid = false;
			}
			if (isBlank(salary)) {
				errors += "<strong>Оклад</strong> не указан.<br>";
				valid = false;
			}
			if (!isInteger(parseInt(salary))) {
				errors += "<strong>Оклад</strong> должен быть целым числом.<br>";
				valid = false;
			}
			if (!isBlank(credited)) {
				if (!isInteger(parseInt(credited))) {
					errors += "<strong>\"Начислено\"</strong> должно быть целым числом.<br>";
					valid = false;
				}
			}
			if (!isBlank(withheld)) {
				if (!isInteger(parseInt(withheld))) {
					errors += "<strong>\"Удержано\"</strong> должно быть целым числом.<br>";
					valid = false;
				}
			}
			if (!valid) {
				err.innerHTML += '<div class="alert alert-danger">'+ errors +'</div>';
				return valid;
			}
		}
		function isBlank(str) {
			return (!str || /^\s*$/.test(str));
		}

		function isInteger(num) {
			return (num ^ 0) === num;
		}
	</script>
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
								<li><a href="chairs.php">Кафедры</a></li>
								<li><a href="employees.php">Сотрудники</a></li>
								<li><a href="wages.php">Зарплата</a></li>
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
								<li><a href="../lab3/chairs.php">Кафедры</a></li>
								<li><a href="../lab3/employees.php">Сотрудники</a></li>
								<li><a href="../lab3/wages.php">Зарплата</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<h3><span class="label label-success">Лабораторная №1.2 [В одном файле]</span>
			<span class="label label-success">Зарплаты</span></h3>
		<h3><span class="label label-success">Способ передачи [в ассоциативном массиве]</span></h3>
		<h3><span class="label label-success">Хранение [в сессии]</span></h3>
		<hr class="soften" />
		<div id="er"></div>
		<form role="form" action="wages-handler.php" method="POST" 
			onsubmit="return checkedOnSend('idEmployeeLastName','idSalary','idCredited','idWithheld');">
			<div class="form-group">
				<label for="idEmployeeLastName">
					<strong>*</strong> Фамилия сотрудника:</label>
				<input type="text" id="idEmployeeLastName" 
					name="employeeLastName" class="form-control" 
					placeholder="Фамилия сотрудника" required autofocus>
			</div>
			<div class="form-group">
				<label for="idSalary">
					<strong>*</strong> Оклад:</label>
				<input type="text" id="idSalary" class="form-control" 
					name="salary" placeholder="Оклад" required>
			</div>
			<div class="form-group">
				<label for="idCredited">Начислено:</label>
				<input type="text" id="idCredited" class="form-control"
					name="credited" placeholder="Начислено">
			</div>
			<div class="form-group">
				<label for="idWithheld">Удержано:</label>
				<input type="text" id="idWithheld" class="form-control"
					name="withheld" placeholder="Удержано">
			</div>
			<input type="reset" class="btn btn-warning" name="reset" value="Очистить">
			<button type="submit" class="btn btn-warning">Добавить зарплату</button>
		</form>
		<hr class="soften" />
		<?php
			if (!isset($_SESSION['task1-wages-table'])) {
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
			$table = $_SESSION['task1-wages-table'];
			foreach ($table as $row) {
				echo '<tr>';
				foreach ($row as $currentValue) {
					echo '<td>'. $currentValue . '</td>';
				}
				echo '</tr>';
			}
		?>
		</tbody>
		</table>
		<?php } ?>
	</div><!-- container-fluid -->
</body>
</html>