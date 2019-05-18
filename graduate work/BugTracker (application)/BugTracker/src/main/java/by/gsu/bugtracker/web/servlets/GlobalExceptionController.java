package by.gsu.bugtracker.web.servlets;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionController {
	
	private static final Logger LOG = Logger.getLogger(GlobalExceptionController.class);

	@ExceptionHandler(Exception.class)
	public ModelAndView handleAllException(Exception ex) {
		ModelAndView model = new ModelAndView("error/GenericError");
		LOG.error("Global handler", ex);
		model.addObject("errMsg", "Ups, somthing wrong");
		return model;
	}
}
