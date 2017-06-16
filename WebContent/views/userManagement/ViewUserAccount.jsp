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
<link rel="stylesheet" type="text/css" runat="server" href="${pageContext.request.contextPath}/css/tweetStyles.css" />
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
		<div class="col-sm-7" >
			<p> ${sessionScope.user} </p>
       		<p> ${sessionScope.user}</p>
		</div>
		<div class="col-sm-3">
			<span class = "glyphicon glyphicon-trash delete-button" id = '${sessionScope.user}'></span>
		</div>
	</div>		
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='${pageContext.request.contextPath}/img/sports.png' style="width:75px">	
		</div>
		<div class="col-sm-10">
			Sport list to be subscribed to rankings and to check preferences.
		</div>
	</div>
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='${pageContext.request.contextPath}/img/statistics.png' style="width:75px">
		</div>
		<div class="col-sm-10">
			Statistics and progress.
		</div>
	</div>
	
	<div class="user-block" style="margin-bottom:100px">
		<div class="col-sm-2">
			<img src='${pageContext.request.contextPath}/img/configuration.png' style="width:75px">
		</div>
		<div class="col-sm-10">
			User account configuration: privacy, friends, user data etc.
		</div>
	</div>
		
	<div class="modal" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">You are not the
						owner of the tweet</h4>
				</div>
				<div class="modal-body">
					<p>You can delete only your tweets</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Confirm</button>
				</div>

			</div>
		</div>
	</div>
	
	<table style="margin-left:100px">
		<tr>
			<td class="col-md-11">
				<form>
					<input type="text" name="search" placeholder="Search User">
				</form>
			</td>
			<td class="col-md-1">
				<button id="id-button" type="button" class="btn btn-default btn-lg"
					data-toggle="modal" data-target="#myModal">
					<i class="glyphicon glyphicon-plus" aria-hidden="true"></i> Subscribe to User
				</button>
			</td>
		</tr>
	</table>
	
	<div id="main-test" style="margin-top:100px"></div>
	
	<ul>
		<li><div class="friend panel">
				<div class="col-sm-2" style="padding-top:10px">
					<div class="user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>
				</div>
				<div class="col-sm-10" style="padding-top:35px">
					Jon Doe
				</div>
		</div></li>
		
	</ul>
	
	<script>
	$(document).ready(function() {
		$(".delete-button").click(function() {
			var id = $(this).attr("id");
			deleteUser(id);
		});
	});
	function deleteUser(id) {
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				id : id
			},
			success : function(data) {
				window.location.href = '${pageContext.request.contextPath}/views/index.jsp';
			},
			error : function() {

			}
		});
	}
	function loadFriends(responseJson) {
		$.each(responseJson, function(index, friend) {
			var $divMain = $("<div>").addClass("friend tweet").appendTo(
					$("#main-test"));
			var $div = $("<div>").addClass("panel-heading").appendTo($divMain);
			$("<table>").appendTo($div)
			var $table = $("<table>").appendTo($div)
			$("<tr>").appendTo($table).append(
					$("<td>").addClass("col-md-11").append(
							$("<div>").addClass("tweet-header-user").text(
									tweet.user))).append(
					$("<td>").addClass("col-md-1").append(
							$("<div>").addClass("tweet-header-date").text(
									tweet.publicationDate)));
			$("<p>").appendTo($div).text(tweet.hashTag);
			$("<div>").appendTo($div).text(tweet.description);
			$("<div>").appendTo($div).addClass(
					"panel-footer tweet tweet-footer").append(
					$("<span>").addClass(
							"glyphicon glyphicon-trash delete-button").attr(
							"id", tweet.idTweet));
		});
	}
	
	</script>
	
</body>
</html>