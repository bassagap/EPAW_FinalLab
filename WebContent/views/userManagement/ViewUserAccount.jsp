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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" runat="server"
	href="${pageContext.request.contextPath}/css/userProfileStyle.css" />
<!-- <link href="style/style.css" rel="stylesheet" type="text/css"> -->
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js">
	
</script>
<!-- <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script> -->

<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Raleway" />
<link rel="stylesheet" type="text/css" runat="server"
	href="${pageContext.request.contextPath}/css/tweetStyles.css" />
</head>


<body id="body">
	<div class="main-account">
		<div class="user" id='${sessionScope.user}'></div>

		<!-- USER'S PROFILE -->
		<div class="col-sm-6 separate">
			<h1>USER PROFILE</h1>
			<div class="user-block">
				<div class="col-sm-2">
					<div class="user-image"
						style="background-image:url('${pageContext.request.contextPath}/img/user_logo.png')"></div>
				</div>
				<div class="col-sm-7 personal-info">
					<div id="personal-info-name"></div>
					<div id="personal-info-email"></div>
				</div>
				<div class="col-sm-3 trash"></div>
			</div>

			<div class="user-block">
				<div class="col-sm-2">
					<img src='${pageContext.request.contextPath}/img/sports.png'
						style="width: 75px; cursor: pointer")">
				</div>
				<div class="col-sm-10">Sport list to be subscribed to rankings
					and to check preferences.</div>
			</div>

			<div class="user-block">
				<div class="col-sm-2">
					<img src='${pageContext.request.contextPath}/img/statistics.png'
						style="width: 75px; cursor: pointer">
				</div>
				<div class="col-sm-10">Statistics and progress.</div>
			</div>

			<div class="config" style="margin-bottom: 25px"></div>

			<table class="addSubscription" style="margin-left: 100px"></table>

			<div id="main-subs"></div>

		</div>
		<!-- USER'S TWEETS -->
		<div class="col-sm-6">
			<h1>USER TWEETS</h1>
			<div id="main-test">
				<table>
					<tr>
						<td class="col-md-6" id="left"></td>
						<td class="col-md-6" id="right"></td>
					</tr>
				</table>
			</div>
		</div>
		<!--Modal confirm delete -->
		<div class="modal fade" tabindex="-1" id="confirmDeleteModal"
			role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Your tweet is going to be permanently
							deleted</h4>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete it?&hellip;</p>
					</div>
					<div class="modal-footer">
						<button id="CancelDelete" type="button" class="btn btn-default"
							data-dismiss="modal">Cancel</button>
						<button id="ConfirmDelete" type="button" class="btn btn-danger">Delete</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<!-- Modal to EDIT-->
		<div class="modal" id="myModalEdit" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Edit Tweet</h4>
					</div>
					<form id="editTweetForm" action="/Lab3/TweetController"
						method="post" class="form-horizontal" role="form">
						<div class="modal-body">
							<div class="form-group">
								<label class="col-md-2 control-label" for="inputEmail3">HashTag</label>
								<div class="col-md-10">
									<input type="hashTag" name="hashTag" class="form-control"
										id="hashTagEdit" placeholder="#hashTag" />
								</div>
								<label class="col-md-2 control-label" for="inputEmail3">Description</label>
								<div class="col-md-10">
									<input type="description" name="description"
										class="form-control" id="descriptionEdit"
										placeholder="Description" /> <input type="hidden" name="id"
										class="hidden" id="hidden" />
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<input type="submit" id="submit-button" class="btn btn-primary"
								name="submit" value="Save changes" />
						</div>
					</form>
				</div>
			</div>
		</div>

	</div>

	<script>
		$(document).ready(function() {
			var userName = $('.user-id').attr('id');
			var sessionName = '${sessionScope.user}';

			getPersonalInformation(userName, sessionName);
			getTweets("user", userName);
		});

		function getPersonalInformation(userName, sessionName) {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/UserAccountController',
						type : 'GET',
						data : {
							callType : 'navigate',
							userName : userName,
							sessionId : sessionName
						},
						success : function(data) {
							loadPersonalInfo(data, userName, sessionName);
							loadFriends(data, userName);
							$('.unsubscribe-button')
									.click(
											function() {
												var userId = $('.user-id')
														.attr('id');
												var userToDelete = $(this)
														.attr('id');
												$
														.ajax({
															url : '${pageContext.request.contextPath}/UserAccountController',
															type : 'GET',
															data : {
																userName : userId,
																subscriptionName : userToDelete,
																callType : 'deleteSubscription'
															},
															success : function(
																	data) {
																getPersonalInformation(userName, sessionName);
															},
															error : function() {
															}
														})
											});
							$('.search-button')
							.off()
							.click(
									function() {
										var userId = $('.user-id')
												.attr('id');
										var userToSearch = $(
												"#userToSearch").val();
										$
												.ajax({
													url : '${pageContext.request.contextPath}/UserAccountController',
													type : 'GET',
													data : {
														userName : userId,
														subscriptionName : userToSearch,
														callType : 'addSubscription'
													},
													success : function(
															data) {
														getPersonalInformation(userName, sessionName);
														$("#userToSearch").val("");
													},
													error : function() {
													}
												})
									});
							$('.config-button')
									.click(
											function() {
												var userId = $('.user-id')
														.attr('id');
												$
														.ajax({
															url : '${pageContext.request.contextPath}/UserAccountController',
															type : 'GET',
															data : {
																callType : 'enterConfig',
																userName : userId,
																sessionId : sessionName
															},
															success : function(
																	data) {
																gotoConfig();
															},
														});

												function gotoConfig() {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/views/userManagement/ViewConfiguration.jsp',
																type : 'GET',
																success : function(
																		result) {
																	$("#main")
																			.html(
																					result);
																	$(
																			".user-id")
																			.attr(
																					'id',
																					userId);
																}
															});
												}
												;

											});

							$('.friend-button')
									.click(
											function() {
												var userId2 = $(this)
														.attr('id');
												$
														.ajax({
															url : '${pageContext.request.contextPath}/UserAccountController',
															type : 'GET',
															data : {
																callType : 'navigate',
																userName : userId2,
																sessionId : sessionName
															},
															success : function(
																	data) {
																$('.user-id')
																		.attr(
																				'id',
																				userId2);
																getPersonalInformation(userId2,
																		sessionName);
																getTweets("user", userId2);
																
															},
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
														userName : id,
														sessionId : '${sessionScope.user}'
													},
													success : function(
															data) {
														gotoPerfil();
													},
												});
										function gotoPerfil() {
											$
													.ajax({
														url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
														type : 'GET',
														success : function(
																result) {
															$("#main")
																	.html(
																			result);
															$(
																	".user-id")
																	.attr(
																			'id',
																			userName);
														}
													});
										}
										;

									});

						}
					});
		}
		function loadPersonalInfo(data, userName, sessionName) {
			$
					.each(
							data,
							function(index, user) {
								if (user.userName == userName) {
									$("#personal-info-name")
											.text(user.userName);
									if (user.isSubscribed
											|| user.userType == "admin"
											|| user.userName == sessionName) {
										$("#personal-info-email").text(
												user.mail);
									}
									$(".mainSearch").remove();
									$(".delete-button-user").remove();
									$(".configuration").remove();
									$(".userSearch").remove();

									var $deleteUser = $("<span>")
											.addClass(
													"glyphicon glyphicon-trash delete-button-user")
											.attr('id', user.userId).appendTo(
													".trash");

									var $userBlock = $("<div>").addClass(
											"user-block configuration")
											.appendTo(".config");
									var $img = $("<div>").addClass("col-sm-2")
											.appendTo($userBlock);
									var $img2 = $(
											"<img src='${pageContext.request.contextPath}/img/configuration.png' style='width:75px'>")
											.addClass("config-button").css(
													'cursor', 'pointer')
											.appendTo($img);
									var $conf = $("<div>")
											.addClass("col-sm-10")
											.text(
													"User account configuration: privacy, friends, user data etc.")
											.appendTo($userBlock);

									
									if('${sessionScope.userType}' == "admin" || user.userName == '${sessionScope.user}'){
										var $userSearch = $("<div>").addClass(
										"user-block userSearch").appendTo(
										".config");
										var $img = $("<div>").addClass("col-sm-5")
												.appendTo($userSearch);
										var $img2 = $(
										'<input type="text" id="userToSearch" name="search" placeholder="Search User" />')
										.appendTo($img);
										var $conf = $("<div>")
										.addClass("col-sm-7")
										.append(
												'<button id="id-button" type="button" class="btn btn-default btn-lg search-button" data-toggle="modal" data-target="#myModal"> Subscribe to User</button>')
										.appendTo($userSearch);
									}
									
								}
							})
		}

		function loadFriends(data, userName) {
			$(".panelUser").remove();
			$
					.each(
							data,
							function(index, friend) {
								if('${sessionScope.userType}' == "admin" || userName == '${sessionScope.user}'){
									if (friend.isSubscribed) {

										var $divMain = $("<div>").addClass(
												"friend panelUser").css(
												'margin-bottom', '25px').appendTo(
												"#main-subs");

										var $div = $("<div>").addClass("col-sm-2")
												.appendTo($divMain).css(
														'padding-top', '10px');
										var $img = $("<div>")
												.addClass("user-image")
												.appendTo($div)
												.css('background-image',
														"url('${pageContext.request.contextPath}/img/user_logo.png')");

										var $subsName = $("<div>").addClass(
												"col-sm-7").css('padding-top',
												'35px').appendTo($divMain);
										var $subsName = $("<div>").addClass(
												"friend-button").css('cursor',
												'pointer').attr("id",
												friend.userName).text(
												friend.userName)
												.appendTo($subsName);
										var $trash = $("<div>")
												.addClass("col-sm-3").appendTo(
														$divMain);
										var $delete = $("<span>")
												.addClass(
														"glyphicon glyphicon-trash unsubscribe-button")
												.css('padding-top', '25px').attr(
														"id", friend.userName)
												.appendTo($trash);
									}
								}
								
							});
		}

		function getTweets(personalized, userName) {
			$
					.ajax({
						url : '${pageContext.request.contextPath}/TweetController',
						type : 'POST',
						data : {
							clicked : 'user',
							callType : 'updateProfile',
							userId : userName
						},
						success : function(result) {
							$(".panel").remove();
							loadTweet(result);
							$(".delete-button")
									.click(
											function() {
												var id = $(this).attr("id");
												$
														.ajax({
															success : function(
																	data) {
																$(
																		"#confirmDeleteModal")
																		.modal(
																				'show');
																$(
																		"#CancelDelete")
																		.click(
																				function() {

																				});
																$(
																		"#ConfirmDelete")
																		.click(
																				function() {
																					deleteTweet(id);
																					$(
																							"#confirmDeleteModal")
																							.modal(
																									'hide');
																				});
															},
															error : function() {
																$(
																		"#deleteModal")
																		.modal(
																				'show');
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
															success : function(
																	data) {
																$
																		.ajax({
																			success : function(
																					data) {
																				getTweets(
																						"user",
																						userName);
																			},
																			error : function() {

																			}
																		});
															},
															error : function() {
																$(
																		"#deleteModal")
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
															success : function(
																	data) {
																gotoPerfil();
															},
														});
												function gotoPerfil() {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/views/userManagement/ViewUserAccount.jsp',
																type : 'GET',
																success : function(
																		result) {
																	$("#main")
																			.html(
																					result);
																	$(
																			".user-id")
																			.attr(
																					'id',
																					userName);
																}
															});
												}
												;

											});
							$('.config-button')
									.click(
											function() {
												var userId = $('.user-id')
														.attr('id');
												$
														.ajax({
															url : '${pageContext.request.contextPath}/UserAccountController',
															type : 'GET',
															data : {
																callType : 'enterConfig',
																userId : userId,
																sessionId : sessionName
															},
															success : function(
																	data) {
																gotoConfig();
															},
														});

												function gotoConfig() {
													$
															.ajax({
																url : '${pageContext.request.contextPath}/views/userManagement/ViewConfiguration.jsp',
																type : 'GET',
																success : function(
																		result) {
																	$("#main")
																			.html(
																					result);
																	$(
																			".user-id")
																			.attr(
																					'id',
																					userId);
																}
															});
												}
												;

											});

						}
					});
		}
		function editTweet(id, responseJson) {
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
						getTweets("user", id);
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
					getTweets(id);
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
					getTweets("user", id);
				},
				error : function() {

				}
			});
		}
		function loadTweet(responseJson) {
			if (responseJson[0].visibility) {
				$
						.each(
								responseJson,
								function(index, tweet) {
									if (index != 0) {
										var $divMain = $("<div>").addClass(
												"panel tweet").appendTo(

										$("#main-test"));
										var $div = $("<div>").addClass(
												"panel-heading").appendTo(
												$divMain);
										$("<table>").appendTo($div)
										var $table = $("<table>")
												.appendTo($div)

										$("<tr>")
												.appendTo($table)
												.append(
														$("<td>")
																.addClass(
																		"col-md-10")
																.append(
																		$(
																				"<div>")
																				.addClass(
																						"tweet-header-user")
																				.attr(
																						"id",
																						tweet.idTweet)
																				.text(
																						tweet.user)
																				.css(
																						'cursor',
																						'pointer')
																				.append(
																						$(
																								"<div>")
																								.addClass(
																										"user-image pull-left"))))

												.append(
														$("<td>")
																.addClass(
																		"col-md-1")
																.append(
																		$(
																				"<div>")
																				.addClass(
																						"tweet-header-date")
																				.text(
																						tweet.publicationDate)));
										$("<p>").appendTo($div).text(
												tweet.hashTag);
										$("<div>").appendTo($div).text(
												tweet.description);
										appendIfOwnerOrAdmin(tweet, $div);
										drawRetweets(tweet, $divMain);
									}
								});
			} else {
				var $divMain = $("<div>").addClass("panel tweet").appendTo(
						$("#main-test"));
				var $div = $("<div>").addClass("panel-heading").css(
						'text-align', 'center')
						.text("This profile is private.").appendTo($divMain);
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
													+ "-selected pull-right")
											.text(tweet.likes).attr("id",
													tweet.idTweet))
							.append(
									$("<span>")
											.addClass(
													"glyphicon glyphicon-retweet retweet-button pull-right")
											.attr("id", tweet.idTweet));

				}
			}
			function drawRetweets(tweet, $divMain) {
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