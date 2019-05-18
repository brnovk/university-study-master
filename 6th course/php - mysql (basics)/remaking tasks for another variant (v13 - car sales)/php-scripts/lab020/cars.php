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
            <h4>Работа 2, Текстовые файлы, Автомобили</h4>
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
	$sortedField = 'model';
	if ($requestType === INPUT_POST || $requestType === INPUT_GET) {
		$rawSortedField = 
			filter_input($requestType, 'sortedField', FILTER_SANITIZE_SPECIAL_CHARS);
		if (strcmp($rawSortedField, 'color') == 0) {
			$sortedField = 'color';
		} elseif (strcmp($rawSortedField, 'manufactureDate') == 0) {
			$sortedField = 'manufactureDate';
		} elseif (strcmp($rawSortedField, 'price') == 0) {
			$sortedField = 'price';
		} elseif (strcmp($rawSortedField, 'percentDeduction') == 0) {
			$sortedField = 'percentDeduction';
		} elseif (strcmp($rawSortedField, 'owner') == 0) {
			$sortedField = 'owner';
		} elseif (strcmp($rawSortedField, 'buyer') == 0) {
			$sortedField = 'buyer';
		}
	}
?>
<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="cars.php" method="POST">
			<div class="col">
				<div class="col width-fit">
					<div class="cell">
						<label for="sortedField">Сортировать по полю:</label>
					</div>
				</div>
				<div class="col width-fit">
					<div class="cell">
						<select name="sortedField" id="sortedField" required>
 							<option value="model"
								<?php echo $sortedField == 'model' ? 'selected' : ''?>>
								Марка
							</option>
							<option value="color"
								<?php echo $sortedField == 'color' ? 'selected' : ''?>>
								Цвет
							</option>
							<option value="manufactureDate"
								<?php echo $sortedField == 'manufactureDate' ? 'selected' : ''?>>
								Дата выпуска
							</option>
							<option value="price"
								<?php echo $sortedField == 'price' ? 'selected' : ''?>>
								Цена
							</option>
							<option value="percentDeduction"
								<?php echo $sortedField == 'percentDeduction' ? 'selected' : ''?>>
								Процент фирме
							</option>
							<option value="owner"
								<?php echo $sortedField == 'owner' ? 'selected' : ''?>>
								Владелец
							</option>
							<option value="buyer"
								<?php echo $sortedField == 'buyer' ? 'selected' : ''?>>
								Покупатель
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
		<form action="cars-search.php" method="POST">
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
							<option value="model">Марка</option>
							<option value="color">Цвет</option>
							<option value="manufactureDate">Дата выпуска</option>
							<option value="price">Цена</option>
							<option value="percentDeduction">Процент фирме</option>
							<option value="owner">Владелец</option>
							<option value="buyer">Покупатель</option>
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
				<a href="cars-add.php">Добавить автомобиль</a>
			</div>
		</div>
	</div>
</div>
</div>
<?php
	require 'file-handler.php';
	$res = getCars();
	if (empty($res) || count($res) == 0) { 
		echo '<div class="masthead"><div class="site-center"><div class="cell">';
		echo "<strong>Оповещение:</strong> отсутствуют данные в таблице автомобилей.";
		echo '</div></div></div>';
	} else { 
?>
<table class="border" cellspacing="0" cellpadding="0" >
<caption><h3>Таблица автомобилей</h3></caption>
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
		usort($res, makeSortFunction($sortedField));
		foreach ($res as $row) {
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
<?php } ?>
</body>
</html>