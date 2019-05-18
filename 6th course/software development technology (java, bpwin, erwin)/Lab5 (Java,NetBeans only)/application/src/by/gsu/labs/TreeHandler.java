package by.gsu.labs;

import java.util.ArrayList;

/**
 * Класс обработчик дерева, представленного арифметическим выражением.
 * @author Victor Baranov
 */
public class TreeHandler {
    
    @SuppressWarnings("ManualArrayToCollectionCopy")
    public char[][] generateTreeArray(String equation) {
        inputDataValidation(equation);
        equation = equation.replace(" ", "");
        char[] sourceSet = equation.toCharArray();
        
        int currentPriority = 0;
        int maxPiority = currentPriority;
        ArrayList<Integer> priorities = new ArrayList<>();
        int columnCount = 0;
        int index = 0;
        for (Character currentChar : sourceSet) {
            if ('(' == currentChar) {
                currentPriority+=2;
                maxPiority = (maxPiority < currentPriority) 
                        ? currentPriority : maxPiority;
                continue;
            }
            if (')' == currentChar) {
                currentPriority-=2;
                maxPiority = (maxPiority < currentPriority) 
                        ? currentPriority : maxPiority;
                continue;
            }
            if (Character.isLetter(currentChar)) {
                columnCount++;
                priorities.add(-1);
            }
            if ((currentChar == '+') || (currentChar == '-')) {
                
                priorities.add(currentPriority);
                columnCount++;
            }
            if ((currentChar == '*') || (currentChar == '/')) {
                priorities.add(currentPriority+1);
                columnCount++;
                maxPiority = (maxPiority < currentPriority+1) 
                        ? currentPriority+1 : maxPiority;
            }
            if ((priorities.get(index)!= (-1)) && (index==1)){
                priorities.set(0, priorities.get(index)+1);
            } else if (index >= 2) {
                if ((priorities.get(index)!= (-1)) && 
                        ((priorities.get(index)) > priorities.get(index-2))) {
                    priorities.set(index-1, priorities.get(index)+1);
                } else if ((priorities.get(index)!= (-1)) && 
                        ((priorities.get(index)) <= priorities.get(index-2))) {
                    priorities.set(index-1, priorities.get(index-2)+1);
                }
            }
            index++;
        }
        priorities.set(index-1, priorities.get(index-2)+1);
        int rowCount = maxPiority+2;
        
        char[][] resultArray = new char[rowCount][columnCount];
        
        equation = equation.replace("(", "");
        equation = equation.replace(")", "");
        sourceSet = equation.toCharArray();
        
        for (int i=0; i<sourceSet.length; i++) {
                resultArray[priorities.get(i)][i] = sourceSet[i];
        }
        return resultArray;
    }
    
    private void inputDataValidation(String equation) {
        equation = equation.replace(" ", "");
        if ("".equals(equation)) {
            throw new IllegalArgumentException("Пустое поле с выражением");
        }
        int bracketCount = 0;
        int numberCount = 0;
        for (char currentLetter : equation.toCharArray()) {
            if (currentLetter == '(') {
                bracketCount++;
            }
            if (currentLetter == ')') {
                bracketCount--;
            }
            if (Character.isDigit(currentLetter)) {
                numberCount++;
            }
        }
        if (bracketCount!=0) {
            throw new IllegalArgumentException("Некорректное количество "
                    + "скобок в выражении");
        }
        
        if (numberCount!=0) {
            throw new IllegalArgumentException("В выражении не должны "
                    + "присутствовать цифры");
        }
        char[] tmpArray = equation.toCharArray();
        if ((tmpArray[0] == '-')||(equation.contains("(-"))) {
            throw new IllegalArgumentException("В выражении не должны "
                    + "присутствовать отрицательные переменные");
        }
    }
}
