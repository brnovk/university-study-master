package by.gsu.lab.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import by.gsu.lab.db.ConnectionControl;
import by.gsu.lab.db.DBDataLoader;

public class IndexPageFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, 
			FilterChain chain) throws IOException, ServletException {
		Connection connection = null;
		try {
			connection = ConnectionControl.getConnection();
			DBDataLoader loader = new DBDataLoader();
			List<String> helperGalaxies = loader.getIndexHelperCalaxies(connection);
			request.setAttribute("helperGalaxiesList", helperGalaxies);

			List<String> helperPlanets = loader.getIndexHelperPlanets(connection);
			request.setAttribute("helperPlanetsList", helperPlanets);

			chain.doFilter(request,response);
		} catch (IllegalArgumentException | SQLException | ClassNotFoundException ex) {
			chain.doFilter(request,response);
		} finally {
            ConnectionControl.close();
        }
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
	}
}
