/**
 * Функция парсит URL-параметры запроса, созданного html-формой при помощи
 * метода GET. Затем, по имени параметра, ищется id-шник с таким же именем и
 * подсталяется переданное значение.
 */
function parseParameters() {

	var ID_NAME = 0;
	var ID_VALUE = 1;
	var START_PARAMETERS = "?";
	var DELIMETER_PAIRS = "&";
	var DELIMETER_VALUES = "=";
	var EMPTY = "";

	// Получаем строку с параметрами запроса
	var partURL = window.location.search.replace(START_PARAMETERS, EMPTY);
	
	// Разделяем строку на пары name/value
	var parameters = partURL.split(DELIMETER_PAIRS);
	var count = parameters.length - 1;
	
	for (var i = count; i >= 0; i--) {
		
		// Разделяем пару на name/value
		var pair = parameters[i].split(DELIMETER_VALUES);
		
		// Заменяем "ВСЕ" плюсы на пробелы
		var rawValue = pair[ID_VALUE].replace(/\+/g, " ");
		
		// Исправляем кирилические символы
		var value = decodeURIComponent(rawValue);
		
		if (isBlank(value)) {
			//continue;
			// Подставляем значение на место пустых параметров
			value = "<не указано>"
		}
		
		// Получаем в документе элемент с таким же id, что и name
		var spanElem = document.getElementById(pair[ID_NAME]);
		
		// Очищаем старое значение в элементе
		spanElem.innerHTML = EMPTY;
		
		// Создаём новое значение в элементе
		spanElem.appendChild(document.createTextNode(value));
	}
}

/**
 * Функция проверки строки на null и пустоту.
 * (Если в строке только пробелы или переводы строки - всё равно считается пустой)
 */
function isBlank(str) {
    return (!str || !/[^\s]/.test(str));
}
