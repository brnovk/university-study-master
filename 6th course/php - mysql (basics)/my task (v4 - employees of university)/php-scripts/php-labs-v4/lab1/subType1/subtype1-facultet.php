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
	<title>Работа №1, Версия 1 (Факультеты)</title>
	<meta name="keywords" content="факультеты, php"/>
	<meta name="description" content="Страница с работой №1, версия 1"/>
	<link rel="stylesheet" href="../../../styles/style.css">
	<script src="../lab1-facultet-js/lab1-facultet-js.js"></script>
</head>
<body onload="changeSelect(); changeDeleteBlock();">
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
			<strong>Способ передачи данных:</strong> в строковой переменной
		</div><!-- description-header-page -->

		<div class="header-right-link float-rigth">
			<a href="../../lab2/lab/faculties-view.php" title="На страницу с работой №2">Работа №2 &gt;</a>
		</div><!-- header-right-link -->
	</header><!-- page-header -->

	<main class="page-main">

		<h1 class="page-title">Факультеты</h1>

		<div class="clearfix">

			<div class="task1-form-wrapper float-left">

				<form class="task1-form" action="subtype1-facultet-handler.php"
					name="subtype1-subtask1-form" method="post"
					onsubmit="return checkedOnSend('idFacultyName');">

					<div>
						<label for="idFacultyName">
							Название факультета <strong>*</strong>
						</label>
						<input type="text" name="facultyName" id="idFacultyName" 
							placeholder="Название факультета" tabindex="1" 
							autofocus required/>
					</div>

					<div>
						<label for="idFacultyDean">
							Декан факультета <strong>*</strong>
						</label>
						<input type="text" name="facultyDean" id="idFacultyDean" 
							placeholder="Декан факультета" tabindex="2" required/>
					</div>

					<div>
						<label for="idPhoneDean">Телефон деканата</label>
						<input type="text" name="phoneDean" id="idPhoneDean" 
							placeholder="Телефон деканата" tabindex="3"/>
					</div>

					<div class="clearfix">

						<div class="float-left">
							<label for="idNumberChairs">
								Кол-во кафедр <strong>*</strong>
							</label>
							<select name="numberChairs" id="idNumberChairs"
								tabindex="4" required>
							</select>
						</div>

						<div class="float-rigth visible-block"
							id="idSelectProcessingManagement">

						    <div class="clearfix">

						        <div class="entry-checkbox-buttons">
						            <input type="checkbox" name="deleteFromList" 
										id="idDeleteFromList" value="Delete" 
										onclick="showDeleteBlock();">
									<label for="idDeleteFromList">Удалить</label>
						        </div>

						        <div class="entry-checkbox-buttons">
									<input type="checkbox" name="appendToList" 
										id="idAppendToList" value="Append"
										onclick="showAppendBlock();">
									<label for="idAppendToList">Добавить</label>
						        </div>
						    </div>
						</div>

						<div class="float-rigth invisible-block"
							id="idAppendBlock">

							<div class="clearfix">

								<input type="text" class="append-value-block float-left"
									name="addNumberChairs" id="idAddNumberСhairs" 
									placeholder="Кол-во кафедр"
									onkeydown="checkedInterringSymbols(event);"
									onblur="checkedOnBlur('idAddNumberСhairs');" />

								<button class="append-value-block float-rigth"
									id="idCancelAppend" type="button"
									onclick="cancelShowAppendBlock();">
									Отмена
								</button>

								<button class="append-value-block float-rigth"
									id="idAddNumberСhairsButton" type="button"
									onclick="appendValToList();">
									Добавить
								</button>
							</div>
						</div>

						<div class="float-rigth invisible-block" id="idDeleteCancel">
							
							<div class="clearfix">
								
								<button class="append-value-block float-rigth"
									type="button" onclick="cancelShowDeleteBlock();">
									Отмена
								</button>
							</div>
						</div>
					</div>

					<div class="invisible-block" id="idDeleteBlock">
					</div>

					<?php
						if (isset($_SESSION['task1-facultet-hiddenList'])) {
							$listParameters = 
								$_SESSION['task1-facultet-hiddenList'];
							echo '<input type="hidden" id="idHiddenField" 
								name="hiddenFieldNumberChairs" value="';
							foreach ($listParameters as $currentValue) {
								echo $currentValue.' ';
							}
							echo '">';
						} else {
							echo '<input type="hidden" id="idHiddenField" 
							name="hiddenFieldNumberChairs" value="1">';
						}
					?>
					
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
					<li class="active"><a href="#">Факультеты</a></li>
					<li><a href="subtype1-chairs.php">Кафедры</a></li>
					<li><a href="subtype1-employees.php">Сотрудники</a></li>
				</ul>
				<a class="task1-link-version" href="../subType2/subtype2-facultet.php"
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
			if (isset($_SESSION['task1-facultet-table'])) {

				echo '<table>'.PHP_EOL;
					echo '<caption>'.PHP_EOL;
						echo 'Таблица факультетов';
					echo PHP_EOL.'</caption>'.PHP_EOL;
					echo '<thead>'.PHP_EOL;
						echo OPEN_ROW;
							echo OPEN_COL;
								echo 'Название факультета';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Декан факультета';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Телефон деканата';
							echo CLOSE_COL;
							echo OPEN_COL;
								echo 'Количество кафедр';
							echo CLOSE_COL;
						echo CLOSE_ROW;
					echo '</thead>'.PHP_EOL;
					echo '<tbody>'.PHP_EOL;

				$rows = preg_split('/\~/', 
					$_SESSION['task1-facultet-table'], NULL, PREG_SPLIT_NO_EMPTY);

				foreach ($rows as $currentRow) {
					echo OPEN_ROW;
					$values = preg_split('/===/', $currentRow, NULL, 
						PREG_SPLIT_NO_EMPTY);
					foreach ($values as $currentValue) {
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