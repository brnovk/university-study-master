package by.gsu.bugtracker.domain;

public abstract class PaginationParams {
	
	private Integer orderBy;
	private Integer page;
	private Integer order;

	public PaginationParams() { }
	
	public PaginationParams(Integer page, Integer orderBy, Integer order) {
		this.page = page;
		this.orderBy = orderBy;
		this.order = order;
	}
	
	public abstract String getStringOrderBy();

	public Integer getPage() {
		return page;
	}
	
	public void setPage(Integer page) {
		this.page = page;
	}
	
	public Integer getOrderBy() {
		return orderBy;
	}
	
	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}
	
	public String getOrder() {
		return (order.equals(1)? "ASC":"DESC");
	}
	
	public void setOrder(Integer order) {
		this.order = order;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		if (page != null)
			builder.append(page).append(";");
		if (orderBy != null)
			builder.append(orderBy).append(";");
		if (order != null)
			builder.append(order);
		return builder.toString();
	}
}
