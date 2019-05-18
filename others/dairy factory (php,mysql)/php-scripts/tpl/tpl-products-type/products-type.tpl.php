<h1>Типы продукции:</h1>

<?php if (isset($types)) { ?>
    <?php foreach($types as $value) { ?>
        <div class="section">
            <div class="cleafix">
                <h2><?= $value['name'] ?></h2>
                <?php if($isAdmin) { ?>
                    <form action="products-type-delete" method="post">
                        <input type="hidden" name="id" id="id" value="<?= $value['id'] ?>">
                        <input type="submit" value="Удалить">
                    </form>
                <?php } ?>
            </div>
        </div>
    <?php } ?>
<?php } else { ?>
    <div class="section">
        <p>Список типов продукции пуст</p>
    </div>
<?php } ?>


