<h1>О компании</h1>

<?php if (isset($about[0])) { ?>
    <div class="section">
<!--        <h2>Описание:</h2>-->
        <div><?= $about[0]['description'] ?></div>
    </div>
    <div class="section">
        <h2>Адрес:</h2>
        <div><?= $about[0]['address'] ?></div>
    </div>
    <div class="section">
        <h2>Телефоны:</h2>
        <div><?= $about[0]['phone1'] ?></div>
        <div><?= $about[0]['phone2'] ?></div>
        <div><?= $about[0]['phone3'] ?></div>
    </div>
    <div class="section">
        <h2>Факс:</h2>
        <div><?= $about[0]['fax'] ?></div>
    </div>
<?php } ?>

