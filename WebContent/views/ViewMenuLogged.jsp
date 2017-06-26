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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<li class="UserAccount" id="UserAccount">
				<div class="user-image"
					style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')">
				</div>${sessionScope.user} 
				<div id = "admin">
				${sessionScope.userType} 
				</div>	
			</li>
		</ul>
		<hr class="hr-left-side-menu">
		<ul>
			<li class="Public" id="Public"> Public </li>
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
	<div id= '${sessionScope.user}' class="user-id"></div>
</body>

<script>
	document.getElementById("mySidenav").style.width = "250px";
	document.getElementById("main").style.marginLeft = "250px";
	$("#main-button").hide();
	if('${sessionScope.userType}' == "admin" ){
		$("#admin").show();
	}else{
		$("#admin").hide();
	}
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
														url : '${pageContext.request.contextPath}/IAMController',
														type : 'GET',
														data: {
															callType : "logout"
														},
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
	$("#UserAccount").click(
			
			function(){
				var userId = $(".user-id").attr("id");
				$.ajax({
					url : '${pageContext.request.contextPath}/UserAccountController',
					type : 'GET',
					data : {
						callType: 'navigate',
						userId : userId,
						sessionId: userId
					},
					success: function(data){
						var isAnonymous = (data[1] == 'true');
						if(isAnonymous){
							gotoViewAccount();
				    	}
					},
				});
			});
		
				
		function gotoViewAccount() {
			$.ajax({
				url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
				type : 'GET',
				success : function(
						result) {
							$("#main").html(result);
							$(".user-id").attr('id','${sessionScope.user}' );
						}
			});
		};
	
		$("#Public").click(
				function() {
					$.ajax({
						url : '${pageContext.request.contextPath}/views/tweetsManagement/ViewTweets.jsp',
						type : 'GET',
						success : function(
								result,
								responseText,
								session) {
									$("#main").html(result);
								}
					});
				});
</script>

</html>
