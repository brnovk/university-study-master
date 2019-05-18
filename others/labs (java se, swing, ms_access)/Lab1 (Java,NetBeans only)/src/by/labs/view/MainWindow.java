package by.labs.view;

import by.labs.constants.Constants;
import by.labs.math.DivisorCalculateHelper;

import java.util.List;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

/**
 * Класс главного окна приложения.
 */
public class MainWindow extends JFrame {
    
    private final DivisorCalculateHelper helper;

    public MainWindow(DivisorCalculateHelper helper) {
        this.helper = helper;
        initComponents();
        setAlignmentTableCols();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        labelNumber = new javax.swing.JLabel();
        number = new javax.swing.JSpinner();
        labelResult = new javax.swing.JLabel();
        divisorCount = new javax.swing.JTextField();
        calculateButton = new javax.swing.JButton();
        scrollPane = new javax.swing.JScrollPane();
        resultTable = new javax.swing.JTable();
        menuBar = new javax.swing.JMenuBar();
        menu = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.labs.constants.Constants.MAIN_WINDOW_TITLE);
        setMinimumSize(new java.awt.Dimension(375, 300));

        labelNumber.setText(by.labs.constants.Constants.LABEL_NUMBER);

        number.setModel(new javax.swing.SpinnerNumberModel(42, 1, 2147483647, 1));

        labelResult.setText(by.labs.constants.Constants.LABEL_RESULT);

        divisorCount.setEnabled(false);

        calculateButton.setText(by.labs.constants.Constants.BUTTON_CALCULATE);
        calculateButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                calculateButtonActionPerformed(evt);
            }
        });

        resultTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Порядковый номер", "Делитель", "Делитель с делимым"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Integer.class, java.lang.Integer.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        scrollPane.setViewportView(resultTable);

        menu.setText(by.labs.constants.Constants.BUTTON_MENU);
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
                    .addComponent(scrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(calculateButton, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(labelResult)
                            .addComponent(labelNumber))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(number, javax.swing.GroupLayout.DEFAULT_SIZE, 279, Short.MAX_VALUE)
                            .addComponent(divisorCount))))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelNumber)
                    .addComponent(number, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(labelResult)
                    .addComponent(divisorCount, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(scrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 153, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(calculateButton, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void calculateButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_calculateButtonActionPerformed
        
        // Получение указнного пользователем числа.
        int inputNumber = (Integer) number.getValue();
        
        // Получение коллекции делителей
        List<int[]> results = helper.calculate(inputNumber);
        
        // Установка размерности таблицы, значений ячеек и выделенной ячейки.
        setTableRows(results.size());
        setTableValues(results);
        
        // Установка значения в поле "Количество делителей".
        setResultFieldValue(results.size());
    }//GEN-LAST:event_calculateButtonActionPerformed
    
    /**
     * Метод установки количества строк таблицы.
     * @param row Количество строк.
     */
    private void setTableRows(int row) {
        ((DefaultTableModel) resultTable.getModel()).setRowCount(row);
    }
    
    /**
     * Метод установки значений ячеек таблицы.
     */
    private void setTableValues(List<int[]> results) {
        for (int i=0; i < results.size(); i++) {
            resultTable.setValueAt(
                    results.get(i)[Constants.COUNTER_INDEX], i, Constants.COUNTER_INDEX);
            resultTable.setValueAt(
                    results.get(i)[Constants.DIVISOR_INDEX], i, Constants.DIVISOR_INDEX);
            resultTable.setValueAt(results.get(i)[Constants.DIVISOR_INDEX] + "*" 
                    + results.get(i)[Constants.QUOTIENT_INDEX], i, Constants.QUOTIENT_INDEX);
        }
    }
    
    /**
     * Метод установки значения поля "Количество делителей".
     */
    private void setResultFieldValue(int count) {
        divisorCount.setText(String.valueOf(count));
    }
    
    /**
     * Вспомогательный метод установки выравнивания в ячейках таблицы
     */
    private void setAlignmentTableCols() {
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.CENTER);
        resultTable.getColumnModel().getColumn(
                Constants.COUNTER_INDEX).setCellRenderer(centerRenderer);
        resultTable.getColumnModel().getColumn(
                Constants.DIVISOR_INDEX).setCellRenderer(centerRenderer);
        resultTable.getColumnModel().getColumn(
                Constants.QUOTIENT_INDEX).setCellRenderer(centerRenderer);
    }
    
    private void menuMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_menuMouseClicked
        // Отображение MessageDialog'а с заданием к лабораторной.
        JOptionPane.showMessageDialog(new JFrame(), Constants.ABOUT_MESSAGE,
            Constants.ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_menuMouseClicked

    @SuppressWarnings("Convert2Lambda")
    public static void initializeView(final DivisorCalculateHelper helper) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info 
                    : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException 
                | InstantiationException 
                | IllegalAccessException 
                | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(
                    MainWindow.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new MainWindow(helper).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton calculateButton;
    private javax.swing.JTextField divisorCount;
    private javax.swing.JLabel labelNumber;
    private javax.swing.JLabel labelResult;
    private javax.swing.JMenu menu;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JSpinner number;
    private javax.swing.JTable resultTable;
    private javax.swing.JScrollPane scrollPane;
    // End of variables declaration//GEN-END:variables
}
