/**
 * Функция создаёт новое окно в браузере (почти полный аналог файла accept.html)
 * получая значение полей формы на странице submit-v2.html и подставляя в 
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
		"<p>Из перечисленных в опросе, вам понравилось произведение " +
		"<strong><span class=\"cl8\">" + getFieldValue(formName,'liked') +
		"</span></strong>.</p>" +
		"<p>Причина, по которой вам понравилось это произведение:" +
		"<strong><span class=\"cl8\">" + getFieldValue(formName,'comment') +
		"</span></strong>.<br></p>" +
		"<p>Из указанных русских классиков, <strong><span class=\"cl8\">" +
		getFieldValue(formName,'writer') + "</span></strong> наиболее интересен" + 
		" вам.</p>" +
		"<p>Спасибо, что приняли участие в нашем небольшом опросе" +
		" - ваше мнение очень важно для нас!</p>" +
		"</div>" +
		"</article>" +
		"</main>" +
		"<nav class=\"menu-container\">" +
		"<ul class=\"sidebar-menu\">" +
		"<li>" +
		"<a href=\"main-lermontov.html\" title=\"Страница о Лермонтове\">" +
		"Биография Лермонтова" +
		"</a></li><li>" +
		"<a href=\"main-pushkin.html\" title=\"Страница о Пушкине\">" +
		"Биография Пушкина" +
		"</a></li></ul>" +
		"<div class=\"menu-wrapper\">" +
		"<div class=\"title-sidebar-menu\">" +
		"Тестовые страницы" +
		"</div>" +
		"<ul class=\"sidebar-menu\">" +
		"<li>" +
		"<a href=\"normal-formated.html\" " +
		"title=\"Пример текста с обычным форматированием\">" +
		"Обычное форматирование" +
		"</a>" +
		"</li>" +
		"<li><a href=\"preformated.html\" " +
		"title=\"Пример текста с предварительным форматированием\">" +
		"Предварительное форматирование</a>" +
		"</li>" +
		"<li>" +
		"<a href=\"submit-v1.html\" title=\"Проверка работы html-форм и JS [Способ 1]\">" +
		"Использование JavaScript [<i>Способ 1</i>]" +
		"</a>" +
		"</li>" +
		"<li><a href=\"submit-v2.html\" title=\"Проверка работы html-форм и JS [Способ 2]\">" +
		"Использование JavaScript [<i>Способ 2</i>]" +
		"</a></li>" +
		"</ul>" +
		"</div>" +
		"<div class=\"menu-wrapper\">" +
		"<div class=\"title-sidebar-menu\">Информация</div>" +
		"<ul class=\"sidebar-menu\">" +
		"<li>" +
		"<a href=\"task.html\" title=\"Описание тех. задания на разработку\">" +
		"Описание требований" +
		"</a>" +
		"</li>" +
		"<li><a href=\"about.html\" title=\"Информация о сайте\">О сайте</a></li>" +
		"</ul>" +
		"</div>" +
		"</nav>" +
		"</div>" +
		"</div>" +
		"<footer class=\"page-footer\">" +
		"<div class=\"footer-block\">" +
		"<address>" +
		"<span class=\"title\">Developed by:</span><br>" +
		"<span class=\"signature\">Group:</span> POIT-41<br>" +
		"<span class=\"signature\">Student:</span> Viktor Baranov<br>" +
		"<span class=\"signature\">E-mail:</span>" +
		"<a href=\"mailto:some@example.by\">some@example.by</a>" +
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