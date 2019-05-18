<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
?>
<!DOCTYPE html>
<html lang="ru">
<head>
	<meta charset="utf-8">
	<title>Лабораторная №1.1, Сотрудники</title>
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
		function postClick() {
			var sel = document.getElementById("idPost");
			var length = sel.options.length-1;
			for (i = length; i >= 0; i--) {
			  sel.options[i] = null;
			}
			var cboxes = document.getElementsByClassName('manageCheckbox');
		    var len = cboxes.length;
		    for (var i=0; i<len; i++) {
		    	if (cboxes[i].checked) {
					var opt = document.createElement('option');
					opt.value = cboxes[i].value;
					opt.innerHTML = cboxes[i].value;
					sel.appendChild(opt);
		    	}
		    }
		}

		function chColor(cl) {
			var elements = document.getElementsByTagName("input");
			var length = elements.length-1;
			for (i = length; i >= 0; i--) {
				if (elements[i].type == 'text') {
					elements[i].setAttribute("style", cl.value);
				}
			}
		}

		/**
		 * Проверка вводимых символов
		 */
		function cp(e) {
			var cp = document.getElementById("cp");
			while(cp.firstChild) {
			    cp.removeChild(cp.firstChild);
			}
			var key = e.keyCode || e.which;
			if ((key == 48)||(key == 49)||(key == 50)||(key == 51)||(key == 52)||(key == 53)||
				(key == 54)||(key == 55)||(key == 56)||(key == 57)) {
				cp.appendChild(
					document.createTextNode(
						" (!!! Введена цифра. В поле фамилии маловероятно наличие цифр)"));
			} else {
				cp.appendChild(
					document.createTextNode(
						" (Нажата не цифра с кодом \""+key+"\")"));
			}
		}

		/**
		 * Проверка при выходе из элемента управления
		 */
		function co() {
			var co = document.getElementById("co");
			while(co.firstChild) {
			    co.removeChild(co.firstChild);
			}
			var el = document.getElementById("idPost");
			if (el.options.length == 0) {
				co.appendChild(
					document.createTextNode(
						" (Не выбрано ни одной должности)"));
			} else {
				co.appendChild(
					document.createTextNode(
						" (Выбрана должность \""+ el.options[el.selectedIndex].value +"\")"));
			}
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
			<span class="label label-success">Сотрудники</span></h3>
		<h3><span class="label label-success">Способ передачи [в индексном массиве]</span></h3>
		<h3><span class="label label-success">Хранение [в сессии]</span></h3>
		<hr class="soften" />
		<form role="form" action="employees-handler.php" method="POST">
			<div class="form-group">
				<label for="idEmployeeLastName">
					<strong>*</strong> Фамилия сотрудника<span id="cp"></span>:</label>
				<input type="text" id="idEmployeeLastName" class="form-control" 
					onkeydown="cp(event);" 
					name="employeeLastName" placeholder="Фамилия сотрудника" required autofocus>
			</div>
			<div class="form-group">
				<label for="idChairName"><strong>*</strong> Кафедра: </label>
				<input type="text" id="idChairName" class="form-control" 
					name="chairName" placeholder="Кафедра" required>
			</div>
			<div class="form-group">
				<div class="alert alert-success">
					<div class="radio">
						<label>
							<input type="radio" 
							onclick="chColor(this);" value="background: #DFF0D8;"
							name="chCol">Сделать все [input type="text"] салатовыми</label>
					</div>
					<div class="radio">
						<label>
							<input type="radio" 
							onclick="chColor(this);" value="background: #D7DEEF;"
							name="chCol">Сделать все [input type="text"] голубыми</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="alert alert-success">
					<label> Должности в списке: &nbsp; &nbsp;</label>
					<label class="checkbox-inline"><input type="checkbox" class="manageCheckbox"
						value="ассистент" onclick="postClick();">ассистент</label>
					<label class="checkbox-inline"><input type="checkbox" class="manageCheckbox"
						value="доцент" onclick="postClick();">доцент</label>
					<label class="checkbox-inline"><input type="checkbox" class="manageCheckbox"
						value="профессор" onclick="postClick();">профессор</label>
				</div>
			</div>
			<div class="form-group">
				<label for="idPost"><strong>*</strong> Должность<span id="co"></span>:</label>
				<select name="post" id="idPost" class="form-control" 
				onblur="co();" 
				required>
				</select>
			</div>
			<div class="form-group">
				<label for="idHomeAddress">Домашний адрес:</label>
				<input type="text" id="idHomeAddress" class="form-control" 
					name="homeAddress" placeholder="Домашний адрес">
			</div>
			<div class="form-group">
				<label for="idPhone">Телефон сотрудника:</label>
				<input type="text" id="idPhone" class="form-control" 
					name="phone" placeholder="Телефон сотрудника">
			</div>
			<button type="submit" class="btn btn-warning">Добавить сотрудника</button>
		</form>
		<hr class="soften" />
		<?php
			if (!isset($_SESSION['task1-employee-table'])) {
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
			$table = $_SESSION['task1-employee-table'];
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