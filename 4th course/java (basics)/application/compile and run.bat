:: Создание директории для размещения скомпилированных class-файлов
mkdir classes

:: Компиляция java-файлов в class-файлы
javac -encoding utf-8 -classpath ./src -d ./classes src/Runner.java

:: Запуск приложения из class-файлов 
:: java -classpath ./classes;./libs/com.mysql.jdbc_5.1.5.jar Runner
:: pause

:: Создание директории для размещения "запускаемого" jar-файла и драйвера БД
mkdir runnable_jar\libs

:: Копирование драйвера БД в созданную директорию
XCOPY "libs\com.mysql.jdbc_5.1.5.jar" "runnable_jar\libs" 

:: Создание "запускаемого" jar-файла
jar cvmf manifest.mf runnable_jar/appl.jar -C ./classes .
pause

:: Удаление директории со всеми созданными class-файлами
rd "classes" /S /Q 

:: Запуск созданного "запускаемого" jar-файла
java -jar runnable_jar/"appl".jar
pause
