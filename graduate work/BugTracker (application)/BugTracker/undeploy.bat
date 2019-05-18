:: Удаление war-файла из Tomcat'a. Если сервер сейчас запущен, он может
:: самостоятельно удалить созданный каталог с приложением (webapps\BugTracker\),
:: каталог со скомпилированными jsp (\work\Catalina\localhost\BugTracker\) и
:: конфигурационный файл приложения (\conf\Catalina\localhost\BugTracker.xml).
:: Если сервер сейчас не запущен, он сделает это при последующем запуске.
:: Но для надёжности, ниже удалим соответствующие каталоги и файлы вручную.
DEL "%CATALINA_HOME%\webapps\BugTracker.war" /S /Q

:: Удаление каталога с развёрнутым приложением
DEL "%CATALINA_HOME%\webapps\BugTracker\" /S /Q

:: Удаление каталога со скомпилированными jsp.
DEL "%CATALINA_HOME%\work\Catalina\localhost\BugTracker\" /S /Q

:: Удаление конфигурационного файла приложения
DEL "%CATALINA_HOME%\conf\Catalina\localhost\BugTracker.xml" /S /Q

pause
