<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"  import="models.BeanUser"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Lab 3 template </title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/structure.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"> </script>
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<body>

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<ul>
		<li class = "Login"><div class = "user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div><a>Login</a></li>
	</ul>
	<hr class = "hr-left-side-menu">
	<ul>
		<li class = "Register"><a>Register</a></li>
		<li class = "No-Register"><a>Enter Without Register</a></li>
	</ul>
	<hr class = "hr-left-side-menu">
	<ul>
		<li class = "About"><a>About</a></li>
	</ul>
</div>
<span id = "main-button" style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; </span>
<div id="main">

</div>

<script>
document.getElementById("mySidenav").style.width = "250px";
document.getElementById("main").style.marginLeft = "250px";
$("#main-button").hide();

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
    $("#main-button").hide("slow");
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft= "0";
    $("#main-button").show();
}
$(document).ready(function(){
	$(".Register").click(function(){
    	$.ajax({url: '${pageContext.request.contextPath}/views/accessManagement/ViewRegisterForm.jsp', success: function(result){
        	$("#main").html(result);
    	}});
	});
	
   	$.ajax({url: '${pageContext.request.contextPath}/views/accessManagement/ViewLoginForm.jsp', type: "POST", data : {userName: '${user.userName}', error: '${user.error[0]}'}, success: function(result, responseText, session){	
       	$("#main").html(result);
   	}});
	$(".Login").click(function(){
    	$.ajax({url:  '${pageContext.request.contextPath}/views/accessManagement/ViewLoginForm.jsp', type: "POST", data : {userName: '${user.userName}', error: '${user.error[0]}'}, success: function(result, responseText, session){
        	$("#main").html(result);
    	}});
	});
   	
	$(".No-Register").click(function(){
		$.ajax({
	           url:'../LoginController',
	           type:'GET', 
	           data: {userType: "anonymous"},
	           success:function(data){
	        		 window.location.href = "ViewMenuLogged.jsp";  		
	           },
	           error:function(){
	           }});
	});
});
</script>
     
</body>
</html> 