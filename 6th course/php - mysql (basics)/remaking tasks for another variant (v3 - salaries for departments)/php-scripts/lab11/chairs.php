<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8">
	<title>Лабораторная №1.1, Кафедры</title>
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
								<li><a href="chairs.php">Кафедры</a></li>
								<li><a href="employees.php">Сотрудники</a></li>
								<li><a href="wages.php">Зарплата</a></li>
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
								<li><a href="../lab3/chairs.php">Кафедры</a></li>
								<li><a href="../lab3/employees.php">Сотрудники</a></li>
								<li><a href="../lab3/wages.php">Зарплата</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<h3><span class="label label-success">Лабораторная №1.1 [В разных файлах]</span>
			<span class="label label-success">Кафедры</span></h3>
		<h3><span class="label label-success">Способ передачи [строковая переменная]</span></h3>
		<h3><span class="label label-success">Хранение [в сессии]</span></h3>
		<hr class="soften" />
		<form role="form" action="chairs-handler.php" method="POST">
			<div class="form-group">
				<label for="idChairName">
					<strong>*</strong> Название кафедры:</label>
				<input type="text" id="idChairName" 
					name="chairsName" class="form-control" 
					placeholder="Название кафедры" required autofocus>
			</div>
			<div class="form-group">
				<label for="idChairHead">Заведующий кафедрой:</label>
				<input type="text" id="idChairHead" class="form-control" 
					name="chairsHead" placeholder="Заведующий кафедрой">
			</div>
			<div class="form-group">
				<label for="idChairPhone">Телефон кафедры:</label>
				<input type="text" id="idChairPhone" class="form-control"
					name="chairsPhone" placeholder="Телефон кафедры">
			</div>
			<input type="reset" class="btn btn-warning" name="reset" value="Очистить">
			<button type="submit" class="btn btn-warning">Добавить кафедру</button>
		</form>
		<hr class="soften" />
		<?php
			if (!isset($_SESSION['task1-chair-table'])) {
				echo '<div class="alert alert-warning">';
				echo '<strong>Оповещение:</strong> отсутствуют данные в таблице кафедр.';
				echo '</div>';
			} else { 
		?>
		<table class="table table-condensed table-bordered">
		<caption>
			Таблица кафедр
		</caption>
		<thead>
		<tr class="success">
			<th>Название</th>
			<th>Заведующий</th>
			<th>Телефон</th>
		</tr>
		</thead>
		<tbody>
		<?php
			$rows = preg_split('/\~/', 
				$_SESSION['task1-chair-table'], NULL, PREG_SPLIT_NO_EMPTY);
			foreach ($rows as $row) {
				echo '<tr>';
				$values = preg_split('/===/', $row, NULL, 
					PREG_SPLIT_NO_EMPTY);
				foreach ($values as $currentValue) {
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