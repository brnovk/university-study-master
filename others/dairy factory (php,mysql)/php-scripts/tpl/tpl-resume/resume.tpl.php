<h1>Присланные резюме:</h1>
<?php if (isset($resume)) { ?>
    <?php $ind = 1; ?>
    <?php foreach($resume as $value) { ?>
        <div class="section">
            <h2><?= $value['vacancies'] ?></h2>
            <div class="hidden" id='<?php echo 'hideblock'.$ind ?>'>
                <?= $value['message'] ?>
            </div>
            <button id='<?php echo 'showButton'.$ind ?>' onclick=
            '<?php echo 'showDescription("hideblock'.$ind.'", "showButton'.$ind.'");' ?>'>
                Показать резюме
            </button>
            <?php if($isAdmin) { ?>
                <form action="resume-delete" method="post">
                    <input type="hidden" name="id" id="id" value="<?= $value['id'] ?>">
                    <input type="submit" value="Удалить">
                </form>
            <?php } ?>
        </div>
        <?php $ind++; ?>
    <?php } ?>
<?php } else { ?>
    <div class="section">
        <p>Список резюме пуст</p>
    </div>
<?php } ?>
