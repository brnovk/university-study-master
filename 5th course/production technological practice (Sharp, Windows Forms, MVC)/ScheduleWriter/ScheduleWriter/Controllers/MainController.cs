
using System.Collections.Generic;
using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;
using ScheduleWriter.Model.Ifaces;
using ScheduleWriter.View.Ifaces;
using ScheduleWriter.View.Impls;

namespace ScheduleWriter.Controllers {

    // Класс контроллер приложения
    public class MainController {

        private readonly IMainWindowView _view;

        private readonly IModel _model;

        public MainController(IMainWindowView view, IModel model) {
            _view = view;
            _model = model;
        }

        /// <summary>
        /// Перзагрузка расписания во view
        /// </summary>
        public void ViewReboot() {
            var sg = _model.GetScheduleGroup();
            _view.SetScheduleGroup(sg);
        }

        /// <summary>
        /// Метод-предикат существования пары в модели
        /// </summary>
        public bool IsPairExist(WeekDay weekDay, NumberPair numberPair) {
            return _model.IsPairExist(weekDay, numberPair);
        }

        /// <summary>
        /// Проверка возможности вставки пары из буффера в указанную ячейку
        /// </summary>
        public bool IsInsertedIntoCell(WeekDay weekDay, NumberPair numberPair) {
            if (!_model.IsBufferEmpty()) {
                return false;
            }
            var bufferPair = _model.GetBufferPair();
            return ((bufferPair.NumberPair != numberPair) 
                || (bufferPair.WeekDay != weekDay))
                || !_model.IsPairExist(weekDay, numberPair);
        }

        /// <summary>
        /// Метод добавления пары после редактирования в EditWindowView
        /// </summary>
        public void AddPairAfterEditing(Pair pair) {
            if (_model.IsPairExist(pair.WeekDay, pair.NumberPair)) {
                _model.EditPair(pair);
            } else {
                _model.AddPair(pair);
            }
            ViewReboot();
        }

        /// <summary>
        /// Метод для добавления новой пары либо редактирования существующей
        /// </summary>
        public void AddOrEditPair(WeekDay weekDay, NumberPair numberPair) {
            var isExist = _model.IsPairExist(weekDay, numberPair);
            var pair = (isExist) ?
                _model.GetPair(weekDay, numberPair) :
                new Pair(weekDay, numberPair, new List<PartPair>());
            var editingView = new EditWindowView(pair, this);

            editingView.ShowDialog();
        }

        /// <summary>
        /// Копировать пару в буффер
        /// </summary>
        public void CopyPair(WeekDay weekDay, NumberPair numberPair) {
            _model.CopyPair(weekDay, numberPair);
        }

        /// <summary>
        /// Вставить пару из буффера
        /// </summary>
        public void PastePair(WeekDay weekDay, NumberPair numberPair) {
            _model.PastePair(weekDay, numberPair);
            ViewReboot();
        }

        /// <summary>
        /// Метод удаления пары
        /// </summary>
        public void DeletePair(WeekDay weekDay, NumberPair numberPair) {
            _model.DeletePair(weekDay, numberPair);
            ViewReboot();
        }
    }
}
