<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
$(document).ready(function(){
    $("#loginForm").validate({
    	submitHandler: function(form) {
    		$('#content').load('LoginController',$("#loginForm").serialize());
    }
    });
});
</script>

<form id="loginForm" action="" method="POST">
	<table>
		<tr> 
			<td> <input type="text" name="userName" value="${login.user}" id="userName" class="required login-input" minlength="5" placeholder = "User id "/> </td> 
			<c:if test="${login.error[0] == 1}">
			   <td class="error"> Nonexistent username in our DB! </td> 
			</c:if>
		</tr>
		<tr> 
			<td> <input type="password" name="password" value="${login.user}" id="password" class="required login-input" minlength="5" placeholder = "Password "/> </td> 
			<c:if test="${login.error[0] == 1}">
			   <td class="error"> Nonexistent username in our DB! </td> 
			</c:if>
		</tr>
		<tr> 
			<td> <input name="sumbit" type="submit" value="Enviar" class= "login-button"> </td>
		</tr>
	</table>
</form>