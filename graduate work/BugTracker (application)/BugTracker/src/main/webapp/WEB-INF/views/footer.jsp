<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<div class="clearfix">
	<div class="float-left footer-block not-extreme">
		<s:message code="footer.thesis"/>
	</div>
	<div class="float-left footer-block">
		<s:message code="footer.author"/>
	</div>
	<div class="float-right footer-block">
		<a href='mailto:<s:message code="footer.support.email"/>?subject=feedback' 
			title='<s:message code="footer.supportTitle"/>'>
			<s:message code="footer.supportlabel"/>
		</a>
	</div>
	<div class="float-right footer-block not-extreme">
		<s:message code="footer.institution"/>
	</div>
	<div class="float-right footer-block not-extreme">
		2016
	</div>
</div>