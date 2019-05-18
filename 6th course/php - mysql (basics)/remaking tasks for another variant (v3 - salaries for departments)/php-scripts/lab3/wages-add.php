<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'database.php';
	$valid = true;
	$requestType = '';
	$errors = '';
	$appendEmployeeLastName = null;
	$appendSalary = null;
	$appendCredited = null;
	$appendWithheld = null;
	$employeeList = null;
	try {
		$pdo = Database::connect();
		$sql = 'SELECT employeeLastName FROM employees
				LEFT OUTER JOIN wages ON wages.id = employees.id
				WHERE wages.employeeId is null;';
		$employeeList = $pdo->query($sql);
		if ($employeeList->rowCount() == 0) {
			$errors .= 'В таблице сотрудников нет сотрудников с отсутствующей зарплатой.<br>';
			$employeeList = null;
		} else {
			$employeeList = $employeeList->fetchAll();
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
		$rawAppendEmployeeLastName = 
			filter_input($requestType, 'appendEmployeeLastName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendSalary = 
			filter_input($requestType, 'appendSalary', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendCredited = 
			filter_input($requestType, 'appendCredited', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendWithheld = 
			filter_input($requestType, 'appendWithheld', FILTER_SANITIZE_SPECIAL_CHARS);

		$appendEmployeeLastName = normalizeText($rawAppendEmployeeLastName);		
		if (empty($appendEmployeeLastName) && $appendEmployeeLastName !== '0') {
			$errors .= 'Не указана фамилия сотрудника.<br>';
			$valid = false;
		}
		$appendSalary = normalizeText($rawAppendSalary);
		if (empty($appendSalary) && $appendSalary !== '0') {
			$errors .= 'Не указан оклад.<br>';
			$valid = false;
		} elseif (!is_numeric($appendSalary) 
			|| (int)$appendSalary != $appendSalary 
			|| (int)$appendSalary <= 0 ) {

			$errors .= 'Оклад должен быть положительным целым числом.<br>';
			$valid = false;
		}
		$appendCredited = normalizeText($rawAppendCredited);
		if (empty($appendCredited) && $appendCredited !== '0') {
			// Поле не обязательное, поэтому null
			$appendCredited = null;
		} elseif (!is_numeric($appendCredited) 
			|| (int)$appendCredited != $appendCredited 
			|| (int)$appendCredited <= 0 ) {

			$errors .= '"Начислено" должно быть положительным целым числом.<br>';
			$valid = false;
		}
		$appendWithheld = normalizeText($rawAppendWithheld);
		if (empty($appendWithheld) && $appendWithheld !== '0') {
			// Поле не обязательное, поэтому null
			$appendWithheld = null;
		} elseif (!is_numeric($appendWithheld) 
			|| (int)$appendWithheld != $appendWithheld 
			|| (int)$appendWithheld <= 0 ) {

			$errors .= '"Удержано" должно быть положительным целым числом.<br>';
			$valid = false;
		}

		if ($valid) {
			try {
				$pdo = Database::connect();
				$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$sql = "INSERT INTO wages (salary, credited, withheld, employeeId)
						VALUES (?, ?, ?, (SELECT employees.id FROM employees 
						WHERE employees.employeeLastName = ? ));";
				$q = $pdo->prepare($sql);
				$q->execute(array(
					$appendSalary,
					$appendCredited,
					$appendWithheld,
					$appendEmployeeLastName));
				Database::disconnect();
				header("Location: wages.php");
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
	<title>Лабораторная №3, Добавление зарплаты</title>
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
			<span class="label label-success">Добавление зарплаты</span></h3>
		<hr class="soften" />
		<?php if (!empty($errors)): ?>
			<div class="alert alert-danger">
				<?php echo $errors;?>
			</div>
			<hr class="soften" />
		<?php endif; ?>
		<?php if (!is_null($employeeList)) { ?>
			<p>
				<form role="form" action="wages-add.php" method="POST">
					<div class="form-group">
						<label for="idAppendEmployeeLastName">
							<strong>*</strong> Фамилия сотрудника:</label>
						<select name="appendEmployeeLastName" id="idAppendEmployeeLastName" 
							class="form-control" required>
						<?php 
							if (!is_null($employeeList)) {
								foreach ($employeeList as $currentEmployee) {
									echo '<option value="'
										.$currentEmployee['employeeLastName']
										.'">'.$currentEmployee['employeeLastName']
										.'</option>';
								}
							}
						 ?>
						</select>
					</div>
					<div class="form-group">
						<label for="idAppendSalary"><strong>*</strong> Оклад:</label>
						<input type="text" id="idAppendSalary" class="form-control" 
							name="appendSalary" placeholder="Оклад" required
							value="<?php echo !is_null($appendSalary)?$appendSalary:'';?>">
					</div>
					<div class="form-group">
						<label for="idAppendCredited">Начислено:</label>
						<input type="text" id="idAppendCredited" class="form-control" 
							name="appendCredited" placeholder="Начислено"
							value="<?php echo !is_null($appendCredited)?$appendCredited:'';?>">
					</div>
					<div class="form-group">
						<label for="idAppendWithheld">Удержано:</label>
						<input type="text" id="idAppendWithheld" class="form-control" 
							name="appendWithheld" placeholder="Удержано"
							value="<?php echo !is_null($appendWithheld)?$appendWithheld:'';?>">
					</div>
					<a href="wages.php" class="btn btn-default">Назад</a>
					<button type="submit" class="btn btn-warning">Добавить зарплату</button>
				</form>
			</p>
		<?php } else { ?>
			<a href="wages.php" class="btn btn-default">Назад</a>
		<?php } ?>
	</div><!-- container-fluid -->
</body>
</html>