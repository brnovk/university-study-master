function showDeleteBlock() {
	uncheckAllCheckBoxes();
	setClassNameById("idSelectProcessingManagement", 'invisible-block');
	setClassNameById("idDeleteCancel", 'visible-block');
	setClassNameById("idDeleteBlock", 'visible-block');
}

function cancelShowDeleteBlock() {
	uncheckAllCheckBoxes();
	setClassNameById("idDeleteCancel", 'invisible-block');
	setClassNameById("idDeleteBlock", 'invisible-block');
	setClassNameById("idSelectProcessingManagement", 'visible-block');
}

function showAppendBlock() {
	uncheckAllCheckBoxes();
	setClassNameById("idSelectProcessingManagement", 'invisible-block');
	setClassNameById("idAppendBlock", 'visible-block');
	document.getElementById("idAddNumberСhairs").focus();
}

function cancelShowAppendBlock() {
	uncheckAllCheckBoxes();
	setClassNameById("idAppendBlock", 'invisible-block');
	setClassNameById("idSelectProcessingManagement", 'visible-block');
}

function appendValToList() {
	var item = document.getElementById('idAddNumberСhairs').value;
	if (isBlank(item)) {
		alert("Введите значение.");
		return;
	};
	if (!isInteger(parseInt(item))) {
		alert("Значение должно быть целым числом");
		return;
	}
	if (parseInt(item) <= 0) {
		alert("Значение должно быть больше нуля");
		return;
	}
	var elem = document.getElementById('idHiddenField');
	var params = elem.value.split(" ");

	var index = -1;
	for (var i = 0; i < params.length; i++) {
		if (item == params[i]) {
			alert("Введённое значение уже есть в списке.");
			return;
		}
	}
	params.push(item.trim());
	var res = '';
	for (var j = 0; j < params.length; j++) {
		if (!isBlank(params[j])) {
			res += params[j];
			res += ' ';
		}
	}
	elem.setAttribute('value',res);

	changeSelect();
	changeDeleteBlock();
	setClassNameById("idSelectProcessingManagement", 'visible-block');
	setClassNameById("idAppendBlock", 'invisible-block');
}

function deleteValFromList(item) {
	var elem = document.getElementById('idHiddenField');
	var params = elem.value.split(" ");
	var index = -1;
	for (var i = 0; i < params.length; i++) {
		if (item == params[i]) {
			index = i;
			break;
		}
	}
	if (index > -1) {
		params.splice(index, 1);
	}
	var res = '';
	for (var j = 0; j < params.length; j++) {
		if (!isBlank(params[j])) {
			res += params[j];
			res += ' ';
		}
	}
	elem.setAttribute('value',res);
	changeSelect();
	changeDeleteBlock();
	setClassNameById("idSelectProcessingManagement", 'visible-block');
	setClassNameById("idDeleteCancel", 'invisible-block');
	setClassNameById("idDeleteBlock", 'invisible-block');
}

function changeSelect() {
	var elem = document.getElementById('idHiddenField');
	var params = elem.value.split(" ");

	var mySelect = document.getElementById('idNumberChairs');
	while (mySelect.firstChild) {
		mySelect.removeChild(mySelect.firstChild);
	}

	for (var i = 0; i < params.length; i++) {
		if (!isBlank(params[i])) {
			var newOption = document.createElement('option');
			newOption.setAttribute('value', params[i]);
			var newContent = document.createTextNode(params[i]);
			newOption.appendChild(newContent);
			mySelect.appendChild(newOption);
		}
	}
}

function changeDeleteBlock() {
	var elem = document.getElementById('idHiddenField');
	var params = elem.value.split(" ");

	var myDeleteBlock = document.getElementById('idDeleteBlock');
	while (myDeleteBlock.firstChild) {
		myDeleteBlock.removeChild(myDeleteBlock.firstChild);
	}
	for (var i = 0; i < params.length; i++) {
		if (!isBlank(params[i])) {

			var newInput = document.createElement('input');
			newInput.setAttribute('type', 'radio');
			newInput.setAttribute('name', 'radioListValue');
			var newNodeID = 'idRadioListValue'.concat(params[i]);
			newInput.setAttribute('id', newNodeID);
			newInput.setAttribute('value', params[i]);
			newInput.setAttribute('onclick', 'deleteValFromList('.concat(params[i].concat(');')));
			myDeleteBlock.appendChild(newInput);

			var newLabel = document.createElement('label');
			newLabel.setAttribute('for', newNodeID);
			var newLabelContent = 
				document.createTextNode(
					'Удалить из списка значение с цифрой \"'.concat(
						params[i].concat(
							'\"')));
			newLabel.appendChild(newLabelContent);
			myDeleteBlock.appendChild(newLabel);

			var br = document.createElement("br");
			myDeleteBlock.appendChild(br);
			myDeleteBlock.appendChild(br);
		}
	}
}

function isBlank(str) {
	return (!str || /^\s*$/.test(str));
}

function isInteger(num) {
	return (num ^ 0) === num;
}


function uncheckAllCheckBoxes() {
	var checkboxes = document.getElementsByTagName('input');
	for (var i=0; i<checkboxes.length; i++) {
	  if (checkboxes[i].type == 'checkbox') {
	    checkboxes[i].checked = false;
	  }
	}
}
	
function setClassNameById(id, classNameVal) {
	var elem = document.getElementById(id);
	elem.className = classNameVal;
}

/*
 *	Проверка вводимых символов.
 */
function checkedInterringSymbols(e) {
	var keyID = (e.charCode) ? e.charCode : ((e.which) ? e.which : e.keyCode);
	if ((keyID >= 48 && keyID <= 57) 
			|| (keyID >= 96 && keyID <= 105)
			|| (keyID == 8)
			|| (keyID == 46)) {
		//nothing
	} else {
		alert("Количество кафедр может быть только целым числом");
	}
}

/*
 *	Проверка при выходе (onBlur)
 */
function checkedOnBlur(id) {
	var value = document.getElementById(id).value;
	if (isBlank(value)) {
		return true;
	}
	if (!isInteger(parseInt(value))) {
		document.getElementById(id).value = '';
		alert("Значение поля удалено, так как должно быть целым числом");
	}
}

/*
 *	Проверка при отправке
 */
function checkedOnSend(id) {
	var value = document.getElementById(id).value;
	if (isBlank(value)) {
		alert("Название факультета не указано!");
		return false;
	}
}