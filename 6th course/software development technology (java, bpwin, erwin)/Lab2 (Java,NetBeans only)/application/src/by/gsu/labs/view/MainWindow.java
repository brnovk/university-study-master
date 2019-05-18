package by.gsu.labs.view;

import java.util.Formatter;
import javax.swing.*;

import java.awt.BorderLayout;
import java.awt.event.*;

import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.*;

import by.gsu.labs.controllers.LogicController;
import static by.gsu.labs.constants.Constants.*;


/**
 * Класс главного окна приложения, с реализоваными методами интерфейса слоя
 * представления.
 * @author Viktor Baranov
 */
public class MainWindow extends JFrame implements IView {
    
    /**
     * Контроллер приложения.
     */
    private final LogicController controller;
    
    public MainWindow(LogicController controller) {
        
        // Инициализация компонетов и полей.
        initComponents();
        this.controller = controller;
        jPanelChartArea.setLayout(new BorderLayout());
        
        // Передача инстанса класса в контроллер. 
        controller.setView(this);
        
        // Вызов метода вычисления в контроллере.
        this.controller.calculateSequences();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        averageFieldLabel = new javax.swing.JLabel();
        dispersionFieldLabel = new javax.swing.JLabel();
        averageField = new javax.swing.JTextField();
        dispersionField = new javax.swing.JTextField();
        resultingColumnScrollPane = new javax.swing.JScrollPane();
        resultingColumnArea = new javax.swing.JTextArea();
        resultingColumnLabel = new javax.swing.JLabel();
        exponentialColumnLabel = new javax.swing.JLabel();
        jPanelChartArea = new javax.swing.JPanel();
        exponentialColumnScrollPane = new javax.swing.JScrollPane();
        exponentialColumnArea = new javax.swing.JTextArea();
        jSeparator = new javax.swing.JSeparator();
        jMenuBar = new javax.swing.JMenuBar();
        jMenuButtonAbout = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.gsu.labs.constants.Constants.MAIN_WINDOW_TITLE);
        setLocationByPlatform(true);

        averageFieldLabel.setText(by.gsu.labs.constants.Constants.AVERAGE_LABEL);

        dispersionFieldLabel.setText(by.gsu.labs.constants.Constants.DISPERSION_LABEL);

        resultingColumnArea.setColumns(10);
        resultingColumnArea.setLineWrap(true);
        resultingColumnArea.setRows(5);
        resultingColumnArea.setMargin(new java.awt.Insets(2, 0, 2, 0));
        resultingColumnScrollPane.setViewportView(resultingColumnArea);

        resultingColumnLabel.setText(by.gsu.labs.constants.Constants.RESULTING_COLUMN_LABEL);
        resultingColumnLabel.setMaximumSize(new java.awt.Dimension(110, 28));

        exponentialColumnLabel.setText(by.gsu.labs.constants.Constants.EXPONENTIAL_COLUMN_LABEL);
        exponentialColumnLabel.setMaximumSize(new java.awt.Dimension(110, 28));

        javax.swing.GroupLayout jPanelChartAreaLayout = new javax.swing.GroupLayout(jPanelChartArea);
        jPanelChartArea.setLayout(jPanelChartAreaLayout);
        jPanelChartAreaLayout.setHorizontalGroup(
            jPanelChartAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );
        jPanelChartAreaLayout.setVerticalGroup(
            jPanelChartAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );

        exponentialColumnArea.setColumns(10);
        exponentialColumnArea.setLineWrap(true);
        exponentialColumnArea.setRows(5);
        exponentialColumnArea.setMargin(new java.awt.Insets(2, 0, 2, 0));
        exponentialColumnScrollPane.setViewportView(exponentialColumnArea);

        jMenuButtonAbout.setText(by.gsu.labs.constants.Constants.BUTTON_MENU);
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
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanelChartArea, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jSeparator)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(averageFieldLabel)
                            .addComponent(dispersionFieldLabel))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(dispersionField, javax.swing.GroupLayout.DEFAULT_SIZE, 227, Short.MAX_VALUE)
                            .addComponent(averageField))))
                .addGap(10, 10, 10)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(exponentialColumnScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 130, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(exponentialColumnLabel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(resultingColumnLabel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(resultingColumnScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 130, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(exponentialColumnLabel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(resultingColumnLabel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(averageFieldLabel)
                        .addComponent(averageField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(resultingColumnScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 422, Short.MAX_VALUE)
                    .addComponent(exponentialColumnScrollPane)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(dispersionFieldLabel)
                            .addComponent(dispersionField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jSeparator, javax.swing.GroupLayout.PREFERRED_SIZE, 7, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanelChartArea, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * Обработка нажатия кнопки "Задание"
     * @param evt 
     */
    private void jMenuButtonAboutMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jMenuButtonAboutMouseClicked
        controller.showAboutMessage();
    }//GEN-LAST:event_jMenuButtonAboutMouseClicked

    /**
     * Метод инициализации и отображения гистограмы.
     * @param chartValues Данные для отображения.
     */
    @Override
    public void drawChart(double[] chartValues) {

        CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                null, RANGE_TOOLTIP, normilizeDataChart(chartValues));
        JFreeChart chart = ChartFactory.createBarChart(
            null,                           // chart title
            null,                           // domain axis label
            null,                           // range axis label
            dataset,                        // data
            PlotOrientation.HORIZONTAL,     // orientation
            false,                          // include legend
            false,
            false
        );
        chart.setBackgroundPaint(this.getBackground());

        ChartPanel chartPanel = new ChartPanel(chart);
        jPanelChartArea.removeAll();
        jPanelChartArea.revalidate();
        setChartPanelAutosize(chartPanel, jPanelChartArea);
        jPanelChartArea.add(chartPanel);
        chartPanel.getChartRenderingInfo().setEntityCollection(null);
    }

    /**
     * Метод отоброжения среднего значения.
     * @param value
     */
    @Override
    public void showAverageValue(double value) {
        averageField.setText(String.format(FLOAT_PATTERN, value));
    }

    /**
     * Метод отображения дисперсии.
     * @param value 
     */
    @Override
    public void showDispersion(double value) {
        dispersionField.setText(String.format(FLOAT_PATTERN, value));
    }

    /**
     * Метод отображения экспоненциально-распределённой последовательности.
     * @param sequence 
     */
    @Override
    public void showSequenceExponential(double[] sequence) {
        exponentialColumnArea.setText(null);
        Formatter formatter = new Formatter();
        for (double current : sequence) {
            formatter.format(FLOAT_PATTERN + NEWLINE, current);
        }
        exponentialColumnArea.setText(formatter.toString());
    }

    /**
     * Метод отображения, вычисленой по указанной формуле, последовательности.
     * @param sequence 
     */
    @Override
    public void showSequenceResulting(double[] sequence) {
        resultingColumnArea.setText(null);
        Formatter formatter = new Formatter();
        for (double current : sequence) {
            formatter.format(FLOAT_PATTERN + NEWLINE, current);
        }
        resultingColumnArea.setText(formatter.toString());
    }
    
    /**
     * Вспомогательный метод для корректировки размеров гистограммы.
     * @param chartPanel Панель гистограммы.
     * @param jPanel Панель контейнер в окне.
     */
    private void setChartPanelAutosize(ChartPanel chartPanel, JPanel jPanel) {
        jPanel.addComponentListener(new ComponentAdapter() {
            @Override
            public void componentResized(ComponentEvent e) {
                chartPanel.setMaximumDrawHeight(e.getComponent().getHeight());
                chartPanel.setMaximumDrawWidth(e.getComponent().getWidth());
                chartPanel.setMinimumDrawWidth(e.getComponent().getWidth());
                chartPanel.setMinimumDrawHeight(e.getComponent().getHeight());
            }
        });
    }
    
    /**
     * Вспомогательный метод для преобразования одномерной последовательности
     * в двумерные последовательности-интервалы. Требуется для отображения в
     * панели гистограммы.
     * @param source
     * @return 
     */
    private double[][] normilizeDataChart(double[] source) {
        int inc = -1;
        double[][] result = new double[RANGE_COUNT][RANGE_COUNT];
        for (int i=0; i < RANGE_COUNT; i++) {
            for (int j=0; j < RANGE_COUNT; j++) {
                result[j][i] = source[++inc]; 
            }
        }
        return result;
    }
    
    @SuppressWarnings("Convert2Lambda")
    public static void initializing(LogicController controller) {
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
                new MainWindow(controller).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField averageField;
    private javax.swing.JLabel averageFieldLabel;
    private javax.swing.JTextField dispersionField;
    private javax.swing.JLabel dispersionFieldLabel;
    private javax.swing.JTextArea exponentialColumnArea;
    private javax.swing.JLabel exponentialColumnLabel;
    private javax.swing.JScrollPane exponentialColumnScrollPane;
    private javax.swing.JMenuBar jMenuBar;
    private javax.swing.JMenu jMenuButtonAbout;
    private javax.swing.JPanel jPanelChartArea;
    private javax.swing.JSeparator jSeparator;
    private javax.swing.JTextArea resultingColumnArea;
    private javax.swing.JLabel resultingColumnLabel;
    private javax.swing.JScrollPane resultingColumnScrollPane;
    // End of variables declaration//GEN-END:variables

}