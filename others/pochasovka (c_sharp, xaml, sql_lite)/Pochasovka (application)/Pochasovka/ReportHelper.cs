using System;
using System.Collections.Generic;
using Excel = Microsoft.Office.Interop.Excel;
using System.Windows;
using Pochasovka.Database;
using Pochasovka.Entities;

namespace Pochasovka
{
    /// <summary>
    /// Класс хелпер для создания отчёта
    /// </summary>
    public class ReportHelper
    {
        
        string generateFileName()
        {
            return "Отчёт_почасовка_" + DateTime.Now.ToString("dd.MM.yyyy");
        }

        string getPathToFile()
        {
            string path = null;
            Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog();
            dlg.FileName = generateFileName();
            dlg.DefaultExt = ".xls";
            dlg.Filter = "Microsoft Excel Document (.xls)|*.xls";
            Nullable<bool> result = dlg.ShowDialog();
            if (result == true)
            {
                path = dlg.FileName;
            }
            return path;
        }

        public void printReport()
        {
            string filePath = getPathToFile();
            if (filePath == null)
            {
                return;
            }

            Excel.Application excelApplication;
            Excel.Workbook applicationWorkBook;
            Excel.Worksheet workSheet;
            object misValue = System.Reflection.Missing.Value;
            
            excelApplication = new Excel.Application();
            applicationWorkBook = excelApplication.Workbooks.Add(misValue);

            workSheet = (Excel.Worksheet)applicationWorkBook.Worksheets.get_Item(1);
            workSheet.PageSetup.Orientation = Excel.XlPageOrientation.xlLandscape;

            workSheet.Cells[1, 1] = "Структура";
            workSheet.Cells[1, 2] = "Источник потребления";
            workSheet.Cells[1, 3] = "Рабочих\r\nдней\r\nмесяца";
            workSheet.Cells[1, 4] = "Объём\r\nпродукции";
            workSheet.Cells[1, 5] = "Норма\r\nпотребления";
            workSheet.Cells[1, 6] = "Тариф (стоимость)";
            workSheet.Cells[1, 7] = "Световая\r\nэнергия";
            workSheet.Cells[1, 8] = "Силовая\r\nэнергия";
            workSheet.Cells[1, 9] = "Общая\r\nэнергия";
            workSheet.Cells[1, 10] = "Энергии\r\nв 1 день";
            workSheet.Cells[1, 11] = "Стоимость";
            workSheet.Range["A1", "K1"].AutoFormat(Excel.XlRangeAutoFormat.xlRangeAutoFormatTable1, 
                false, false, true, true, false, true);
            

            LimitHandler limitHandler = LimitHandler.getInstance();
            List<Limit> limits = limitHandler.getLimits();
            int currentRow = 1;
            foreach (Limit limit in limits)
            {
                currentRow++;
                workSheet.Cells[currentRow, 1] = limit.ConsumptionSource.Structural.Name;
                workSheet.Cells[currentRow, 2] = limit.ConsumptionSource.Name;
                workSheet.Cells[currentRow, 3] = limit.DayOfMonth;
                workSheet.Cells[currentRow, 4] = limit.VolumeProducts;
                workSheet.Cells[currentRow, 5] = limit.Norm;
                workSheet.Cells[currentRow, 6] = limit.Rate.Name + "(" + limit.Rate.Value + ")";
                workSheet.Cells[currentRow, 7] = limit.ConsumptionPowerLight;
                workSheet.Cells[currentRow, 8] = limit.ConsumptionPowerElectric;
                workSheet.Cells[currentRow, 9] = limit.TotalPower;
                workSheet.Cells[currentRow, 10] = limit.ConsumedOneDayEnergy;
                workSheet.Cells[currentRow, 11] = limit.Cost;
            }
            workSheet.Range["A1", ("K"+currentRow)].Cells.WrapText = true;

            applicationWorkBook.SaveAs(filePath, Excel.XlFileFormat.xlWorkbookNormal, misValue, misValue, misValue, 
                misValue, Excel.XlSaveAsAccessMode.xlExclusive, misValue, misValue, misValue, misValue, misValue);
            applicationWorkBook.Close(true, misValue, misValue);
            excelApplication.Quit();
            
            releaseObject(workSheet);
            releaseObject(applicationWorkBook);
            releaseObject(excelApplication);

            MessageBox.Show("Файл отчёта успешно создан: \n" + filePath);
        }

        private void releaseObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                MessageBox.Show("Exception Occured while releasing object " + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }
    }
}
