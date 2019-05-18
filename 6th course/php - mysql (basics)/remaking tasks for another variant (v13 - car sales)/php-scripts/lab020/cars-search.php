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

		$rawSearchValue = filter_input($requestType, 'searchValue', FILTER_SANITIZE_SPECIAL_CHARS);
		$rawSearchField = filter_input($requestType, 'searchField', FILTER_SANITIZE_SPECIAL_CHARS);

		$searchValue = normalizeText($rawSearchValue);
		if (empty($searchValue) && $searchValue !== '0') {
			$errors .= 'Не указано значение для поиска.<br>';
			$valid = false;
		}
		$displaySearchValue = $searchValue;

		$searchField = normalizeText($rawSearchField);
		if (empty($searchField) && $searchField !== '0') {
			$errors .= 'Не указано поле для поиска.<br>';
			$valid = false;
		}
		if (strcmp($searchField, 'model') == 0) {
			$displaySearchField = 'Марка';
		} elseif (strcmp($searchField, 'color') == 0) {
			$displaySearchField = 'Цвет';
		} elseif (strcmp($searchField, 'manufactureDate') == 0) {
			$displaySearchField = 'Дата выпуска';
		} elseif (strcmp($searchField, 'price') == 0) {
			$displaySearchField = 'Цена';
		} elseif (strcmp($searchField, 'percentDeduction') == 0) {
			$displaySearchField = 'Процент фирме';
		} elseif (strcmp($searchField, 'owner') == 0) {
			$displaySearchField = 'Владелец';
		} elseif (strcmp($searchField, 'buyer') == 0) {
			$displaySearchField = 'Покупатель';
		} else {
			$errors .= 'Неизвестный тип поля поиска.<br>';
			$valid = false;
		}
		if ($valid) {
			$searchError = null;
			$searchResult = searchCars($searchField, $searchValue, $searchError);
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
			Повторите загрузку результатов со страницы "Автомобилей"';
	}

	function normalizeText($rawString) {
	    $result = preg_replace('/\s\s+/', ' ', $rawString);
	    return trim(strip_tags(htmlspecialchars($result)));
	}
?>
<!DOCTYPE html>
<html>
<?php include "../header_menu.php"; ?>
<div class="masthead">
    <div class="site-center">
        <div class="cell">
            <h4>Работа 2, Поиск автомобилей</h4>
        </div>
    </div>
</div>
<?php if (!empty($errors)): ?>
	<br><div class="total"><div class="site-center"><div class="cell">
		<?php echo $errors;?>
	</div></div></div>
<?php endif; ?>
<?php if ($existSearchResult) { ?>
	<table class="border">
	<caption><h3>
		Таблица автомобилей содержащих 
		<span style="font-weight: bold;"><?php echo $displaySearchValue; ?></span>
		в поле 
		<span style="font-weight: bold;"><?php echo $displaySearchField; ?></span></h3>
	</caption>
	<thead>
	<tr>
		<th>Марка</th>
		<th>Цвет</th>
		<th>Дата выпуска</th>
		<th>Цена</th>
		<th>Процент фирме</th>
		<th>Владелец</th>
		<th>Покупатель</th>
	</tr>
	</thead>
	<tbody>
	<?php
		foreach ($searchResult as $row) {
			echo '<tr>';
			echo '<td>'. $row['model'] . '</td>';
			echo '<td>'. $row['color'] . '</td>';
			echo '<td>'. date('Y-m-d',$row['manufactureDate']) . '</td>';
			echo '<td>'. $row['price'] . '</td>';
			echo '<td>'. $row['percentDeduction'] . '</td>';
			echo '<td>'. $row['owner'] . '</td>';
			echo '<td>'. $row['buyer'] . '</td>';
			echo '</tr>';
		}
	?>
	</tbody>
	</table>
<?php } else { ?>
	<?php if (!empty($displaySearchValue)): ?>
		<br><div class="masthead"><div class="site-center"><div class="cell">
			Записей содеращих <strong><?php echo $displaySearchValue; ?></strong> 
			в поле <strong><?php echo $displaySearchField; ?></strong> не найдено
		</div></div></div>
	<?php endif; ?>
<?php } ?>
<div class="cell">
	<a href="cars.php">Назад</a>
</div>
</body>
</html>