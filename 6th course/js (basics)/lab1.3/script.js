
var points = [
	{	
		x:(document.documentElement.clientWidth-100)/2, 
		y:0
	},
	{
		x:(document.documentElement.clientWidth-100)/2, 
		y:document.documentElement.clientHeight-40
	}
];

var chunks;
var moveImageTimer;
var chunkIndex;
var chunkPass;
var block;
var stepLength;
var isFirstRun = true;
points.reverse();

function doLogic() {

	if (isFirstRun) {
		var NAME = "Виктор";
		var ID_BLOCK = 'idNameBlock';

		// Создание блока с именем.
		block = document.createElement('div');
		block.setAttribute('id', ID_BLOCK);
		block.innerHTML = NAME;
		document.getElementsByTagName('body')[0].appendChild(block);
		isFirstRun = false;
	}
	chunkIndex = 0;
	chunkPass = 0;
	moveImageTimer = setInterval(moveImage, 1);
	stepLength =  1 ;
	calculateLengths();
	renderImage();
}

function calculateLengths() {
	chunks = [];
	for(var i=0; i<points.length-1; i++) {
		chunks.push(
			Math.sqrt(
				Math.pow(points[i+1].x-points[i].x,2)
				+Math.pow(points[i+1].y-points[i].y,2)
				)
			);
	}
}

function moveImage() {
	chunkPass += stepLength;
	renderImage();
}

function renderImage() {
	if (chunkPass>=chunks[chunkIndex]) {
		chunkPass -= chunks[chunkIndex];
		chunkIndex++;
		if (chunkIndex>=chunks.length) {
			clearInterval(moveImageTimer);
			block.style.top = Math.round(points[chunkIndex].y)+'px';
			points.reverse();
			setTimeout("doLogic()",1000)
			return;
		}
		renderImage();
		return;
	}
	var currentY = points[chunkIndex].y + (chunkPass / chunks[chunkIndex])
		* (points[chunkIndex+1].y-points[chunkIndex].y);

	var currentX = points[chunkIndex].x + (chunkPass / chunks[chunkIndex])
		* (points[chunkIndex+1].x-points[chunkIndex].x)+Math.sin(currentY/50)*60;
	block.style.left = ''+Math.round(currentX)+'px';
	block.style.top = ''+Math.round(currentY)+'px';
}