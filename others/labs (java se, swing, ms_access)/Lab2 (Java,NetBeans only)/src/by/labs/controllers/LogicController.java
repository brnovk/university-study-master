package by.labs.controllers;

import javax.swing.*;

import by.labs.math.SequenceHandler;
import by.labs.view.IView;

import static by.labs.constants.Constants.*;

/**
 * Класс контроллер приложения.
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
        
        double[] first = sequenceHandler.generateUniformDistributionSequence(
            SIZE_SOURCE_SEQUENCE, FIRST_SEQ_LOW_RANGE, FIRST_SEQ_HIGH_RANGE);
        view.showFirstRandomSequence(first);
        
        double[] second = sequenceHandler.generateUniformDistributionSequence(
            SIZE_SOURCE_SEQUENCE, SECOND_SEQ_LOW_RANGE, SECOND_SEQ_HIGH_RANGE);
        view.showSecondRandomSequence(second);
        
        double[] third = sequenceHandler.generateUniformDistributionSequence(
            SIZE_SOURCE_SEQUENCE, THIRD_SEQ_LOW_RANGE, THIRD_SEQ_HIGH_RANGE);
        view.showThirdRandomSequence(third);
        
        double[] result = sequenceHandler.taskSequence(first, second, third);
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
