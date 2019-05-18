package by.gsu.bugtracker.domain;

public class IssuePaginationParams extends PaginationParams {
	
	private enum OrderBY {
		ID, PRIORITY, ASSIGNEE, TYPE, STATUS, SUMMARY
	}

	public IssuePaginationParams() {
		super();
	}

	public IssuePaginationParams(Integer page, Integer orderBy, Integer order) {
		super(page, orderBy, order);
	}

	@Override
	public String getStringOrderBy() {
		return OrderBY.values()[getOrderBy()].toString().toLowerCase();
	}
}
