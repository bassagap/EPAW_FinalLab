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
	
	<!-- USER'S TWEETS -->
	<div class="col-sm-6">
		<div id="main-test">
		<table>
			<tr>
				<td class="col-md-6" id="left"></td>
				<td class="col-md-6" id="right"></td>
			</tr>
		</table>
	</div>
	</div>
	<!-- USER'S PROFILE -->
	<div class="col-sm-6">
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
			
		<div class="config" style="margin-bottom: 25px"></div>
		
		<table class="addSubscription" style="margin-left:100px"></table>
		
		<div id="main-subs"></div>
		
		</div>
	</div>
	
	<script>
	$(document).ready(function() {
		var userId =   $('.user-id').attr('id');
		var sessionId = '${sessionScope.user}';
		
		enter(userId,sessionId);				
	});
	
	function enter(userId,sessionId){			
		var userId =   $('.user-id').attr('id');
		
		console.log("-----");
		console.log("UserId: "+userId);
		console.log("Session: "+sessionId);
		console.log("-----");
		
		getPersonalInfo(userId,sessionId);
		getFriends(userId,sessionId);
		
		initTweets(userId);
		
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
				
				$('.delete-button-user').click(function() {
					$.ajax({
						url : '${pageContext.request.contextPath}/UserAccountController',
						type : 'GET',
						data : {
							callType: 'deleteUser',
							userId : userId,
							sessionId: sessionId
						},
						success : function(data) {
							console.log("log");
							window.location.href = '${pageContext.request.contextPath}/views/index.jsp';
						},
						error : function() {
						}
					})
				});
				
				$('.config-button').click(function() {
					var userId =   $('.user-id').attr('id');
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
				
				$('.unsubscribe-button').click(function() {
					var userId =   $('.user-id').attr('id');
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
							$('.user-id').attr('id',userId);
							getFriends(userId,sessionId);
						},
						error : function() {
						}
					})
				});
				
				$('.search-button').off().click(function() {
					var userId =   $('.user-id').attr('id');
					var userToSearch = $("#userToSearch").val();
					$.ajax({
						url : '${pageContext.request.contextPath}/SubscriptionsController',
						type : 'GET',
						data : {
							userName : userId,
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
				
				$('.friend-button').click(function() {
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
								$('.user-id').attr('id',userId2);
								enter(userId2,sessionId);
							},
						});
					});
		    },
		    error: function(){
		        console.log("The request failed");
		    }
		});
	}
	function reloadFriends(data){
		$(".panelUser").remove();
		loadFriends(data);
	}
	
	function loadPersonalInfo(data,userId){
		$("#personal-info-name").text(data[2]);
		$("#personal-info-email").text("");
		$("#personal-info-email").text(data[3]);
		
		$(".mainSearch").remove();
		$(".delete-button-user").remove();
		$(".configuration").remove();
		$(".userSearch").remove();
			
		if(data[0] == "true"){
			var $deleteUser = $("<span>").addClass("glyphicon glyphicon-trash delete-button-user").attr('id',userId).appendTo(".trash");
			
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
		$(".panelUser").remove();
		
		$.each(data, function(index, friend) {
			if(index !=0 && index!=1 && data[1] == "true"){
				var $divMain = $("<div>").addClass("friend panelUser").css('margin-bottom','25px').appendTo("#main-subs");
				
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
	function initTweets(userId){
		getTweets("user", userId);
		$("#myAlert").hide();
	}
	function getTweets(personalized,userId) {
		$
				.ajax({
					url : '${pageContext.request.contextPath}/TweetController',
					type : 'POST',
					data : {
						clicked : 'user',
						callType : 'updateProfile',
						userId: userId
					},
					success : function(result) {
						$(".panel").remove();
						loadTweet(result);
						$(".delete-button").click(function() {
							var id = $(this).attr("id");
							$.ajax({
								success : function(data) {
									$("#confirmDeleteModal").modal('show');
									$("#CancelDelete").click(function() {

									});
									$("#ConfirmDelete").click(function() {
										deleteTweet(id);
										$("#confirmDeleteModal").modal('hide');
									});
								},
								error : function() {
									$("#deleteModal").modal('show');
								}

							});
						});
						$(".edit-button").click(function() {
							var id = $(this).attr("id");
							$.ajax({
								success : function(data) {
									$("#hidden").val(id);
									editTweet(id, result);
								},
								error : function() {
									$("#deleteModal").modal('show');
								}
							});

						});
						$(".retweet-button").click(function() {
							var id = $(this).attr("id");
							retweet(id);
						});
						$(".like-button")
								.click(
										function() {
											var id = $(this).attr("id");
											$
													.ajax({
														type : "GET",
														url : '${pageContext.request.contextPath}/TweetController',
														data : {
															callType : 'like',
															id : id
														},
														success : function(data) {
															$
																	.ajax({
																		success : function(
																				data) {
																			initTweets(userId);
																		},
																		error : function() {

																		}
																	});
														},
														error : function() {
															$("#deleteModal")
																	.modal(
																			'show');
														}

													});

										});
						$(".tweet-header-user")
								.click(
										function() {
											var id = $(this).attr("id");
											var userName = $(this).text();
											$
													.ajax({
														url : '${pageContext.request.contextPath}/UserAccountController',
														type : 'POST',
														data : {
															callType : 'navigate',
															userId : id,
															sessionId : '${sessionScope.user}'
														},
														success : function(data) {
															gotoPerfil();
														},
													});
											function gotoPerfil() {
												$.ajax({
													url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
													type : 'GET',
													success : function(result) {
														$("#main").html(result);
														$(".user-id").attr('id',userName);
													}
												});
											};

										});

					}
				});
	}
	function editTweet(id, responseJson) {
		//console.log("response: ", responseJson);
		var personalized = $("#personalizedSearch").prop("checked");
		$("#myModalEdit").modal('show');
		$.each(responseJson, function(index, tweet) {
			if (tweet.idTweet == id) {
				$("#descriptionEdit").val(tweet.description);
				$("#hashTagEdit").val(tweet.hashTag);
			}
		});
		var formEdit = $('#editTweetForm');
		formEdit.submit(function() {
			$.ajax({
				type : formEdit.attr('method'),
				url : formEdit.attr('action'),
				data : formEdit.serialize() + "&callType=edit",
				success : function(data) {
					initTweets(userId);
					$('#myModalEdit').modal('hide');
					$('body').removeClass('modal-open');
					$('.modal-backdrop').remove();
				},
				error : function() {
					$("#anonymousModal").modal('show');
				}

			});
			return false;
		});
	}

	function deleteTweet(id) {
		var personalized = $("#personalizedSearch").prop("checked");
		$.ajax({
			url : '${pageContext.request.contextPath}/TweetController',
			type : 'GET',
			data : {
				id : id,
				callType : 'delete'
			},
			success : function(data) {
				initTweets(userId);
			},
			error : function() {
			}
		});
	}
	function retweet(id) {
		var personalized = $("#personalizedSearch").prop("checked");
		$.ajax({
			url : '${pageContext.request.contextPath}/TweetController',
			type : 'GET',
			data : {
				id : id,
				callType : 'retweet'
			},
			success : function(data) {
				initTweets(userId);
			},
			error : function() {

			}
		});
	}
	function loadTweet(responseJson) {
		if(responseJson[0].visibility == "true")
			$.each(responseJson, function(index, tweet) {
				if(index !=0){
					var $divMain = $("<div>").addClass("panel tweet").appendTo(
				
							$("#main-test"));
					var $div = $("<div>").addClass("panel-heading").appendTo($divMain);
					$("<table>").appendTo($div)
					var $table = $("<table>").appendTo($div)
		
					$("<tr>").appendTo($table).append(
							$("<td>").addClass("col-md-10").append(
									$("<div>").addClass("tweet-header-user").attr("id",
											tweet.idTweet).text(tweet.user).css('cursor','pointer').append(
													$("<div>").addClass("user-image pull-left"))))
		
					.append(
							$("<td>").addClass("col-md-1").append(
									$("<div>").addClass("tweet-header-date").text(
											tweet.publicationDate)));
					$("<p>").appendTo($div).text(tweet.hashTag);
					$("<div>").appendTo($div).text(tweet.description);
					appendIfOwnerOrAdmin(tweet, $div);
					drawRetweets(tweet, $divMain);
				}
			});
		else {
			var $divMain = $("<div>").addClass("panel tweet").appendTo($("#main-test"));
			var $div = $("<div>").addClass("panel-heading").css('text-align','center').text("This profile is private.").appendTo($divMain);
		}
		
		function appendIfOwnerOrAdmin(tweet, $div) {
			if (tweet.user == '${sessionScope.user}'
					|| '${sessionScope.userType}' == "admin") {
				$("<div>")
						.appendTo($div)
						.addClass("panel-footer tweet tweet-footer")
						.append(
								$("<span>")
										.addClass(
												"glyphicon glyphicon-trash delete-button pull-left")
										.attr("id", tweet.idTweet))
						.append(
								$("<span>")
										.addClass(
												"glyphicon glyphicon-pencil edit-button pull-left")
										.attr("id", tweet.idTweet))
						.append(
								$("<span>").addClass(
										"glyphicon glyphicon-thumbs-up like-button "
												+ tweet.isLiked
												+ "-selected  pull-right")
										.text(tweet.likes).attr("id",
												tweet.idTweet))
						.append(
								$("<span>")
										.addClass(
												"glyphicon glyphicon-retweet retweet-button pull-right")
										.attr("id", tweet.idTweet));
			} else {
				$("<div>")
						.appendTo($div)
						.addClass("panel-footer tweet tweet-footer")
						.append(
								$("<span>").addClass(
										"glyphicon glyphicon-thumbs-up like-button "
												+ tweet.isLiked
												+ "-selected pull-right").text(
										tweet.likes).attr("id", tweet.idTweet))
						.append(
								$("<span>")
										.addClass(
												"glyphicon glyphicon-retweet retweet-button pull-right")
										.attr("id", tweet.idTweet));

			}
		}
		function drawRetweets(tweet, $divMain) {
			//console.log("Retweet: ", tweet);
			if (tweet.parentTweet != -1) {
				$divMain.addClass("retweet");
			} else {
				$divMain.addClass("tweet");
			}
		}
	}
</script>
	
</body>
</html>