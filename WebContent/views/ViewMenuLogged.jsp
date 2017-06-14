<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" import="models.BeanTweet"
	import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lab 3 template</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/structure.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js">
	
</script>

<!-- Latest compiled JavaScript -->
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<body>
	<!-- Begin Header -->
	<!-- El logo nomes es veu en les pantalles de registre i login així que el trec del index <div id="top-logo"> </div> -->
	<div id="mySidenav" class="sidenav">
		<table>
			<tr>
				<td class="col-md-1"><span id="logout-button"
					class="glyphicon glyphicon-log-out logout-button "> </span></td>
				<td class="col-md-3"><span href="javascript:void(0)"
					class="closebtn" onclick="closeNav()">&times;</span></td>
			</tr>
		</table>
		<ul>
			<li class="UserAccount"><div class="user-image"
					style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>${sessionScope.user}</li>
		</ul>
		<hr class="hr-left-side-menu">
		<ul>
			<li class="Rankings">Rankings 	<div id="test"></div></li>
			<li class="Popular">Popular</li>
		</ul>
		<hr class="hr-left-side-menu">
		<ul>
			<li class="About">About</li>
		</ul>
		<hr class="hr-left-side-menu">
	</div>
	<span id="main-button" style="font-size: 30px; cursor: pointer"
		onclick="openNav()">&#9776; </span>
	
	<div id="main"></div>
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
		document.getElementById("main").style.marginLeft = "0";
		$("#main-button").show();
	}
	$(document)
			.ready(
					function() {
						$("#logout-button")
								.click(
										function() {
											$
													.ajax({
														url : '${pageContext.request.contextPath}/LogoutController',
														type : 'GET',
														success : function(data) {
															window.location.href = '${pageContext.request.contextPath}/views/index.jsp';
														},
														error : function() {
														}
													});
										});
					});
	$
			.ajax({
				url : '${pageContext.request.contextPath}/views/tweetsManagement/ViewTweets.jsp',
				type: 'GET',
				data: {},
				success : function(result) {
					$("#main").html(result);
				}
			});
</script>

</html>
