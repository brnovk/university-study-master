package by.gsu.lab.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class Subtask3Controller extends AbstractBaseController {
	
	static final String DATE_PATTERN = "dd.MM.yyyy - HH:mm";

	@Override
	protected void performTask(HttpServletRequest request, 
		HttpServletResponse response)
			throws ServletException, IOException {
        final String rawDateReceived = "1.11.2015 - 23:06";
        final String lastName = "Baranov";
        try {
			Date dateReceived = getDateFromString(
			        DATE_PATTERN, rawDateReceived);
			Date dateExecution = new Date();
			request.setAttribute("lastName", lastName);
			request.setAttribute("dateReceived", dateReceived);
			request.setAttribute("dateExecution", dateExecution);
			jump("/subtask3.jsp", request, response);
		} catch (ParseException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}
	
    private static Date getDateFromString(String datePattern, String rawDate) 
            throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat(datePattern);
        return dateFormat.parse(rawDate);
    }
}