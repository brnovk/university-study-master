<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
?>
<!DOCTYPE html>
<html>
<?php include "../header_menu.php"; ?>
<div class="masthead">
    <div class="site-center">
        <div class="cell">
            <h4>Работа 3, База данных, Владельцы</h4>
        </div>
    </div>
</div>
<?php
	$requestType = '';
	if (filter_input_array(INPUT_POST)) {
	    $requestType = INPUT_POST;
	} else if (filter_input_array(INPUT_GET)) {
	    $requestType = INPUT_GET;
	}
	$sortedField = 'fullName';
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawSortedField = 
			filter_input($requestType, 'sortedField', FILTER_SANITIZE_SPECIAL_CHARS);
		if (strcmp($rawSortedField, 'address') == 0) {
			$sortedField = 'address';
		} elseif (strcmp($rawSortedField, 'phone') == 0) {
			$sortedField = 'phone';
		}
	}
?>
<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="owners.php" method="POST">
			<div class="col">
				<div class="col width-fit">
					<div class="cell">
						<label for="sortedField">Сортировать по полю:</label>
					</div>
				</div>
				<div class="col width-fit">
					<div class="cell">
						<select name="sortedField" id="sortedField" required>
							<option value="fullName"
								<?php echo $sortedField == 'fullName' ? 'selected' : ''?>>
								ФИО
							</option>
							<option value="address"
								<?php echo $sortedField == 'address' ? 'selected' : ''?>>
								Адрес
							</option>
							<option value="phone"
								<?php echo $sortedField == 'phone' ? 'selected' : ''?>>
								Телефон
							</option>
						</select>
					</div>
				</div>
				<div class="col width-fit">
					<div class="cell">
						<button type="submit">Сортировать</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="col">
		<form action="owners-search.php" method="POST">
			<div class="col">
				<div class="col width-fit">
					<div class="cell">
						<input type="text" required
							name="searchValue" placeholder="Искомое значение">
					</div>
				</div>
				<div class="col width-fit">
					<div class="cell">
						<select name="searchField" required>
							<option value="fullName">ФИО</option>
							<option value="address">Адрес</option>
							<option value="phone">Телефон</option>
						</select>
					</div>
				</div>
				<div class="col width-fit">
					<div class="cell">
						<button type="submit">Искать</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="col">
		<div class="col width-fit">
			<div class="cell">
				<a href="owners-add.php">Добавить владельца</a>
			</div>
		</div>
	</div>
</div>
</div>
<?php
	try {
		include 'database.php';
		$pdo = Database::connect();
		$sql = 'SELECT fullName, address, phone FROM owners;';
		$res = $pdo->query($sql);
		if ($res->rowCount() == 0) { 
			echo '<div class="masthead"><div class="site-center"><div class="cell">';
			echo "<strong>Оповещение:</strong> отсутствуют данные в таблице владельцев.";
			echo '</div></div></div>';
		} else { 
?>
<table class="border" cellspacing="0" cellpadding="0" >
<caption><h3>Таблица владельцев</h3></caption>
<thead>
<tr>
	<th>ФИО</th>
	<th>Адрес</th>
	<th>Телефон</th>
</tr>
</thead>
<tbody>
<?php
			$res = $res->fetchAll();
			usort($res, Database::makeSortFunction($sortedField));
			foreach ($res as $row) {
				echo '<tr>';
				echo '<td>'. $row['fullName'] . '</td>';
				echo '<td>'. $row['address'] . '</td>';
				echo '<td>'. $row['phone'] . '</td>';
				echo '</tr>';
			}
		}
		Database::disconnect();
?>
</tbody>
</table>
<?php
	}
	catch(PDOException $e) {
		echo '<div class="total"><div class="site-center"><div class="cell">';
		echo "<strong>Ошибка соединения с БД:</strong> ". $e->getMessage();
		echo '</div></div></div>';
	}
?>
</body>
</html>