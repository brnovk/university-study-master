
 function doLogic() {

 	var NAME = "Виктор";
 	var ID_BLOCK = 'idNameBlock';

	// Создание блока с именем.
	var nameBlock = document.createElement('div');
	nameBlock.setAttribute('id', ID_BLOCK);
	nameBlock.innerHTML = NAME;
	document.getElementsByTagName('body')[0].appendChild(nameBlock);


 	/**
 	 * Костыль для удивительной парадигмы разработки на js=)
 	 * http://habrahabr.ru/post/134823/
 	 * http://javascript.ru/forum/misc/22329-vremya-vypolneniya.html
 	 */
    window.wait = function(first) {
        return new (function(){
            var self = this;
            var callback = function(){
                var args;
                if(self.deferred.length) {
                    args = [].slice.call(arguments);
                    args.unshift(callback);
                    self.deferred[0].apply(self, args);
                    self.deferred.shift();
                }
            }
            this.wait = function(run){
                this.deferred.push(run);
                return self;
            }
             
            this.deferred = [];
             
            first(callback);
        })
    }

	var timerId = setTimeout(function tick() {

		// Установка стартовой позиции
		setBlockPosition(ID_BLOCK, (getQuarterWidth()*3), (getQuarterHeight()*3));

		wait(function(runNext){
		moveBlock(ID_BLOCK, (getQuarterWidth()), (getQuarterHeight()*3));
		setTimeout( function() { runNext(); }, 2000);

		}).wait(function(runNext, a, b){
		moveBlock(ID_BLOCK, (getQuarterWidth()*3), (getQuarterHeight()));
		setTimeout(runNext, 2000);

		}).wait(function(runNext){
		moveBlock(ID_BLOCK, (getQuarterWidth()), (getQuarterHeight()));
		setTimeout(runNext, 2000);

		}).wait(function(runNext){
		setTimeout(runNext, 500);

		});
		timerId = setTimeout(tick, 6500);
	}, 500);
}

/**
 * Получить ширину окна
 */
 function getWidthWindow() {
 	return document.documentElement.clientWidth;
 }

/**
 * Получить высоту окна
 */
 function getHeightWindow() {
	return document.documentElement.clientHeight;
 }

/**
 * Установить позицию блока.
 */
 function setBlockPosition(idElement, left, top) {
	var element = document.getElementById(idElement);
	element.style.left = left.toString()+"px";
	element.style.top = top.toString()+"px";
 }

/**
 * Перемещение блок на указанную величину.
 */
 function moveBlock(idElement, newLeft, newTop) {
 	var element = document.getElementById(idElement);
 	var left = parseInt(getComputedProperty(element, 'left'), 10);
 	var top = parseInt(getComputedProperty(element, 'top'), 10);

 	var dx = left - newLeft;
 	var dy = top - newTop;
 	var i = 1;
 	var count = 70;
 	var delay = 20;

 	function loop() {
 		if ( i >= count ) { 
 			return; 
 		}
 		i += 1;
 		element.style.left = ( left - ( dx * i / count ) ).toFixed( 0 ) + 'px';
 		element.style.top = ( top - ( dy * i / count ) ).toFixed( 0 ) + 'px';
 		setTimeout( loop, delay );
 	}
 	loop();
 }

/**
 * Получить вычисленное браузером свойство.
 */
 function getComputedProperty( element, property ) {
 	return window.getComputedStyle( element, null ).getPropertyValue( property );
 }

/**
 * Получить четверть ширины экрана.
 */
 function getQuarterWidth() {
 	return ((getWidthWindow()/4)|0);
 }

/**
 * Получить четверть высоты экрана.
 */
 function getQuarterHeight() {
 	return ((getHeightWindow()/4)|0);
 }