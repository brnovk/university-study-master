<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';
	$valid = true;
	$requestType = '';
	$errors = '';
	$appendEmployeeLastName = null;
	$appendChairName = null;
	$appendPost = null;
	$appendHomeAddress = null;
	$appendPhone = null;

	$chairList = getChairs();
	if (empty($chairList) || count($chairList) == 0) { 
		$errors .= 'В таблице кафедр нет ни одной записи.<br>';
		$chairList = null;
	}

	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawAppendEmployeeLastName = 
			filter_input($requestType, 'appendEmployeeLastName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairName = 
			filter_input($requestType, 'appendChairName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendPost = 
			filter_input($requestType, 'appendPost', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendHomeAddress = 
			filter_input($requestType, 'appendHomeAddress', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendPhone = 
			filter_input($requestType, 'appendPhone', FILTER_SANITIZE_SPECIAL_CHARS);
		$appendEmployeeLastName = normalizeText($rawAppendEmployeeLastName);
		if (empty($appendEmployeeLastName) && $appendEmployeeLastName !== '0') {
			$errors .= 'Не указана фамилия сотрудника.<br>';
			$valid = false;
		}
		$appendChairName = normalizeText($rawAppendChairName);
		if (empty($appendChairName) && $appendChairName !== '0') {
			$errors .= 'Не указана кафедра.<br>';
			$valid = false;
		}
		$appendHomeAddress = normalizeText($rawAppendHomeAddress);
		if (empty($appendHomeAddress) && $appendHomeAddress !== '0') {
			// Поле не обязательное, поэтому null
			$appendHomeAddress = null;
		}
		$appendPost = normalizeText($rawAppendPost);
		if (empty($appendPost) && $appendPost !== '0') {
			// Поле не обязательное, поэтому null
			$appendPost = null;
		}
		$appendPhone = normalizeText($rawAppendPhone);
		if (empty($appendPhone) && $appendPhone !== '0') {
			// Поле не обязательное, поэтому null
			$appendPhone = null;
		}
		if ($valid) {
			$res = addEmployee($appendEmployeeLastName,$appendPost,$appendHomeAddress,$appendPhone,
					$appendChairName);
			if (!is_null($res)) {
				$errors .= 'Ошибка добавления сотрудника: '.$res.'<br>';
			} else {
				header("Location: employees.php");
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
	<title>Лабораторная №2, Добавление сотрудника</title>
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
			<span class="label label-success">Добавление сотрудника</span></h3>
		<hr class="soften" />
		<?php if (!empty($errors)): ?>
			<div class="alert alert-danger">
				<?php echo $errors;?>
			</div>
			<hr class="soften" />
		<?php endif; ?>
		<form role="form" action="employees-add.php" method="POST">
			<div class="form-group">
				<label for="idAppendEmployeeLastName">
					<strong>*</strong> Фамилия сотрудника:</label>
				<input type="text" id="idAppendEmployeeLastName" class="form-control" 
					name="appendEmployeeLastName" placeholder="Фамилия сотрудника" required
					value="<?php echo !is_null($appendEmployeeLastName)?$appendEmployeeLastName:'';?>">
			</div>
			<div class="form-group">
				<label for="idAppendChairName">
					<strong>*</strong> Кафедра:</label>
				<select name="appendChairName" id="idAppendChairName" class="form-control" required>
				<?php 
					if (!is_null($chairList)) {
						foreach ($chairList as $currentChair) {
							echo '<option value="'
								.$currentChair['chairName']
								.'">'.$currentChair['chairName']
								.'</option>';
						}
					}
				 ?>
				</select>
			</div>
			<div class="form-group">
				<label for="idAppendPost"><strong>*</strong> Должность:</label>
				<select name="appendPost" id="idAppendPost" class="form-control" required>
					<option value="ассистент">ассистент</option>
					<option value="доцент">доцент</option>
					<option value="профессор">профессор</option>
				</select>
			</div>
			<div class="form-group">
				<label for="idAppendHomeAddress">Домашний адрес:</label>
				<input type="text" id="idAppendHomeAddress" class="form-control" 
					name="appendHomeAddress" placeholder="Домашний адрес"
					value="<?php echo !is_null($appendHomeAddress)?$appendHomeAddress:'';?>">
			</div>
			<div class="form-group">
				<label for="idAppendPhone">Телефон сотрудника:</label>
				<input type="text" id="idAppendPhone" class="form-control" 
					name="appendPhone" placeholder="Телефон сотрудника"
					value="<?php echo !is_null($appendPhone)?$appendPhone:'';?>">
			</div>
			<a href="employees.php" class="btn btn-default">Назад</a>
			<button type="submit" class="btn btn-warning">Добавить сотрудника</button>
		</form>
	</div><!-- container-fluid -->
</body>
</html>