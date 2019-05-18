<h1>Информация для партнёров</h1>
<?php if (isset($partners)) { ?>
    <?php $ind = 1; ?>
    <?php foreach($partners as $value) { ?>
        <div class="section">
            <h2><?= $value['header'] ?></h2>
            <div class="hidden" id='<?php echo 'hideblock'.$ind ?>'>
                <?= $value['body'] ?>
            </div>
            <button id='<?php echo 'showButton'.$ind ?>' onclick=
            '<?php echo 'showDescription("hideblock'.$ind.'", "showButton'.$ind.'");' ?>'>
                Показать информационный блок
            </button>
            <?php if($isAdmin) { ?>
                <form action="partners-delete" method="post">
                    <input type="hidden" name="id" id="id" value="<?= $value['id'] ?>">
                    <input type="submit" value="Удалить">
                </form>
            <?php } ?>
        </div>
        <?php $ind++; ?>
    <?php } ?>
<?php } else { ?>
    <div class="section">
        <p>Список информации для партнёров пуст</p>
    </div>
<?php } ?>
