package by.gsu.lab.view;

import by.gsu.lab.model.enums.SourceType;
import by.gsu.lab.model.enums.OrderSymbolType;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import static by.gsu.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class ViewHelper {
    
    public String fileOpenChoise(MainWindow mainWindow) {
        JFileChooser chooser = new JFileChooser();
        FileNameExtensionFilter filter = new FileNameExtensionFilter(
                TXT_FILE_EXTENSION_DESCRIPTION, TXT_FILE_EXTENSION);
        chooser.setFileFilter(filter);
        
        int returnVal = chooser.showOpenDialog(mainWindow);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            return chooser.getSelectedFile().getPath();
        }
        return EMPTY_STRING;
    }
    
    public String directoryOpenChoise(MainWindow mainWindow) {
        JFileChooser chooser = new JFileChooser();
        chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        chooser.setAcceptAllFileFilterUsed(false);
        int returnVal = chooser.showOpenDialog(mainWindow);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            return chooser.getSelectedFile().getPath();
        }
        return EMPTY_STRING;
    }
    
    public void clearField(JTextArea textArea) {
        textArea.setText(EMPTY_STRING);
    }
    
    public OrderSymbolType getOrderFromComboboxIndex(JComboBox jComboBox) {
        int index = jComboBox.getSelectedIndex();
        if (index == 0) {
            return OrderSymbolType.SECOND;
        } else if (index == 1) {
            return OrderSymbolType.THIRD;
        } else if (index == 2) {
            return OrderSymbolType.FOURTH;
        } else {
            throw new IllegalStateException(ILLEGAL_SYMBOL_INDEX + index);
        }
    }
    
    public void errorMessage(String message) {
        JOptionPane.showMessageDialog(new JFrame(), message,
            ERROR_MESSAGE_HEADER, JOptionPane.ERROR_MESSAGE);
    }

    public void informationMessage(String messageHeader, String message) {
        JOptionPane.showMessageDialog(new JFrame(), message,
            messageHeader, JOptionPane.INFORMATION_MESSAGE);
    }

    public String getDataUserChoice(MainWindow view, SourceType sourceType) {
        switch (sourceType) {
            case USER_INPUT_FIELD:
                return view.getDataUserInputField();
            case TXT_FILE:
                return view.getPathToFile();
            case CATALOG_WITH_TXT_FILES:
                return view.getPathToFolder();
            default:
                throw new IllegalStateException(sourceType.name());
        }
    }
}