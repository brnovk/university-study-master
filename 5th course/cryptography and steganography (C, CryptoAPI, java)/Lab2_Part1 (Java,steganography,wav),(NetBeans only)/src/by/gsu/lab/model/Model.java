package by.gsu.lab.model;

import by.gsu.lab.exceptions.ValidationException;
import by.gsu.lab.exceptions.SteganographyException;
import javax.sound.sampled.*;
import java.awt.Desktop;
import java.io.*;

import by.gsu.lab.controller.MainController;
import static by.gsu.lab.constants.Constants.*;

/**
 * @author Viktor Baranov
 */
public class Model {
    
    private final MainController controller;
    private final UserDataValidator validator;

    public Model(MainController controller) {
        this.controller = controller; 
        validator = new UserDataValidator();
    }

    public void openDirectoryWithFile(String path) throws IOException,
            ValidationException {
        validator.pathOpenFileValidation(path);
        File directory = validator.getDirectory(path);
        Desktop.getDesktop().open(directory);
    }
    
    public void emdebText(String fileToOpenPath, String fileToSavePath, 
            String data) throws IOException, ValidationException, 
            SteganographyException {
        validator.dataValidation(data);
        validator.pathOpenFileValidation(fileToOpenPath);
        validator.extentionFileValidation(fileToOpenPath);
        validator.pathSaveFileValidation(fileToSavePath);
        encode(fileToOpenPath, data, fileToSavePath);
    }
    
    public void extractText(String filePath) throws IOException,
            ValidationException, SteganographyException {
        validator.pathOpenFileValidation(filePath);
        validator.extentionFileValidation(filePath);
        String result = decode(filePath);
        controller.setExtractText(result);
    }
    
    byte[] readSourceFileInArray(AudioInputStream inputStream) 
            throws IOException {
        // Получение размера фрейма этого формата
        int byteperframe = inputStream.getFormat().getFrameSize();
        /*  Получение количества байт wav данных 
            (по сути - длина wav файла в байтах - 44 байта заголовка) */
        int numbytes = (int)inputStream.getFrameLength() * byteperframe;
        byte[] sourceFileDataBytes = new byte[numbytes];
        while (inputStream.read(sourceFileDataBytes) != -1) {
        }
        return sourceFileDataBytes;
    }

    void encode(String sourceWav, String text, String resultWav) 
            throws SteganographyException {
        try (AudioInputStream sourceStream = 
                AudioSystem.getAudioInputStream(new File(sourceWav))) {
            // MAGIC! Don't tourch!
            if ((sourceStream.getFrameLength()/MES_PROPORTION) < text.length()){
                throw new IllegalStateException(ERROR_LONG_MESSAGE + 
                        (int)(sourceStream.getFrameLength() / MES_PROPORTION));
            }
            byte[] dataWav = readSourceFileInArray(sourceStream);
            new Steganography().addTextToData(dataWav, text);
            try (AudioInputStream resultStream = new AudioInputStream(
                    new ByteArrayInputStream(dataWav), 
                    sourceStream.getFormat(), 
                    sourceStream.getFrameLength())) {
            if (!AudioSystem.isFileTypeSupported(AudioFileFormat.Type.WAVE, 
                    resultStream)) {
                throw new IllegalStateException(ERROR_WRITE_RESULT);
            }
            AudioSystem.write(resultStream, AudioFileFormat.Type.WAVE, 
                    new File(resultWav));
            }
        } catch (UnsupportedAudioFileException | RuntimeException | 
                IOException ex) {
            throw new SteganographyException(ex);
        }
    }

    String decode(String outfile) throws SteganographyException {
        try (AudioInputStream sourceStream = 
                AudioSystem.getAudioInputStream(new File(outfile))) {
            byte[] abytes = readSourceFileInArray(sourceStream);
            return new Steganography().getTextFromData(abytes);
        } catch (UnsupportedAudioFileException | IOException ex) {
            throw new SteganographyException(ex);
        }
    }
}