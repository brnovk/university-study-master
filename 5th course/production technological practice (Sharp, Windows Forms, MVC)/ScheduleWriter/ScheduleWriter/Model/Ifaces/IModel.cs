using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;

namespace ScheduleWriter.Model.Ifaces {

    /// <summary>
    /// Интерфейс определяющий методы работы с моделью
    /// </summary>
    public interface IModel {

        // Предикат существования пары в модели
        bool IsPairExist(WeekDay weekDay, NumberPair numberPair);

        // Вернуть всё расписание группы из модели
        ScheduleGroup GetScheduleGroup();

        // Получение пары из модели
        Pair GetPair(WeekDay weekDay, NumberPair numberPair);

        // Проверка пустоты буффера
        bool IsBufferEmpty();

        // Получение пары из буффера
        Pair GetBufferPair();

        // Добавить новую пару в модель
        void AddPair(Pair pair);

        // Заменить пару в модели
        void EditPair(Pair pair);

        // Копировать пару в буферное поле в модели
        void CopyPair(WeekDay weekDay, NumberPair numberPair);

        // Вставить пару из буфферного поля модели
        void PastePair(WeekDay weekDay, NumberPair numberPair);

        // Удалить пару из модели
        void DeletePair(WeekDay weekDay, NumberPair numberPair);
    }
}