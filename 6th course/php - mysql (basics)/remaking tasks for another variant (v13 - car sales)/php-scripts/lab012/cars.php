<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
    $isFirstRequest = false;

    $requestType = '';
    if (filter_input_array(INPUT_POST)) {
        $requestType = INPUT_POST;
    } else if (filter_input_array(INPUT_GET)) {
        $requestType = INPUT_GET;
    } else {
        $isFirstRequest = true;
    }
    if (!$isFirstRequest) {
        $rawModel = 
            filter_input($requestType, 'model', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawColor = 
            filter_input($requestType, 'color', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawManufactureDate = 
            filter_input($requestType, 'manufactureDate', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawPrice = 
            filter_input($requestType, 'price', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawPercentDeduction = 
            filter_input($requestType, 'percentDeduction', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawOwner = 
            filter_input($requestType, 'owner', FILTER_SANITIZE_SPECIAL_CHARS);
        $rawBuyer = 
            filter_input($requestType, 'buyer', FILTER_SANITIZE_SPECIAL_CHARS);

        $model = normalizeText($rawModel);
        $model = (empty($model) ? '<Не указан>' : $model);

        $color = normalizeText($rawColor);
        $color = (empty($color) ? '<Не указан>' : $color);

        $manufactureDate = normalizeText($rawManufactureDate);
        $manufactureDate = (empty($manufactureDate) ? '<Не указан>' : $manufactureDate);

        $price = normalizeText($rawPrice);
        $price = (empty($price) ? '<Не указан>' : $price);

        $percentDeduction = normalizeText($rawPercentDeduction);
        $percentDeduction = (empty($percentDeduction) ? '<Не указан>' : $percentDeduction);

        $owner = normalizeText($rawOwner);
        $owner = (empty($owner) ? '<Не указан>' : $owner);

        $buyer = normalizeText($rawBuyer);
        $buyer = (empty($buyer) ? '<Не указан>' : $buyer);

        if (!defined('ROW_DELIMETER')) {
            define('ROW_DELIMETER', '~');
        }
        if (!defined('COL_DELIMETER')) {
            define('COL_DELIMETER', '===');
        }

        $tableRow = $model.COL_DELIMETER
            .$color.COL_DELIMETER
            .$manufactureDate.COL_DELIMETER
            .$price.COL_DELIMETER
            .$percentDeduction.COL_DELIMETER
            .$owner.COL_DELIMETER
            .$buyer.ROW_DELIMETER;

        if (isset($_SESSION['task1-car-table'])) {
            $_SESSION['task1-car-table'] .= $tableRow;
        } else {
            $_SESSION['task1-car-table'] = $tableRow;
        }
    }

    function normalizeText($rawString) {
        $result = preg_replace('/\s\s+/', ' ', $rawString);
        return trim(strip_tags(htmlspecialchars($result)));
    }
?>
<!DOCTYPE html>
<html>
<?php include "../header_menu.php"; ?>

    <script type="text/javascript">

        /**
         * Изменение элементов списка
         */
        function postClick() {
            var sel = document.getElementById("color");
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

        function chReset(cl) {
            var reset = document.getElementById("reset");
            reset.style.visibility=cl.value;
        }

        /**
         * Проверка вводимых символов (Цена)
         */
        function cp(e) {
            var cp = document.getElementById("cp");
            while(cp.firstChild) {
                cp.removeChild(cp.firstChild);
            }
            var key = e.keyCode || e.which;
            if ((key == 48)||(key == 49)||(key == 50)||(key == 51)||(key == 52)||(key == 53)||
                (key == 54)||(key == 55)||(key == 56)||(key == 57)||(key == 96)||(key == 97)||
                (key == 98)||(key == 99)||(key == 100)||(key == 101)||(key == 102)||(key == 103)||
                (key == 104)||(key == 105)||(key == 13)||(key == 8)||(key == 46)) {
            } else {
                cp.appendChild(
                    document.createTextNode(
                        " (!!! Цена должна быть целым числом)"));
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
            var el = document.getElementById("color");
            if (el.options.length == 0) {
                co.appendChild(
                    document.createTextNode(
                        " (Не выбрано ни одного цвета)"));
            } else {
                co.appendChild(
                    document.createTextNode(
                        " (Выбран цвет \""+ el.options[el.selectedIndex].value +"\")"));
            }
        }

        /**
         * Проверка при отправке
         */
        function checkedOnSend(model, price, percentDeduction) {
            var model = document.getElementById(model).value;
            var price = document.getElementById(price).value;
            var percentDeduction = document.getElementById(percentDeduction).value;
            var valid = true;
            var errors = "";
            var err = document.getElementById('er');
            while(err.firstChild) {
                err.removeChild(err.firstChild);
            }
            if (isBlank(model)) {
                errors += "<strong>Марка</strong> не указана.<br>";
                valid = false;
            }
            if (!isBlank(price)) {
                if (!isInteger(parseInt(price))) {
                    errors += "<strong>Цена</strong> должна быть целым числом.<br>";
                    valid = false;
                }
            }
            if (!isBlank(percentDeduction)) {
                if (!isInteger(parseInt(percentDeduction))) {
                    errors += "<strong>Процент фирме</strong> должен быть числом.<br>";
                    valid = false;
                }
            }
            if (!valid) {
                err.innerHTML += '<div class="total"><div class="site-center"><div class="cell">'
                    + errors 
                    +'</div></div></div><br>';
                return valid;
            }
        }
        function isBlank(str) {
            return (!str || /^\s*$/.test(str));
        }

        function isInteger(num) {
            return (num ^ 0) === num;
        }

    </script>

<div class="masthead">
    <div class="site-center">
        <div class="cell">
            <h4>Работа 1.2, Автомобили, в одном файле, в переменной</h4>
        </div>
    </div>
</div>
<div class="site-center">
<div class="cell">
	<div class="col">
		<form action="cars.php" method="POST" 
            onsubmit="return checkedOnSend('model','price','percentDeduction');">

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="model"><strong>*</strong> Марка:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="model" name="model" type="text" placeholder="Марка" required autofocus/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col width-fit">
                    <div class="cell">
                        ↓↓↓ ИЗМЕНЕНИЕ ЭЛЕМЕНТОВ СПИСКА ↓↓↓
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label>Цвета в списке:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <label class="checkbox-inline"><input type="checkbox" class="manageCheckbox"
                            value="красный" onclick="postClick();"> красный</label>
                        <label class="checkbox-inline"> <input type="checkbox" class="manageCheckbox"
                            value="жёлтый" onclick="postClick();"> жёлтый</label>
                        <label class="checkbox-inline"> <input type="checkbox" class="manageCheckbox"
                            value="зелёный" onclick="postClick();"> зелёный</label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col width-fit">
                    <div class="cell">
                        ↓↓↓ ПРОВЕРКА ПРИ ПОТЕРЕ ФОКУСА (ВЫХОДЕ) ↓↓↓
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="color">Цвет:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <select name="color" id="color" onblur="co();">
                        </select>
                    </div>
                </div>
                <div class="col label">
                    <div class="cell">
                        <span id="co"></span>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="manufactureDate">Дата выпуска:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="manufactureDate" name="manufactureDate" type="text" 
                            placeholder="Дата выпуска"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col width-fit">
                    <div class="cell">
                        ↓↓↓ ПРОВЕРКА ВВОДИМЫХ СИМВОЛОВ ↓↓↓
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="price">Цена:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="price" name="price" type="text" placeholder="Цена" onkeydown="cp(event);"/>
                    </div>
                </div>
                <div class="col label">
                    <div class="cell">
                        <span id="cp"></span>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="percentDeduction">Процент фирме:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="percentDeduction" name="percentDeduction" type="text" 
                            placeholder="Процент фирме"/>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="owner">Продавец:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="owner" name="owner" type="text" placeholder="Продавец"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div class="cell">
                        <label for="buyer">Покупатель:</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <input id="buyer" name="buyer" type="text" placeholder="Покупатель"/>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col width-fit">
                    <div class="cell">
                        <label>
                            <input type="radio" name="r1" 
                            onclick="chReset(this);" value="hidden">Убрать кнопку "Очистить"</label>
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <label>
                            <input type="radio" name="r1" 
                            onclick="chReset(this);" value="visible">Восстановить кнопку "Очистить"</label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col label">
                    <div style="margin: 10px;">
                    	<input id="reset" type="reset" name="reset" value="Очистить">
                    </div>
                </div>
                <div class="col width-fit">
                    <div class="cell">
                        <button type="submit">Добавить автомобиль</button>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="col width-fit">
                    <div class="cell">
                        ↑↑↑ ПРОВЕРКА ПРИ ОТПРАВКЕ (Марка, цена и процент) ↑↑↑
                    </div>
                </div>
            </div>
        </form>
	</div>
</div>
</div>

<div id="er"></div>

<?php
	if (!isset($_SESSION['task1-car-table'])) {
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
    $rows = preg_split('/\~/', 
        $_SESSION['task1-car-table'], NULL, PREG_SPLIT_NO_EMPTY);
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
</body>
</html>