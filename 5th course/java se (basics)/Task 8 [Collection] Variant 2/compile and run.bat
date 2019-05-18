:: Создание директории для размещения скомпилированных class-файлов
mkdir classes

:: Копирование файла с числами в каталог для скомпилированных классов
:: для последующей упаковки в jar вместе с классами.
COPY "src\numbers.txt" "classes\numbers.txt"

:: Компиляция java-файлов в class-файлы
javac -encoding utf-8 -classpath ./src -d ./classes src/Runner.java

:: Запуск приложения из class-файлов 
:: java -classpath ./classes; Runner
:: pause

:: Создание директории для размещения "запускаемого" jar-файла
mkdir runnable_jar

:: Создание "запускаемого" jar-файла
jar cvmf manifest.mf runnable_jar/appl.jar -C ./classes .
pause

:: Удаление из директории всех созданных class-файлов
rd "classes" /S /Q 

:: Запуск созданного "запускаемого" jar-файла
java -jar runnable_jar/"appl".jar
pause
