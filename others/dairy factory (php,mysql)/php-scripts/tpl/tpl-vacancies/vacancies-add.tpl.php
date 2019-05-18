<form name="vacancies-add" class="add-form" action="vacancies-add" method="post"
      onsubmit='return validateVacanciesAdd("vacancies-add", "header", "body");'>

    <div class="cleafix">
        <label class="float-left" for="header">Заголовок вакансии:</label>
        <input class="float-left" type="text" name="header" id="header"><br>
    </div>
    <div class="cleafix">
        <label class="float-left" for="body">Текст вакансии:</label>
        <textarea class="float-left" name="body" id="body"></textarea><br>
    </div>
    <input type="submit" value="Добавить вакансию">
</form>