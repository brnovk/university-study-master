package by.labs.controllers;

import by.labs.view.MainWindow;
import by.labs.math.QuadrilateralParser;

import static by.labs.constants.Constants.*;

import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

/**
 * Контроллер приложения.
 */
public class LogicController {

    private MainWindow mainWindow;
    
    public LogicController() {
    }
    
    public void setView(MainWindow mainWindow) {
        this.mainWindow = mainWindow;
    }
    
    /**
     * Метод вычисления требуемого в задании.
     * @param source 
     */
    public void calculate(String source) {
        QuadrilateralParser parser = new QuadrilateralParser();
        String result = parser.parse(source);
        mainWindow.printResult(result);
    }
    
    /**
     * Получение псевдо-случайных данных для заполнения.
     * @return 
     */
    public String randomSourceGenerator() {
        Random random = new Random();
        StringBuilder result = new StringBuilder();
        for (int i=0; i<R_COUNT; i++) {
            double ox_offset = R_MIN + (R_MAX - R_MIN) * random.nextDouble();
            double oy_offset = R_MIN + (R_MAX - R_MIN) * random.nextDouble();
            double x1 = R_MIN + (R_MAX - R_MIN) * random.nextDouble();
            double y1 = R_MIN + (R_MAX - R_MIN) * random.nextDouble();
            double x2 = x1 + ox_offset;
            double y2 = y1;
            if ((i%2==1) && random.nextBoolean()) {
                y2 = (R_MIN + (R_MAX - R_MIN) * random.nextDouble());
            }
            double x3 = x2;
            if ((i%2==1) && random.nextBoolean()) {
                x3 = (R_MIN + (R_MAX - R_MIN) * random.nextDouble());
            }
            double y3 = y2 + oy_offset;
            double x4 = x1;
            double y4 = y1 + oy_offset;
            result.append(String.format(OPEN_BRACKET+FLOAT_PATTERN+COMMA, x1));
            result.append(String.format(FLOAT_PATTERN+SEMICOLON, y1));
            result.append(String.format(FLOAT_PATTERN+COMMA, x2));
            result.append(String.format(FLOAT_PATTERN+SEMICOLON, y2));
            result.append(String.format(FLOAT_PATTERN+COMMA, x3));
            result.append(String.format(FLOAT_PATTERN+SEMICOLON, y3));
            result.append(String.format(FLOAT_PATTERN+COMMA, x4));
            result.append(String.format(FLOAT_PATTERN+CLOSE_BRACKET, y4));
            result.append((i+1 == R_COUNT) ? EMPTY_STRING : COMMA);
            result.append(NEWLINE);
        }
        return result.toString();
    }
    
    /**
     * Отображение MessageDialog'а с заданием к лабораторной.
     */
    public void showAboutMessage() {
        JOptionPane.showMessageDialog(new JFrame(), ABOUT_MESSAGE, 
            ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }
}
