
var idNodeForEdit = -1;
var currentSelect = -1;
var laboratoryList = null;

// (1) Клик по кнопке меню "Просмотр"
function view() {

	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-view";
	var TABLE_ID = "id-table-block-view";
	var CAPTION_TEXT = "Все записи базы данных";
	if (currentSelect != 1){
		currentSelect = 1;
		classNameDelete("active");
		setClassNameById("menuIdView","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");
		removeElementById(TABLE_ID);
		var table = getTable(1, TABLE_ID, CAPTION_TEXT, -1, -1);
		var block = document.getElementById(BLOCK_ID);
		block.appendChild(table);
	}
}

// (6) Клик по кнопке меню "Добавление"
function add() {
	var BLOCK_ID = "id-block-add";
	if (currentSelect != 6){
		currentSelect = 6;
		classNameDelete("active");
		setClassNameById("menuIdAdd","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");

		// clear form
		document.getElementById('idFirstLastNameInAddForm').value = '';
		document.getElementById('idGroupInAddForm').value = '';
		document.getElementById('idLab1InAddForm').value = '0';
		document.getElementById('idLab2InAddForm').value = '0';
		document.getElementById('idLab3InAddForm').value = '0';
	}
}

function performSubmitAdd() {
	var surname = document.getElementById('idFirstLastNameInAddForm').value;
	if (isBlank(surname)) {
		document.getElementById("idFirstLastNameInAddForm").focus();
		return false;
	}
	var group = document.getElementById('idGroupInAddForm').value;
	if (isBlank(group)) {
		document.getElementById("idGroupInAddForm").focus();
		return false;
	}
	var lab1 = document.getElementById('idLab1InAddForm').value;
	if (!isInt(lab1)||(lab1>1)||(lab1<0)) {
		document.getElementById("idLab1InAddForm").focus();
		return false;
	}
	var lab2 = document.getElementById('idLab2InAddForm').value;
	if (!isInt(lab2)||(lab2>1)||(lab2<0)) {
		document.getElementById("idLab2InAddForm").focus();
		return false;
	}
	var lab3 = document.getElementById('idLab3InAddForm').value;
	if (!isInt(lab3)||(lab3>1)||(lab3<0)) {
		document.getElementById("idLab3InAddForm").focus();
		return false;
	}

	document.getElementById('idFirstLastNameInAddForm').value = '';
	document.getElementById('idGroupInAddForm').value = '';
	document.getElementById('idLab1InAddForm').value = '0';
	document.getElementById('idLab2InAddForm').value = '0';
	document.getElementById('idLab3InAddForm').value = '0';

	var freeId = getFreeId();
	addLaboratoryToList(freeId, surname, group, lab1, lab2, lab3);
	view();
	return false;
}

// (5) Клик по кнопке меню "Изменение"
function change() {
	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-select-for-change";

	var FORM_CLASSNAME = "form-select-for-change-node";
	var FORM_ID = "id-form-list-for-change";
	var PAIR_ID_PATTERN = "rChangeId";
	var INPUT_NAME = "radio-node-for-change";
	var INPUT_ONCLICK = "radioForChangeClick();";

	if (currentSelect != 5){
		currentSelect = 5;
		classNameDelete("active");
		setClassNameById("menuIdChange","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");
		removeElementById(FORM_ID);
		var form = getForm(FORM_CLASSNAME, FORM_ID, PAIR_ID_PATTERN, INPUT_NAME, INPUT_ONCLICK);
		var block = document.getElementById(BLOCK_ID);
		block.appendChild(form);
	}
}

function radioForChangeClick() {
	var INPUT_NAME = "radio-node-for-change";
	var radios = document.getElementsByName(INPUT_NAME);
	var idForChange = -1;
	for (var i = 0, length = radios.length; i < length; i++) {
		if (radios[i].checked) {
			idForChange = radios[i].value;
			break;
    	}
	}
	if (idForChange == -1) {
		return;
	}

	var BLOCK_ID_CHANGE = "id-block-change";
	classReplace("visible", "invisible");
	setClassNameById(BLOCK_ID_CHANGE,"visible");

	// clear form
	document.getElementById('idFirstLastNameInChangeForm').value = '';
	document.getElementById('idGroupInChangeForm').value = '';
	document.getElementById('idLab1InChangeForm').value = '';
	document.getElementById('idLab2InChangeForm').value = '';
	document.getElementById('idLab3InChangeForm').value = '';
	

	idForChange = Number(idForChange);
	var node = getNodeById(idForChange);
	idNodeForEdit = idForChange;

	// write node in form
	document.getElementById('idFirstLastNameInChangeForm').value = node[1];
	document.getElementById('idGroupInChangeForm').value = node[2];
	document.getElementById('idLab1InChangeForm').value = node[3];
	document.getElementById('idLab2InChangeForm').value = node[4];
	document.getElementById('idLab3InChangeForm').value = node[5];
}

function performSubmitChange() {
	var surname = document.getElementById('idFirstLastNameInChangeForm').value;
	if (isBlank(surname)) {
		document.getElementById("idFirstLastNameInChangeForm").focus();
		return false;
	}
	var group = document.getElementById('idGroupInChangeForm').value;
	if (isBlank(group)) {
		document.getElementById("idGroupInChangeForm").focus();
		return false;
	}
	var lab1 = document.getElementById('idLab1InChangeForm').value;
	if (!isInt(lab1)||(lab1>1)||(lab1<0)) {
		document.getElementById("idLab1InChangeForm").focus();
		return false;
	}
	var lab2 = document.getElementById('idLab2InChangeForm').value;
	if (!isInt(lab2)||(lab2>1)||(lab2<0)) {
		document.getElementById("idLab2InChangeForm").focus();
		return false;
	}
	var lab3 = document.getElementById('idLab3InChangeForm').value;
	if (!isInt(lab3)||(lab3>1)||(lab3<0)) {
		document.getElementById("idLab3InChangeForm").focus();
		return false;
	}

	document.getElementById('idFirstLastNameInChangeForm').value = '';
	document.getElementById('idGroupInChangeForm').value = '';
	document.getElementById('idLab1InChangeForm').value = '0';
	document.getElementById('idLab2InChangeForm').value = '0';
	document.getElementById('idLab3InChangeForm').value = '0';
	
	deleteNodeById(idNodeForEdit);
	addLaboratoryToList(idNodeForEdit, surname, group, lab1, lab2, lab3);
	view();
	return false;
}

// (4) Клик по кнопке меню "Удаление"
function deleteL() {

	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-select-for-delete";

	var FORM_CLASSNAME = "form-select-for-delete-node";
	var FORM_ID = "id-form-list-for-delete";
	var PAIR_ID_PATTERN = "rDeleteId";
	var INPUT_NAME = "radio-node-for-delete";
	var INPUT_ONCLICK = "radioForDeleteClick();";

	if (currentSelect != 4){
		currentSelect = 4;
		classNameDelete("active");
		setClassNameById("menuIdDelete","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");
		removeElementById(FORM_ID);
		var form = getForm(FORM_CLASSNAME, FORM_ID, PAIR_ID_PATTERN, INPUT_NAME, INPUT_ONCLICK);
		var block = document.getElementById(BLOCK_ID);
		block.appendChild(form);
	}
}

// Функция удаления
function radioForDeleteClick() {
	var INPUT_NAME = "radio-node-for-delete";
	var radios = document.getElementsByName(INPUT_NAME);
	var idForDelete = -1;
	for (var i = 0, length = radios.length; i < length; i++) {
		if (radios[i].checked) {
			idForDelete = radios[i].value;
			break;
    	}
	}
	if (idForDelete == -1) {
		return;
	}
	deleteNodeById(idForDelete);
	currentSelect = -1;
	deleteL();
}

// (7) Клик по кнопке меню "Поиск"
function search() {

	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-select-for-find";
	if (currentSelect != 7){
		currentSelect = 7;
		classNameDelete("active");
		setClassNameById("menuIdSearch","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");

		// clear form
		document.getElementById("fieldFindSurname").checked = true;
		document.getElementById('idValueFindForm').value = '';
		document.getElementById('idValueFindForm').focus();
	}
}

function performSubmitQueryFind() {
	var RADIO_NAME = "type-field-find";
	var radios = document.getElementsByName(RADIO_NAME);
	var indexField = "";
	for (var i = 0, length = radios.length; i < length; i++) {
		if (radios[i].checked) {
			indexField = radios[i].value;
			break;
    	}
	}
	if (isBlank(indexField)) {
		var EMPTY_BLOCK_ID = "id-block-empty-result-find";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return false;
	}
	var searchValue = document.getElementById('idValueFindForm').value;
	if (isBlank(searchValue)) {
		document.getElementById("idValueFindForm").focus();
		return false;
	}

	if (!isExistFindValue(indexField, searchValue)) {
		var EMPTY_BLOCK_ID = "id-block-empty-result-find";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return false;
	}

	var BLOCK_ID = "id-block-exist-result-find";
	var TABLE_ID = "id-table-result-find";
	var CAPTION_TEXT = "Записи найденые по указанному критерию";

	currentSelect = -1;
	classNameDelete("active");
	classReplace("visible", "invisible");
	setClassNameById(BLOCK_ID,"visible");
	removeElementById(TABLE_ID);
	var table = getTable(3, TABLE_ID, CAPTION_TEXT, indexField, searchValue);
	var block = document.getElementById(BLOCK_ID);
	block.appendChild(table);
	return false;
}

function isExistFindValue(indexField, value) {
	if (!isInt(indexField)||(indexField>5)||(indexField<0)) {
		return false;
	}
	if (isBlank(value)) {
		return false;
	}

	indexField = Number(indexField);
	for (var i = 0; i < laboratoryList.length; i++) {
		if (laboratoryList[i][indexField] == value) {
			return true;
		}
	}
	return false;
}

// (2) Клик по кнопке меню "Сортировка"
function sort() {

	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-sort";
	var TABLE_ID = "id-table-block-sort";
	var CAPTION_TEXT = "Отсортированные записи базы данных";
	if (currentSelect != 2){
		currentSelect = 2;
		classNameDelete("active");
		setClassNameById("menuIdSort","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");
		removeElementById(TABLE_ID);
		laboratoryList.sort(sortArrBySurname);
		var table = getTable(1, TABLE_ID, CAPTION_TEXT, -1, -1);
		laboratoryList.sort(sortArrById);
		var block = document.getElementById(BLOCK_ID);
		block.appendChild(table);
	}
}

// (3) Клик по кнопке меню "Выборка списка студентов, сдавших все лабораторные"
function doTask() {

	if (!isListEmpty()) {
		var EMPTY_BLOCK_ID = "id-block-empty-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_BLOCK_ID,"visible");
		return;
	}

	if (!doTaskHelper()) {
		var EMPTY_DO_TASK_BLOCK_ID = "id-block-empty-do-task-list";
		currentSelect = -1;
		classNameDelete("active");
		classReplace("visible", "invisible");
		setClassNameById(EMPTY_DO_TASK_BLOCK_ID,"visible");
		return;
	}

	var BLOCK_ID = "id-block-do-task";
	var TABLE_ID = "id-table-block-do-task";
	var CAPTION_TEXT = "Список студентов, сдавших все лабораторные";
	if (currentSelect != 3){
		currentSelect = 3;
		classNameDelete("active");
		setClassNameById("menuIdDoTask","active");
		classReplace("visible", "invisible");
		setClassNameById(BLOCK_ID,"visible");
		removeElementById(TABLE_ID);
		var table = getTable(2, TABLE_ID, CAPTION_TEXT, -1, -1);
		var block = document.getElementById(BLOCK_ID);
		block.appendChild(table);
	}
}

function doTaskHelper() {
	for (var i = 0; i < laboratoryList.length; i++) {
		if ((laboratoryList[i][3] == 1)&&
			(laboratoryList[i][4] == 1)&&
			(laboratoryList[i][5] == 1)) {
			return true;
		}
	}
	return false;
}

//Вспомогательная функция удаления класса у узла.
function classNameDelete(classNameVal) {
	var elems = document.getElementsByTagName('*'), i;
	for (i in elems) {
	    if((' ' + elems[i].className + ' ').indexOf(' ' + classNameVal + ' ')
	            > -1) {
	        elems[i].className = '';
	    }
	}
}

//Вспомогательная функция установки класса у узла, по указанному id узла.
function setClassNameById(id, classNameVal) {
	var elem = document.getElementById(id);
	elem.className = classNameVal;
}

// Вспомогательная функция замены класса у элемента
function classReplace(oldClassName, newClassName){
	var elems = document.getElementsByTagName('*'), i;
	for (i in elems) {
	    if((' ' + elems[i].className + ' ').indexOf(' ' + oldClassName + ' ')
	            > -1) {
	        elems[i].className = newClassName;
	    }
	}
}

// Вспомогательная функция удаления узла по указанному id
function removeElementById(idElem) {
	var elem = document.getElementById(idElem);
	if (elem != null){
		elem.parentNode.removeChild(elem);
	}
}

// Вспомогательная функция сортировки исходного списка 
// по возрастанию id
function sortArrById(a,b){
     if (Number(a[0]) < Number(b[0])){
        return -1;
     } else if (Number(a[0]) > Number(b[0])) {
        return  1;
     } else {
        if (a[1] < b[1]) {
           return -1; 
        }
        else if (a[1] > b[1]) {
           return 1;
        } 
        else {
           return 0;
        }
     }
}

// Вспомогательная функция сортировки исходного списка 
// по возрастанию ФИО Студентов
function sortArrBySurname(a,b){
     if (a[1] < b[1]){
        return -1;
     } else if (a[1] > b[1]) {
        return  1;
     } else {
        if (Number(a[0]) < Number(b[0])) {
           return -1; 
        }
        else if (Number(a[0]) > Number(b[0])) {
           return 1;
        } 
        else {
           return 0;
        }
     }
}

function getTable(cType, tableId, captionText, fieldIdForFind, valueForFind){

	var HEADER_SURNAME = "ФИО Студента";
	var HEADER_GROUP = "Группа";
	var HEADER_LAB1 = "Лаб. №1";
	var HEADER_LAB2 = "Лаб. №2";
	var HEADER_LAB3 = "Лаб. №3";

	var TH = "th";
	var TR = "tr";
	var TD = "td";
	var THEAD = "thead";
	var TBODY = "tbody";

	var TABLE_CLASSNAME = "tables";
	var TABLE = "table";
	var HEADER_ID = "id";
	var CAPTION = "caption";

	var table = document.createElement(TABLE);
	table.className = TABLE_CLASSNAME;
	table.setAttribute(HEADER_ID, tableId);

	var caption = document.createElement(CAPTION);
	caption.innerHTML = captionText;
	table.appendChild(caption);

	var th1 = document.createElement(TH);
	th1.innerHTML = HEADER_ID;
	var th2 = document.createElement(TH);
	th2.innerHTML = HEADER_SURNAME;
	var th3 = document.createElement(TH);
	th3.innerHTML = HEADER_GROUP;
	var th4 = document.createElement(TH);
	th4.innerHTML = HEADER_LAB1;
	var th5 = document.createElement(TH);
	th5.innerHTML = HEADER_LAB2;
	var th6 = document.createElement(TH);
	th6.innerHTML = HEADER_LAB3;

	var tr = document.createElement(TR);
	tr.appendChild(th1);
	tr.appendChild(th2);
	tr.appendChild(th3);
	tr.appendChild(th4);
	tr.appendChild(th5);
	tr.appendChild(th6);

	var thead = document.createElement(THEAD);
	thead.appendChild(tr);

	table.appendChild(thead);

	var tbody = document.createElement(TBODY);

	for (var i = 0; i < laboratoryList.length; i++) {
		if (nodeSelecter(cType, laboratoryList[i][0],
								laboratoryList[i][1],
								laboratoryList[i][2],
								laboratoryList[i][3],
								laboratoryList[i][4],
								laboratoryList[i][5], 
								fieldIdForFind, 
								valueForFind)) {
			var td1 = document.createElement(TD);
			td1.innerHTML = laboratoryList[i][0];
			var td2 = document.createElement(TD);
			td2.innerHTML = laboratoryList[i][1];
			var td3 = document.createElement(TD);
			td3.innerHTML = laboratoryList[i][2];
			var td4 = document.createElement(TD);
			td4.innerHTML = laboratoryList[i][3];
			var td5 = document.createElement(TD);
			td5.innerHTML = laboratoryList[i][4];
			var td6 = document.createElement(TD);
			td6.innerHTML = laboratoryList[i][5];

			var tr = document.createElement(TR);
			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.appendChild(td3);
			tr.appendChild(td4);
			tr.appendChild(td5);
			tr.appendChild(td6);
			tbody.appendChild(tr);
		}
	};

	table.appendChild(tbody);

	return table;
}

function getForm(formClassname, formId, pairIdPattern, inputName, inputOnclick) {

	var ATTR_ID = "id";
	var ATTR_METHOD = "method";
	var ATTR_ACCEPT_CHARSET = "accept-charset";
	var ATTR_FOR = "for";
	var ATTR_TYPE = "type";
	var ATTR_TYPE_RADIO = "radio";
	var ATTR_VALUE = "value";
	var ATTR_NAME = "name";
	var ATTR_ONCLICK = "onclick";

	var FORM_METHOD = "post";
	var FORM_ACCEPT_CHARSET = "utf-8";

	var DIV = "div";
	var LABEL = "label";
	var INPUT = "input";
	var FORM = "form";

	var DIV_CLASS = "radio-list-item";

	var form = document.createElement(FORM);
	form.className = formClassname;
	form.setAttribute(ATTR_ID, formId);
	form.setAttribute(ATTR_METHOD, FORM_METHOD);
	form.setAttribute(ATTR_ACCEPT_CHARSET, FORM_ACCEPT_CHARSET);

	for (var i = 0; i < laboratoryList.length; i++) {

		var div = document.createElement(DIV);
		div.className = DIV_CLASS;

		var label = document.createElement(LABEL);
		label.setAttribute(ATTR_FOR, (pairIdPattern+i));
		label.innerHTML = 
				"[ " + laboratoryList[i][0] + 
				" - " + laboratoryList[i][1] + 
				" - " + laboratoryList[i][2] + 
				" ] [ " + laboratoryList[i][3] + 
				", " + laboratoryList[i][4] + 
				", " + laboratoryList[i][5] + " ]";
		div.appendChild(label);

		var input = document.createElement(INPUT);
		input.setAttribute(ATTR_ID, (pairIdPattern+i));
		input.setAttribute(ATTR_TYPE, ATTR_TYPE_RADIO);
		input.setAttribute(ATTR_VALUE, laboratoryList[i][0]);
		input.setAttribute(ATTR_NAME, inputName);
		input.setAttribute(ATTR_ONCLICK, inputOnclick);
		div.appendChild(input);

		form.appendChild(div);
	};
	return form;
}

function nodeSelecter(cType, id, surname, group, lab1, lab2, lab3, findIdField, findValue) {
	if (cType==1) {
		return true;
	}
	if (cType==2) {
		return (lab1 == 1)&&(lab2 == 1)&&(lab3 == 1);
	}
	if (cType==3) {
		if (findIdField == 0) {
			return id == findValue;
		}
		if (findIdField == 1) {
			return surname == findValue;
		}
		if (findIdField == 2) {
			return group == findValue;
		}
		if (findIdField == 3) {
			return lab1 == findValue;
		}
		if (findIdField == 4) {
			return lab2 == findValue;
		}
		if (findIdField == 5) {
			return lab3 == findValue;
		}
	}
	return false;
}

function getNodeById(id) {
    for (i=0; i<laboratoryList.length; i++) {
        if (laboratoryList[i][0] == id) {

            return laboratoryList[i];
        }
    }
}

function deleteNodeById(id) {
	var COUNT_LINE_FOR_DELETE = 1;
	laboratoryList.splice(getSequenceNumber(id), COUNT_LINE_FOR_DELETE);
}

function getSequenceNumber(id) {
    for (i=0; i<laboratoryList.length; i++) {
        if (laboratoryList[i][0] == id) {
            return i;
        }
    };
    return -1;
}

function isListEmpty() {
	return (typeof laboratoryList !== 'undefined' && laboratoryList.length > 0);
}

function isInt(n) {
   return Number(n)==n && n%1===0;
}

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function getFreeId() {
	var id = 1;
	while (true) {
		var flag = true;
		for (var i = 0; i < laboratoryList.length; i++) {
			if (laboratoryList[i][0] == id){
				id++;
				flag = false;
				break;
			}
		}
		if (flag) {
			return id;
		}
	}
}

function addLaboratoryToList(id, surname, group, lab1, lab2, lab3) {
	id = Number(id);
	lab1 = Number(lab1);
	lab2 = Number(lab2);
	lab3 = Number(lab3);
	laboratoryList.push([id, surname, group, lab1, lab2, lab3]);
	laboratoryList.sort(sortArrById);
}

// Функция инициализации начальных значений бд
function ininialize() {
	if (laboratoryList == null) {
		// alert("onLoad");
		laboratoryList = [
			[1, "Полянин Андрей Витальевич", "ПОИТ-21", 1, 0, 1],
			[2,	"Ивашко Руслан Валерьевич", "ПОИТ-21", 1, 1, 1],
			[3,	"Шимкевич Павел Дмитриевич", "М-31", 0, 0, 1],
			[4,	"Климович Игорь Викторович", "М-41", 1, 0, 0],
			[5,	"Демидович Вячеслав Геннадиевич", "М-31", 1, 1, 1],
			[6,	"Тихонович Степан Матвеевич", "М-41", 1, 1, 1],
			[7,	"Протасевич Юрий Робертович", "ПМ-41", 1, 0, 0],
			[8,	"Стефанович Анатолий Ростиславович", "ПМ-42", 0, 1, 1],
			[9,	"Стешиц Василий Антонович", "ПМ-42", 1, 1, 1],
			[10,"Камчиц Пётр Борисович", "ПМ-42", 0, 1, 1],
			[11,"Павловский Владимир Федорович", "ПО-32", 1, 1, 1]
		];
		view();
	}
}