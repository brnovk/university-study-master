package by.gsu.labs.view;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import by.gsu.labs.constants.Constants;
import by.gsu.labs.math.SquareCalculateHelper;

/**
 * Класс главного окна приложения.
 * @author Viktor Baranov
 */
public class MainWindow extends javax.swing.JFrame {

    private final SquareCalculateHelper calculateHelper;
    
    public MainWindow(SquareCalculateHelper calculateHelper) {
        this.calculateHelper = calculateHelper;
        initComponents();
    }
    
    @SuppressWarnings({"unchecked", "Convert2Lambda"})
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        columnsCountLabel = new javax.swing.JLabel();
        columnsCount = new javax.swing.JSpinner();
        calculateButton = new javax.swing.JButton();
        rowsCountLabel = new javax.swing.JLabel();
        rowsCount = new javax.swing.JSpinner();
        resultFieldLabel = new javax.swing.JLabel();
        resultField = new javax.swing.JTextField();
        scrollPane = new javax.swing.JScrollPane();
        resultTable = new javax.swing.JTable();
        menuBar = new javax.swing.JMenuBar();
        menu = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.gsu.labs.constants.Constants.MAIN_WINDOW_TITLE);
        setLocationByPlatform(true);

        columnsCountLabel.setLabelFor(columnsCount);
        columnsCountLabel.setText(by.gsu.labs.constants.Constants.COLUMN_FIELD_LABEL);

        columnsCount.setModel(new javax.swing.SpinnerNumberModel(1, 1, 25, 1));
        columnsCount.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        columnsCount.setName(""); // NOI18N

        calculateButton.setText(by.gsu.labs.constants.Constants.BUTTON_CALCULATE);
        calculateButton.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        calculateButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                calculateButtonActionPerformed(evt);
            }
        });

        rowsCountLabel.setLabelFor(rowsCount);
        rowsCountLabel.setText(by.gsu.labs.constants.Constants.ROW_FIELD_LABEL);

        rowsCount.setModel(new javax.swing.SpinnerNumberModel(1, 1, 25, 1));
        rowsCount.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        resultFieldLabel.setLabelFor(resultField);
        resultFieldLabel.setText(by.gsu.labs.constants.Constants.RESULT_FIELD_LABEL);

        resultField.setEnabled(false);

        resultTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        resultTable.setAutoResizeMode(javax.swing.JTable.AUTO_RESIZE_ALL_COLUMNS);
        resultTable.setCellSelectionEnabled(true);
        resultTable.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        resultTable.setDoubleBuffered(true);
        resultTable.setRowHeight(20);
        resultTable.setRowMargin(0);
        resultTable.setTableHeader(null);
        scrollPane.setViewportView(resultTable);

        menu.setText(by.gsu.labs.constants.Constants.BUTTON_MENU);
        menu.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        menu.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                menuMouseClicked(evt);
            }
        });
        menuBar.add(menu);

        setJMenuBar(menuBar);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(rowsCountLabel)
                            .addComponent(resultFieldLabel)
                            .addComponent(columnsCountLabel))
                        .addGap(10, 10, 10)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(columnsCount, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(rowsCount, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(resultField, javax.swing.GroupLayout.Alignment.TRAILING)))
                    .addComponent(scrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 549, Short.MAX_VALUE)
                    .addComponent(calculateButton, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(columnsCountLabel)
                    .addComponent(columnsCount, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(rowsCount, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(rowsCountLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(resultFieldLabel)
                    .addComponent(resultField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(scrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 349, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(calculateButton, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * Метод вызваемый при нажании на кнопку "Рассчитать".
     * @param evt 
     */
    private void calculateButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_calculateButtonActionPerformed
        
        // Получение указнных пользователем значений.
        int column = (Integer) columnsCount.getValue();
        int row = (Integer) rowsCount.getValue();
        
        // Получение двумерного массива арфметического крадрата.
        long[][] squareValues = calculateHelper.calculateSquare(row, column);
        
        // Установка размерности таблицы, значений ячеек и выделенной ячейки.
        setTableSize(row, column);
        setTableValues(squareValues);
        setTableSelectedValue(row, column);
        
        // Установка значения в поле результата.
        setResultFieldValue(squareValues);
    }//GEN-LAST:event_calculateButtonActionPerformed

    /**
     * Метод вызваемый при нажании на кнопку меню "Задание".
     * @param evt 
     */
    private void menuMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_menuMouseClicked

        // Отображение MessageDialog'а с заданием к лабораторной.
        JOptionPane.showMessageDialog(new JFrame(), Constants.ABOUT_MESSAGE,
            Constants.ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_menuMouseClicked

    /**
     * Метод установки размерности таблицы.
     * @param row Количество строк.
     * @param column Количество столбцов.
     */
    private void setTableSize(int row, int column) {
        ((DefaultTableModel) resultTable.getModel()).setRowCount(row);
        ((DefaultTableModel) resultTable.getModel()).setColumnCount(column);
    }
    
    /**
     * Метод установки значений ячеек таблицы.
     * @param values Массив значений ячеек.
     */
    private void setTableValues(long[][] values) {
        for (int i=0; i<values.length; i++) {
            for (int j=0; j<values[i].length; j++) {
                resultTable.setValueAt(values[i][j], i, j);
            }
        }
    }
    
    /**
     * Метод выделенния указанной ячейки таблицы.
     * @param row Строка с требуемой ячейкой.
     * @param column Столбец с требуемой ячейкой.
     */
    private void setTableSelectedValue(int row, int column) {
        resultTable.changeSelection(row-1, column-1, false, false);
    }
    
    /**
     * Метод установки значения поля "Результат".
     * Устанавливается последнее значение двумерного массива.
     * @param values
     */
    private void setResultFieldValue(long[][] values) {
        long result = values[values.length-1][values[values.length-1].length-1];
        resultField.setText(String.valueOf(result));
    }

    @SuppressWarnings("Convert2Lambda")
    public static void initializeView(SquareCalculateHelper calculateHelper) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : 
                    javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException | 
                InstantiationException | 
                IllegalAccessException | 
                javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(
                MainWindow.class.getName()).log(
                        java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new MainWindow(calculateHelper).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton calculateButton;
    private javax.swing.JSpinner columnsCount;
    private javax.swing.JLabel columnsCountLabel;
    private javax.swing.JMenu menu;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JTextField resultField;
    private javax.swing.JLabel resultFieldLabel;
    private javax.swing.JTable resultTable;
    private javax.swing.JSpinner rowsCount;
    private javax.swing.JLabel rowsCountLabel;
    private javax.swing.JScrollPane scrollPane;
    // End of variables declaration//GEN-END:variables
}
