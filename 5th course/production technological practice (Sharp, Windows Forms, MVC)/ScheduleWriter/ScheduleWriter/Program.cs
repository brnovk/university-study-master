using System;
using System.Windows.Forms;
using ScheduleWriter.Controllers;
using ScheduleWriter.Model.Ifaces;
using ScheduleWriter.Model.Impls;
using ScheduleWriter.View.Ifaces;
using ScheduleWriter.View.Impls;

namespace ScheduleWriter {

    static class Program {

        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main() {

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            // Главное окно (view) приложения
            IMainWindowView view = new MainWindow();

            // Создание класса релизации модели (model)
            IModel memoryModelImplementation = new MemoryImplementation();

            // Создание контроллера приложения
            var controller = new MainController(view, memoryModelImplementation);

            // Добавление этого контроллера во view
            view.SetController(controller);

            // Вызов метода загрузки данных из model во view
            controller.ViewReboot();

            // Запуск главного окна приложения
            Application.Run((MainWindow)view);
        }
    }
}
