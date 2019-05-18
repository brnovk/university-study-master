
var mainArray = null;
var virtualArray = null;
var topArray = null;
var leftArray = null;

function init() {
	mainArray = generateMainArray();
	virtualArray = generateVirtualArray(mainArray);
	topArray = generateTopArray(mainArray);
	leftArray = generateLeftArray(mainArray);
	
	var DIV_ID_TOP_TABLE_CONTAINER = "topTableContainer";
	var TOP_TABLE_CLASS = "topPanelTable";
	var topTable = getTopTable(TOP_TABLE_CLASS, topArray);
	var topTableContainer = document.getElementById(DIV_ID_TOP_TABLE_CONTAINER);
	topTableContainer.appendChild(topTable);

	var DIV_ID_LEFT_TABLE_CONTAINER = "leftTableContainer";
	var LEFT_TABLE_CLASS = "leftPanelTable";
	var leftTable = getLeftTable(LEFT_TABLE_CLASS, leftArray);
	var leftTableContainer = document.getElementById(DIV_ID_LEFT_TABLE_CONTAINER);
	leftTableContainer.appendChild(leftTable);

	var DIV_ID_GAME_TABLE_CONTAINER = "gameTableContainerVisible";
	var GAME_TABLE_CLASS = "gameTable";
	var gameTable = getGameTable(GAME_TABLE_CLASS, virtualArray);
	var gameTableContainer = document.getElementById(DIV_ID_GAME_TABLE_CONTAINER);
	gameTableContainer.appendChild(gameTable);

	var DIV_ID_GAME_INVISIBLE_CONTAINER = "gameTableContainerInvisible";
	var INVISIBLE_GAME_TABLE_CLASS = "gameTable";
	var invisibleGameTable = getGameTable(INVISIBLE_GAME_TABLE_CLASS, mainArray);
	var invisibleTableContainer = document.getElementById(DIV_ID_GAME_INVISIBLE_CONTAINER);
	invisibleTableContainer.appendChild(invisibleGameTable);
}

function getTopTable(tableClassName, tableArray) {
	var TR = "tr";
	var TD = "td";
	var TBODY = "tbody";
	var TABLE = "table";
	var table = document.createElement(TABLE);
	table.className = tableClassName;
	var maxRow = 0;
	for (var i = 0; i < tableArray.length; i++) {
		if (tableArray[i] === undefined || tableArray[i].length == 0) {
			continue;
		}
		if (tableArray[i].length > maxRow) {
			maxRow = tableArray[i].length;
		}
	}
	var tbody = document.createElement(TBODY);
	for (var j=0; j < maxRow; j++) {
		var tr = document.createElement(TR);
		for (var i = 0; i < tableArray.length; i++) {

			if (tableArray[i] === undefined || tableArray[i].length == 0) {
				var td = document.createElement(TD);
				tr.appendChild(td);
				continue;
			}
			if (tableArray[i][j] === undefined) {
				var td = document.createElement(TD);
				tr.appendChild(td);
				continue;
			}
			var td = document.createElement(TD);
			td.innerHTML = tableArray[i][j];
			tr.appendChild(td);
		};
		tbody.appendChild(tr);
	};
	table.appendChild(tbody);
	return table;
}

function getLeftTable(tableClassName, tableArray) {
	var TR = "tr";
	var TD = "td";
	var TBODY = "tbody";
	var TABLE = "table";
	var table = document.createElement(TABLE);
	table.className = tableClassName;
	var maxRow = 0;
	for (var i = 0; i < tableArray.length; i++) {
		if (tableArray[i] === undefined || tableArray[i].length == 0) {
			continue;
		}
		if (tableArray[i].length > maxRow) {
			maxRow = tableArray[i].length;
		}
	}
	var tbody = document.createElement(TBODY);
	for (var i = 0; i < tableArray.length; i++) {
		var tr = document.createElement(TR);
		if (tableArray[i] === undefined || tableArray[i].length == 0) {
			for (var j=0; j<maxRow; j++) {
				var td = document.createElement(TD);
				tr.appendChild(td);
			}
			tbody.appendChild(tr);
			continue;
		}
		for (var j=0; j<maxRow; j++) {
			if (tableArray[i][j] === undefined) {
				var td = document.createElement(TD);
				tr.appendChild(td);
			} else {
				var td = document.createElement(TD);
				td.innerHTML = tableArray[i][j];
				tr.appendChild(td);
			}
			tbody.appendChild(tr);
		}
		tbody.appendChild(tr);
	};
	table.appendChild(tbody);
	return table;
}

function getGameTable(tableClassName, tableArray) {
	var TR = "tr";
	var TD = "td";
	var ATTR_ID = "id";
	var ATTR_ONCLICK = "onclick";
	var ACTIVE = "active"
	var TBODY = "tbody";
	var TABLE = "table";
	var table = document.createElement(TABLE);
	table.className = tableClassName;
	var tbody = document.createElement(TBODY);
	for (var i = 0; i < tableArray.length; i++) {
		var tr = document.createElement(TR);
		for (var j=0; j<tableArray[i].length; j++) {
			var td = document.createElement(TD);
			td.setAttribute(ATTR_ID, getIdHelper(i,j));
			td.setAttribute(ATTR_ONCLICK, "tdOnClickHandler('" + i.toString() + "','"+j.toString()+"');");
			if (tableArray[i][j] == 1) {
				td.className = ACTIVE;
			}
			tr.appendChild(td);
		}
		tbody.appendChild(tr);
	};
	table.appendChild(tbody);
	return table;
}

function generateMainArray() {
	var resultArray = new Array (
	    new Array (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,1,1,0,0,0,0,0,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,0,0,0,1,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,1,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0),
	    new Array (0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,0),
	    new Array (0,0,0,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0),
	    new Array (0,0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,1,1,1,0),
	    new Array (0,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,1,1,1,0),
	    new Array (0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
	    new Array (0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
	    new Array (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
	);
	return resultArray;
}

function generateVirtualArray(sourceArray) {
	var resultArray = new Array(sourceArray.length);
	for (var i = 0; i < sourceArray.length; i++) {
		var lineArray = new Array(sourceArray[0].length);
		for (var j = 0; j < sourceArray[0].length; j++) {
			lineArray[j] = 0;
		}
		resultArray[i] = lineArray;
	};
	return resultArray;
}

function generateTopArray(sourceArray) {
    var resultArray = new Array();
    var max = 0;
    var prew,k;
    var buf;

    for (var i = 0; i < sourceArray[0].length; i++) {
        var prew = sourceArray[0][i];
        if (prew==1) {
            buf = new Array(0);
            k = 0;
        } else {
            buf = new Array();
            k = -1;
        }
        for (var j = 0; j < sourceArray.length; j++) {
            if (sourceArray[j][i]==1) {
                if(sourceArray[j][i]>prew) {
                    k++;
                    buf.push(0);
                }
                buf[k]++;
            }
            prew=sourceArray[j][i];
        }
        if (buf.length>max) {
            max = buf.length;
        }
        resultArray.push(buf);
    }
    return resultArray;
}

function generateLeftArray(sourceArray) {
    var resultArray = new Array();
    var max = 0;
    var prew,k;
    var buf;

    for (var i = 0; i < sourceArray.length; i++)
    {
        prew = sourceArray[i][0];
        buf = new Array();
        if (prew==1)
        {
            buf.push(0);
            k = 0;
        }
        else
            k = -1;
        for (var j = 0; j < sourceArray[0].length; j++)
        {
            if (sourceArray[i][j]==1)
            {
                if(sourceArray[i][j]>prew)
                {
                    k++;
                    buf.push(0);
                }
                buf[k]++;
            }
            prew=sourceArray[i][j];
        }
        if (buf.length>max)
            max = buf.length;
        resultArray.push(buf);
    }
    return resultArray;
}

function tdOnClickHandler(x, y) {
	var idTD = getIdHelper(x,y);
	numX = Number(x);
	numY = Number(y);
	var td = document.getElementById(idTD);
	if (virtualArray[numX][numY] === 0) {
		virtualArray[numX][numY] = 1;
		td.className = "active";
	} else {
		virtualArray[numX][numY] = 0;
		document.getElementById(idTD).className =
   			document.getElementById(idTD).className.replace(/(?:^|\s)active(?!\S)/g,'');
	}
}

function getIdHelper(x, y) {
	var resX;
	var resY;
	if (Number(x)>=0 && Number(x)<10) {
		resX = "0" + x.toString();
	} else {
		resX = x.toString();
	}
	if (Number(y)>=0 && Number(y)<10) {
		resY = "0" + y.toString();
	} else {
		resY = y.toString();
	}
	return resX + resY;
} 

function showAnswerBlock() {
	document.getElementById("gameTableContainerVisible").className =
   			document.getElementById("gameTableContainerVisible").className.
   			replace(/(?:^|\s)visible(?!\S)/g, " invisible");
	document.getElementById("gameTableContainerInvisible").className =
   			document.getElementById("gameTableContainerInvisible").className.
   			replace(/(?:^|\s)invisible(?!\S)/g, " visible");
}

function showMainBlock() {
	document.getElementById("gameTableContainerInvisible").className =
   			document.getElementById("gameTableContainerInvisible").className.
   			replace(/(?:^|\s)visible(?!\S)/g, " invisible");
	document.getElementById("gameTableContainerVisible").className =
   			document.getElementById("gameTableContainerVisible").className.
   			replace(/(?:^|\s)invisible(?!\S)/g, " visible");
}

function clearBlock() {
	for (var i=0; i<virtualArray.length; i++) {
		for (var j=0; j<virtualArray[i].length; j++) {
			if (virtualArray[i][j] == 1) {
				document.getElementById(getIdHelper(i,j)).className =
   				document.getElementById(getIdHelper(i,j)).className.
   					replace(/(?:^|\s)active(?!\S)/g, '');;
				virtualArray[i][j] = 0;
			}
		}
	}
}

function verificationBlock() {
	var errors= 0;
	var val= 0;
	var lval=0;
    for (var i=0; i < mainArray.length; i++)
        for (var j=0; j < mainArray[i].length; j++)
        {
            if ((virtualArray[i][j]==1)&&(mainArray[i][j]==0))
                errors++;
            if(mainArray[i][j]==1)
                lval++;
            if(virtualArray[i][j]==1)
                val++;
        }
    val = lval-val+errors;
    if (val==0 && errors==0) {
    	alert("Поздавляем, все клетки успешно заполнены!");
    } else {
	    if (errors==0) {
	        alert("Осталось заполнить клеток: "+val);
	    } else{
	        alert("Осталось заполнить клеток: "+val+"\nОшибок: "+errors);
	    }
	}
}