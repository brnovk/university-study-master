var width = document.documentElement.clientWidth-30,
    height = document.documentElement.clientHeight-30;

var x1=0, y1=0;

function moveIt(){
    x = Math.floor( Math.random()*width );
    y = Math.floor( Math.random()*height );
    while (Math.abs(x1-x)<=70) {
    	x = Math.floor(Math.random()*width);
    }
    while (Math.abs(y1-y)<=50) {
    	y = Math.floor(Math.random()*height);
    }
    x1 = x;
    y1 = y;
    startMove();
}

var img = document.getElementById('block');
var x0 = parseInt(img.style.left),
    y0 = parseInt(img.style.top),
        x1,y1, kx,ky, speed=2;
var moveImageTimer;
var lon;

function moveto(){
    kx = x1 - x0;
    ky = y1 - y0;
    lon = Math.sqrt(kx * kx + ky * ky);
    if (lon > 12)
    {
        y0 += Math.round(speed * ky / lon);
        x0 += Math.round(speed * kx / lon);
        img.style.left = x0 +'px';
        img.style.top = y0 +'px';
    }
    else
        clearInterval(moveImageTimer);
}
function startMove() {
clearInterval(moveImageTimer);
    moveImageTimer = setInterval(moveto, 1);
}