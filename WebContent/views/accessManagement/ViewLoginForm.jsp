<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" session="false" import="models.BeanUser"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<script>
$(document).ready(function(){
	console.log("Hi");
	console.log('${params.userName}');
    $("#loginForm").validate();
  });
</script>

<div class="top-logo"></div>
<form action="/Lab3/LoginController" method="post" >
	<table>
		<tr> 
			<td> <input type="text" name="userName" value="${param.userName}" id="userName" class="required login-input" minlength="5" placeholder = "User Name"/> </td> 
		</tr>
		<tr> 
			<td> <input type="password" name="password"  id="password" class="required login-input" minlength="5" placeholder = "Password "/></td> 
		</tr>
		<c:if test="${param.error== 1}">
			<tr>
			   	<td class="error"> Nonexistent username or password in our DB! </td> 
		   	</tr>
		</c:if>
		<tr> 
			<td> <input name="sumbit" type="submit" value="Login" class= "login-button"> </td>
		</tr>
	</table>
</form>