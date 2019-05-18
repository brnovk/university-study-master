<form name="partners-add" class="add-form" action="partners-add" method="post"
      onsubmit='return validatePartnersAdd("partners-add", "header", "body");'>

    <div class="cleafix">
        <label class="float-left" for="header">Заголовок блока:</label>
        <input class="float-left" type="text" name="header" id="header"><br>
    </div>
    <div class="cleafix">
        <label class="float-left" for="body">Информационный блок:</label>
        <textarea class="float-left" name="body" id="body"></textarea><br>
    </div>
    <input type="submit" value="Добавить">
</form>