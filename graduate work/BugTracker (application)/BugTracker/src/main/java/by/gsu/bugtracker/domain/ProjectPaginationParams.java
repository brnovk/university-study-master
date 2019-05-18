package by.gsu.bugtracker.domain;

public class ProjectPaginationParams extends PaginationParams {
	
	private enum OrderBY {
		NAME, MANAGER, DESCRIPTION
	}

	public ProjectPaginationParams() {
		super();
	}

	public ProjectPaginationParams(Integer page, Integer orderBy, Integer order) {
		super(page, orderBy, order);
	}

	@Override
	public String getStringOrderBy() {
		return OrderBY.values()[getOrderBy()].toString().toLowerCase();
	}
}
