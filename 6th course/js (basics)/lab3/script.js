//-----------------------------------------------------------------------------
	/* Task 0 - Переключение между режимами*/

// 0 - radio-headers-only, 1 - radio-headers-and-content
var currentType = 0;

// Клик по радиобаттону
function handleClick() {
	var radios = document.getElementsByName('radio-item');
	for (var i = 0, length = radios.length; i < length; i++) {
		if (radios[i].checked) {
			if (radios[i].value == "radio-headers-only") {
				currentType = 0;
			} else if (radios[i].value == "radio-headers-and-content") {
				currentType = 1;
			}
			break;
    	}
	}
	changeOfRegime();
}

// Переключение
function changeOfRegime() {
	if (currentType == 0) {
		classReplace('content', 'hide-content');
	} else {
		classReplace('hide-content', 'content');
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
//-----------------------------------------------------------------------------
/* Task 1 - Изменение цвета*/
function fnsh1(){
	document.body.style.color = "#009A28";
	// document.body.style.background = "#373a41";
}

function rest1(){
	document.body.style.color = "#000";
	// document.body.style.background = "white";
}
//-----------------------------------------------------------------------------
	/* Task 2 - Резиновый заголовок*/
var clicked2 = false;

function strt2(){
	// alert("strt2");
   clicked2 = true;
}

function fnsh2(){
    clicked2=false;
}

function rest2(){
    clicked2=false;
}

function rubberText(el, xxx) {
	var ee = parseInt(el.style.letterSpacing, 10);
	if ((ee <= 20)&&(xxx>0)) {
		el.style.letterSpacing = (ee+1) + 'px';
	} else if ((ee >0)&&(xxx<0)) {
		el.style.letterSpacing = (ee-1) + 'px';
	}
}

//-----------------------------------------------------------------------------
	/* Task 3 - Изменение размера изовражения вправо(и влево естественно)*/
document.ondragstart = function() { return false }
document.body.onselectstart = function() { return false }
var clicked = false;

function strt(){
   clicked = true;
}

function fnsh(){
    clicked=false;
}

function rest(){
    clicked=false;
}

function inproc(event) {

	// task 3
    if (!clicked) {
        x = event.pageX;
        y = event.pageY;
        w = document.images[0].width;
        h = document.images[0].height;
    }
    else if (document.images[0].width>100 || (event.pageY-y+event.pageX-x)>0) {
        document.images[0].height= h;
        document.images[0].width=w+event.pageX-x
    }

    // task 2
    if (!clicked2) {
        x2 = event.pageX;
    }
    else {
		var hh2 = document.getElementById("hh2");
		if ((x2-event.pageX)>0) {
			rubberText(hh2, 1);
		} else {
			rubberText(hh2, -1);
		}
    }
}