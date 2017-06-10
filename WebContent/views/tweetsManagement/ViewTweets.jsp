<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Lab 3 template </title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/tweetStyles.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"> </script>
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td class="col-md-11">
			<form>
	  			<input type="text" name="search" placeholder="Search..">
			</form>
		</td>
		<td class="col-md-1">	
			<button type="button" class="btn btn-default btn-lg">
	  			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Add Tweet
			</button>
		</td>
	</tr>
</table>
<div class="panel tweet">
  	<div class="panel-heading">
		<div class = "tweet-header-user">User</div>
		<div class = "tweet-header-date">22/05/2016</div>
	</div>
    <div class="panel-body">Panel Content</div>
    <div class="panel-footer tweet tweet-footer">
    	<span id = "delete-button" class="glyphicon glyphicon-trash delete-button "> </span>
    </div>
</div>
<div class="panel tweet">
  	<div class="panel-heading">
		<div class = "tweet-header-user">User</div>
		<div class = "tweet-header-date">22/05/2016</div>
	</div>
    <div class="panel-body">Panel Content</div>
    <div class="panel-footer tweet tweet-footer">
    	<span id = "delete-button" class="glyphicon glyphicon-trash delete-button "> </span>
    </div>
</div>
<div class="panel tweet">
  	<div class="panel-heading">
		<div class = "tweet-header-user">User</div>
		<div class = "tweet-header-date">22/05/2016</div>
	</div>
    <div class="panel-body">Panel Content</div>
    <div class="panel-footer tweet tweet-footer">
    	<span id = "delete-button" class="glyphicon glyphicon-trash delete-button "> </span>
    </div>
</div>
</body>
</html>