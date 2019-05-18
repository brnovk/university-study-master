using Pochasovka.Database;
using Pochasovka.Entities;
using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace Pochasovka
{
    /// <summary>
    /// Логика взаимодействия для LimitAppendWindow.xaml
    /// </summary>
    public partial class LimitAppendWindow : Window
    {
        /// <summary>
        /// Флаг обозначающий, ведётся редактирование записи или создание новой
        /// </summary>
        private static bool isAppend;

        /// <summary>
        /// Буферный id редактируемой записи (только в режиме редактирования)
        /// </summary>
        private static int editId;

        /// <summary>
        /// Конструтор класса для создания новой записи
        /// </summary>
        public LimitAppendWindow()
        {
            isAppend = true;
            InitializeComponent();
            ComboBoxFilling();
        }

        /// <summary>
        /// Конструктор класса для редактирования записи
        /// </summary>
        /// <param name="limit"></param>
        public LimitAppendWindow(Limit limit) : this()
        {
            isAppend = false;

            // Заполение полей окна и установка указанной записи cobbobox'ов
            editId = limit.Id;
            textBoxLimitEditDayOfMonth.Text = limit.DayOfMonth.ToString();
            textBoxLimitEditVolumeProducts.Text = limit.VolumeProducts.ToString();
            textBoxLimitEditNorm.Text = limit.Norm.ToString();
            textBoxLimitConsumptionPowerLight.Text = limit.ConsumptionPowerLight.ToString();
            textBoxLimitConsumptionPowerElectric.Text = limit.ConsumptionPowerElectric.ToString();
            textBoxLimitConsumptionTotalPower.Text = limit.TotalPower.ToString();
            textBoxLimitConsumptionConsumedOneDayEnergy.Text = limit.ConsumedOneDayEnergy.ToString();
            textBoxLimitConsumptionCost.Text = limit.Cost.ToString();
            int selectIndex = 0;
            foreach (ConsumptionSource item in comboBoxLimitEditConsumptionSource.Items)
            {
                if (item.Equals(limit.ConsumptionSource))
                {
                    comboBoxLimitEditConsumptionSource.SelectedIndex = selectIndex;
                    break;
                }
                selectIndex++;
            }
            selectIndex = 0;
            foreach (Rate item in comboBoxLimitEditRate.Items)
            {
                if (item.Equals(limit.Rate))
                {
                    comboBoxLimitEditRate.SelectedIndex = selectIndex;
                    break;
                }
                selectIndex++;
            }
        }

        /// <summary>
        /// Заполнение комбобоксов данными из БД
        /// </summary>
        private void ComboBoxFilling()
        {
            ConsumptionSourceHandler consumptionSourceHandler = ConsumptionSourceHandler.getInstance();
            List<ConsumptionSource> consumptionSources = consumptionSourceHandler.getConsumptionSources();
            comboBoxLimitEditConsumptionSource.Items.Clear();
            foreach (ConsumptionSource value in consumptionSources)
            {
                comboBoxLimitEditConsumptionSource.Items.Add(value);
            }
            comboBoxLimitEditConsumptionSource.SelectedIndex = 0;

            RateHandler rateHandler = RateHandler.getInstance();
            List<Rate> rates = rateHandler.getRates();
            comboBoxLimitEditRate.Items.Clear();
            foreach (Rate value in rates)
            {
                comboBoxLimitEditRate.Items.Add(value);
            }
            comboBoxLimitEditRate.SelectedIndex = 0;
        }
        
        /// <summary>
        /// Клик по кнопке "Сохранить"
        /// </summary>
        private void limitEditAdd_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Получение строковых данных из окна
                string rawDayOfMonth = textBoxLimitEditDayOfMonth.Text;
                string rawVolumeProducts = textBoxLimitEditVolumeProducts.Text;
                string rawNorm = textBoxLimitEditNorm.Text;
                string rawConsumptionPowerLight = textBoxLimitConsumptionPowerLight.Text;
                Rate selectedRate = (Rate)comboBoxLimitEditRate.SelectedValue;
                ConsumptionSource selectedConsumpionSource = (ConsumptionSource)comboBoxLimitEditConsumptionSource.SelectedValue;

                // Валидация данных (проверка корректности)
                validation(rawDayOfMonth, rawVolumeProducts, rawNorm, rawConsumptionPowerLight, selectedRate, selectedConsumpionSource);

                // Преобразование из строковых типов в нужные
                int dayOfMonth = int.Parse(rawDayOfMonth);
                int volumeProducts = int.Parse(rawVolumeProducts);
                double norm = double.Parse(rawNorm);
                double consumptionPowerLight = double.Parse(rawConsumptionPowerLight);
                double consumptionPowerElectric = calculateConsumptionPowerElectric(volumeProducts, norm);
                double totalPower = calculateTotalPower(consumptionPowerLight, consumptionPowerElectric);
                double consumedOneDayEnergy = calculateConsumedOneDayEnergy(totalPower, dayOfMonth);
                double cost = calculateCost(totalPower, selectedRate);

                // Добавление или изменение записи
                LimitHandler limitHandler = LimitHandler.getInstance();
                if (isAppend)
                {
                    limitHandler.addLimit(dayOfMonth, volumeProducts, norm, consumptionPowerElectric,
                        consumptionPowerLight, totalPower, consumedOneDayEnergy, cost, selectedConsumpionSource, selectedRate);
                } else
                {
                    limitHandler.editLimit(editId, dayOfMonth, volumeProducts, norm, consumptionPowerElectric,
                        consumptionPowerLight, totalPower, consumedOneDayEnergy, cost, selectedConsumpionSource, selectedRate);
                }
                Close();
                MainWindow.getInstance().TablesRefresh();
            } catch (ArgumentException ex)
            {
                // Вывод сообщения об ошибке
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Клик по кнопке "Вычислить"
        /// </summary>
        private void limitEditCalculate_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string rawDayOfMonth = textBoxLimitEditDayOfMonth.Text;
                string rawVolumeProducts = textBoxLimitEditVolumeProducts.Text;
                string rawNorm = textBoxLimitEditNorm.Text;
                string rawConsumptionPowerLight = textBoxLimitConsumptionPowerLight.Text;
                Rate selectedRate = (Rate)comboBoxLimitEditRate.SelectedValue;
                ConsumptionSource selectedConsumpionSource = (ConsumptionSource)comboBoxLimitEditConsumptionSource.SelectedValue;
                validation(rawDayOfMonth, rawVolumeProducts, rawNorm, rawConsumptionPowerLight, selectedRate, selectedConsumpionSource);

                int dayOfMonth = int.Parse(rawDayOfMonth);
                int volumeProducts = int.Parse(rawVolumeProducts);
                double norm = double.Parse(rawNorm);
                double consumptionPowerLight = double.Parse(rawConsumptionPowerLight);
                double consumptionPowerElectric = calculateConsumptionPowerElectric(volumeProducts, norm);
                double totalPower = calculateTotalPower(consumptionPowerLight, consumptionPowerElectric);
                double consumedOneDayEnergy = calculateConsumedOneDayEnergy(totalPower, dayOfMonth);
                double cost = calculateCost(totalPower, selectedRate);

                textBoxLimitConsumptionPowerElectric.Text = consumptionPowerElectric.ToString();
                textBoxLimitConsumptionTotalPower.Text = totalPower.ToString();
                textBoxLimitConsumptionConsumedOneDayEnergy.Text = consumedOneDayEnergy.ToString();
                textBoxLimitConsumptionCost.Text = cost.ToString();
            }
            catch (ArgumentException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Вычисление Силовой энергии
        /// </summary>
        private double calculateConsumptionPowerElectric(int volumeProducts, double norm)
        {
            return volumeProducts * norm;
        }

        /// <summary>
        /// Вычисление Общей энергии
        /// </summary>
        private double calculateTotalPower(double consumptionPowerLight, double consumptionPowerElectric)
        {
            return consumptionPowerLight + consumptionPowerElectric;
        }

        /// <summary>
        /// Вычисление энергии в 1 день
        /// </summary>
        private double calculateConsumedOneDayEnergy(double totalPower, double dayOfMonth)
        {
            return totalPower / dayOfMonth;
        }

        /// <summary>
        /// Вычисление стоимости
        /// </summary>
        private double calculateCost(double totalPower, Rate rate)
        {
            return (rate.Value * totalPower) / (1000.0 * 1.18);
        }

        /// <summary>
        /// Валидация данных (Проверка корректности)
        /// </summary>
        private void validation(String rawDayOfMonth, String rawVolumeProducts, String rawNorm, String rawConsumptionPowerLight,
            Rate selectedRate, ConsumptionSource selectedConsumpionSource)
        {
            if (rawDayOfMonth == null || rawDayOfMonth.Trim().Length == 0)
            {
                throw new ArgumentException("Количество дней месяца пустое");
            }
            int dayOfMonth = 0;
            if (!Int32.TryParse(rawDayOfMonth, out dayOfMonth))
            {
                throw new ArgumentException("Количество рабочих дней месяца должно быть целым числом от 1 до 31");
            }
            if (dayOfMonth < 1 || dayOfMonth > 31)
            {
                throw new ArgumentException("Количество рабочих дней месяца должно быть целым числом от 1 до 31");
            }

            if (rawVolumeProducts == null || rawVolumeProducts.Trim().Length == 0)
            {
                throw new ArgumentException("Обьём продукции не указан");
            }
            int volumeProducts = 0;
            if (!Int32.TryParse(rawVolumeProducts, out volumeProducts))
            {
                throw new ArgumentException("Обьём продукции должен быть неотрицательным целым числом");
            }
            if (volumeProducts < 0)
            {
                throw new ArgumentException("Обьём продукции должен быть неотрицательным целым числом");
            }

            if (rawNorm == null || rawNorm.Trim().Length == 0)
            {
                throw new ArgumentException("Норма не указана");
            }
            double norm = 0;
            if (!Double.TryParse(rawNorm, out norm))
            {
                throw new ArgumentException("Норма должна быть неотрицательным числом");
            }
            if (norm < 0)
            {
                throw new ArgumentException("Норма должна быть неотрицательным числом");
            }

            if (rawConsumptionPowerLight == null || rawConsumptionPowerLight.Trim().Length == 0)
            {
                throw new ArgumentException("Световая энергия не указана");
            }
            double consumptionPowerLight = 0;
            if (!Double.TryParse(rawConsumptionPowerLight, out consumptionPowerLight))
            {
                throw new ArgumentException("Световая энергия должна быть неотрицательным числом");
            }
            if (consumptionPowerLight < 0)
            {
                throw new ArgumentException("Световая энергия должна быть неотрицательным числом");
            }

            if (selectedRate == null)
            {
                throw new ArgumentException("Тариф не указан");
            }
            if (selectedConsumpionSource == null)
            {
                throw new ArgumentException("Источник потребления не указан");
            }
        }

        /// <summary>
        /// Клик по кнопке "Отмена"
        /// </summary>
        private void limitEditCancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }


// Обработки нажатий Enter на элементе (Переход фокуса ввода на следующее поле или нажание кнопки Вычислить)

        private void comboBoxLimitEditConsumptionSource_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                textBoxLimitEditDayOfMonth.Focusable = true;
                Keyboard.Focus(textBoxLimitEditDayOfMonth);
            }
        }

        private void textBoxLimitEditDayOfMonth_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                textBoxLimitEditVolumeProducts.Focusable = true;
                Keyboard.Focus(textBoxLimitEditVolumeProducts);
            }
        }

        private void textBoxLimitEditVolumeProducts_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                textBoxLimitEditNorm.Focusable = true;
                Keyboard.Focus(textBoxLimitEditNorm);
            }
        }

        private void textBoxLimitEditNorm_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                comboBoxLimitEditRate.Focusable = true;
                Keyboard.Focus(comboBoxLimitEditRate);
            }
        }

        private void comboBoxLimitEditRate_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                textBoxLimitConsumptionPowerLight.Focusable = true;
                Keyboard.Focus(textBoxLimitConsumptionPowerLight);
            }
        }

        private void textBoxLimitConsumptionPowerLight_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                limitEditCalculate.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
            }
        }
    }
}
