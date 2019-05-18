<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<title><s:message code="page.title.login"/></title>
	<!--[if IE]>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<![endif]-->
	<!--[if lt IE 9]>
		<script src="<c:url value="/resources/js/oldIEFix.js"/>"></script>
	<![endif]-->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" href="data:image/png;base64,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"/>	
	<script type="text/javascript">
		function trimStr(str) {
			return str.replace(/^(\s|\u00A0)+|(\s|\u00A0)+$/g, '');
		}
	
		function trimLoginPassOnSubmit(formName, loginId, passwordId) {
			document.forms[formName][loginId].value = trimStr(document.forms[formName][loginId].value);
			document.forms[formName][passwordId].value = trimStr(document.forms[formName][passwordId].value);
		}
	</script>
	<style>
		html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;font-size:100%;font:inherit;vertical-align:baseline}
		article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}
		body{line-height:1}
		ol,ul{list-style:none}
		blockquote,q{quotes:none}
		blockquote:before,blockquote:after,q:before,q:after{content:'';content:none}
		table{border-collapse:collapse;border-spacing:0}
		/*@font-face {
			  font-family: 'Open Sans';
			  font-style: normal;
			  font-weight: 300;
			  src: url(https://themes.googleusercontent.com/static/fonts/opensans/v6/RjgO7rYTmqiVp7vzi-Q5UfY6323mHUZFJMgTvxaG2iE.eot);
			  src: local('Open Sans'), local('OpenSans'), url(https://themes.googleusercontent.com/static/fonts/opensans/v6/RjgO7rYTmqiVp7vzi-Q5UfY6323mHUZFJMgTvxaG2iE.eot) format('embedded-opentype'), url(https://themes.googleusercontent.com/static/fonts/opensans/v6/RjgO7rYTmqiVp7vzi-Q5UT8E0i7KZn-EPnyo3HZu7kw.woff) format('woff');
		} */
		@font-face{font-family:OpenSans;src:url(<c:url value="/resources/css/opensans.eot"/>);src:local(opensans),url(<c:url value="/resources/css/opensans.ttf"/>);text-rendering:optimizeLegibility;font-weight:300}
		body,input[type="submit"],input[type="reset"],input[type="text"],input[type="password"]{font-family:'Open Sans',sans-serif}
				
		body, html {
		    width: 100%;
		    height: 100%;
		    margin: 0;
		    padding: 0;
		    display:table;
		}
		
		body {
		    display:table-cell;
		    vertical-align:middle;
			background: #10334A;
			background: -moz-linear-gradient(top, #10334A 0%, #101722 100%);
			background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#10334A), color-stop(100%,#101722));
			background: -webkit-linear-gradient(top, #10334A 0%,#101722 100%);
			background: -o-linear-gradient(top, #10334A 0%,#101722 100%);
			background: -ms-linear-gradient(top, #10334A 0%,#101722 100%);
			background: linear-gradient(to bottom, #10334A 0%,#101722 100%);
			filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#10334A', endColorstr='#101722',GradientType=0 );
			color: #111;
		}
		
		form {
		    display:table;
		    margin:auto;
		    padding: 5px;
			border: 1px solid #ccc;
			background: rgba(255, 255, 255, 0.5);
			filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#4cffffff', endColorstr='#4cffffff');
			border-radius: 5px;
			color: #000;
		}
		
		
		form table caption {
			border-bottom: 1px solid #ccc;
			padding: 10px 5px;
			margin-bottom: 5px;
			color: #7cfc00;
			text-shadow: 1px 1px #708090;
			-moz-text-shadow: 1px 1px #708090;
			-webkit-text-shadow: 1px 1px #708090;
			filter: dropshadow(color=#708090, offx=1, offy=1);
		}
		
		form table {
			min-width: 300px;
			width: 320px;
			font-size: 14px;
		}
			
		form table td {
		 	padding: 2px 0 2px 5px;
			width: 33%;
		}
		
		form table td input[type="text"],
		form table td input[type="password"] {
			font-size: 14px;
			width: 97%;
			height: 100%;
			-ms-box-sizing:content-box;
			-moz-box-sizing:content-box;
			-webkit-box-sizing:content-box; 
			box-sizing:content-box;
		}
		
		form table td input[type="reset"],
		form table td input[type="submit"] {
			font-size: 14px;
			-ms-box-sizing:content-box;
			-moz-box-sizing:content-box;
			-webkit-box-sizing:content-box; 
			box-sizing:content-box;
			width: 80%;
			height: 20px;
			cursor: pointer;
		}
			
		form table a {
			font-weight: 500;
			color: #10334A;
			text-decoration: none;
			font-weight: bold;
		}
		
		form table a:hover {
			text-decoration: underline;
			color: #eee;
			text-shadow: 1px 1px #10334A;
			-moz-text-shadow: 1px 1px #10334A;
			-webkit-text-shadow: 1px 1px #10334A;
			filter: dropshadow(color=#10334A, offx=1, offy=1);
		}
	</style>
</head>
<body>
<noscript><div align="center" style="color: red;"><s:message code="noscript.message"/></div></noscript>
<form method="POST" action="<c:url value="/j_spring_security_check"/>" name="loginForm"
			onsubmit="trimLoginPassOnSubmit('loginForm','loginId','passId');">
	<table>
		<c:if test="${not empty param.error}">
			<caption>
				<s:message code="loginform.loginerror"/>: 
					${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			</caption>
		</c:if>
		<tr>
			<td align="right"><s:message code="loginform.login"/>:</td>
			<td colspan="2">
				<input type="text" name="j_username" id="loginId"
					placeholder='<s:message code="loginform.login.text.placeholder"/>' required="required"/>
			</td>
		</tr>
		<tr>
			<td align="right"><s:message code="loginform.password"/>:</td>
			<td colspan="2">
				<input type="password" name="j_password" id="passId"
					placeholder='<s:message code="loginform.password.text.placeholder"/>' required="required"/>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2"><s:message code="loginform.remember"/></td>
			<td align="center"><input type="checkbox" name="_spring_security_remember_me"/></td>
		</tr>
		<tr>
			<td align="center">
				<a href="<c:url value="/"/>" title='<s:message code="loginform.tomain.title"/>'>
					&lt; <s:message code="loginform.tomain"/>
				</a>
			</td>
			<td align="center">
				<input type="submit" value='<s:message code="loginform.btn.login"/>'
					title='<s:message code="loginform.btn.login.title"/>'/>
			</td>
			<td align="center">
				<input type="reset" value='<s:message code="loginform.btn.reset"/>'
					title='<s:message code="loginform.btn.reset.title"/>'/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>