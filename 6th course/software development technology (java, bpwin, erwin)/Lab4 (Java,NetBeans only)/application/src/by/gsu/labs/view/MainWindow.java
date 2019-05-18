package by.gsu.labs.view;

import by.gsu.labs.constants.Constants;
import by.gsu.labs.math.DefiniteIntegral;
import by.gsu.labs.controllers.LogicController;
import javax.swing.*;
import java.util.List;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;
import be.ugent.caagt.jmathtex.*;
import org.jfree.chart.*;
import org.jfree.data.xy.*;
import org.jfree.chart.plot.*;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.renderer.xy.XYItemRenderer;

/**
 * Класс главного окна приложения.
 * @author Victor Baranov
 */
public class MainWindow extends JFrame implements IView {

    /**
     * Контроллер приложения.
     */
    private final LogicController controller;
    
    @SuppressWarnings("LeakingThisInConstructor")
    public MainWindow(LogicController controller) {
        
        initComponents();
        this.controller = controller;
        showLatexFormula(Constants.LATEX_PATTERN);
        jPanelChartArea.setLayout(new BorderLayout());
        
        // Передача инстанса класса в контроллер. 
        controller.setView(this);
    }
    
    private void showLatexFormula(String latexPattern) {
        // https://www.codecogs.com/latex/eqneditor.php
        TeXFormula formula = new TeXFormula(latexPattern);
        Icon icon = formula.createTeXIcon(TeXConstants.STYLE_DISPLAY, 35);
        BufferedImage image = new BufferedImage(
                icon.getIconWidth(), 
                icon.getIconHeight(), 
                BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2 = image.createGraphics();
        icon.paintIcon(new JLabel(), g2, 0, 0); // component can't be null
        
        this.jPanelFormulaArea.add(new JLabel(new ImageIcon(image)));
        this.jPanelFormulaArea.setLayout(new FlowLayout());
    }
    
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
    
    @Override
    public void drawChart(DefiniteIntegral integral) {
        
        XYSeriesCollection xySeriesCollection = new XYSeriesCollection();
        String chartLegend = String.format(Constants.CHART_LEGEND_PATTERN, 
                integral.getDigitsAfterPoint(), 
                integral.getSubIntervalCount(),
                integral.getSubIntervalLength(),
                integral.getLowLimit(),
                integral.getHighLimit());
        XYSeries series = new XYSeries(chartLegend);
        List<List<Double>> coordinates = integral.getCoordinates();
        for (List<Double> currentDot : coordinates) {
            series.add(currentDot.get(1), currentDot.get(0));
        }
        xySeriesCollection.addSeries(series);
        
        JFreeChart jfreechart = ChartFactory.createScatterPlot(
            null, null, null, xySeriesCollection,
            PlotOrientation.VERTICAL, true, true, false);
        XYPlot xyPlot = (XYPlot) jfreechart.getPlot();
        xyPlot.setDomainCrosshairVisible(true);
        xyPlot.setRangeCrosshairVisible(true);
        XYItemRenderer renderer = xyPlot.getRenderer();
        renderer.setSeriesPaint(0, Color.blue);
        NumberAxis domain = (NumberAxis) xyPlot.getDomainAxis();
        domain.setVerticalTickLabels(true);
        jfreechart.setBackgroundPaint(this.getBackground());
        
        ChartPanel chartPanel = new ChartPanel(jfreechart);
        jPanelChartArea.removeAll();
        jPanelChartArea.revalidate();
        setChartPanelAutosize(chartPanel, jPanelChartArea);
        jPanelChartArea.setLayout(new BorderLayout());
        jPanelChartArea.add(chartPanel, BorderLayout.CENTER);
        chartPanel.getChartRenderingInfo().setEntityCollection(null);
    }

    @Override
    public void showResult(DefiniteIntegral definiteIntegral) {
        String pattern = "%." + definiteIntegral.getDigitsAfterPoint() + "f";
        jTextFieldResult.setText(
                String.format(pattern, definiteIntegral.getResult()));
    }

    @SuppressWarnings({"unchecked", "Convert2Lambda"})
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanelFormulaArea = new javax.swing.JPanel();
        jLabelLowLimit = new javax.swing.JLabel();
        jTextFieldLowLimit = new javax.swing.JTextField();
        jLabelHighLimit = new javax.swing.JLabel();
        jTextFieldHighLimit = new javax.swing.JTextField();
        jLabelSubIntervalCount = new javax.swing.JLabel();
        jTextFieldSubIntervalCount = new javax.swing.JTextField();
        jSeparator = new javax.swing.JSeparator();
        jButtonCalculate = new javax.swing.JButton();
        jLabelResult = new javax.swing.JLabel();
        jTextFieldResult = new javax.swing.JTextField();
        jPanelChartArea = new javax.swing.JPanel();
        jLabelDigitAfterPoint = new javax.swing.JLabel();
        jTextFieldDigitAfterPoint = new javax.swing.JTextField();
        jMenuBar = new javax.swing.JMenuBar();
        jMenuButtonAbout = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.gsu.labs.constants.Constants.MAIN_WINDOW_TITLE);

        jPanelFormulaArea.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        javax.swing.GroupLayout jPanelFormulaAreaLayout = new javax.swing.GroupLayout(jPanelFormulaArea);
        jPanelFormulaArea.setLayout(jPanelFormulaAreaLayout);
        jPanelFormulaAreaLayout.setHorizontalGroup(
            jPanelFormulaAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 229, Short.MAX_VALUE)
        );
        jPanelFormulaAreaLayout.setVerticalGroup(
            jPanelFormulaAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 120, Short.MAX_VALUE)
        );

        jLabelLowLimit.setText(by.gsu.labs.constants.Constants.LABEL_LOW_LIMIT);

        jTextFieldLowLimit.setText("0");

        jLabelHighLimit.setText(by.gsu.labs.constants.Constants.LABEL_HIGH_LIMIT);

        jTextFieldHighLimit.setText("3");

        jLabelSubIntervalCount.setText(by.gsu.labs.constants.Constants.LABEL_SUB_INTERVAL_COUNT);

        jTextFieldSubIntervalCount.setText("40");

        jButtonCalculate.setText(by.gsu.labs.constants.Constants.BUTTON_CALCULATE);
        jButtonCalculate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonCalculateActionPerformed(evt);
            }
        });

        jLabelResult.setText(by.gsu.labs.constants.Constants.LABEL_RESULT);

        javax.swing.GroupLayout jPanelChartAreaLayout = new javax.swing.GroupLayout(jPanelChartArea);
        jPanelChartArea.setLayout(jPanelChartAreaLayout);
        jPanelChartAreaLayout.setHorizontalGroup(
            jPanelChartAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );
        jPanelChartAreaLayout.setVerticalGroup(
            jPanelChartAreaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 190, Short.MAX_VALUE)
        );

        jLabelDigitAfterPoint.setText(by.gsu.labs.constants.Constants.LABEL_DIGITS_AFTER_POINT);

        jTextFieldDigitAfterPoint.setText("10");

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
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanelChartArea, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jSeparator)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jPanelFormulaArea, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabelHighLimit)
                            .addComponent(jLabelSubIntervalCount)
                            .addComponent(jLabelLowLimit)
                            .addComponent(jLabelDigitAfterPoint))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jTextFieldSubIntervalCount, javax.swing.GroupLayout.DEFAULT_SIZE, 277, Short.MAX_VALUE)
                            .addComponent(jTextFieldLowLimit)
                            .addComponent(jTextFieldHighLimit)
                            .addComponent(jTextFieldDigitAfterPoint)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabelResult)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jTextFieldResult)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButtonCalculate)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabelLowLimit)
                            .addComponent(jTextFieldLowLimit, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabelHighLimit)
                            .addComponent(jTextFieldHighLimit, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabelSubIntervalCount)
                            .addComponent(jTextFieldSubIntervalCount, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabelDigitAfterPoint)
                            .addComponent(jTextFieldDigitAfterPoint, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(jPanelFormulaArea, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jSeparator, javax.swing.GroupLayout.PREFERRED_SIZE, 2, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButtonCalculate)
                    .addComponent(jLabelResult)
                    .addComponent(jTextFieldResult, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanelChartArea, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButtonCalculateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonCalculateActionPerformed
        String draftLowLimit = this.jTextFieldLowLimit.getText();
        String draftHighLimit = this.jTextFieldHighLimit.getText();
        String draftSubIntervalCount = this.jTextFieldSubIntervalCount.getText();
        String draftEpsilon = this.jTextFieldDigitAfterPoint.getText();
        controller.calculateIntegral(
                draftLowLimit, 
                draftHighLimit, 
                draftSubIntervalCount, 
                draftEpsilon);
    }//GEN-LAST:event_jButtonCalculateActionPerformed

    private void jMenuButtonAboutMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jMenuButtonAboutMouseClicked
        controller.showAboutMessage();
    }//GEN-LAST:event_jMenuButtonAboutMouseClicked

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
            java.util.logging.Logger.getLogger(MainWindow.class.getName()).log(
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
    private javax.swing.JButton jButtonCalculate;
    private javax.swing.JLabel jLabelDigitAfterPoint;
    private javax.swing.JLabel jLabelHighLimit;
    private javax.swing.JLabel jLabelLowLimit;
    private javax.swing.JLabel jLabelResult;
    private javax.swing.JLabel jLabelSubIntervalCount;
    private javax.swing.JMenuBar jMenuBar;
    private javax.swing.JMenu jMenuButtonAbout;
    private javax.swing.JPanel jPanelChartArea;
    private javax.swing.JPanel jPanelFormulaArea;
    private javax.swing.JSeparator jSeparator;
    private javax.swing.JTextField jTextFieldDigitAfterPoint;
    private javax.swing.JTextField jTextFieldHighLimit;
    private javax.swing.JTextField jTextFieldLowLimit;
    private javax.swing.JTextField jTextFieldResult;
    private javax.swing.JTextField jTextFieldSubIntervalCount;
    // End of variables declaration//GEN-END:variables
}