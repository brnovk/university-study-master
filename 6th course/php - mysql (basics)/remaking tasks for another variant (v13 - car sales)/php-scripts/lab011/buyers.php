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
            <h4>Работа 1.1, Покупатели, в разных файлах, в индексном массиве</h4>
        </div>
    </div>
</div>
<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="buyers-handler.php" method="POST">
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="fullName"><strong>*</strong> ФИО:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="fullName" name="fullName" type="text" placeholder="ФИО" required autofocus/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="address">Адрес:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="address" name="address" type="text" placeholder="Адрес"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="phone">Телефон:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="phone" name="phone" type="text" placeholder="Телефон"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div style="margin: 10px;">
                    	<input type="reset" name="reset" value="Очистить">
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <button type="submit">Добавить покупателя</button>
                    </div>
                </div>
            </div>
        </form>
	</div>
</div>
</div>
<?php
	if (!isset($_SESSION['task1-buyer-table'])) {
		echo '<div class="masthead"><div class="site-center"><div class="cell">';
		echo "<strong>Оповещение:</strong> отсутствуют данные в таблице покупателей.";
		echo '</div></div></div>';
	} else { 
?>
<table class="border" cellspacing="0" cellpadding="0" >
<caption><h3>Таблица покупателей</h3></caption>
<thead>
<tr>
	<th>ФИО</th>
	<th>Адрес</th>
	<th>Телефон</th>
</tr>
</thead>
<tbody>
<?php
	$table = $_SESSION['task1-buyer-table'];
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
</body>
</html>