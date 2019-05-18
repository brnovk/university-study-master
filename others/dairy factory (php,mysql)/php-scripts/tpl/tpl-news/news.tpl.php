<h1>Новости</h1>
<?php if (isset($news)) { ?>
    <?php $ind = 1; ?>
    <?php foreach($news as $value) { ?>
        <div class="section">
            <h2><?= $value['header'] ?></h2>
            <div class="hidden" id='<?php echo 'hideblock'.$ind ?>'>
                <?= $value['body'] ?>
            </div>
            <button id='<?php echo 'showButton'.$ind ?>' onclick=
                '<?php echo 'showDescription("hideblock'.$ind.'", "showButton'.$ind.'");' ?>'>
                Показать новость
            </button>
            <div class="cleafix">
                <div class="timestamp float-left"><?= $value['dateTime'] ?></div>
                <?php if($isAdmin) { ?>
                    <form action="news-delete" method="post">
                        <input type="hidden" name="id" id="id" value="<?= $value['id'] ?>">
                        <input type="submit" value="Удалить">
                    </form>
                <?php } ?>
            </div>
        </div>
        <?php $ind++; ?>
    <?php } ?>
<?php } else { ?>
    <div class="section">
        <p>Список новостей пуст</p>
    </div>
<?php } ?>
