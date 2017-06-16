<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lab 3 template</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" runat="server" href="${pageContext.request.contextPath}/css/userProfileStyle.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js">
	
</script>
<!-- <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script> -->

<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Raleway" />
</head>


<body id = "body">
	
	<div class="user-block">
		<div class="col-sm-2">
			<div class="user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>
		</div>
		<div class="col-sm-10">
			<p> ${sessionScope.user} </p>
       		<p> ${sessionScope.user}</p>
		</div>
	</div>		
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='../img/sports.png' style="width:75px">	
		</div>
		<div class="col-sm-10">
			Sport list to be subscribed to rankings and to check preferences.
		</div>
	</div>
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='../img/statistics.png' style="width:75px">
		</div>
		<div class="col-sm-10">
			Statistics and progress.
		</div>
	</div>
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='../img/configuration.png' style="width:75px">
		</div>
		<div class="col-sm-10">
			User account configuration: privacy, friends, user data etc.
		</div>
	</div>
	
</body>
</html>