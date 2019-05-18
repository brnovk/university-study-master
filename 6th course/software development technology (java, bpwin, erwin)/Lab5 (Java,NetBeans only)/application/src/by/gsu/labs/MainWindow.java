package by.gsu.labs;

import java.util.*;
import javax.swing.*;
import java.awt.Font;
import javax.swing.table.*;
import javax.swing.SwingConstants;

/**
 * Класс главного окна приложения.
 * @author Victor Baranov
 */
public class MainWindow extends javax.swing.JFrame {

    TreeHandler treeHandler = new TreeHandler();
    
    public MainWindow() {
        initComponents();
        jTable1.setFont(new Font("Monospace", Font.BOLD, 25));
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jTextField1 = new javax.swing.JTextField();
        jButton1 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Lab5 [ТРПО, ПОИТ-61, Вариант 4, Баранов В.Ф.]");
        setLocationByPlatform(true);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentResized(java.awt.event.ComponentEvent evt) {
                formComponentResized(evt);
            }
        });

        jLabel1.setText("Выражение:");

        jTextField1.setText("(a*b)+c-a*(b+c)");

        jButton1.setText("Построить дерево");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jTable1.setForeground(new java.awt.Color(0, 153, 153));
        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        jTable1.setDoubleBuffered(true);
        jTable1.setEnabled(false);
        jTable1.setGridColor(new java.awt.Color(204, 204, 204));
        jScrollPane1.setViewportView(jTable1);

        jMenu1.setText("Задание");
        jMenu1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jMenu1MouseClicked(evt);
            }
        });
        jMenuBar1.add(jMenu1);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 666, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jTextField1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButton1)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 388, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        try {
            char[][] tree = treeHandler.generateTreeArray(jTextField1.getText());
             DefaultTableModel model = (DefaultTableModel) jTable1.getModel();
            model.setRowCount(tree.length);
            model.setColumnCount(tree[0].length);

            JTableHeader th = jTable1.getTableHeader();
            TableColumnModel tcm = th.getColumnModel();
            for (int i=0; i < tree[0].length; i++) {
                TableColumn tc = tcm.getColumn(i);
                        tc.setHeaderValue("");
            }
            List<Integer> symbolList = new ArrayList<>();

            for (int i=0; i < tree.length; i++) {
                for (int j=0; j < tree[i].length; j++) {
                    if ("+-*/".indexOf(tree[i][j])!=-1) {
                        symbolList.add(j);
                    }
                    model.setValueAt(tree[i][j], i, j);
                }
            }
            for (int i=0; i < tree[0].length; i++) {
                DefaultTableCellRenderer centerRenderer = 
                        new DefaultTableCellRenderer();
                centerRenderer.setHorizontalAlignment(SwingConstants.CENTER);
                jTable1.getColumnModel().getColumn(i).setCellRenderer(
                        (TableCellRenderer)centerRenderer);
            }
            ((DefaultTableCellRenderer)jTable1.getTableHeader().
                    getDefaultRenderer()).setHorizontalAlignment(
                            SwingConstants.CENTER);
            for (Integer currentCol : symbolList) {
                TableColumn tc = tcm.getColumn(currentCol);
                tc.setHeaderValue( "↓" );
            }
            this.formComponentResized(null);
        } catch (IllegalArgumentException ex) {
                    JOptionPane.showMessageDialog(new JFrame(), ex.getMessage(),
            "Error", JOptionPane.ERROR_MESSAGE);
        }
                
       
    }//GEN-LAST:event_jButton1ActionPerformed

    private void formComponentResized(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentResized
        if (jTable1.getRowCount()>0) {
            int x = jTable1.getRowHeight();
            int heigth = jScrollPane1.getHeight()/jTable1.getRowCount();
            if (Math.abs(x - heigth) > 20) {
                for (int i=0; i<jTable1.getRowCount(); i++) {
                    jTable1.setRowHeight(i, heigth-8);
                }
            }
        }
    }//GEN-LAST:event_formComponentResized

    private void jMenu1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jMenu1MouseClicked
        JOptionPane.showMessageDialog(new JFrame(), "Вариант 4\n"
        + "Группа: ПОИТ-61\n"
        + "Студент: Баранов В.Ф.\n\nТребуется разработать ПС, с оптимальной "
        + "структурой данных.\n\nВыражение (a*b)+c-a*(b+c) соответствует "
        + "дереву.\nНапишите программу, которая по введённому выражению строит"
        + " дерево.",
            "Задание к лабораторной №5", JOptionPane.INFORMATION_MESSAGE);
    }//GEN-LAST:event_jMenu1MouseClicked
   
    @SuppressWarnings("Convert2Lambda")
    public static void main(String args[]) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : 
                    javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException 
                | InstantiationException 
                | IllegalAccessException 
                | javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainWindow.class.getName()).log(
                    java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new MainWindow().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JTextField jTextField1;
    // End of variables declaration//GEN-END:variables
}
