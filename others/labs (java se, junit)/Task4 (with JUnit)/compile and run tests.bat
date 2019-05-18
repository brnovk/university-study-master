:: Создание директории для размещения
:: скомпилированных class-файлов тестов и тестируемых классов
mkdir test_classes

:: Компиляция java-файлов тестов и тестируемых классов в class-файлы
javac -encoding utf-8 -classpath ./src;./lib/junit-4.12.jar;./lib/hamcrest-core-1.3.jar -d ./test_classes test/by/test/math/*.java

:: Запуск теста by.test.math.TriangleTest из class-файлов 
java -cp ./test_classes;./lib/hamcrest-core-1.3.jar;./lib/junit-4.12.jar; org.junit.runner.JUnitCore by.test.math.TriangleTest

:: Удаление каталога с class-файлами тестов и тестируемых классов
rd "test_classes" /S /Q 
pause
