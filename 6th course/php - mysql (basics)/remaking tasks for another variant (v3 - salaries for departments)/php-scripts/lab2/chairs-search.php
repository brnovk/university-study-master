<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'file-handler.php';
	$valid = true;
	$requestType = '';
	$errors = '';
	$existSearchResult = false;
	$displaySearchValue = '';
	$displaySearchField = '';
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawChairsSearchValue = 
			filter_input($requestType, 'chairsSearchValue', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawChairSearchField = 
			filter_input($requestType, 'chairSearchField', FILTER_SANITIZE_SPECIAL_CHARS);

		$chairsSearchValue = normalizeText($rawChairsSearchValue);
		if (empty($chairsSearchValue) && $chairsSearchValue !== '0') {
			$errors .= 'Не указано значение для поиска.<br>';
			$valid = false;
		}
		$displaySearchValue = $chairsSearchValue;

		$chairSearchField = normalizeText($rawChairSearchField);
		if (empty($chairSearchField) && $chairSearchField !== '0') {
			$errors .= 'Не указано поле для поиска.<br>';
			$valid = false;
		}
		if (strcmp($chairSearchField, 'CHAIR_NAME') == 0) {
			$chairSearchField = 'chairName';
			$displaySearchField = 'Название кафедры';
		} elseif (strcmp($chairSearchField, 'CHAIR_HEAD') == 0) {
			$chairSearchField = 'chairHead';
			$displaySearchField = 'Заведующий кафедрой';
		} elseif (strcmp($chairSearchField, 'CHAIR_PHONE') == 0) {
			$chairSearchField = 'chairPhone';
			$displaySearchField = 'Телефон кафедры';
		} else {
			$errors .= 'Неизвестный тип поля поиска.<br>';
			$valid = false;
		}
		if ($valid) {
			$searchError = null;
			$searchResult = searchChairs($chairSearchField, $chairsSearchValue, $searchError);
			if (!is_null($searchError)) {
				$errors .= 'Произошла ошибка поиска: '.$searchError.'<br>';
			} else {
				if (!is_null($searchResult)) {
					$existSearchResult = true;
				}
			}
		}
	} else {
		$errors .= 'Ошибка загрузки параметров поиска. 
			Повторите загрузку результатов со страницы "Кафедр"';
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
	<title>Лабораторная №2, Поиск кафедр</title>
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
			<span class="label label-success">Поиск кафедр</span></h3>
		<hr class="soften" />
		<?php if (!empty($errors)): ?>
			<div class="alert alert-danger">
				<?php echo $errors;?>
			</div>
			<hr class="soften" />
		<?php endif; ?>
		<?php if ($existSearchResult) { ?>
			<table class="table table-condensed table-bordered">
			<caption>
				Таблица кафедр содержащих 
				<span style="font-weight: bold;"><?php echo $displaySearchValue; ?></span>
				в поле 
				<span style="font-weight: bold;"><?php echo $displaySearchField; ?></span>
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
				foreach ($searchResult as $row) {
					echo '<tr>';
					echo '<td>'. $row['chairName'] . '</td>';
					echo '<td>'. $row['chairHead'] . '</td>';
					echo '<td>'. $row['chairPhone'] . '</td>';
					echo '</tr>';
				}
			?>
			</tbody>
			</table>
			<?php } else { ?>
			<?php if (!empty($displaySearchValue)): ?>
				<div class="alert alert-warning">
					Записей содеращих <strong><?php echo $displaySearchValue; ?></strong> 
					в поле <strong><?php echo $displaySearchField; ?></strong> не найдено
				</div>
			<?php endif; ?>
			<?php } ?>
		<a href="chairs.php" class="btn btn-default">Назад</a>
	</div><!-- container-fluid -->
</body>
</html>