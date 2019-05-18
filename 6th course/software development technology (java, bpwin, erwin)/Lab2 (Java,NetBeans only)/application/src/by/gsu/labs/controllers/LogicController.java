package by.gsu.labs.controllers;

import javax.swing.*;

import by.gsu.labs.math.SequenceHandler;
import by.gsu.labs.view.IView;

import static by.gsu.labs.constants.Constants.*;


/**
 * Класс контроллер приложения.
 * @author Viktor Baranov
 */
public class LogicController {
    
    private IView view;
    
    private SequenceHandler sequenceHandler;
    
    public LogicController() {
    }

    public void setView(IView view) {
        this.view = view;
    }

    public void setSequenceHandler(SequenceHandler sequenceHandler) {
        this.sequenceHandler = sequenceHandler;
    }   

    /**
     * Метод вычисляет всё требуемое в задании и отображает это в слое view.
     */
    public void calculateSequences() {
        
        double[] source = 
                sequenceHandler.generateExponentialSequence(SIZE, LAMBDA);
        view.showSequenceExponential(source);
        
        double[] result = sequenceHandler.generateTaskSequence(source);
        view.showSequenceResulting(result);
        
        double averageValue = sequenceHandler.calculateAverageValue(result);
        view.showAverageValue(averageValue);
        
        double expectedValue = sequenceHandler.calculateExpectedValue(result);
        
        double variance = 
                sequenceHandler.calculateVariance(result, expectedValue);
        view.showDispersion(variance);

        view.drawChart(result);
        
    }
    
    /**
     * Отображение MessageDialog'а с заданием к лабораторной.
     */
    public void showAboutMessage() {
        JOptionPane.showMessageDialog(new JFrame(), ABOUT_MESSAGE,
            ABOUT_MESSAGE_HEADER, JOptionPane.INFORMATION_MESSAGE);
    }
}