package by.gsu.lab.controller;

import by.gsu.lab.view.MainWindow;
import by.gsu.lab.view.ViewHelper;
import by.gsu.lab.exceptions.ValidationException;
import by.gsu.lab.exceptions.SteganographyException;
import java.io.IOException;
import javax.swing.*;

import by.gsu.lab.model.Model;
import static by.gsu.lab.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class MainController {
    
    private Model model;
    private MainWindow view;
    private ViewHelper viewHelper;
    
    public MainController() {
        viewHelper = new ViewHelper();
    }
    
    public MainController(MainWindow view, Model model){
        this();
        this.view = view;
        this.model = model;
    }

    public void setView(MainWindow view) {
        this.view = view;
    }

    public void setModel(Model model) {
        this.model = model;
    }
    

    public void fileOpenChoise(JTextField textField) {
        String path = viewHelper.fileOpenChoise(view);
        if (!EMPTY_STRING.equals(path)) {
            textField.setText(path);
        }
    }
    
    public void fileSaveChoise(JTextField textField) {
        String path = viewHelper.fileSaveChoise(view);
        if (!EMPTY_STRING.equals(path)) {
            textField.setText(path);
        }
    }

    public void clearField(JTextArea textArea, JLabel jLabel) {
        viewHelper.clearField(textArea, jLabel);
    }

    public void openDirectoryWithFile(JTextField jTextField) {
        try {
            String path = jTextField.getText();
            model.openDirectoryWithFile(path.trim());
        } catch (IOException | ValidationException ex) {
            String message = ex.getMessage();
            viewHelper.errorMessage(message);
        }
    }
    
    public void showTask(){
        viewHelper.informationMessage(TASK_MESSAGE_HEADER, TASK_MESSAGE);
    }

    public void changeDataLength(JTextArea jTextArea, JLabel jLabel) {
        int length = jTextArea.getText().trim().length();
        jLabel.setText(Integer.toString(length));
    }

    public void embedText(JTextField textFieldFileOpen, 
            JTextField textFieldFileSave, JTextArea jTextArea) {
        try {
            model.emdebText(textFieldFileOpen.getText(), 
                    textFieldFileSave.getText(), jTextArea.getText());
            viewHelper.informationMessage(
                SUCCESS_MESSAGE_HEADER,
                SUCCESS_EMBED_MESSAGE);
        } catch (ValidationException| IOException| SteganographyException ex) {
            String message = ex.getMessage();
            viewHelper.errorMessage(message);
        }
    }

    public void extractText(JTextField jTextField) {
        try {
            model.extractText(jTextField.getText());
            viewHelper.informationMessage(
                SUCCESS_MESSAGE_HEADER,
                SUCCESS_EXTRACT_MESSAGE);
        } catch (ValidationException| IOException| SteganographyException ex) {
            String message = ex.getMessage();
            viewHelper.errorMessage(message);
        }
    }

    public void setExtractText(String result) {
        view.setExpactedText(result);
    }
}