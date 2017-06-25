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
	<div class="main-account">
	<div class="user" id= '${sessionScope.user}'></div>
	<div class="user-block">
		
		<div class="col-sm-2">
			<div class="user-image" style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>
		</div>
		<div class="col-sm-7 personal-info">
			<div id="personal-info-name"> </div>
       		<div id="personal-info-email"> </div>
		</div>
		<div class="col-sm-3 trash"></div>
	</div>		
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='${pageContext.request.contextPath}/img/sports.png' style="width:75px; cursor: pointer")">	
		</div>
		<div class="col-sm-10">
			Sport list to be subscribed to rankings and to check preferences.
		</div>
	</div>
	
	<div class="user-block">
		<div class="col-sm-2">
			<img src='${pageContext.request.contextPath}/img/statistics.png' style="width:75px; cursor: pointer">
		</div>
		<div class="col-sm-10">
			Statistics and progress.
		</div>
	</div>
		
	<div class="config" style="margin-bottom: 100px"></div>	
	
	<table class="addSubscription" style="margin-left:100px"></table>
	
	<div id="main-test" style="margin-top:100px"></div>
	</div>
	
	<script>
	$(document).ready(function() {
		var userId =   $('.user-id').attr('id');
		var sessionId = '${sessionScope.user}';
		
		enter(userId,sessionId);		
			
		$(document).on('click','.delete-button',function(){
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
					getFriends(userId,sessionId);
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
					getFriends(userId,sessionId);
				},
				error : function() {
				}
			})
		});
		
		$(document).on('click','.friend-button',function(){
			var userId2 =  $(this).attr('id');
			$.ajax({
				url : '${pageContext.request.contextPath}/UserAccountController',
				type : 'GET',
				data : {
					callType: 'navigate',
					userId : userId2,
					sessionId: sessionId
				},
				success: function(data){
					userId = userId2;
					enter(userId,sessionId);
				},
			});
		});
		
		$(document).on('click','.config-button',function(){
			$.ajax({
				url : '${pageContext.request.contextPath}/UserAccountController',
				type : 'GET',
				data : {
					callType: 'enterConfig',
					userId : userId,
					sessionId: sessionId
				},
				success: function(data){
						gotoConfig();
				},
			});
								
			function gotoConfig() {
				$.ajax({
					url : '${pageContext.request.contextPath}/views/userManagement/ViewConfiguration.jsp',
					type : 'GET',
					success : function(result) {
						$("#main").html(result);
						$(".user-id").attr('id',userId);
					}
				});
			};
				
		});
		
	});
	
	function enter(userId,sessionId){			
		console.log("-----");
		console.log("UserId: "+userId);
		console.log("Session: "+sessionId);
		console.log("-----");
		
		getPersonalInfo(userId,sessionId);
		getFriends(userId,sessionId);
		
		$('<a name="top"/>').insertBefore($('body').children().eq(0));
		window.location.hash = 'top';
	}
			
	function getPersonalInfo(userId,sessionId){
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				callType: 'navigate',
				userId : userId,
				sessionId: sessionId
			},
			success: function(data){
				reloadPersonalInfo(data,userId);
		    },
		    error: function(){
		        console.log("The request failed");
		    }
			});
	}
	
	function reloadPersonalInfo(data,sessionId){
		$(".mainSearch").remove();
		loadPersonalInfo(data,sessionId);
	}
	function getFriends(userId,sessionId){
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				callType: 'getFriends',
				userId :  userId,
				sessionId: sessionId,
			},
			success: function(data){
				reloadFriends(data);
		    },
		    error: function(){
		        console.log("The request failed");
		    }
		});
	}
	function reloadFriends(data){
		$(".panel").remove();
		loadFriends(data);
	}
	
	function loadPersonalInfo(data,userId){
		$("#personal-info-name").text(data[2]);
		$("#personal-info-email").text("");
		$("#personal-info-email").text(data[3]);
		
		$(".mainSearch").remove();
		$(".delete-button").remove();
		$(".configuration").remove();
		$(".userSearch").remove();
			
		if(data[0] == "true"){
			var $deleteUser = $("<span>").addClass("glyphicon glyphicon-trash delete-button").attr('id',userId).appendTo(".trash");
			
			var $userBlock = $("<div>").addClass("user-block configuration").appendTo(".config");
			var $img = $("<div>").addClass("col-sm-2").appendTo($userBlock);
			var $img2 = $("<img src='${pageContext.request.contextPath}/img/configuration.png' style='width:75px'>").addClass("config-button").css('cursor','pointer').appendTo($img);
			var $conf = $("<div>").addClass("col-sm-10").text("User account configuration: privacy, friends, user data etc.").appendTo($userBlock);

			var $userSearch = $("<div>").addClass("user-block userSearch").appendTo(".config");
			var $img = $("<div>").addClass("col-sm-5").appendTo($userSearch);
			var $img2 = $('<input type="text" id="userToSearch" name="search" placeholder="Search User" />').appendTo($img);
			var $conf = $("<div>").addClass("col-sm-7").append('<button id="id-button" type="button" class="btn btn-default btn-lg search-button" data-toggle="modal" data-target="#myModal"> Subscribe to User</button>').appendTo($userSearch);
		}
	}
	function loadFriends(data){
		$(".panel").remove();
		$.each(data, function(index, friend) {
			if(index !=0){
				var $divMain = $("<div>").addClass("friend panel").css('margin-bottom','25px').appendTo("#main-test");
				
				var $div = $("<div>").addClass("col-sm-2").appendTo($divMain).css('padding-top','10px');
				var $img = $("<div>").addClass("user-image").appendTo($div).css('background-image',"url('${pageContext.request.contextPath}/img/user_logo.png')");
					
				var $subsName = $("<div>").addClass("col-sm-7").css('padding-top','35px').appendTo($divMain);
				var $subsName = $("<div>").addClass("friend-button").css('cursor','pointer').attr("id",friend).text(friend).appendTo($subsName);
				if(data[0] == "true"){
					var $trash = $("<div>").addClass("col-sm-3").appendTo($divMain);
					var $delete = $("<span>").addClass("glyphicon glyphicon-trash unsubscribe-button").val("hola").attr("id",friend).appendTo($trash);
				}
			}
	});
}
</script>
	
</body>
</html>