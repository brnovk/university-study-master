package by.gsu.lab.view;

import java.io.File;
import java.util.Date;
import java.text.SimpleDateFormat;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;

import static by.gsu.lab.constants.Constants.*;


/**
 * @author Viktor Baranov
 */
public class ViewHelper {
    
    public String fileOpenChoise(MainWindow mainWindow) {
        JFileChooser chooser = new JFileChooser();
        FileNameExtensionFilter filter = 
            new FileNameExtensionFilter(WAV_DIALOG_TOOLTIP, WAV_EXTENSION);
        chooser.setFileFilter(filter);
        int returnVal = chooser.showOpenDialog(mainWindow);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            return chooser.getSelectedFile().getPath();
        }
        return EMPTY_STRING;
    }
    
    public String fileSaveChoise(MainWindow mainWindow) {
        final String DATE_FORMAT = "yyyy-MM-dd HH-mm";
        final String OUT_FORMAT = "AudioWithMessage(%s)" + 
                EXTENSION_SEPARATOR + WAV_EXTENSION;
        JFileChooser chooser = new JFileChooser();
        FileNameExtensionFilter filter = 
            new FileNameExtensionFilter(WAV_DIALOG_TOOLTIP, WAV_EXTENSION);
        chooser.setFileFilter(filter);
        chooser.setSelectedFile(
                new File(String.format(
                        OUT_FORMAT, 
                        new SimpleDateFormat(DATE_FORMAT).format(new Date()))
                )
        );
        int returnVal = chooser.showSaveDialog(mainWindow);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
            return chooser.getSelectedFile().getPath();
        }
        return EMPTY_STRING;
    }

    public void clearField(JTextArea textArea, JLabel jLabel) {
        textArea.setText(EMPTY_STRING);
        if (jLabel != null){
            jLabel.setText(MINIMAL_COUNT_SYMBOLS);
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
}