package by.gsu.labs.view;

/**
 * Интерфейс для работы с view слое приложения.
 * @author Viktor Baranov
 */
public interface IView {
    
    void drawChart(double[] chartValues);
    
    void showAverageValue(double value);
    
    void showDispersion(double value);
    
    void showSequenceExponential(double[] sequence);
    
    void showSequenceResulting(double[] sequence);
    
}