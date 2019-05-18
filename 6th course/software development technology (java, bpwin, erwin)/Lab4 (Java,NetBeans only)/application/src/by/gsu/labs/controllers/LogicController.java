package by.gsu.labs.controllers;

import javax.swing.*;
import by.gsu.labs.view.IView;
import by.gsu.labs.math.DefiniteIntegral;

import static by.gsu.labs.constants.Constants.*;

/**
 * Контроллер приложения.
 * @author Viktor Baranov
 */
public class LogicController {
        
    private IView view;
    
    public LogicController() {
    }

    public void setView(IView view) {
        this.view = view;
    }
    
    public void calculateIntegral(String draftLowLimit, String draftHighLimit,
            String draftSubIntervalCount, String draftDigitsAfterPoint) {
        try {
            // Валидация параметров.
            validateInputParameters(draftLowLimit, draftHighLimit, 
                    draftSubIntervalCount, draftDigitsAfterPoint);

            // Парсинг строковых параметров в числовые.
            double lowLimit = Double.valueOf(draftLowLimit.trim());
            double highLimit = Double.valueOf(draftHighLimit.trim());
            int subIntervalCount = Integer.valueOf(draftSubIntervalCount.trim());
            int digitsAfterPoint = Integer.valueOf(draftDigitsAfterPoint.trim());

            // Создание объекта интеграла и вычисление.
            DefiniteIntegral definiteIntegral = new DefiniteIntegral(lowLimit,
                    highLimit, subIntervalCount, digitsAfterPoint);
            definiteIntegral.integralCalculate();

            // Отображение результатов и графика.
            view.showResult(definiteIntegral);
            view.drawChart(definiteIntegral);
            
        } catch (IllegalArgumentException ex) {
            showErrorMessage(ex.getMessage());
        }

    }

    private void validateInputParameters(String draftLowLimit, 
            String draftHighLimit, String draftSubIntervalCount, 
            String draftDigitsAfterPoint) {
        if (EMPTY_STRING.equals(draftLowLimit.trim())) {
            throw new IllegalArgumentException(EMPTY_LOW_LIMIT);
        }
        if (!isDouble(draftLowLimit.trim())) {
            throw new IllegalArgumentException(ILLEGAL_LOW_LIMIT);
        }
        if (EMPTY_STRING.equals(draftHighLimit.trim())) {
            throw new IllegalArgumentException(EMPTY_HIGH_LIMIT);
        }
        if (!isDouble(draftHighLimit.trim())) {
            throw new IllegalArgumentException(ILLEGAL_HIGH_LIMIT);
        }
        if (EMPTY_STRING.equals(draftSubIntervalCount.trim())) {
            throw new IllegalArgumentException(EMPTY_SUB_INTERVAL_COUNT);
        }
        if (!isInteger(draftSubIntervalCount.trim())) {
            throw new IllegalArgumentException(ILLEGAL_SUB_INTERVAL_COUNT);
        }
        int subIntervalCount = Integer.parseInt(draftSubIntervalCount.trim());
        if (subIntervalCount < RANGE_MIN_SUB_INTERVAL_COUNT) {
            throw new IllegalArgumentException(ILLEGAL_RANGE_SUB_INTERVAL_COUNT);
        }
        if (EMPTY_STRING.equals(draftDigitsAfterPoint.trim())) {
            throw new IllegalArgumentException(EMPTY_DIGITS_AFTER_POINT);
        }
        if (!isInteger(draftDigitsAfterPoint.trim())) {
            throw new IllegalArgumentException(ILLEGAL_DIGITS_AFTER_POINT);
        }
        int digitsAfterPoint = Integer.parseInt(draftDigitsAfterPoint.trim());
        if (digitsAfterPoint < RANGE_MIN_DIGITS_AFTER_POINT 
                || digitsAfterPoint > RANGE_MAX_DIGITS_AFTER_POINT) {
            throw new IllegalArgumentException(ILLEGAL_RANGE_DIGITS_AFTER_POINT);
        }
    }
    
    private boolean isDouble(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException ex) {
            return false;
        }
    }
    
    private boolean isInteger(String str) {
        try {
            Integer.parseInt(str);
            return true;
        }
        catch(NumberFormatException ex) {
            return false;
        }
    }
    
    /**
     * Отображение MessageDialog'а с заданием к лабораторной.
     */
    public void showAboutMessage() {
        JOptionPane.showMessageDialog(new JFrame(), ABOUT_MESSAGE, 
                ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }
    
    private void showErrorMessage(String message) {
        JOptionPane.showMessageDialog(new JFrame(), message, 
                ERROR_MESSAGE_HEADER, JOptionPane.ERROR_MESSAGE);
    }
}