package by.labs.view;

import by.labs.constants.Constants;
import by.labs.controllers.LogicController;

/**
 * Класс главного окна приложения.
 */
public class MainWindow extends javax.swing.JFrame {
    /**
     * Контроллер приложения.
     */
    private final LogicController controller;
    
    @SuppressWarnings("LeakingThisInConstructor")
    public MainWindow(LogicController controller) {
        initComponents();
        this.controller = controller;
        // Передача инстанса класса в контроллер. 
        controller.setView(this);
        showCaretPosition();
    }
    
    /**
     * Вывод результатов
     * @param result 
     */
    public void printResult(String result) {
        resultTextArea.setText(result);
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonRandom = new javax.swing.JButton();
        buttonCalculate = new javax.swing.JButton();
        sourceScrollPane = new javax.swing.JScrollPane();
        sourceTextArea = new javax.swing.JTextArea();
        resultScrollPane = new javax.swing.JScrollPane();
        resultTextArea = new javax.swing.JTextArea();
        jLabelSource = new javax.swing.JLabel();
        jLabelResult = new javax.swing.JLabel();
        jLabelCaretPosition = new javax.swing.JLabel();
        jMenuBar = new javax.swing.JMenuBar();
        jMenuButtonAbout = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.labs.constants.Constants.MAIN_WINDOW_TITLE);
        setMinimumSize(new java.awt.Dimension(825, 410));

        buttonRandom.setText(by.labs.constants.Constants.BUTTON_RANDOM);
        buttonRandom.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonRandomActionPerformed(evt);
            }
        });

        buttonCalculate.setText(by.labs.constants.Constants.BUTTON_CALCULATE);
        buttonCalculate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonCalculateActionPerformed(evt);
            }
        });

        sourceTextArea.setColumns(20);
        sourceTextArea.setRows(5);
        sourceTextArea.addCaretListener(new javax.swing.event.CaretListener() {
            public void caretUpdate(javax.swing.event.CaretEvent evt) {
                sourceTextAreaCaretUpdate(evt);
            }
        });
        sourceScrollPane.setViewportView(sourceTextArea);

        resultTextArea.setColumns(20);
        resultTextArea.setRows(5);
        resultTextArea.setEnabled(false);
        resultScrollPane.setViewportView(resultTextArea);

        jLabelSource.setText(by.labs.constants.Constants.LABEL_SOURCE);

        jLabelResult.setText(by.labs.constants.Constants.LABEL_RESULT);

        jLabelCaretPosition.setText(" ");

        jMenuButtonAbout.setText(by.labs.constants.Constants.BUTTON_MENU);
        jMenuButtonAbout.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jMenuButtonAboutMouseClicked(evt);
            }
        });
        jMenuBar.add(jMenuButtonAbout);

        setJMenuBar(jMenuBar);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(sourceScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 289, Short.MAX_VALUE)
                    .addComponent(buttonCalculate, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabelCaretPosition)
                            .addComponent(jLabelSource))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addGap(10, 10, 10)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(resultScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 511, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(buttonRandom, javax.swing.GroupLayout.PREFERRED_SIZE, 511, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabelResult))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabelCaretPosition)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabelSource)
                    .addComponent(jLabelResult))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(resultScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 292, Short.MAX_VALUE)
                    .addComponent(sourceScrollPane))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(buttonCalculate, javax.swing.GroupLayout.DEFAULT_SIZE, 33, Short.MAX_VALUE)
                    .addComponent(buttonRandom, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jMenuButtonAboutMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jMenuButtonAboutMouseClicked
        controller.showAboutMessage();
    }//GEN-LAST:event_jMenuButtonAboutMouseClicked

    private void sourceTextAreaCaretUpdate(javax.swing.event.CaretEvent evt) {//GEN-FIRST:event_sourceTextAreaCaretUpdate
        showCaretPosition();
    }//GEN-LAST:event_sourceTextAreaCaretUpdate

    private void buttonCalculateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonCalculateActionPerformed
        // Нажатие кнопки вычисления
        removeSpacesSource();
        String source = sourceTextArea.getText();
        controller.calculate(source);
    }//GEN-LAST:event_buttonCalculateActionPerformed

    private void buttonRandomActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonRandomActionPerformed
        // Нажатие книпки заполения случайными данными
        String random = controller.randomSourceGenerator();
        sourceTextArea.setText(random);
    }//GEN-LAST:event_buttonRandomActionPerformed
    
    /**
     * Отображение в jLabel текущей позиции каретки
     */
    private void showCaretPosition() {
        int caretPosition = sourceTextArea.getCaretPosition()+1;
        jLabelCaretPosition.setText(Constants.CARET_POSITION + caretPosition);
    }
    
    /**
     * Удаление пробелов из введённых пользователем данных.
     */
    private void removeSpacesSource() {

        // избавляемся от пробелов, но не трогаем перевод строк
        String cleared = sourceTextArea.getText().replaceAll(
            Constants.REGEX_SPICE_WITHOUT_NEWLINE, Constants.EMPTY_STRING);
        // избавляемся от неразрывных пробелов 
        cleared = cleared.replaceAll(Constants.REGEX_NBSP, Constants.EMPTY_STRING);
        sourceTextArea.setText(cleared);
    }
    
    @SuppressWarnings("Convert2Lambda")
    public static void initializing(final LogicController controller) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info 
                    : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException | InstantiationException 
                | IllegalAccessException 
                | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainWindow.class.getName())
                    .log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        
        //</editor-fold>

        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new MainWindow(controller).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonCalculate;
    private javax.swing.JButton buttonRandom;
    private javax.swing.JLabel jLabelCaretPosition;
    private javax.swing.JLabel jLabelResult;
    private javax.swing.JLabel jLabelSource;
    private javax.swing.JMenuBar jMenuBar;
    private javax.swing.JMenu jMenuButtonAbout;
    private javax.swing.JScrollPane resultScrollPane;
    private javax.swing.JTextArea resultTextArea;
    private javax.swing.JScrollPane sourceScrollPane;
    private javax.swing.JTextArea sourceTextArea;
    // End of variables declaration//GEN-END:variables
}
