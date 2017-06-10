<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"  %>

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
         <!-- Begin Header -->
         <!-- El logo nomes es veu en les pantalles de registre i login així que el trec del index <div id="top-logo"> </div> -->
         
         <div id="mySidenav" class="sidenav">
         <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
         	<ul>
				<li class = "UserAccount"><div class = "user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>${sessionScope.user}</li>
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
			<hr class = "hr-left-side-menu">
			<ul>
				<li id="logout_button" class="logout-button"><a>Logout</a></li>
			</ul>
		</div>
		<span id = "main-button" style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; </span>
		<div id="main">

</div>
</body>

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
	$("#logout_button").click(function(){
        $.ajax({
           url:'${pageContext.request.contextPath}/LogoutController',
           type:'GET',
           success:function(data){
        		 window.location.href = '${pageContext.request.contextPath}/views/index.jsp';  		
           },
           error:function(){
           }});
	});
});
</script>

</html>