package by.gsu.labs.view;

import by.gsu.labs.math.DefiniteIntegral;

/**
 * Интерфейс для работы с view слое приложения.
 * @author Viktor Baranov
 */
public interface IView {
    
    void drawChart(DefiniteIntegral definiteIntegral);
    
    void showResult(DefiniteIntegral definiteIntegral);
}