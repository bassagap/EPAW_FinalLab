<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" session="false" import="models.BeanUser"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="top-logo"></div>
<form action="/Lab3/IAMController" method="post" id="loginForm">
	<table>
		<tr>
			<td><input type="text" name="userName" value="${param.userName}"
				id="userName" class="required login-input" minlength="5"
				placeholder="User Name" /></td>
		</tr>
		<tr>
			<td><input type="password" name="password" id="password"
				class="required login-input" minlength="5" placeholder="Password " />
			<div id="error"></div></td>
		</tr>
		<tr>
			<td><input name="sumbit" type="submit" value="Login"
				class="login-button"></td>
		</tr>
	</table>
</form>
<script>
	var form = $('#loginForm');
	form
			.submit(function() {
				$
						.ajax({
							type : form.attr('method'),
							url : form.attr('action'),
							data : form.serialize() + "&callType=login",
							success : function(data) {
								window.location.href = '${pageContext.request.contextPath}/views/ViewMenuLogged.jsp';
							},
							error : function() {
								$("#error")
										.text(
												"Nonexistent username or password in our DB!").addClass("error");
							}

						});

				return false;
			});
</script>