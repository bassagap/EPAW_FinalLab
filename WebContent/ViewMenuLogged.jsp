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
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<body>
         <!-- Begin Header -->
         <!-- El logo nomes es veu en les pantalles de registre i login així que el trec del index <div id="top-logo"> </div> -->
         
         <div class="left-side-menu">
			<ul>
				<li class = "UserAccount"><div class = "user-image" style="background-image:url('img/user_logo.png')"></div><a>Login</a></li>
			</ul>
			<hr class = "hr-left-side-menu">
			<ul>
				<li class = "Rankings"><a>Rankings</a></li>
				<li class = "Popular"><a>Popular</a></li>
			</ul>
			<hr class = "hr-left-side-menu">
			<ul>
				<li class = "About"><a>About</a></li>
			</ul>
		</div>
		<div id= "wrapper" ></div>		 
</body>

<script>
$(document).ready(function(){
	var user = "${sessionScope.user}";
	console.log("Hi Paula");

	console.log(user);
	$(".Rankings").click(function(){
    	$.ajax({url: "ViewRegisterForm.jsp", success: function(result){
        	$("#wrapper").html(result);
    	}});
	});
});
</script>

</html>
