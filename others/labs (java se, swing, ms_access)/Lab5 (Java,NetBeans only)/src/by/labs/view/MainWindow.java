package by.labs.view;

import static by.labs.constants.Constants.*;

import by.labs.controllers.LogicController;
import by.labs.model.beans.Student;
import java.util.List;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

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
        controller.setView(this);
        controller.initialiseCources();
        String selectedItem = String.valueOf(jComboBoxAddCourse.getSelectedItem());
        controller.updateAddCourse(Integer.parseInt(selectedItem));
        controller.showStudents();
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        tableScrollPane = new javax.swing.JScrollPane();
        tableStudents = new javax.swing.JTable();
        listScrollPane = new javax.swing.JScrollPane();
        namesakesStudents = new javax.swing.JTextArea();
        textFieldSurname = new javax.swing.JTextField();
        jLabelSurname = new javax.swing.JLabel();
        jLabelCourse = new javax.swing.JLabel();
        jComboBoxAddCourse = new javax.swing.JComboBox();
        jLabelGroup = new javax.swing.JLabel();
        jComboBoxAddGroup = new javax.swing.JComboBox();
        jButtonAdd = new javax.swing.JButton();
        jSeparator = new javax.swing.JSeparator();
        jButtonGenerateRandom = new javax.swing.JButton();
        namesakesLabel = new javax.swing.JLabel();
        jButtonFind = new javax.swing.JButton();
        jComboBoxFindCourse = new javax.swing.JComboBox();
        jLabelFindCourse = new javax.swing.JLabel();
        menuBar = new javax.swing.JMenuBar();
        buttonAbout = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle(by.labs.constants.Constants.WINDOW_TITLE);
        setMinimumSize(new java.awt.Dimension(630, 430));

        tableStudents.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Фамилия", "Курс", "Группа"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.Integer.class, java.lang.String.class
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
        tableScrollPane.setViewportView(tableStudents);

        namesakesStudents.setColumns(20);
        namesakesStudents.setLineWrap(true);
        namesakesStudents.setRows(5);
        namesakesStudents.setEnabled(false);
        listScrollPane.setViewportView(namesakesStudents);

        jLabelSurname.setText(by.labs.constants.Constants.LABEL_ADD_SURNAME);

        jLabelCourse.setText(by.labs.constants.Constants.LABEL_ADD_COURSE);

        jComboBoxAddCourse.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBoxAddCourseActionPerformed(evt);
            }
        });

        jLabelGroup.setText(by.labs.constants.Constants.LABEL_ADD_GROUP);

        jComboBoxAddGroup.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Item 1" }));

        jButtonAdd.setText(by.labs.constants.Constants.BUTTON_ADD);
        jButtonAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonAddActionPerformed(evt);
            }
        });

        jButtonGenerateRandom.setText(by.labs.constants.Constants.BUTTON_RANDOM_GENERATION);
        jButtonGenerateRandom.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonGenerateRandomActionPerformed(evt);
            }
        });

        namesakesLabel.setText(" ");

        jButtonFind.setText(by.labs.constants.Constants.BUTTON_CHECK);
        jButtonFind.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButtonFindActionPerformed(evt);
            }
        });

        jLabelFindCourse.setText(by.labs.constants.Constants.LABEL_CHECKED_COURSE);

        buttonAbout.setText(by.labs.constants.Constants.BUTTON_TASK);
        buttonAbout.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                buttonAboutMouseClicked(evt);
            }
        });
        menuBar.add(buttonAbout);

        setJMenuBar(menuBar);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(jButtonAdd, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jComboBoxAddGroup, javax.swing.GroupLayout.Alignment.TRAILING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jComboBoxAddCourse, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jLabelGroup)
                        .addComponent(textFieldSurname)
                        .addComponent(jLabelCourse)
                        .addComponent(jButtonGenerateRandom, javax.swing.GroupLayout.DEFAULT_SIZE, 135, Short.MAX_VALUE)
                        .addComponent(jSeparator, javax.swing.GroupLayout.Alignment.TRAILING)
                        .addComponent(jLabelSurname)
                        .addComponent(jButtonFind, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jComboBoxFindCourse, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addComponent(jLabelFindCourse))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(tableScrollPane, javax.swing.GroupLayout.DEFAULT_SIZE, 290, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(listScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(namesakesLabel))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(tableScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabelSurname)
                        .addGap(4, 4, 4)
                        .addComponent(textFieldSurname, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jLabelCourse)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jComboBoxAddCourse, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jLabelGroup)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jComboBoxAddGroup, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jButtonAdd, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(14, 14, 14)
                        .addComponent(jSeparator, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 44, Short.MAX_VALUE)
                        .addComponent(jLabelFindCourse)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jComboBoxFindCourse, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButtonFind, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButtonGenerateRandom, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(namesakesLabel)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(listScrollPane)))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void buttonAboutMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_buttonAboutMouseClicked
        // Клик по кнопке Задание
        controller.showAboutMessage();
    }//GEN-LAST:event_buttonAboutMouseClicked

    private void jComboBoxAddCourseActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBoxAddCourseActionPerformed
        // Заполнение списка групп, в зависимости от выбранного курса.
        String selectedItem = String.valueOf(jComboBoxAddCourse.getSelectedItem());
        controller.updateAddCourse(Integer.parseInt(selectedItem));
    }//GEN-LAST:event_jComboBoxAddCourseActionPerformed

    private void jButtonAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonAddActionPerformed
        // Клик по кнопке Добавления
        final String EMPTY = "";
        final String SPACE = " ";
        final String NBSP_SPACE = "\\u00A0";
        String surname = textFieldSurname.getText();
        surname = surname.replaceAll(NBSP_SPACE, SPACE).trim();
        if (EMPTY.equals(surname)) {
            JOptionPane.showMessageDialog(new JFrame(), SURNAME_NOT_FILL,
            WARNING_MESSAGE_HEADER, JOptionPane.ERROR_MESSAGE);
            return;
        }
        String selectedGroup = 
                String.valueOf(jComboBoxAddGroup.getSelectedItem()).trim();
        controller.addStudent(surname, selectedGroup);
        textFieldSurname.setText(null);
    }//GEN-LAST:event_jButtonAddActionPerformed

    private void jButtonGenerateRandomActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonGenerateRandomActionPerformed
        // Клик по кнопке заполения случайными значениями.
        controller.randomStudentsGeneration();
    }//GEN-LAST:event_jButtonGenerateRandomActionPerformed

    private void jButtonFindActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButtonFindActionPerformed
        // Клик по кнопке поиска однофамильцев.
        String selectedCourse = 
                String.valueOf(jComboBoxFindCourse.getSelectedItem()).trim();
        controller.showNamesakes(Integer.parseInt(selectedCourse));
    }//GEN-LAST:event_jButtonFindActionPerformed

    /**
     * Заполнение Combobox курсами.
     * @param cources 
     */
    public void fillingAddCourceCombobox(List<String> cources) {
        jComboBoxAddCourse.setModel(new DefaultComboBoxModel(cources.toArray()));
    }
    
    /**
     * Заполнение Combobox курсами.
     * @param cources 
     */
    public void fillingCheckedCourceCombobox(List<String> cources) {
        jComboBoxFindCourse.setModel(new DefaultComboBoxModel(cources.toArray()));
    }
    
    /**
     * Заполнение Combobox группами.
     * @param groups 
     */
    public void fillingAddGroupCombobox(List<String> groups) {
        jComboBoxAddGroup.setModel(new DefaultComboBoxModel(groups.toArray()));
    }
    
    /**
     * Заполнение таблицы студентов.
     * @param students 
     */
    public void fillingTableStudents(List<Student> students) {
        ((DefaultTableModel) tableStudents.getModel()).setRowCount(students.size());
        for (int i=0; i < students.size(); i++) {
            int j = 0;
            tableStudents.setValueAt(students.get(i).getSurname(), i, j++);
            tableStudents.setValueAt(students.get(i).getGroup().getCourse(), i, j++);
            tableStudents.setValueAt(students.get(i).getGroup().getName(), i, j++);
        }
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.LEFT);
        tableStudents.getColumnModel().getColumn(
                0).setCellRenderer(centerRenderer);
        tableStudents.getColumnModel().getColumn(
                1).setCellRenderer(centerRenderer);
        tableStudents.getColumnModel().getColumn(
                2).setCellRenderer(centerRenderer);
    }
    
    /**
     * Установка значения в label результата поиска однофамильцев. 
     * @param label 
     */
    public void setLabelResult(String label) {
        namesakesLabel.setText(label);
    }

    /**
     * Заполнение списка однофамильцев.
     * @param namesakesList 
     */
    public void setResultList(String namesakesList) {
        namesakesStudents.setText(namesakesList);
    }
    
    @SuppressWarnings("Convert2Lambda")
    public static void initialView(final LogicController controller) {
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
    private javax.swing.JMenu buttonAbout;
    private javax.swing.JButton jButtonAdd;
    private javax.swing.JButton jButtonFind;
    private javax.swing.JButton jButtonGenerateRandom;
    private javax.swing.JComboBox jComboBoxAddCourse;
    private javax.swing.JComboBox jComboBoxAddGroup;
    private javax.swing.JComboBox jComboBoxFindCourse;
    private javax.swing.JLabel jLabelCourse;
    private javax.swing.JLabel jLabelFindCourse;
    private javax.swing.JLabel jLabelGroup;
    private javax.swing.JLabel jLabelSurname;
    private javax.swing.JSeparator jSeparator;
    private javax.swing.JScrollPane listScrollPane;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JLabel namesakesLabel;
    private javax.swing.JTextArea namesakesStudents;
    private javax.swing.JScrollPane tableScrollPane;
    private javax.swing.JTable tableStudents;
    private javax.swing.JTextField textFieldSurname;
    // End of variables declaration//GEN-END:variables

}
