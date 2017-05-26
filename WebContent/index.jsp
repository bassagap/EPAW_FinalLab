<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Lab 3 template </title>
<link rel="stylesheet" type="text/css" href="css/structure.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"> </script>
</head>
<body>
         <!-- Begin Header -->
         <div id="top-logo"> </div>
         <div class="left-side-menu">
			<ul>
				<li><a>Login</a></li>
				<li><a>Register</a></li>
				<li><a>About Us</a></li>
				<li><a>Enter Without Register</a></li>
			</ul>
		</div>
		<div id= "wrapper" ></div>		 
</body>

<script>
$(document).ready(function(){
	$(".Register").click(function(){
    	$.ajax({url: "ViewRegisterForm.jsp", success: function(result){
        	$("#wraper").html(result);
    	}});
	});
});
$(document).ready(function(){
	$(".Login").click(function(){
    	$.ajax({url: "ViewLoginForm.jsp", success: function(result){
        	$("#wraper").html(result);
    	}});
	});
});
</script>

</html>
