package by.labs.view;

/**
 * Интерфейс для работы с view слоем приложения.
 */
public interface IView {
    
    void drawChart(double[] chartValues);
    
    void showAverageValue(double value);
    
    void showDispersion(double value);
    
    void showFirstRandomSequence(double[] sequence);
    
    void showSecondRandomSequence(double[] sequence);
    
    void showThirdRandomSequence(double[] sequence);
    
    void showSequenceResulting(double[] sequence);
    
}
