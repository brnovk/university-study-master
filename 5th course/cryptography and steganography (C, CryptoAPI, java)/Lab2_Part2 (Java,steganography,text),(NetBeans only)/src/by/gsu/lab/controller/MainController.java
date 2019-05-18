package by.gsu.lab.controller;

import by.gsu.lab.view.ViewHelper;
import by.gsu.lab.view.MainWindow;
import by.gsu.lab.model.exceptions.ValidationException;
import by.gsu.lab.model.exceptions.GeneratorException;
import by.gsu.lab.model.enums.SourceType;
import by.gsu.lab.model.enums.OrderSymbolType;
import java.awt.datatransfer.*;
import java.awt.Toolkit;
import javax.swing.*;
import java.util.*;

import by.gsu.lab.model.sources.AbstractSource;
import by.gsu.lab.model.Logic;

import static by.gsu.constants.Constants.*;

/**
 * Контроллер приложения.
 * @author Viktor Baranov
 */
public class MainController {
    private Logic logic;
    private MainWindow view;
    private ViewHelper viewHelper;
    
    public MainController() {
        viewHelper = new ViewHelper();
    }
    
    public MainController(MainWindow view, Logic logic){
        this();
        this.view = view;
        this.logic = logic;
    }
    
    public void setView(MainWindow view) {
        this.view = view;
    }

    public void setLogic(Logic model) {
        this.logic = model;
    }
    
    public void fileOpenChoise(JTextField textField) {

        String path = viewHelper.fileOpenChoise(view);
        if (!EMPTY_STRING.equals(path)) {
            textField.setText(path);
            setSourceType(SourceType.TXT_FILE);
        }
    }
    
    public void directoryOpenChoise(JTextField textField) {
        String path = viewHelper.directoryOpenChoise(view);
        if (!EMPTY_STRING.equals(path)) {
            textField.setText(path);
            setSourceType(SourceType.CATALOG_WITH_TXT_FILES);
        }
    }
    
    public void showTask(){
        viewHelper.informationMessage(ABOUT_MESSAGE_HEADER, ABOUT_MESSAGE);
    }
    
    public void clearField(JTextArea textArea) {
        viewHelper.clearField(textArea);
    }

    public void setSourceType(SourceType sourceType) {
        logic.setSourceType(sourceType);
        view.setSourceType(sourceType);
    }

    public void setOrderSymbolType(OrderSymbolType orderType) {
        logic.setOrderSymbolType(orderType);
        view.setOrderSymbolType(orderType);
    }
    
    public void generateContainer(String message) {
        try {
            String data = viewHelper.getDataUserChoice(view, 
                    logic.getSourceType());
            // Удаление из сообщения всех символов, кроме букв и цифр.
            message = normalizeMessage(message);
            // Удаление всех повторяющихся букв и цифр.
            String withoutRepeatMessage = removeDuplicateSymbols(message);
            AbstractSource generator = logic.getGenerator(withoutRepeatMessage, 
                    data);
            generator.dataValidation();
            Map<Character, HashSet<String>> source = 
                    generator.generate(logic.getOrderSymbolType());
            String container = logic.generateContainer(message, source);
            view.setDataContainer(container);
        } catch (GeneratorException | ValidationException ex) {
            String errorMessage = ex.getMessage();
            viewHelper.errorMessage(errorMessage);
        }
    }

    public void pasteTextIntoClipboard(String message) {
        StringSelection stringSelection = new StringSelection(message);
        Clipboard clpbrd = Toolkit.getDefaultToolkit().getSystemClipboard();
        clpbrd.setContents(stringSelection, null);
    }
    
    private String removeDuplicateSymbols(String message) {
        final int NO_AGREEMENT = -1;
        StringBuilder result = new StringBuilder();
        for(char letter : message.toCharArray()){
            if (result.toString().indexOf(letter) == NO_AGREEMENT) {
                result.append(letter);
            }
        }
        return result.toString();
    }

    private String normalizeMessage(String message) {
        StringBuilder result = new StringBuilder();
        for(char letter : message.toCharArray()){
            if (Character.isLetterOrDigit(letter)) {
                result.append(letter);
            }
        }
        return result.toString();
    }
}