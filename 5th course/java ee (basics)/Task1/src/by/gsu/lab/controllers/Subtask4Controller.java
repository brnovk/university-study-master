package by.gsu.lab.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.enums.Subtask4FunctionType;
import by.gsu.lab.helpers.Subtask4Helper;

@SuppressWarnings("serial")
public class Subtask4Controller extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {
			String rawNumber = request.getParameter("number");
			String rawFunctionType = request.getParameter("functionType");
			String rawAccuracy = request.getParameter("accuracy");
			
			stringValidation(rawNumber, rawFunctionType);
			doubleValidation("Number must be an integer or float.",
					rawNumber);
			Double number = Double.parseDouble(rawNumber);
			Subtask4FunctionType fType = 
					Subtask4FunctionType.parseFunctionType(rawFunctionType);
			Integer accuracy = null;
			if (!"".equals(rawAccuracy.trim())) {
				accuracy = Integer.parseInt(rawAccuracy);
			}
			Subtask4Helper helper = new Subtask4Helper();
			request.setAttribute("resultInDegrees", 
					helper.calculateInDegrees(number, fType, accuracy));
			request.setAttribute("resultInRadians", 
					helper.calculateInRadians(number, fType, accuracy));
			request.setAttribute("function", fType);
			request.setAttribute("number", number);
			jump("/subtask4-result.jsp", request, response);
		} catch (IllegalArgumentException ex) {
			jumpError("/index.jsp", ex.getMessage(), request, response);
		}
	}
}
