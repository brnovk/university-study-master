<h1>О компании</h1>
<form name="about-edit" class="add-form form-about" action="about-edit"
      onsubmit='return validateAboutEdit("about-edit", "description", "address");'>

    <input type="hidden" name="id" value="<?= isset($about[0]['id']) ? $about[0]['id'] : '' ?>">
    <div class="cleafix">
        <label class="float-left" for="description">Описание компании:</label>
        <textarea class="float-left" name="description"
              id="description"><?= isset($about[0]['description']) ? strip_tags($about[0]['description']) : '' ?></textarea>
    </div><br>
    <div class="cleafix">
        <label class="float-left" for="address">Адрес:</label>
        <textarea class="float-left" name="address"
              id="address"><?= isset($about[0]['address']) ? $about[0]['address'] : '' ?></textarea>
    </div><br>
    <div class="cleafix">
        <label class="float-left" for="phone1">Телефон (1):</label>
        <input class="float-left" type="text" name="phone1" id="phone1"
               value="<?= isset($about[0]['phone1']) ? $about[0]['phone1'] : '' ?>">
    </div>
    <div class="cleafix">
        <label class="float-left" for="phone2">Телефон (2):</label>
        <input class="float-left" type="text" name="phone2" id="phone2"
               value="<?= isset($about[0]['phone2']) ? $about[0]['phone2'] : '' ?>">
    </div>
    <div class="cleafix">
        <label class="float-left" for="phone3">Телефон (3):</label>
        <input class="float-left" type="text" name="phone3" id="phone3"
               value="<?= isset($about[0]['phone3']) ? $about[0]['phone3'] : '' ?>">
    </div>
    <div class="cleafix">
        <label class="float-left" for="fax">Факс:</label>
        <input class="float-left" type="text" name="fax" id="fax"
               value="<?= isset($about[0]['fax']) ? $about[0]['fax'] : '' ?>">
    </div>
    <input type="submit" value="Сохранить">
</form>


