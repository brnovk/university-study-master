package by.gsu.lab.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class Subtask2Controller extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		final String colorNegativeTemp = "blue";
		final String colorPositiveTemp = "red";
		try {
			String rawTemperature = request.getParameter("temperature");
			stringValidation(rawTemperature);
			doubleValidation("Temperature field must be an integer or float number.",
					rawTemperature);
			
			double temperature = Double.parseDouble(rawTemperature);
			request.setAttribute("temperature", temperature);
			
			int compareResult = Double.compare(temperature, 0D);
			if (compareResult > 0) {
				request.setAttribute("color", colorPositiveTemp);
				jump("/subtask2-result.jsp", request, response);
			} else if (compareResult < 0) {
				request.setAttribute("color", colorNegativeTemp);
				jump("/subtask2-result.jsp", request, response);
			} else {
				jumpError("/subtask2-result.jsp", "Specified number is zero.",
						request, response);
			}
		} catch (IllegalArgumentException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}
}