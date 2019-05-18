var HEADER_ID = "id";
var HEADER_SURNAME = "Фамилия";
var HEADER_DATE_CONCLUSION = "Дата заключения";
var HEADER_DATE_EXPIRATION = "Дата окончания";
var HEADER_DURATION = "Длительность (в годах)";
var TH = "th";
var TR = "tr";
var TD = "td";
var THEAD = "thead";
var TBODY = "tbody";
var CAPTION = "caption";
var TABLE_CLASSNAME = "tables";
var TABLE = "table";

var currentSelect = -1;
var contractList = null;

function allEmployees() {
	if (currentSelect != 1){
		currentSelect = 1;
		classNameDelete("active");
		setClassNameById("idAllEmployees","active");
		classReplace("visible", "invisible");
		setClassNameById("all-employees","visible");
		removeElementById("all-employees-table-id");

		var table = document.createElement(TABLE);
		table.className = TABLE_CLASSNAME;
		table.setAttribute(HEADER_ID,"all-employees-table-id");

		var caption = document.createElement(CAPTION);
		caption.innerHTML = "Вся информация о контрактах сотрудников.";
		table.appendChild(caption);

		var th1 = document.createElement(TH);
		th1.innerHTML = HEADER_ID;
		var th2 = document.createElement(TH);
		th2.innerHTML = HEADER_SURNAME;
		var th3 = document.createElement(TH);
		th3.innerHTML = HEADER_DATE_CONCLUSION;
		var th4 = document.createElement(TH);
		th4.innerHTML = HEADER_DURATION;

		var tr = document.createElement(TR);
		tr.appendChild(th1);
		tr.appendChild(th2);
		tr.appendChild(th3);
		tr.appendChild(th4);

		var thead = document.createElement(THEAD);
		thead.appendChild(tr);

		table.appendChild(thead);

		var tbody = document.createElement(TBODY);

		for (var i = 0; i < contractList.length; i++) {
			var j = 0;
			var td1 = document.createElement(TD);
			td1.innerHTML = getValueContractList(i, j++);
			var td2 = document.createElement(TD);
			td2.innerHTML = getValueContractList(i, j++);
			var td3 = document.createElement(TD);
			td3.innerHTML = getValueContractList(i, j++);
			var td4 = document.createElement(TD);
			td4.innerHTML = getValueContractList(i, j++);

			var tr = document.createElement(TR);
			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.appendChild(td3);
			tr.appendChild(td4);
			tbody.appendChild(tr);
		};

		table.appendChild(tbody);

		var el = document.getElementById("all-employees");

		el.appendChild(table);
	}
}

function addContract() {
	if (currentSelect != 2){
		currentSelect = 2;
		classNameDelete("active");
		setClassNameById("idAddContract","active");
		classReplace("visible", "invisible");
		setClassNameById("add-contract","visible");
	}
}


function calcDateEndingContract() {
	if (currentSelect != 3){
		currentSelect = 3;
		classNameDelete("active");
		setClassNameById("idCalcDates","active");
		classReplace("visible", "invisible");
		setClassNameById("ending-contract-table","visible");

		removeElementById("ending-contract-table-id");

		var table = document.createElement(TABLE);
		table.className = TABLE_CLASSNAME;
		table.setAttribute(HEADER_ID,"ending-contract-table-id");

		var caption = document.createElement(CAPTION);
		caption.innerHTML = "Таблица окончания контрактов сотрудников.";
		table.appendChild(caption);

		var th1 = document.createElement(TH);
		th1.innerHTML = HEADER_ID;
		var th2 = document.createElement(TH);
		th2.innerHTML = HEADER_SURNAME;
		var th3 = document.createElement(TH);
		th3.innerHTML = HEADER_DATE_CONCLUSION;
		var th4 = document.createElement(TH);
		th4.innerHTML = HEADER_DATE_EXPIRATION;
		var th5 = document.createElement(TH);
		th5.innerHTML = HEADER_DURATION;

		var tr = document.createElement(TR);
		tr.appendChild(th1);
		tr.appendChild(th2);
		tr.appendChild(th3);
		tr.appendChild(th4);
		tr.appendChild(th5);

		var thead = document.createElement(THEAD);
		thead.appendChild(tr);

		table.appendChild(thead);

		var tbody = document.createElement(TBODY);

		for (var i = 0; i < contractList.length; i++) {
			var j = 0;
			var td1 = document.createElement(TD);
			td1.innerHTML = getValueContractList(i, j++);
			var td2 = document.createElement(TD);
			td2.innerHTML = getValueContractList(i, j++);
			var td3 = document.createElement(TD);
			td3.innerHTML = getValueContractList(i, j);
			var td4 = document.createElement(TD);
			var dateExpiration = new Date(
				contractList[i][j].getFullYear(), 
				contractList[i][j].getMonth(),
				contractList[i][j].getDate(), 0, 0, 0, 0);
			dateExpiration.setFullYear(dateExpiration.getFullYear() + (contractList[i][++j]));
			td4.innerHTML = dateExpiration.toISOString().substring(0, 10);
			var td5 = document.createElement(TD);
			td5.innerHTML = getValueContractList(i, j);

			var tr = document.createElement(TR);
			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.appendChild(td3);
			tr.appendChild(td4);
			tr.appendChild(td5);
			tbody.appendChild(tr);
		};

		table.appendChild(tbody);

		var el = document.getElementById("ending-contract-table");

		el.appendChild(table);
	}
}

function employeesByYearEnding() {
	if (currentSelect != 4){
		currentSelect = 4;
		classNameDelete("active");
		setClassNameById("idByYear","active");
		classReplace("visible", "invisible");
		setClassNameById("ending-contract-by-year-1","visible");
	}
}

function employeesByYearEnding2(year) {
	if (currentSelect == 4){
			classReplace("visible", "invisible");
		if (!isYearExpirationExist(year)) {
			setClassNameById("ending-contract-by-year-3","visible");
		} else {
			setClassNameById("ending-contract-by-year-2","visible");

			removeElementById("contract-by-year-2-table-id");

			var table = document.createElement(TABLE);
			table.className = TABLE_CLASSNAME;
			table.setAttribute(HEADER_ID,"contract-by-year-2-table-id");

			var caption = document.createElement(CAPTION);
			caption.innerHTML = "Таблица сотрудников, с указанным годом окончания контракта.";
			table.appendChild(caption);

			var th1 = document.createElement(TH);
			th1.innerHTML = HEADER_ID;
			var th2 = document.createElement(TH);
			th2.innerHTML = HEADER_SURNAME;
			var th3 = document.createElement(TH);
			th3.innerHTML = HEADER_DATE_EXPIRATION;

			var tr = document.createElement(TR);
			tr.appendChild(th1);
			tr.appendChild(th2);
			tr.appendChild(th3);

			var thead = document.createElement(THEAD);
			thead.appendChild(tr);

			table.appendChild(thead);

			var tbody = document.createElement(TBODY);

			for (var i = 0; i < contractList.length; i++) {
				var dateExpiration = new Date(
					contractList[i][2].getFullYear(), 
					contractList[i][2].getMonth(),
					contractList[i][2].getDate(), 0, 0, 0, 0);
				dateExpiration.setFullYear(dateExpiration.getFullYear() + contractList[i][3]);
				if (dateExpiration.getFullYear() == year) {
					var j = 0;
					var td1 = document.createElement(TD);
					td1.innerHTML = getValueContractList(i, j++);
					var td2 = document.createElement(TD);
					td2.innerHTML = getValueContractList(i, j++);
					var td3 = document.createElement(TD);
					td3.innerHTML = dateExpiration.toISOString().substring(0, 10);

					var tr = document.createElement(TR);
					tr.appendChild(td1);
					tr.appendChild(td2);
					tr.appendChild(td3);

					tbody.appendChild(tr);
				}
			};

			table.appendChild(tbody);

			var el = document.getElementById("ending-contract-by-year-2");

			el.appendChild(table);
		}
	}
}

function employeesBy1stQEnding() {
	if (currentSelect != 5){
		currentSelect = 5;
		classNameDelete("active");
		setClassNameById("idBy1st","active");
		classReplace("visible", "invisible");
		setClassNameById("ending-contract-with-first-quarter","visible");

		removeElementById("contract-with-first-quarter-table-id");

		var table = document.createElement(TABLE);
		table.className = TABLE_CLASSNAME;
		table.setAttribute(HEADER_ID,"contract-with-first-quarter-table-id");

		var caption = document.createElement(CAPTION);
		caption.innerHTML = "Таблица сотрудников с оканчивающимися в 1 квартале контрактами.";
		table.appendChild(caption);

		var th1 = document.createElement(TH);
		th1.innerHTML = HEADER_ID;
		var th2 = document.createElement(TH);
		th2.innerHTML = HEADER_SURNAME;
		var th3 = document.createElement(TH);
		th3.innerHTML = HEADER_DATE_EXPIRATION;

		var tr = document.createElement(TR);
		tr.appendChild(th1);
		tr.appendChild(th2);
		tr.appendChild(th3);

		var thead = document.createElement(THEAD);
		thead.appendChild(tr);

		table.appendChild(thead);

		var tbody = document.createElement(TBODY);

		for (var i = 0; i < contractList.length; i++) {
			var dateConclusion = contractList[i][2];
			if (dateConclusion.getMonth()>=0 && dateConclusion.getMonth()<=2) {
				var j = 0;
				var td1 = document.createElement(TD);
				td1.innerHTML = getValueContractList(i, j++);
				var td2 = document.createElement(TD);
				td2.innerHTML = getValueContractList(i, j++);
				var td3 = document.createElement(TD);
				var dateExpiration = new Date(
					contractList[i][j].getFullYear(), 
					contractList[i][j].getMonth(),
					contractList[i][j].getDate(), 0, 0, 0, 0);
				dateExpiration.setFullYear(dateExpiration.getFullYear() + contractList[i][j+1]);
				td3.innerHTML = dateExpiration.toISOString().substring(0, 10);

				var tr = document.createElement(TR);
				tr.appendChild(td1);
				tr.appendChild(td2);
				tr.appendChild(td3);

				tbody.appendChild(tr);
			}
		};

		table.appendChild(tbody);

		var el = document.getElementById("ending-contract-with-first-quarter");

		el.appendChild(table);
	}
}

function getValueContractList(i, j) {
	if (isDate(contractList[i][j])) {
		return contractList[i][j].toISOString().substring(0, 10);
	}
	return contractList[i][j];
}

function classNameDelete(classNameVal) {
	var elems = document.getElementsByTagName('*'), i;
	for (i in elems) {
	    if((' ' + elems[i].className + ' ').indexOf(' ' + classNameVal + ' ')
	            > -1) {
	        elems[i].className = '';
	    }
	}
}

// Замена класса у элемента
function classReplace(oldClassName, newClassName){
	var elems = document.getElementsByTagName('*'), i;
	for (i in elems) {
	    if((' ' + elems[i].className + ' ').indexOf(' ' + oldClassName + ' ')
	            > -1) {
	        elems[i].className = newClassName;
	    }
	}
}

function removeElementById(idElem) {
	var elem = document.getElementById(idElem);
	if (elem != null){
		elem.parentNode.removeChild(elem);
	}
}

function setClassNameById(id, classNameVal) {
	var elem = document.getElementById(id);
	elem.className = classNameVal;
}

function performSubmitAdd() {
	var surname = (document.getElementById("idSurnameInAddForm").value).trim();
	if (isBlank(surname)) {
		document.getElementById("idSurnameInAddForm").focus();
		return false;
	}
	var date = (document.getElementById("idDateInAddForm").value).trim();
	if (!isValidDate(date)) {
		document.getElementById("idDateInAddForm").focus();
		return false;
	}
	var duration = (document.getElementById("idDurationInAddForm").value).trim();
	if (!isInt(duration)){
		document.getElementById("idDurationInAddForm").focus();
		return false;
	}
	if ((duration<1)||(duration>5)){
		document.getElementById("idDurationInAddForm").focus();
		return false;
	}
	document.getElementById('idSurnameInAddForm').value = '';
	document.getElementById('idDateInAddForm').value = '';
	document.getElementById('idDurationInAddForm').value = '1';
	addContractToList(surname, date, duration);
	allEmployees();
	return false;
}

function performSubmitQuery() {
	var year = (document.getElementById("idYearInQueryForm").value).trim();
	if (!isInt(year)){
		document.getElementById("idYearInQueryForm").focus();
		return false;
	}
	if ((year<1990)||(year>2100)){
		document.getElementById("idYearInQueryForm").focus();
		return false;
	}
	document.getElementById('idYearInQueryForm').value = '2015';
	employeesByYearEnding2(year);
	return false;
}

function addContractToList(surname, date_string, duration) {

	var id = getFreeId();

    var matches = /^(\d{4})[-\/](\d{2})[-\/](\d{2})$/.exec(date_string);
    if (matches == null) return false;
    var d = matches[3];
    var m = matches[2] - 1;
    var y = matches[1];

	var dateNew = new Date(y, m, d);
	contractList.push([id, surname, dateNew, Number(duration)]);
}

function getFreeId() {
	var id = 1;
	while (true) {
		var flag = true;
		for (var i = 0; i < contractList.length; i++) {
			if (contractList[i][0] == id){
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

function isYearExpirationExist(year) {
	for (var i = 0; i < contractList.length; i++) {
		var dateConclusion = new Date(
					contractList[i][2].getFullYear(), 
					contractList[i][2].getMonth(),
					contractList[i][2].getDate(), 0, 0, 0, 0);
		if ((dateConclusion.getFullYear() + contractList[i][3]) == year) {
			return true;
		}
	};
	return false;
}

function isInt(n) {
   return Number(n)==n && n%1===0;
}

function isDate(val) {
	return val instanceof Date;
}

function isValidDate(date) {
    var matches = /^(\d{4})[-\/](\d{2})[-\/](\d{2})$/.exec(date);
    if (matches == null) return false;
    var d = matches[3];
    var m = matches[2] - 1;
    var y = matches[1];
    var composedDate = new Date(y, m, d);
    return composedDate.getDate() == d &&
            composedDate.getMonth() == m &&
            composedDate.getFullYear() == y;
}

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function ininialize() {
	if (contractList == null) {
		// alert("onLoad");
		contractList = [
			[1,	"Маслов", 		new Date(2015, 02, 08), 1],
			[2,	"Родионов", 	new Date(2014, 11, 25), 1],
			[3,	"Кулагин", 		new Date(2015, 04, 09), 5],
			[4,	"Сазонов", 		new Date(2015, 02, 03), 3],
			[5,	"Овчинников",	new Date(2014, 00, 13), 1],
			[6,	"Белозёров", 	new Date(2012, 02, 30), 3],
			[7,	"Муравьёв", 	new Date(2015, 07, 12), 3],
			[8,	"Фролов", 		new Date(2015, 01, 14), 1],
			[9,	"Зайцев", 		new Date(2010, 05, 20), 5],
			[10,"Михайлов", 	new Date(2015, 03, 16), 1],
			[11,"Сысоев", 		new Date(2016, 03, 14), 5]
		];
		allEmployees();
	}
}