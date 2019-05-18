using ScheduleWriter.Controllers;
using ScheduleWriter.Model.Beans;

namespace ScheduleWriter.View.Ifaces {

    // Интерфейс для работы с главным окном приложения
    public interface IMainWindowView {

        // Метод установки контроллера приложения
        void SetController(MainController controller);

        // Заполние view переданным в параметре расписанием группы
        void SetScheduleGroup(ScheduleGroup scheduleGroup);
    }
}