/**
 * Функция создаёт новое окно в браузере
 * получая значение полей формы на странице submit.html и подставляя в 
 * соответстввующие теги.
 */
function completeTask(formName) {

	var INVALID_PARAMETER = "Invalid function parameter!!";
	if (!document.forms[formName]) {
	    alert(INVALID_PARAMETER);
		return;
	}

	var params = "menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes"
	var customWindow = window.open("", "customWindow", params);
	customWindow.document.write(
		"<!DOCTYPE html>" +
		"<html lang=\"ru\">" +
		"<head>" +
		"<meta charset=\"UTF-8\">" +
		"<title>...</title>" +
		"<meta name=\"keywords\" content=\"\">" +
		"<meta name=\"description\" content=\"\">" +
		"<link rel=\"stylesheet\" href=\"css/style.css\">" +
		"</head>" +
		"<body>" +
		"<div class=\"page-wrapper\">" +

		"<header class=\"page-header\">" +
		"<div class=\"header-block\">" +
		"<span class=\"header-text\">" +
		"Контрольная работа по дисциплине:<br>" +
		"</span>" +
		"<span class=\"header-text\">" +
		"<strong>Разработка web-приложений</strong>" +
		"</span>" +
		"</div>" +
		"</header>" +
		"<div class=\"page-content-wrapper\">" +
		"<main class=\"main-wrapper\">" +
		"<article class=\"other-article-container\">" +
		"<div class=\"article-title\">" +
		"<h1>Результат опроса</h1>" +
		"</div>" +
		"<div class=\"article-chapter\">" +
		"<p>Из перечисленных в опросе, вам понравился фильм " +
		"<strong><span class=\"cl4\">" + getFieldValue(formName,'liked') +
		"</span></strong>.</p>" +
		"<p>Причина, по которой он вам понравился:" +
		"<strong><span class=\"cl4\">" + getFieldValue(formName,'comment') +
		"</span></strong>.<br></p>" +
		"<p>Из указанных актёров, <strong><span class=\"cl4\">" +
		getFieldValue(formName,'actor') + "</span></strong> наиболее интересен" + 
		" вам.</p>" +
		"<p>Спасибо, что приняли участие в нашем небольшом опросе" +
		" - ваше мнение очень важно для нас!</p>" +
		"</div>" +
		"</article>" +
		"</main>" +
		"<aside class=\"menu-container\">" +
		"<div class=\"menu-wrapper\">" +
		"<div class=\"title-sidebar-menu\">" +
		"Страницы актёров" +
		"</div>" +
		"<ul class=\"sidebar-menu\">" +
		"<li>" +
		"<a href=\"main-qualls.html\" title=\"Дональд Джозеф Куоллс\">" +
		"Куоллс" +
		"</a>" +
		"</li>" +
		"<li>" +
		"<a href=\"main-schwarzenegger.html\" " +
		"title=\"Арнольд Алоис Шварценеггер\">" +
		"Шварценеггер" +
		"</a>" +
		"</li>" +
		"</ul>" +
		"</div>" +
		"<div class=\"menu-wrapper\">" +
		"<div class=\"title-sidebar-menu\">" +
		"Дополнительные страницы	" +
		"</div>" +
		"<ul class=\"sidebar-menu\">" +
		"<li><a href=\"preformated.html\" " +
		"title=\"Пример использования предварительного форматирования\">" +
		"Предварительное форматирование</a>" +
		"</li>" +
		"<li><a href=\"submit.html\" " +
		"title=\"Проверка работы c html-формами и JS\">" +
		"Использование JavaScript" +
		"</a>" +
		"</li>" +
		"<li><a href=\"task.html\" title=\"Описание тех. задания на разработку\">" +
		"Описание требований" +
		"</a>" +
		"</li>" +
		"</ul>" +
		"</div>" +
		"</aside>" +
		"</div>" +
		"</div>" +
		"<footer class=\"page-footer\">" +
		"<div class=\"footer-block\">" +
		"<address>" +
		"<span class=\"title\">Разработано:</span><br>" +
		"<span class=\"signature\">Группа:</span> ПОИТ-41<br>" +
		"<span class=\"signature\">Студент:</span> _student_fullname_<br>" +
		"</address>" +
	    "</div>" +
		"</footer>" +
		"</body>" +
		"</html>");
	customWindow.focus();
}

/**
 * Получение значения поля. Если пустое, возвращает "не указано".
 */
function getFieldValue(formName, fieldName) {
	var EMPTY_VALUE = "<не указано>";
	var fieldValue = document.forms[formName].elements[fieldName].value;
	return (!isBlank(fieldValue)) ? fieldValue : EMPTY_VALUE;
}

/**
 * Функция проверки строки на null и пустоту.
 * (Если в строке пробелы или переводы строки - всё равно считается пустой)
 */
function isBlank(str) {
    return (!str || !/[^\s]/.test(str));
}