<form name="news-add" class="add-form" action="news-add" method="post"
      onsubmit='return validateNewsAdd("news-add", "header", "body");'>

    <div class="cleafix">
        <label class="float-left" for="header">Заголовок новости:</label>
        <input class="float-left" type="text" name="header" id="header"><br>
    </div>
    <div class="cleafix">
        <label class="float-left" for="body">Текст новости:</label>
        <textarea class="float-left" name="body" id="body"></textarea><br>
    </div>
    <input type="submit" value="Добавить">
</form>