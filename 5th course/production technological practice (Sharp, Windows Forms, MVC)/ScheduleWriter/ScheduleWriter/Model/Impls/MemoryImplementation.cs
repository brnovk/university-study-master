using System;
using System.Collections.Generic;
using System.Linq;
using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;
using ScheduleWriter.Model.Ifaces;

namespace ScheduleWriter.Model.Impls {

    public class MemoryImplementation : IModel {

        private ScheduleGroup _sg;

        private Pair _bufferPair;

        /// <summary>
        /// Проверка существования пары в модели
        /// </summary>
        public bool IsPairExist(WeekDay weekDay, NumberPair numberPair) {
            return _sg.PairList.Any(
                currentPair => (currentPair.NumberPair == numberPair)
                && (currentPair.WeekDay == weekDay));
        }

        /// <summary>
        /// Получение всего рассписания группы из модели
        /// </summary>
        public ScheduleGroup GetScheduleGroup()
        {
            return _sg ?? (_sg = new ScheduleGroup("", new List<Pair>()));
        }

        public Pair GetPair(WeekDay weekDay, NumberPair numberPair) {
            return _sg.PairList.FirstOrDefault(
                currentPair => (currentPair.NumberPair == numberPair)
                    && (currentPair.WeekDay == weekDay));
        }

        /// <summary>
        /// Метод-предикат проверки пустоты буффера
        /// </summary>
        public bool IsBufferEmpty() {
            return _bufferPair != null;
        }

        /// <summary>
        /// Метод получения пары из буффера
        /// </summary>
        public Pair GetBufferPair() {
            return _bufferPair;
        }

        /// <summary>
        /// Добавнение новой пары в модель
        /// </summary>
        public void AddPair(Pair pair) {
            if (_sg.PairList.Any(currentPair => (currentPair.NumberPair == pair.NumberPair) &&
                                                (currentPair.WeekDay == pair.WeekDay))) {
                throw new ArgumentException("Error adding Pairs");
            }
            _sg.PairList.Add(pair);
        }

        /// <summary>
        /// Изменение существующей пары в модели
        /// </summary>
        public void EditPair(Pair pair) {
            var replacingPair = _sg.PairList.FirstOrDefault(
                currentPair => (currentPair.NumberPair == pair.NumberPair)
                    && (currentPair.WeekDay == pair.WeekDay));
            if (replacingPair == null) {
                throw new ArgumentException("Error editing Pairs");
            }
            _sg.PairList.Remove(replacingPair);
            _sg.PairList.Add(pair);
        }

        /// <summary>
        /// Копирование существующей пары в буфферное поле
        /// </summary>
        public void CopyPair(WeekDay weekDay, NumberPair numberPair) {
            _bufferPair = null;
            foreach (var currentPair in _sg.PairList.Where(
                currentPair => (currentPair.NumberPair == numberPair) &&
                    (currentPair.WeekDay == weekDay))) {
                _bufferPair = new Pair(
                    currentPair.WeekDay, 
                    currentPair.NumberPair, 
                    ((List<PartPair>)currentPair.PartPairs).GetRange(0, currentPair.PartPairs.Count));
                break;
            }
        }

        /// <summary>
        /// Вставка пары из буфферного поля в модель
        /// </summary>
        public void PastePair(WeekDay weekDay, NumberPair numberPair) {
            if (_bufferPair == null) {
                throw new ArgumentException("Error paste Pairs");
            }
            for (var i = _sg.PairList.Count - 1; i >= 0; i--) {
                if ((_sg.PairList[i].NumberPair == numberPair) &&
                    (_sg.PairList[i].WeekDay == weekDay)) {
                    _sg.PairList.RemoveAt(i);
                    break;
                }
            }
            var pastePair = new Pair(
                weekDay, 
                numberPair, 
                ((List<PartPair>)_bufferPair.PartPairs).GetRange(0, _bufferPair.PartPairs.Count));
            _sg.PairList.Add(pastePair);
        }

        /// <summary>
        /// Удаление пары из модели
        /// </summary>
        public void DeletePair(WeekDay weekDay, NumberPair numberPair) {
            for (var i = _sg.PairList.Count - 1; i >= 0; i--) {
                if ((_sg.PairList[i].NumberPair == numberPair) &&
                    (_sg.PairList[i].WeekDay == weekDay)) {
                    _sg.PairList.RemoveAt(i);
                    break;
                }
            }
        }
    }
}
