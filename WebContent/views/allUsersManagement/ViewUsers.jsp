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
	<div class="user-block">List of all Users:</div>
	<div id="users"></div>
	
	<script>
	$(document).ready(function() {
		var userId =   $('.user-id').attr('id');
		var sessionId = '${sessionScope.user}';
		
		enter(userId,sessionId);				
	});
	
	function enter(userId,sessionId){			
		var userId =   $('.user-id').attr('id');
		
		getUsers(userId,sessionId);

	}
			
	function getUsers(userId,sessionId){
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				callType: 'getUsers',
				sessionId: sessionId
			},
			success: function(data){
				reloadFriends(data,userId);
				
				$('.unsubscribe-button').click(function() {
					var userId2 =   $('.user-id').attr('id');
					var userToDelete = $(this).attr('id');
					$.ajax({
						url : '${pageContext.request.contextPath}/SubscriptionsController',
						type : 'GET',
						data : {
							userName : userId,
							subscriptionName: userToDelete,
							callType: 'delete'
						},
						success : function(data) {
							console.log(userId);
							$('.user-id').attr('id',userId);
							enter(userId2,sessionId);
						},
						error : function() {
						}
					})
				});
				
				$('.add-button').click(function() {
					var userId2 =   $('.user-id').attr('id');
					var userToSearch = $(this).attr('id');
					$.ajax({
						url : '${pageContext.request.contextPath}/SubscriptionsController',
						type : 'GET',
						data : {
							userName : userId,
							subscriptionName: userToSearch,
							callType: 'add'
						},
						success : function(data) {
							enter(userId2,sessionId);
						},
						error : function() {
						}
					})
				});
				
				$('.friend-button').click(function() {
					var userId2 =  $(this).attr('id');
					$.ajax({
						url : '${pageContext.request.contextPath}/UserAccountController',
						type : 'GET',
						data : {
							callType: 'navigate',
							userId : userId2,
							sessionId: '${sessionScope.user}'
						},
						success: function(data){
							var isAnonymous = (data[1] == 'true');
							if(isAnonymous){
								gotoViewAccount(userId2);
					    	}
						},
					});
				});
			
					
			function gotoViewAccount(userId2) {
				$.ajax({
					url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
					type : 'GET',
					success : function(
							result) {
								$("#main").html(result);
								$(".user-id").attr('id',userId2);
								console.log(userId);
							}
				});
			};
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
	
	function loadFriends(data){
		$(".panel").remove();
		$.each(data, function(index, friend) {	
				var $divMain = $("<div>").addClass("friend panel").css('margin-bottom','25px').appendTo("#users");
				
				var $div = $("<div>").addClass("col-sm-2").appendTo($divMain).css('padding-top','10px');
				var $img = $("<div>").addClass("user-image").appendTo($div).css('background-image',"url('${pageContext.request.contextPath}/img/user_logo.png')");
						
				var $subsName = $("<div>").addClass("col-sm-5").css('padding-top','35px').appendTo($divMain);
				var $subsName = $("<div>").addClass("friend-button").css('cursor','pointer').attr("id",friend.userId).text(friend.userName).appendTo($subsName);
				if(friend.isSubscribed){
					var $trash = $("<div>").addClass("col-sm-5").css('padding-top','35px').appendTo($divMain);
					var $delete = $("<span>").addClass("glyphicon glyphicon-minus unsubscribe-button").attr("id",friend.userId).attr("id",friend[0]).prop('title', 'Unsubscribe').appendTo($trash);
				}
				else{
					var $trash = $("<div>").addClass("col-sm-5").css('padding-top','35px').appendTo($divMain);
					var $delete = $("<span>").addClass("glyphicon glyphicon-user add-button").attr("id",friend.userId).prop('title', 'Subscribe').appendTo($trash);
				}
	});
}
</script>
	
</body>
</html>