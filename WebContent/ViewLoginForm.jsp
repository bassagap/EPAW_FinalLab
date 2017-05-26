<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" session="false" import="models.BeanUser"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
BeanUser user = null;
if (request.getAttribute("user")!=null) {
	user = (BeanUser)request.getAttribute("user");
}
else {
	user = new BeanUser();
}
%>	
<script>
$(document).ready(function(){
    $("#loginForm").validate();
  });
</script>

<form action="/Lab3/LoginController" method="post" id="loginForm">
	<table>
		<tr> 
			<td> <input type="text" name="userName" value="<%=user.getUserName() %>" id="userName" class="required login-input" minlength="5" placeholder = "User Name"/> </td> 
			<c:if test="${login.error[0] == 1}">
			   <td class="error"> Nonexistent username in our DB! </td> 
			</c:if>
		</tr>
		<tr> 
			<td> <input type="password" name="password" value="<%=user.getPassword() %>" id="password" class="required login-input" minlength="5" placeholder = "Password "/> </td> 
			<c:if test="${login.error[0] == 1}">
			   <td class="error"> Nonexistent username in our DB! </td> 
			</c:if>
		</tr>
		<tr> 
			<td> <input name="sumbit" type="submit" value="Login" class= "login-button"> </td>
		</tr>
	</table>
</form>