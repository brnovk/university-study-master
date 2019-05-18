<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'database.php';
	$valid = true;
	$requestType = '';
	$errors = '';
	$appendChairName = null;
	$appendChairHead = null;
	$appendChairPhone = null;
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawAppendChairName = 
			filter_input($requestType, 'appendChairName', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairHead = 
			filter_input($requestType, 'appendChairHead', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawAppendChairPhone = 
			filter_input($requestType, 'appendChairPhone', FILTER_SANITIZE_SPECIAL_CHARS);
		$appendChairName = normalizeText($rawAppendChairName);
		if (empty($appendChairName) && $appendChairName !== '0') {
			$errors .= 'Не указано название кафедры.<br>';
			$valid = false;
		}
		$appendChairHead = normalizeText($rawAppendChairHead);
		if (empty($appendChairHead) && $appendChairHead !== '0') {
			// Поле не обязательное, поэтому null
			$appendChairHead = null;
		}
		$appendChairPhone = normalizeText($rawAppendChairPhone);
		if (empty($appendChairPhone) && $appendChairPhone !== '0') {
			// Поле не обязательное, поэтому null
			$appendChairPhone = null;
		}
		if ($valid) {
			try {
				$pdo = Database::connect();
				$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$sql = "INSERT INTO chairs (chairName, chairHead, chairPhone)
						VALUES (?, ?, ?);";
				$q = $pdo->prepare($sql);
				$q->execute(array(
					$appendChairName,
					$appendChairHead,
					$appendChairPhone));
				Database::disconnect();
				header("Location: chairs.php");
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
	<title>Лабораторная №3, Добавление кафедры</title>
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
			<span class="label label-success">Добавление кафедры</span></h3>
		<hr class="soften" />
		<?php if (!empty($errors)): ?>
			<div class="alert alert-danger">
				<?php echo $errors;?>
			</div>
			<hr class="soften" />
		<?php endif; ?>
		<form role="form" action="chairs-add.php" method="POST">
			<div class="form-group">
				<label for="idAppendChairName">
					<strong>*</strong> Название кафедры:</label>
				<input type="text" id="idAppendChairName" 
					name="appendChairName" class="form-control" 
					placeholder="Название кафедры" required
					value="<?php echo !is_null($appendChairName)?$appendChairName:'';?>">
			</div>
			<div class="form-group">
				<label for="idAppendChairHead">Заведующий кафедрой:</label>
				<input type="text" id="idAppendChairHead" class="form-control" 
					name="appendChairHead" placeholder="Заведующий кафедрой"
					value="<?php echo !is_null($appendChairHead)?$appendChairHead:'';?>">
			</div>
			<div class="form-group">
				<label for="idAppendChairPhone">Телефон кафедры:</label>
				<input type="text" id="idAppendChairPhone" class="form-control"
					name="appendChairPhone" placeholder="Телефон кафедры"
					value="<?php echo !is_null($appendChairPhone)?$appendChairPhone:'';?>">
			</div>
			<a href="chairs.php" class="btn btn-default">Назад</a>
			<button type="submit" class="btn btn-warning">Добавить кафедру</button>
		</form>
	</div>
</body>
</html>