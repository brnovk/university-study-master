
function showDescription(blockId, buttonId) {
    var hideblock = document.getElementById(blockId);
    var showButton = document.getElementById(buttonId);

    hideblock.setAttribute('class', 'visible');
    showButton.setAttribute('class', 'hidden');
}


function validateNewsAdd(formName, fieldHeader, fieldBody) {
    var header = document.forms[formName][fieldHeader].value;
    if (header == null || header.trim() == "") {
        alert('Заголовок новости не должен быть пустым');
        return false;
    }
    if (header.length > 255) {
        alert('Заголовок новости не может быть длинее 255 символов');
        return false;
    }
    var body = document.forms[formName][fieldBody].value;
    if (body == null || body.trim() == "") {
        alert('Текст новости не должен быть пустым');
        return false;
    }
    if (body.length > 2500) {
        alert('Текст новости не может быть длинее 2500 символов');
        return false;
    }
    return true;
}


function validateVacanciesAdd(formName, fieldHeader, fieldBody) {
    var header = document.forms[formName][fieldHeader].value;
    if (header == null || header.trim() == "") {
        alert('Заголовок вакансии не должен быть пустым');
        return false;
    }
    if (header.length > 255) {
        alert('Заголовок вакансии не может быть длинее 255 символов');
        return false;
    }
    var body = document.forms[formName][fieldBody].value;
    if (body == null || body.trim() == "") {
        alert('Текст вакансии не должен быть пустым');
        return false;
    }
    if (body.length > 2500) {
        alert('Текст вакансии не может быть длинее 2500 символов');
        return false;
    }
    return true;
}

function validatePartnersAdd(formName, fieldHeader, fieldBody) {
    var header = document.forms[formName][fieldHeader].value;
    if (header == null || header.trim() == "") {
        alert('Заголовок информационного блока не должен быть пустым');
        return false;
    }
    if (header.length > 255) {
        alert('Заголовок информационного блока не может быть длинее 255 символов');
        return false;
    }
    var body = document.forms[formName][fieldBody].value;
    if (body == null || body.trim() == "") {
        alert('Текст информационного блока не должен быть пустым');
        return false;
    }
    if (body.length > 2500) {
        alert('Текст информационного блока не может быть длинее 2500 символов');
        return false;
    }
    return true;
}

function validateProductsAdd(formName, fieldName, fieldDescription) {
    var name = document.forms[formName][fieldName].value;
    if (name == null || name.trim() == "") {
        alert('Название продукта не должно быть пустым');
        return false;
    }
    if (name.length > 255) {
        alert('Название продукта не может быть длинее 255 символов');
        return false;
    }
    var description = document.forms[formName][fieldDescription].value;
    if (description == null || description.trim() == "") {
        alert('Описание продукта не должно быть пустым');
        return false;
    }
    if (description.length > 500) {
        alert('Описание продукта не может быть длинее 500 символов');
        return false;
    }
    return true;
}

function validateAuth(formName, fieldLogin, fieldPassword) {
    var login = document.forms[formName][fieldLogin].value;
    if (login == null || login.trim() == "") {
        alert('Логин не должен быть пустым');
        return false;
    }
    if (login.length > 255) {
        alert('Логин не может быть длинее 255 символов');
        return false;
    }
    var password = document.forms[formName][fieldPassword].value;
    if (password == null || password.trim() == "") {
        alert('Пароль не должен быть пустым');
        return false;
    }
    if (password.length > 255) {
        alert('Пароль не может быть длинее 255 символов');
        return false;
    }
    return true;
}

function validateProductsTypeAdd(formName, fieldName) {
    var name = document.forms[formName][fieldName].value;
    if (name == null || name.trim() == "") {
        alert('Тип продукта не должен быть пустым');
        return false;
    }
    if (name.length > 255) {
        alert('Тип продукта не может быть длинее 255 символов');
        return false;
    }
    return true;
}

function validateResumeAdd(formName, fieldMessage) {
    var message = document.forms[formName][fieldMessage].value;
    if (message == null || message.trim() == "") {
        alert('Сообщение нанимателю не должно быть пустым');
        return false;
    }
    if (message.length > 5000) {
        alert('Сообщение нанимателю не может быть длинее 5000 символов');
        return false;
    }
    return true;
}

function validateAboutEdit(formName, fieldDescription, fieldAddress) {
    var description = document.forms[formName][fieldDescription].value;
    if (description == null || description.trim() == "") {
        alert('Описание компании не должно быть пустым');
        return false;
    }
    if (description.length > 5000) {
        alert('Описание компании не может быть длинее 5000 символов');
        return false;
    }
    var address = document.forms[formName][fieldAddress].value;
    if (address == null || address.trim() == "") {
        alert('Адрес не должен быть пустым');
        return false;
    }
    if (address.length > 255) {
        alert('Адрес не может быть длинее 255 символов');
        return false;
    }
    return true;
}