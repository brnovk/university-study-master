package by.gsu.oop;

import by.gsu.oop.db.DBControl;

import java.io.IOException;
import java.sql.*;
import java.util.Formatter;

import static by.gsu.oop.Constants.*;
import static by.gsu.oop.db.SQLQueries.*;

/**
 * @author Baranov Viktor
 */
public class RunnerLogic {

    public void run() throws IOException, SQLException, ClassNotFoundException {

        Connection connention = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {

            // Connect

            connention = DBControl.getConnection();
            statement = connention.createStatement();

            // Show all tables

            System.out.println(getTable(SELECT_TAB_STUD, LABEL_STUD,
                VALUE_STUD, COLUMN_COUNT_STUD, statement));

            System.out.println(getTable(SELECT_TAB_MOTHER, LABEL_MOTHER, 
                VALUE_MOTHER, COLUMN_COUNT_MOTHER, statement));

            System.out.println(getTable(SELECT_TAB_FATHER, LABEL_FATHER, 
                VALUE_FATHER, COLUMN_COUNT_FATHER, statement));

            System.out.println(getTable(SELECT_TAB_GROUP, LABEL_GROUP, 
                VALUE_GROUP, COLUMN_COUNT_GROUP, statement));

            System.out.println(getTable(SELECT_TAB_CURATOR, LABEL_CURATOR, 
                VALUE_CURATOR, COLUMN_COUNT_CURATOR, statement));

            System.out.println(getTable(SELECT_TAB_FACULTET,LABEL_FACULTET, 
                VALUE_FACULTET, COLUMN_COUNT_FACULTET, statement));

            System.out.println(getTable(SELECT_TAB_COST, LABEL_COST, 
                VALUE_COST, COLUMN_COUNT_COST, statement));

            System.out.println(getTable(SELECT_TAB_COMMUNITY, LABEL_COMMUNITY, 
                VALUE_COMMUNITY, COLUMN_COUNT_COMMUNITY, statement));

        } finally {
            DBControl.close(resultSet);
            DBControl.close(statement);
            DBControl.close();
        }
    }

    private String getTable(String selectQuery, String patternLabel,
        String patternOut, int columnCount, Statement statement)
        throws SQLException {

        Formatter fmt = new Formatter();
        ResultSet resultSet = null;

        try {
            resultSet = statement.executeQuery(selectQuery);
            ResultSetMetaData rsmd = resultSet.getMetaData();
            String[] currentLabel = new String[columnCount];
            for (int i = 0; i < columnCount; i++) {
                currentLabel[i] = rsmd.getColumnName(i + 1);
            }

            fmt.format("%s", TABLE_SEPARATOR1);
            fmt.format(patternLabel, (Object[]) currentLabel);
            fmt.format("%s", TABLE_SEPARATOR2);

            while (resultSet.next()) {
                Object[] currentValue = new Object[columnCount];
                for (int i = 0; i < columnCount; i++) {
                    currentValue[i] = resultSet.getObject(i + 1);
                }
                fmt.format(patternOut, currentValue);
            }

            fmt.format("%s", TABLE_SEPARATOR2);
            return fmt.toString();

        } finally {
            DBControl.close(resultSet);
            fmt.close();
        }
    }
}
