using Pochasovka.Database;
using Pochasovka.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace Pochasovka
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private static MainWindow instance = null;

        public MainWindow()
        {
            new PasswordWindow(false).ShowDialog(); // Вызов окна с запросом пароля при запуске
            InitializeComponent();
            instance = this;
        }

        public static MainWindow getInstance()
        {
            return instance;
        }

        /// <summary>
        /// Событие изменения вкладки (Вызавает обновление таблиц с данными)
        /// </summary>
        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (((FrameworkElement)e.Source).GetType() == typeof(System.Windows.Controls.TabControl))
            {
                TablesRefresh();
            }
        }

        /// <summary>
        /// Метод обновления данных во вкладках (В зависимости от выбранной вкладки)
        /// </summary>
        public void TablesRefresh()
        {
            if (tabStructural.IsSelected)  // Подразделения организации
            {
                StructuralHandler structuralHandler = StructuralHandler.getInstance();
                List<Structural> structurals = structuralHandler.getStructurals();
                dataGridStructural.Items.Clear();
                foreach (Structural value in structurals)
                {
                    dataGridStructural.Items.Add(value);
                }
            }
            else if (tabConsumptionSource.IsSelected) // Источники
            {
                ConsumptionSourceHandler consumptionSourceHandler = ConsumptionSourceHandler.getInstance();
                List<ConsumptionSource> consumptionSources = consumptionSourceHandler.getConsumptionSources();
                dataGridConsumptionSource.Items.Clear();
                foreach (ConsumptionSource current in consumptionSources)
                {
                    dataGridConsumptionSource.Items.Add(current);
                }
                StructuralHandler structuralHandler = StructuralHandler.getInstance();
                List<Structural> structurals = structuralHandler.getStructurals();
                comboBoxConsumptionSource.Items.Clear();
                foreach (Structural value in structurals)
                {
                    comboBoxConsumptionSource.Items.Add(value);
                }
                comboBoxConsumptionSource.SelectedIndex = 0;
            }
            else if (tabRate.IsSelected)  // Тарифы
            {
                RateHandler handler = RateHandler.getInstance();
                List<Rate> rates = handler.getRates();
                dataGridRate.Items.Clear();
                foreach (Rate rate in rates)
                {
                    dataGridRate.Items.Add(rate);
                }
            }
            else if (tabLimit.IsSelected)  // Лимиты
            {
                LimitHandler handler = LimitHandler.getInstance();
                List<Limit> limits = handler.getLimits();
                dataGridLimit.Items.Clear();
                foreach (Limit limit in limits)
                {
                    dataGridLimit.Items.Add(limit);
                }
            }
        }

        /// <summary>
        /// Клик по кнопке "Добавлить структуру"
        /// </summary>
        private void buttonAppendStructural_Click(object sender, RoutedEventArgs e)
        {
            string input = textBoxAppendStructural.Text.Trim();
            if (input.Length != 0)
            {
                StructuralHandler structuralHandler = StructuralHandler.getInstance();
                structuralHandler.addStructural(input);
                MessageBox.Show("Структура " + input + " успешно добавлена!", "", 
                    MessageBoxButton.OK, MessageBoxImage.Information);
                textBoxAppendStructural.Clear();
                TablesRefresh();
            }
            else
            {
                MessageBox.Show("Название структуры не указано");
            }
        }

        /// <summary>
        /// Клик по кнопке "Добавлить источник потребления"
        /// </summary>
        private void buttonConsumptionSource_Click(object sender, RoutedEventArgs e)
        {
            Structural selected = (Structural)comboBoxConsumptionSource.SelectedValue;
            if (selected == null)
            {
                MessageBox.Show("Не выбрана структура");
                return;
            }
            string input = textBoxConsumptionSource.Text.Trim();
            if (input.Length != 0)
            {
                ConsumptionSourceHandler handler = ConsumptionSourceHandler.getInstance();
                handler.addConsumptionSources(selected, input);
                MessageBox.Show("Источник " + input + " успешно добавлен!", "",
                    MessageBoxButton.OK, MessageBoxImage.Information);
                textBoxConsumptionSource.Clear();
                TablesRefresh();
            }
            else
            {
                MessageBox.Show("Источник не указан");
            }
        }

        /// <summary>
        /// Клик по кнопке "Добавлить тариф"
        /// </summary>
        private void buttonAppendRate_Click(object sender, RoutedEventArgs e)
        {
            string rateName = textBoxAppendRateName.Text.Trim();
            string rawRateValue = textBoxAppendRateValue.Text.Trim();
            if (rateName.Length == 0)
            {
                MessageBox.Show("Название тарифа пустое");
                return;
            }
            if (rawRateValue.Length == 0)
            {
                MessageBox.Show("Значение тарифа пустое");
                return;
            }
            double rateValue = 0;
            if (!double.TryParse(rawRateValue, NumberStyles.AllowDecimalPoint, 
                CultureInfo.InvariantCulture, out rateValue))
            {
                MessageBox.Show("Значение тарифа должно быть числом");
                return;
            }
            RateHandler handler = RateHandler.getInstance();
            handler.addRate(rateName, rateValue);
            textBoxAppendRateName.Clear();
            textBoxAppendRateValue.Clear();
            MessageBox.Show("Тариф " + rateName + " успешно добавлен!", "", 
                MessageBoxButton.OK, MessageBoxImage.Information);
            TablesRefresh();
        }

        /// <summary>
        /// Клик по кнопке "Добавить лимит". Вызывается окно добавления лимита
        /// </summary>
        private void buttonAppendLimit_Click(object sender, RoutedEventArgs e)
        {
            new LimitAppendWindow().ShowDialog();
        }
        
        /// <summary>
        /// Клик по одной из кнопок "Изменить" в таблице лимитов (Появляются возле каждой записи)
        /// </summary>
        private void buttonLimitEdit_Click(object sender, RoutedEventArgs e)
        {
            Button pressedButton = (Button)sender;
            int limitId = (int)pressedButton.Tag;
            LimitHandler handler = LimitHandler.getInstance();
            Limit limit = handler.getLimitById(limitId);
            new LimitAppendWindow(limit).ShowDialog();
        }

        /// <summary>
        /// Клик по кнопке "Удалить все записи" во вкладке лимитов
        /// </summary>
        private void buttonDeleteAllLimit_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult messageBoxResult = MessageBox.Show(
                "Вы действительно хотите удалить все записи из таблицы лимитов?",
                "Подтверждение удаления", MessageBoxButton.YesNo);
            if (messageBoxResult == MessageBoxResult.Yes)
            {
                LimitHandler handler = LimitHandler.getInstance();
                handler.deleteAllLimits();
                TablesRefresh();
            }
        }

        /// <summary>
        /// Клик по одной из кнопок "Удалить" в таблице лимитов (Появляются возле каждой записи)
        /// </summary>
        private void buttonLimitDelete_Click(object sender, RoutedEventArgs e)
        {
            Button pressedButton = (Button)sender;
            int limitId = (int)pressedButton.Tag;
            LimitHandler handler = LimitHandler.getInstance();
            handler.deleteLimitById(limitId);
            TablesRefresh();
        }

        /// <summary>
        /// Клик по одной из кнопок "Удалить" в таблице тарифов (Появляются возле каждой записи)
        /// </summary>
        private void buttonRateDelete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Button pressedButton = (Button)sender;
                int rateId = (int)pressedButton.Tag;
                RateHandler handler = RateHandler.getInstance();
                handler.deleteRateById(rateId);
                TablesRefresh();
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Клик по одной из кнопок "Удалить" в таблице структур (Появляются возле каждой записи)
        /// </summary>
        private void buttonStructuralDelete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Button pressedButton = (Button)sender;
                int structuralId = (int)pressedButton.Tag;
                StructuralHandler handler = StructuralHandler.getInstance();
                handler.deleteStructuralById(structuralId);
                TablesRefresh();
            } catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Клик по одной из кнопок "Удалить" в таблице источников потребления (Появляются возле каждой записи)
        /// </summary>
        private void buttonConsumptionSourceDelete_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Button pressedButton = (Button)sender;
                int consumptionSourceId = (int)pressedButton.Tag;
                ConsumptionSourceHandler handler = ConsumptionSourceHandler.getInstance();
                handler.deleteConsumptionSourceById(consumptionSourceId);
                TablesRefresh();
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Клик по кнопке меню "Выход"
        /// </summary>
        private void menuButtonExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
        
        /// <summary>
        /// Клик по кнопке меню "Сформировать отчёт"
        /// </summary>
        private void menuButtonReport_Click(object sender, RoutedEventArgs e)
        {
            new ReportHelper().printReport();
        }
        
        /// <summary>
        /// Клик по кнопке меню "Изменить пароль"
        /// </summary>
        private void menuButtonChangePassWord_Click(object sender, RoutedEventArgs e)
        {
            new PasswordWindow(true).ShowDialog();
        }

        /// <summary>
        /// Клик по кнопке меню "О программе"
        /// </summary>
        private void menuButtonAbout_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(
@"ПС: Почасовое планирование электроэнергии - Почасовка.
Программа автоматизирует работу главного электрика предприятия, а также облегчает его работу и максимально ее ускоряет.
                
Программа имеет удобный и понятный пользователю интерфейс и выполняет следующие функции:
- ввод и изменение пароля;
- содержит информацию:
    • о объемах продукции,
    • источниках электропотребления;
    • нормах потребления электроэнергии;
    • количестве потраченной электроэнергии;
    • тарифах за оплату электроэнергии;
    • количестве рабочих дней в месяце;
- формирование отчетов;
- редактирование справочников:
    • тарифы;
    • лимит плановый.

Расчеты, выполняемые программой:
    • Количество потребляемой силовой электроэнергии;
    • Общее количество электроэнергии;
    • Количество электроэнергии потребляемое в один день;
    • Сумма к оплате в тыс.руб с учетом НДС;

Программа предназначена для ежедневного использования по мере необходимости.",
"О программе");
        }



        // Обработки нажатий Enter на элементах во вкладках Структур, Источников и Тарифов
        // (Переход фокуса ввода на следующее поле или нажание кнопки Добавить)

        private void textBoxAppendStructural_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                buttonAppendStructural.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
            }
        }

        private void textBoxConsumptionSource_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                comboBoxConsumptionSource.Focusable = true;
                Keyboard.Focus(comboBoxConsumptionSource);
            }
        }

        private void comboBoxConsumptionSource_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                buttonConsumptionSource.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
            }
        }

        private void textBoxAppendRateName_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                textBoxAppendRateValue.Focusable = true;
                Keyboard.Focus(textBoxAppendRateValue);
            }
        }

        private void textBoxAppendRateValue_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                buttonAppendRate.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
            }
        }
    }
}
