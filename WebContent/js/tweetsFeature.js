/**
 * 
 */
function getTweets(personalized) {
	$
	.ajax({
		url : '${pageContext.request.contextPath}/TweetController',
		type : 'POST',
		data : {
			clicked : personalized,
			callType : 'update'
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
										getTweets(personalized);
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
				getTweets(personalized);
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
			getTweets(personalized);
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
			getTweets(personalized);
		},
		error : function() {

		}
	});
}
function loadTweet(responseJson) {
	$.each(responseJson, function(index, tweet) {
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
	});
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
	