<h1>Продукция:</h1>

<?php if (isset($products)) { ?>
    <?php $ind = 1; ?>
    <?php foreach($products as $value) { ?>
        <div class="section">
            <h2><?= $value['name'] ?></h2>
            <div class="hidden" id='<?php echo 'hideblock'.$ind ?>'>
                <?= $value['description'] ?>
            </div>
            <button id='<?php echo 'showButton'.$ind ?>' onclick=
            '<?php echo 'showDescription("hideblock'.$ind.'", "showButton'.$ind.'");' ?>'>
                Показать продукт
            </button>
            <div class="cleafix">
                <div class="timestamp float-left"><?= $value['type'] ?></div>
                <?php if($isAdmin) { ?>
                    <form action="products-delete" method="post">
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
        <p>Список продукции пуст</p>
    </div>
<?php } ?>


