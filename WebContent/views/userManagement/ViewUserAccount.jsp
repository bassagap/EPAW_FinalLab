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
	<div class="user" id= '${sessionScope.user}'></div>
	<div class="user-block">
		
		<div class="col-sm-2">
			<div class="user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>
		</div>
		<div class="col-sm-7">
			<div id="personal-info-name"> </div>
       		<div id="personal-info-email"> </div>
		</div>
		<div class="col-sm-3">
			<span class = "glyphicon glyphicon-trash delete-button" id= '${sessionScope.user}'></span>
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
	
	<table class="addSubs" style="margin-left:100px">
	<!-- <tr>
			<td class="col-md-11">
				<form>
					<input type="text" id="userToSearch" name="search" placeholder="Search User">
				</form>
			</td>
			<td class="col-md-1">
				<button id="id-button" type="button" class="btn btn-default btn-lg search-button"	data-toggle="modal" data-target="#myModal">
					Subscribe to User
				</button>
			</td>
		</tr>-->
	</table>
	
	<div id="main-test" style="margin-top:100px"></div>
	<script>
	$(document).ready(function() {
		
		var userId =  $(".user").attr('id');
		var sessionId =  '${sessionScope.user}';
		
		console.log("User id: "+userId);
		console.log("Session id: "+sessionId);

		getPersonalInfo(userId);
		getFriends(userId);
			
		$(".delete-button").click(function() {
			$.ajax({
				url : '${pageContext.request.contextPath}/DeleteUserController',
				type : 'GET',
				data : {
					id : userId
				},
				success : function(data) {
					window.location.href = '${pageContext.request.contextPath}/views/index.jsp';
				},
				error : function() {
				}
			})
		});
		
		$(document).on('click','.unsubscribe-button',function(){
			var userToDelete = $(this).attr('id');
			$.ajax({
				url : '${pageContext.request.contextPath}/SubscriptionsController',
				type : 'GET',
				data : {
					userName : sessionId,
					subscriptionName: userToDelete,
					callType: 'delete'
				},
				success : function(data) {
					reloadSubscriptions();
				},
				error : function() {
				}
			})
		});
		
		$(document).on('click','.search-button',function(){
			var userToSearch = $("#userToSearch").val();
			$.ajax({
				url : '${pageContext.request.contextPath}/SubscriptionsController',
				type : 'GET',
				data : {
					userName : sessionId,
					subscriptionName: userToSearch,
					callType: 'add'
				},
				success : function(data) {
					reloadSubscriptions();
				},
				error : function() {
				}
			})
		});
		
		$(document).on('click','.friend',function(){
			var userId2 =  $(this).attr('id');
			$.ajax({
				url : '${pageContext.request.contextPath}/UserAccountController',
				type : 'GET',
				data : {
					callType: 'enterAccount',
					userId : userId2,
					sessionId: sessionId
				},
				success: function(data){
					gotoViewAccount(userId2);
				},
			});
		});
		function gotoViewAccount(userId2) {
			$.ajax({
				url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
				type : 'GET',
				success : function(result) {
					//$("#main").remove();
					$("#main").html(result);
					$(".user").attr('id',userId2);
				}
			});
		};
		
		function getPersonalInfo(userId){
			$.ajax({
				url : '${pageContext.request.contextPath}/UserAccountController',
				type : 'GET',
				data : {
					callType: 'enterAccount',
					userId : $(".user").attr('id'),
					sessionId: sessionId
				},
				success: function(data){
					loadPersonalInfo(data);
			    },
			    error: function(){
			        console.log("The request failed");
			    }

			});
		}
		
		function getFriends(userId){
			$.ajax({
				url : '${pageContext.request.contextPath}/UserAccountController',
				type : 'GET',
				data : {
					callType: 'getFriends',
					userId :  $(".user").attr('id'),
					sessionId: sessionId
				},
				success: function(data){
					loadFriends(data);
			    },
			    error: function(){
			        console.log("The request failed");
			    }

			});
		}

		function loadPersonalInfo(data){
			$("#personal-info-name").append(data[2]);
			$("#personal-info-email").append(data[3]);
			
			console.log(data);
			
			if(data[0] == "true"){
				var $divTr = $("<tr>").appendTo(".addSubs");
				var $td = $("<td>").addClass("col-md-10").appendTo($divTr);
				var $form = $("<form>").append('<input type="text" id="userToSearch" name="search" placeholder="Search User" />').appendTo($td);
				var $td2 = $("<td>").addClass("col-md-2").append('<button id="id-button" type="button" class="btn btn-default btn-lg search-button" data-toggle="modal" data-target="#myModal"> Subscribe to User</button>').appendTo($divTr);
			}
		}

		function loadFriends(data){
				$.each(data, function(index, friend) {
					if(index !=0){
						var $divMain = $("<div>").addClass("friend panel").attr("id",friend).css('margin-bottom','25px').appendTo("#main-test");
						
						var $div = $("<div>").addClass("col-sm-2").appendTo($divMain).css('padding-top','10px');
						var $img = $("<div>").addClass("user-image").appendTo($div).css('background-image',"url('${pageContext.request.contextPath}/img/user_logo.png')");
						
						var $subsName = $("<div>").addClass("col-sm-7").appendTo($divMain).css('padding-top','35px').text(friend);
						if(data[0] == "true"){
							var $trash = $("<div>").addClass("col-sm-3").appendTo($divMain);
							var $delete = $("<span>").addClass("glyphicon glyphicon-trash unsubscribe-button").val("hola").attr("id",friend).appendTo($trash);
						}
					}
				});
			
		}
		
		function reloadSubscriptions() {
			$("#main-test").remove();
			getFriends();
		}
	});
	</script>
	
</body>
</html>