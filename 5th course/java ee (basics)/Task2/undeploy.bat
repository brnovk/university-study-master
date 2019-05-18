:: Удаление war-файла из Tomcat'a. Если сервер сейчас запущен, он может
:: самостоятельно удалить созданный каталог с приложением (webapps\Task2\),
:: каталог со скомпилированными jsp (\work\Catalina\localhost\Task2\) и
:: конфигурационный файл приложения (\conf\Catalina\localhost\Task2.xml).
:: Если сервер сейчас не запущен, он сделает это при последующем запуске.
:: Но для надёжности, ниже удалим соответствующие каталоги и файлы вручную.
DEL "%CATALINA_HOME%\webapps\Task2.war" /S /Q

:: Удаление каталога с развёрнутым приложением
DEL "%CATALINA_HOME%\webapps\Task2\" /S /Q

:: Удаление каталога со скомпилированными jsp.
DEL "%CATALINA_HOME%\work\Catalina\localhost\Task2\" /S /Q

:: Удаление конфигурационного файла приложения
DEL "%CATALINA_HOME%\conf\Catalina\localhost\Task2.xml" /S /Q

pause
