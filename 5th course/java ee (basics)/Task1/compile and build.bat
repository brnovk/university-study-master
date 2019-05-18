:: Создание каталога для размещений скомпилированных class-файлов в соответсвие
:: со структурой war-файла.
mkdir WebContent\WEB-INF\classes

:: Компиляция java-файлов в class-файлы. Для сервлетов указан класс-патч в Servlet API.
javac -encoding utf-8 -classpath ./src;%CATALINA_HOME%\lib\servlet-api.jar -d ./WebContent/WEB-INF/classes src/by/gsu/lab/beans/*.java src/by/gsu/lab/controllers/*.java src/by/gsu/lab/enums/*.java src/by/gsu/lab/helpers/*.java

:: Создание директории для размещения собранного war-файла
mkdir build_war

:: Переход в каталог WebContent
cd WebContent

:: Сборка war-файла в созданном каталоге build_war
jar -cvf ../build_war/Task1.war *

:: Удаление временной директории со скомпилированными class-файлами
rd "WEB-INF/classes" /S /Q 

pause
