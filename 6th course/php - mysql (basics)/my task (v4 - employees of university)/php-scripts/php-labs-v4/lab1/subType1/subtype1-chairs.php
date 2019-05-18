<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
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
	<title>Работа №1, Версия 1 (Кафедры)</title>
	<meta name="keywords" content="кафедры, php"/>
	<meta name="description" content="Страница с работой №1, версия 1"/>
	<link rel="stylesheet" href="../../../styles/style.css">
</head>
<body>
<div class="page-wrapper">

	<header class="page-header clearfix">

		<div class="header-left-link float-left" title="На страницу с заданием">
			<a href="../lab1-index.html">
				&lt; К заданию
			</a>
		</div><!-- header-left-link-->

		<div class="description-header-page float-left">
			<strong>№ работы:</strong> 1, 
			<strong>Версия:</strong> 1<br>
			<strong>Способ храния данных на сервере:</strong> сессия<br>
			<strong>Тип размещения:</strong> Форма и скрипт в разных файлах<br>
			<strong>Способ передачи данных:</strong> в индексном массиве
		</div><!-- description-header-page -->

		<div class="header-right-link float-rigth">
			<a href="../../lab2/lab/faculties-view.php" title="На страницу с работой №2">Работа №2 &gt;</a>
		</div><!-- header-right-link -->
	</header><!-- page-header -->

	<main class="page-main">

		<h1 class="page-title">Кафедры</h1>

		<div class="clearfix">

			<div class="task1-form-wrapper float-left">

				<form class="task1-form" action="subtype1-chairs-handler.php"
					method="post">

					<div>
						<label for="idFacultyName">
							Название факультета <strong>*</strong>
						</label>
						<input type="text" name="facultyName" id="idFacultyName" 
							placeholder="Название факультета" tabindex="1" 
							autofocus required/>
					</div>

					<div>
						<label for="idChairsName">
							Название кафедры <strong>*</strong>
						</label>
						<input type="text" name="chairsName" id="idChairsName" 
							placeholder="Название кафедры" tabindex="2" required/>
					</div>

					<div>
						<label for="idChairsHead">Заведующий кафедрой</label>
						<input type="text" name="chairsHead" id="idChairsHead" 
							placeholder="Заведующий кафедрой" tabindex="3"/>
					</div>

					<div>
						<label for="idChairsPhone">Телефон кафедры</label>
						<input type="text" name="chairsPhone" id="idChairsPhone" 
							placeholder="Телефон кафедры" tabindex="4"/>
					</div>

					<div>
						<input type="reset" name="resetButton" value="Очистить">
						<input type="submit" tabindex="5" value="Отправить"/>
					</div>

					<div>
						<p><strong>*</strong> - обязательные поля</p>
					</div>
				</form><!-- task1-form -->
			</div><!-- task1-form-wrapper -->

			<div class="vertical-menu-wrapper float-rigth">
				<ul class="menu-list">
					<li><a href="subtype1-facultet.php">Факультеты</a></li>
					<li class="active"><a href="#">Кафедры</a></li>
					<li><a href="subtype1-employees.php">Сотрудники</a></li>
				</ul>
				<a class="task1-link-version" href="../subType2/subtype2-chairs.php"
					title="Перейти к работе №1 версии 2">
					Работа №1 версии 2 &gt;&gt;
				</a>
			</div>
		</div>

		<?php

			if (!defined('OPEN_ROW')) {
			    define('OPEN_ROW', '<tr>'.PHP_EOL);
			}
			if (!defined('CLOSE_ROW')) {
			    define('CLOSE_ROW', '</tr>'.PHP_EOL);
			}
			if (!defined('OPEN_COL')) {
			    define('OPEN_COL', '<td>'.PHP_EOL);
			}
			if (!defined('CLOSE_COL')) {
			    define('CLOSE_COL', PHP_EOL.'</td>'.PHP_EOL);
			}

			if (isset($_SESSION['task1-chairs-table'])) {

				echo '<table>'.PHP_EOL;
					echo '<caption>'.PHP_EOL;
						echo 'Таблица кафедр';
					echo PHP_EOL.'</caption>'.PHP_EOL;
					echo '<thead>'.PHP_EOL;
						echo OPEN_ROW;
							echo OPEN_COL;
								echo 'Название факультета';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Название кафедры';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Заведующий кафедрой';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Телефон кафедры';
							echo CLOSE_COL;
						echo CLOSE_ROW;
					echo '</thead>'.PHP_EOL;
					echo '<tbody>'.PHP_EOL;
					$table = $_SESSION['task1-chairs-table'];
				foreach ($table as $currentRow) {
					echo OPEN_ROW;
					foreach ($currentRow as $currentValue) {
						echo OPEN_COL;
							echo $currentValue;
						echo CLOSE_COL;
					}
					echo CLOSE_ROW;
				}
				echo '</tbody>'.PHP_EOL;
				echo '</table>'.PHP_EOL;
			}
		?>
	</main><!-- page-main -->
</div><!-- page-wrapper -->
</body>
</html>