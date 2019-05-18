package by.gsu.lab.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.beans.Subtask6Node;
import by.gsu.lab.helpers.Subtask6DataStorage;

@SuppressWarnings("serial")
public class Subtask6AppendController extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, 
		HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {
			String surname = request.getParameter("surname");
			String rawPhone = request.getParameter("phone");
			String address = request.getParameter("address");
			stringValidation(surname, rawPhone, address);
			String phone = phoneNormalize(rawPhone);
			Subtask6DataStorage.addNode(new Subtask6Node(phone, surname, address));
			jump("/subtask6-index.jsp", request, response);
		} catch (IllegalArgumentException ex) {
			jumpError("/subtask6-index.jsp", ex.getMessage(), request, response);
		}
	}

	private String phoneNormalize(String rawPhone) {
		String phone = null;
		phone = rawPhone.replaceAll("[()\\s-]+", "");
		for (char letter : phone.toCharArray()) {
			if (!Character.isDigit(letter)) {
				throw new IllegalArgumentException(
						"In phone don't allow this symbol: " + letter);
			}
		}
		return phone;
	}
}
