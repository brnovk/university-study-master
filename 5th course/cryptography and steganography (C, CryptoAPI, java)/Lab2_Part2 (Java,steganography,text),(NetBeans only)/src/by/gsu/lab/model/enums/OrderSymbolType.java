package by.gsu.lab.model.enums;

/**
 * @author Viktor Baranov
 */
public enum OrderSymbolType {
    
    SECOND  (2, "(.)%s(.*)"),
    THIRD   (3, "(.{2})%s(.*)"),
    FOURTH  (4, "(.{3})%s(.*)");
    
    private final int order;
    private final String regexPattern;
    
    private OrderSymbolType(int order, String regexPattern) {
        this.order = order;
        this.regexPattern = regexPattern;
    }
    
    public int getOrder() {
        return order;
    }
    
    public String getRegexPattern() {
        return regexPattern;
    }
}