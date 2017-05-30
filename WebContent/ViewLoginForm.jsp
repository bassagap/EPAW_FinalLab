<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" session="false" import="models.BeanUser"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
String userName = request.getParameter("userName");
String error = request.getParameter("error");
%>	
<script>
$(document).ready(function(){
	console.log('${user}');
    $("#loginForm").validate();
  });
</script>

<form action="/Lab3/LoginController" method="post" >
	<table>
		<tr> 
			<td> <input type="text" name="userName" value="<%=userName %>" id="userName" class="required login-input" minlength="5" placeholder = "User Name"/> </td> 
		</tr>
		<tr> 
			<td> <input type="password" name="password" value="<%=error %>" id="password" class="required login-input" minlength="5" placeholder = "Password "/> </td> 
		</tr>
		<c:if test="${user.error[0] == 1}">
			<tr>
			   	<td class="error"> Nonexistent username in our DB! </td> 
		   	</tr>
		</c:if>
		<tr> 
			<td> <input name="sumbit" type="submit" value="Login" class= "login-button"> </td>
		</tr>
	</table>
</form>