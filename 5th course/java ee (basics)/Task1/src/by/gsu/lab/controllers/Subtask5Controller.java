package by.gsu.lab.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.enums.Subtask5Theme;

@SuppressWarnings("serial")
public class Subtask5Controller extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {
			String rawTheme = request.getParameter("theme");
			stringValidation(rawTheme);

			Subtask5Theme theme = Subtask5Theme.parseTheme(rawTheme);
			request.setAttribute("theme", theme);
			jump("/subtask5-result.jsp", request, response);
		} catch (IllegalArgumentException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}
}