<?php
try {
    $r = DB::getInstance()->executeQuery("SELECT id, header FROM vacancies");
    if ($r['rows'] !== 0) {
        $vacancies = $r['stmt']->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    // TODO err
    echo 'Возникла исключительная ситуация: ',  $e->getMessage(), "\n";
}
?>

<form name="resume-add" class="add-form" action="resume-add" method="post"
      onsubmit='return validateResumeAdd("resume-add", "message");'>

    <div class="cleafix">
        <label class="float-left" for="vacancies">Вакансия:</label>
        <select class="float-left" name="vacancies" id="vacancies">
            <option value="-1">нет в списке</option>
            <?php if (isset($vacancies)) {
                foreach($vacancies as $value) { ?>
                    <option value="<?= $value['id']; ?>"><?= $value['header']; ?></option>

                <?php } } ?>
        </select><br>
    </div>
    <div class="cleafix">
        <label class="float-left" for="message">Сообщение нанимателю:</label>
        <textarea class="float-left" name="message" id="message"></textarea><br>
    </div>
    <input type="submit" value="Откликнутся на вакансию">
</form>