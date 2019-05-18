package by.gsu.lab.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.gsu.lab.beans.Subtask6Node;
import by.gsu.lab.helpers.Subtask6DataStorage;

@SuppressWarnings("serial")
public class Subtask6SearchController extends AbstractBaseController {

	@Override
	protected void performTask(HttpServletRequest request, 
		HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		try {
			List<Subtask6Node> nodes = Subtask6DataStorage.getNodes();
			List<Subtask6Node> listOfFound = new ArrayList<>();
			String searchValue = null;
			String searchPhoneParam = request.getParameter("searchPhone");
			String searchSurnameParam = request.getParameter("searchSurname");
			if (searchPhoneParam != null) {
				String phone = request.getParameter("phone");
				stringValidation(phone);
				phone = phone.trim();
				searchValue = phone;
				for (Subtask6Node current : nodes) {
					if (current.getPhone().indexOf(phone) != -1) {
						listOfFound.add(current);
					}
				}
			} else if (searchSurnameParam != null) {
				String surname = request.getParameter("surname");
				stringValidation(surname);
				surname = surname.trim();
				searchValue = surname;
				for (Subtask6Node current : nodes) {
					if (current.getSurname().indexOf(surname) != -1) {
						listOfFound.add(current);
					}
				}
			} else {
				throw new IllegalArgumentException("Unknown type of search.");
			}
			request.setAttribute("dateExecution", new Date());
			request.setAttribute("searchValue", searchValue);
			request.setAttribute("listOfFound", listOfFound);
			jump("/subtask6-search-result.jsp", request, response);
		} catch (IllegalArgumentException ex) {
			jumpError("/subtask6-index.jsp", ex.getMessage(), request, response);
		}
	}
}
