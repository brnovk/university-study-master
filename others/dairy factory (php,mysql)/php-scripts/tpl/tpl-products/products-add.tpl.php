<?php
try {
    $r = DB::getInstance()->executeQuery("SELECT id, name FROM typeproduct");
    if ($r['rows'] !== 0) {
        $types = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    // TODO err
    echo 'Возникла исключительная ситуация: ',  $e->getMessage(), "\n";
}
?>

<form name="products-add" class="add-form" action="products-add" method="post"
      onsubmit='return validateProductsAdd("products-add", "name", "description");'>

    <div class="cleafix">
        <label class="float-left" for="name">Название</label>
        <input class="float-left" type="text" name="name" id="name">
    </div>
    <div class="cleafix">
        <label class="float-left" for="type">Тип продукта:</label>
        <select class="float-left" name="type" id="type">
            <?php if (isset($types)) {
                foreach($types as $value) { ?>
                    <option value="<?= $value['id']; ?>"><?= $value['name']; ?></option>

                <?php } } ?>
        </select>
    </div>
    <div class="cleafix">
        <label class="float-left" for="description">Описание</label>
        <textarea class="float-left" name="description" id="description"></textarea>
    </div>
    <input type="submit" value="Добавить">
</form>