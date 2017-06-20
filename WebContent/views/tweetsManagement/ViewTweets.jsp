<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true" import="models.BeanTweet"
	import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lab 3 template</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/tweetStyles.css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js"></script>


<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<body id="body">
	<table>
		<tr>
			<td class="col-md-10">
				<form>
					<input type="text" name="search" placeholder="Search...">
				</form>
			</td>
			<td class="col-md-2">
				<div class="checkbox">
  					<label><input type="checkbox" id = "personalizedSearch" value="">Personalized</label>
				</div>
			</td>
			<td class="col-md-1">
				<button id="id-button" type="button" class="btn btn-default btn-lg"
					data-toggle="modal" data-target="#myModal">
					<i class="glyphicon glyphicon-plus" aria-hidden="true"></i> Add
					Tweet
				</button>
			</td>
		</tr>
	</table>

	<!-- Modal -->
	<div class="modal" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">New Tweet</h4>
				</div>
				<form id="addTweetForm" action="/Lab3/TweetController" method="post"
					class="form-horizontal" role="form">
					<div class="modal-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputEmail3">HashTag</label>
							<div class="col-sm-10">
								<input type="hashTag" name="hashTag" class="form-control"
									id="hashTag" placeholder="#hashTag" />
							</div>
							<label class="col-sm-2 control-label" for="inputEmail3">Description</label>
							<div class="col-sm-10">
								<input type="description" name="description"
									class="form-control" id="description" placeholder="Description" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<input type="submit" id="submit-button" class="btn btn-primary"
							name="submit" value="Save changes" />
					</div>
				</form>
			</div>
		</div>
	</div>
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
					<h4 class="modal-title" id="myModalLabel">New Tweet</h4>
				</div>
				<form id="editTweetForm" action="/Lab3/EditTweetController"
					method="post" class="form-horizontal" role="form">
					<div class="modal-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputEmail3">HashTag</label>
							<div class="col-sm-10">
								<input type="hashTag" name="hashTag" class="form-control"
									id="hashTagEdit" placeholder="#hashTag" />
							</div>
							<label class="col-sm-2 control-label" for="inputEmail3">Description</label>
							<div class="col-sm-10">
								<input type="description" name="description"
									class="form-control" id="descriptionEdit"
									placeholder="Description" /> <input type="hidden" name="id"
									class="hidden" id="hidden" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<input type="submit" id="submit-button" class="btn btn-primary"
							name="submit" value="Save changes" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal error on delete -->
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
	<!-- Modal error on delete -->
	<div class="modal" id="anonymousModal" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Anonymous users
						cannot enter tweets</h4>
				</div>
				<div class="modal-body">
					<p>Please register or login to add tweets</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Confirm</button>
				</div>

			</div>
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
					<h4 class="modal-title">Your tweet is going to be permanently deleted</h4>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete it?&hellip;</p>
				</div>
				<div class="modal-footer">
					<button id= "CancelDelete" type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button id= "ConfirmDelete" type="button" class="btn btn-danger">Delete</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<div id="main-test"></div>
</body>


<script>
	$(document).ready(function() {
		getTweets();
		$("#myAlert").hide();
		$("#personalizedSearch").click(
				function() {
					var personalized = false;
					if($(this).prop("checked") == true){
						personalized = true;
					}
					$.ajax({
						url :  '${pageContext.request.contextPath}/TweetController',
						type : 'POST',
						data:{
							clicked : personalized
						},
						success : function(
								result,
								responseText,
								session) {
									alert(personalized);
								
								}
					});		
					
				});
	});
	var form = $('#addTweetForm');
	form.submit(function() {
		$.ajax({
			type : form.attr('method'),
			url : form.attr('action'),
			data : form.serialize(),
			success : function(data) {
				reloadTweets();
				$('#myModal').modal('hide');
				$('body').removeClass('modal-open');
				$('.modal-backdrop').remove();
			},
			error : function() {
				$("#anonymousModal").modal('show');
			}

		});

		return false;
	});
	function getTweets() {
		/* 		$(".delete-button").click(function() {
		 $.ajax({
		 type : 'GET',
		 url : '${pageContext.request.contextPath}/TweetController',
		 success : function(data) {
		 loadTweet(data);
		 var id = $(this).attr("id");
		 deleteTweet(id);
		 reloadTweets();	
		 },
		 error : function() {
		 $("#anonymousModal").modal('show');
		 }

		 }); 
		 });
		 $(".edit-button").click(function() {
		 $.ajax({
		 type : 'GET',
		 url : '${pageContext.request.contextPath}/TweetController',
		 success : function(data) {
		 loadTweet(data);
		 var id = $(this).attr("id");
		 $( "#hidden" ).val(id);
		 editTweet(id);
		 },
		 error : function() {
		 $("#anonymousModal").modal('show');
		 }

		 }); 
		 }); */

		$.get('${pageContext.request.contextPath}/TweetController', function(
				responseJson) {
			loadTweet(responseJson);
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
						$("#anonymousModal").modal('show');
					}

				});
			});
			$(".edit-button").click(function() {
				var id = $(this).attr("id");
				$("#hidden").val(id);
				editTweet(id);
			});
		});
	}
	function editTweet(id, responseJson) {
		$("#myModalEdit").modal('show');
		$.each(responseJson, function(index, tweet) {
			console.log(tweet);
			if (tweet.idTweet == id) {
				console.log(tweet.idTweet);
				$("#descriptionEdit").val(tweet.hashTag);
				$("#hashTagEdit").val(tweet.description);
			}
		});
		var formEdit = $('#editTweetForm');
		formEdit.submit(function() {
			$.ajax({
				type : formEdit.attr('method'),
				url : formEdit.attr('action'),
				data : formEdit.serialize(),
				success : function(data) {
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
		$('.modal').on('hidden.bs.modal', function() {
			$(this).find('form')[0].reset();
		});
	}
	function deleteTweet(id) {
		
		$.ajax({
			url : '${pageContext.request.contextPath}/DeleteTweetsController',
			type : 'GET',
			data : {
				id : id
			},
			success : function(data) {
				reloadTweets();
			},
			error : function() {
				console.log(" error get Tweets");
				$("#deleteModal").modal('show');
			}
		});
	}
	function reloadTweets() {
		$(".panel").remove();
		getTweets();
	}
	function loadTweet(responseJson) {
		$.each(responseJson, function(index, tweet) {
			var $divMain = $("<div>").addClass("panel tweet").appendTo(
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
							"glyphicon glyphicon-trash delete-button col-sm-1")
							.attr("id", tweet.idTweet)).append(
					$("<span>").addClass(
							"glyphicon glyphicon-pencil edit-button col-sm-11")
							.attr("id", tweet.idTweet));
		});
	}
</script>
</html>