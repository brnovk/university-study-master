<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	require 'database.php';
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
		if (strcmp($searchField, 'fullName') == 0) {
			$displaySearchField = 'ФИО';
		} elseif (strcmp($searchField, 'address') == 0) {
			$displaySearchField = 'Адрес';
		} elseif (strcmp($searchField, 'phone') == 0) {
			$displaySearchField = 'Телефон';
		} else {
			$errors .= 'Неизвестный тип поля поиска.<br>';
			$valid = false;
		}
		if ($valid) {
			try {
				$pdo = Database::connect();
				$sql = 'SELECT fullName, address, phone FROM buyers
						WHERE '.$searchField.' LIKE :keyword;';
				$searchResult = $pdo->prepare($sql);
				$searchResult->bindValue(':keyword','%'.$searchValue.'%');
				$searchResult->execute();
				if ($searchResult->rowCount() != 0) {
					$existSearchResult = true;
					$searchResult = $searchResult->fetchAll();
				}
				Database::disconnect();
			} catch(PDOException $e) {
				$errors .= 'Произошла ошибка при работе с БД.<br>'.$e->getMessage();
			}
		}
	} else {
		$errors .= 'Ошибка загрузки параметров поиска. 
			Повторите загрузку результатов со страницы "Покупателей"';
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
            <h4>Работа 3, Поиск покупателей</h4>
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
		Таблица покупателей содержащих 
		<span style="font-weight: bold;"><?php echo $displaySearchValue; ?></span>
		в поле 
		<span style="font-weight: bold;"><?php echo $displaySearchField; ?></span></h3>
	</caption>
	<thead>
	<tr>
		<th>ФИО</th>
		<th>Адрес</th>
		<th>Телефон</th>
	</tr>
	</thead>
	<tbody>
	<?php
		foreach ($searchResult as $row) {
			echo '<tr>';
			echo '<td>'. $row['fullName'] . '</td>';
			echo '<td>'. $row['address'] . '</td>';
			echo '<td>'. $row['phone'] . '</td>';
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
	<a href="buyers.php">Назад</a>
</div>
</body>
</html>