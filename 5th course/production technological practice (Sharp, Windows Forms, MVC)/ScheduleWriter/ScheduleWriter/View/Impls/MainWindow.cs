using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using ScheduleWriter.Controllers;
using ScheduleWriter.Model.Beans;
using ScheduleWriter.Model.Enums;
using ScheduleWriter.View.Ifaces;
using SpannedDataGridViewNet2;

namespace ScheduleWriter.View.Impls {

    public partial class MainWindow : Form, IMainWindowView {

        private const int MinCol = 4;
        private const int MinRow = 1;
        private const int MaxCol = 15;
        private const int MaxRow = 12;

        private static Size _currentSizeMainGrid;

        private WeekDay _activeWeekDay;

        private NumberPair _activeNumberPair;

        private MainController _controller;

        public MainWindow() {
            InitializeComponent();
            InitializeStandartGridCell();
        }

        /// <summary>
        /// Инициализация и задание размеров ячеек хейдеров и пустых ячеек данных
        /// </summary>
        private void InitializeStandartGridCell() {
            #region Создание столбцов и строк

            for (int i = 0; i < ViewConstans.ColumnCount; i++) {
                mainGrid.Columns.Add(new DataGridViewTextBoxColumnEx());
            }
            for (int i = 0; i < ViewConstans.RowCount; i++) {
                mainGrid.Rows.Add(new DataGridViewTextBoxCellEx());
            }

            #endregion

            #region Заполнение горизонтальных хедеров

            mainGrid[0, 0].Value = ViewConstans.EmptyValue;
            ((DataGridViewTextBoxCellEx)mainGrid[0, 0]).ColumnSpan = 4;

            for (int i = 4, j = 0; i < ViewConstans.ColumnCount; i += 2, j++) {
                mainGrid[i, 0].Value = ViewConstans.LabelsWeekDay[j];
                ((DataGridViewTextBoxCellEx)mainGrid[i, 0]).ColumnSpan = 2;
            }

            #endregion

            #region Заполнение первого вертикального хедера (номера пар)

            for (int i = 1, j = 0; i < ViewConstans.RowCount; i += 2, j++) {
                mainGrid[0, i].Value = ViewConstans.PairNumbers[j];
                ((DataGridViewTextBoxCellEx)mainGrid[0, i]).ColumnSpan = 2;
                ((DataGridViewTextBoxCellEx)mainGrid[0, i]).RowSpan = 2;
            }

            #endregion

            #region Заполнение второго вертикального хедера (время пар)

            for (int i = 1, j = 0; i <= ViewConstans.RowCount; i++, j++) {
                mainGrid[2, i].Value = ViewConstans.PairTime[j];
                ((DataGridViewTextBoxCellEx)mainGrid[2, i]).ColumnSpan = 2;
            }

            #endregion

            #region Заполнение MinWeight и FillWeight столбцов и высота 1 строки

            // Номер пары
            mainGrid.Columns[0].FillWeight = ViewConstans.WidthColumnPair;
            mainGrid.Columns[0].MinimumWidth = ViewConstans.WidthColumnPair;
            mainGrid.Columns[1].FillWeight = ViewConstans.WidthColumnPair;
            mainGrid.Columns[1].MinimumWidth = ViewConstans.WidthColumnPair;

            // Время пары
            mainGrid.Columns[2].FillWeight = ViewConstans.WidthColumnTime;
            mainGrid.Columns[2].MinimumWidth = ViewConstans.WidthColumnTime;
            mainGrid.Columns[3].FillWeight = ViewConstans.WidthColumnTime;
            mainGrid.Columns[3].MinimumWidth = ViewConstans.WidthColumnTime;

            // Столбцы дней недели
            for (int i = 4; i < ViewConstans.ColumnCount; i += 2) {
                mainGrid.Columns[i].FillWeight = ViewConstans.WidthColumnWeekday;
                mainGrid.Columns[i].MinimumWidth = ViewConstans.WidthColumnWeekday;
                mainGrid.Columns[i + 1].FillWeight = ViewConstans.WidthColumnWeekday;
                mainGrid.Columns[i + 1].MinimumWidth = ViewConstans.WidthColumnWeekday;
            }

            // Высота 1 строки
            mainGrid.Rows[0].MinimumHeight = 20;

            #endregion

            #region Заполнение ячеек данных пустыми значениями)

            for (int j = 4; j < ViewConstans.ColumnCount; j += 2) {
                for (int i = 1; i < ViewConstans.RowCount; i += 2) {
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i]).ColumnSpan = 2;
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i]).RowSpan = 2;
                }
            }

            #endregion
        }

        /// <summary>
        /// Метод установки контроллера приложения
        /// </summary>
        public void SetController(MainController controller) {
            _controller = controller;
        }

        // Заполнение таблицы парами группы.
        public void SetScheduleGroup(ScheduleGroup scheduleGroup) {
            for (int j = 4; j < ViewConstans.ColumnCount; j += 2) {
                for (int i = 1; i < ViewConstans.RowCount; i += 2) {
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i]).ColumnSpan = 2;
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i]).RowSpan = 2;
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i]).Value = ViewConstans.EmptyValue;
                    ((DataGridViewTextBoxCellEx)mainGrid[j, i + 1]).Value = ViewConstans.EmptyValue;
                    ((DataGridViewTextBoxCellEx)mainGrid[j + 1, i]).Value = ViewConstans.EmptyValue;
                    ((DataGridViewTextBoxCellEx)mainGrid[j + 1, i + 1]).Value = ViewConstans.EmptyValue;
                }
            }

            IList<Pair> pairs = scheduleGroup.PairList;
            foreach (WeekDay weekDay in Enum.GetValues(typeof(WeekDay))) {
                foreach (NumberPair numberPair in Enum.GetValues(typeof(NumberPair))) {
                    bool hasFound = false;
                    Pair foundPair = null;
                    foreach (Pair pair in pairs) {
                        if ((pair.NumberPair == numberPair) && (pair.WeekDay == weekDay)) {
                            hasFound = true;
                            foundPair = pair;
                            break;
                        }
                    }
                    // Если в этот день недели по этому номеру пары есть запись - заполняем ячейку
                    if (hasFound) {
                        // Вычисление индекса ячейки
                        int[] indexes = GetIndexesFromWeekDayAndNumberPair(weekDay, numberPair);

                        IList<PartPair> partPairs = foundPair.PartPairs;
                        foreach (PartPair currentPart in partPairs)
                        {
                            var val = currentPart.SubjectName + " " + currentPart.Audience + "\n" 
                                        + currentPart.Lecturer1 + " " + currentPart.Lecturer2;
                            switch (currentPart.Type) // [столбец , строка]
                            {
                                case PartPairType.PairWholeGroup:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 2;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 2;
                                    mainGrid[indexes[0], indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairSubgroupFirst:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 2;
                                    mainGrid[indexes[0], indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairSubgroupSecond:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0] + 1, indexes[1]]).RowSpan = 2;
                                    mainGrid[indexes[0] + 1, indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairWholeGroupOverLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 2;
                                    mainGrid[indexes[0], indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairWholeGroupBelowLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1] + 1]).ColumnSpan = 2;
                                    mainGrid[indexes[0], indexes[1] + 1].Value = val;
                                    break;
                                case PartPairType.PairSubgroupFirstOverLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 1;
                                    mainGrid[indexes[0], indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairSubgroupSecondOverLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0] + 1, indexes[1]]).RowSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).ColumnSpan = 1;
                                    mainGrid[indexes[0] + 1, indexes[1]].Value = val;
                                    break;
                                case PartPairType.PairSubgroupFirstBelowLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1] + 1]).ColumnSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 1;
                                    mainGrid[indexes[0], indexes[1] + 1].Value = val;
                                    break;
                                case PartPairType.PairSubgroupSecondBelowLine:
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1] + 1]).ColumnSpan = 1;
                                    ((DataGridViewTextBoxCellEx)mainGrid[indexes[0], indexes[1]]).RowSpan = 1;
                                    mainGrid[indexes[0] + 1, indexes[1] + 1].Value = val;
                                    break;
                            }
                        }
                    }
                }
            }
        }

        private void mainGrid_Paint(object sender, PaintEventArgs e) {
            const int firstRowHeight = 20;
            if (mainGrid.Size != _currentSizeMainGrid) {
                mainGrid.Rows[0].Height = firstRowHeight;
                int rowHeight = 
                    (mainGrid.Height - mainGrid.Rows[0].Height) / (mainGrid.Rows.Count - 1);
                bool isFirst = true;
                foreach (DataGridViewRow currentRow in mainGrid.Rows) {
                    if (isFirst) // В первой строке Height не меняем
                    {
                        isFirst = false;
                        continue;
                    }
                    currentRow.Height = rowHeight;
                }
                mainGrid.Rows[mainGrid.Rows.Count - 1].Height += 
                    (mainGrid.Height - mainGrid.Rows[0].Height) % (mainGrid.Rows.Count - 1);
                mainGrid.Rows[mainGrid.Rows.Count - 1].Height -= 3; // TODO Разобрать
                _currentSizeMainGrid = mainGrid.Size;
            }
            if (ViewConstans.FirstInitialize) {
                actionCellPanel.BringToFront();
                RelocationActionCellPanel();
                ChangingActionButtonsPanel();
                ViewConstans.FirstInitialize = false;
            }
        }

        // Движение мыши над ячейкой
        private void mainGrid_CellMouseMove(object sender, DataGridViewCellMouseEventArgs e) {
            // Если ячейка является ячейкой "пары"
            if (IsDataCell(e)) {
                SetActiveCellParameters(e);
                RelocationActionCellPanel();
                ChangingActionButtonsPanel();
            }
        }

        // Изменения значений и handler'ов кнопок actionCellPanel
        private void ChangingActionButtonsPanel() {
            // Кнопка копирования активна только над существующей ячейкой
            actionCellCopy.Enabled = _controller.IsPairExist(_activeWeekDay, _activeNumberPair);

            // Кнопка вставки активна только если буфер не пуст и не над ячейкой с данными из буфера
            actionCellPaste.Enabled = _controller.IsInsertedIntoCell(_activeWeekDay, _activeNumberPair);

            // Кнопка удаления активна только над существующей ячейкой
            actionCellDelete.Enabled = _controller.IsPairExist(_activeWeekDay, _activeNumberPair);

            actionCellAddEdit.Text = (_controller.IsPairExist(_activeWeekDay, _activeNumberPair)) ? "E" : "+";
        }

        /// <summary>
        /// Метод перемещения ActionCellPanel в зависимости от _activeWeekDay и _activeNumberPair
        /// </summary>
        private void RelocationActionCellPanel() {
            var indexes = GetIndexesFromActiveCell();
            var col = indexes[0];
            var row = indexes[1];
            var rect = mainGrid.GetCellDisplayRectangle(col, row, true);
            actionCellPanel.Location = new Point(rect.X, rect.Y);
        }

        /// <summary>
        /// Метод устновки значений полей _activeWeekDay и _activeNumberPair.
        /// </summary>
        private void SetActiveCellParameters(DataGridViewCellMouseEventArgs e) {
            var col = e.ColumnIndex;
            var row = e.RowIndex;
            _activeWeekDay = EnumDescription.GetWeekDay((col - MinCol) / 2);
            _activeNumberPair = EnumDescription.GetNumberPair((row - MinRow) / 2);
        }

        // Получение индексов ячеек из значений полей _activeWeekDay и _activeNumberPair
        private int[] GetIndexesFromActiveCell() {
            return GetIndexesFromWeekDayAndNumberPair(_activeWeekDay, _activeNumberPair);
        }

        // Получение индексов ячеек из WeekDay и NumberPair
        private int[] GetIndexesFromWeekDayAndNumberPair(WeekDay weekDay, NumberPair numberPair) {
            var resultIndexes = new int[2];
            resultIndexes[0] = ((int)weekDay * 2) + MinCol;       // col
            resultIndexes[1] = ((int)numberPair * 2) + MinRow;    // row
            return resultIndexes;
        }

        /// <summary>
        /// Метод-предикат проверки ячейки на то, является из она ячейкой данных (пар)
        /// </summary>
        private bool IsDataCell(DataGridViewCellMouseEventArgs e) {
            var col = e.ColumnIndex;
            var row = e.RowIndex;
            if ((col >= MinCol) && (col <= MaxCol)) {
                if ((row >= MinRow) && (row <= MaxRow)) {
                    return true;
                }
            }
            return false;
        }

        // Кнопка добавления или редактирования
        private void actionCellAddEdit_Click(object sender, EventArgs e) {
            _controller.AddOrEditPair(_activeWeekDay, _activeNumberPair);
        }

        // Кнопка копирования
        private void actionCellCopy_Click(object sender, EventArgs e) {
            _controller.CopyPair(_activeWeekDay, _activeNumberPair);
        }

        // Кнопка вставки
        private void actionCellPaste_Click(object sender, EventArgs e) {
            _controller.PastePair(_activeWeekDay, _activeNumberPair);
        }

        // Кнопка удаления
        private void actionCellDelete_Click(object sender, EventArgs e) {
            _controller.DeletePair(_activeWeekDay, _activeNumberPair);
        }
    }
}
