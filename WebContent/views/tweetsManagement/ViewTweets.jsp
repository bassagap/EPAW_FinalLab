<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"  import="models.BeanTweet"
	import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lab 3 template</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/tweetStyles.css" />
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
	<table>
		<tr>
			<td class="col-md-11">
				<form>
					<input type="text" name="search" placeholder="Search...">
				</form>
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
				<form id="addTweetForm"  action="/Lab3/TweetController" method="post" class="form-horizontal" role="form">
				<div class="modal-body">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="inputEmail3">HashTag</label>
							<div class="col-sm-10">
								<input type="hashTag" name = "hashTag" class="form-control" id="hashTag"
									placeholder="#hashTag" />
							</div>
							<label class="col-sm-2 control-label" for="inputEmail3">Description</label>
							<div class="col-sm-10">
								<input type="description" name = "description" class="form-control" id="description"
									placeholder="Description" />
							</div>
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<input type="submit"  id= "submit-button" class="btn btn-primary" name="submit" value="Save changes" />
				</div>
				</form>
			</div>
		</div>
	</div>




	<div id="main-test"></div>
</body>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script>

$(document).ready( function() {     
	 getTweets();

}); 
console.log('${pageContext.request.contextPath}');
var form = $('#addTweetForm');
form.submit(function () {
	$('#myModal').modal('hide');
	$('body').removeClass('modal-open');
	$('.modal-backdrop').remove();
	$.ajax({
		type: form.attr('method'),
		url: form.attr('action'),
		data: form.serialize(),
		success: function (data) {
			reloadTweets();
	}
});
 
return false;
});
$('.modal').on('hidden.bs.modal', function(){
$(this).find('form')[0].reset();
});

function getTweets(){
	  $.get('${pageContext.request.contextPath}/TweetController', function(responseJson) { 
	    	loadTweet(responseJson);
	        $(".delete-button").click(function() {
	        	 var id = $(this).attr("id");
				deleteTweets(id);
	        });
	    });
	
}
function deleteTweets(id){
 	$
	.ajax({
		url : '${pageContext.request.contextPath}/TweetController',
		type : 'GET',
		data : {
			id : id 
		},
		success : function(
				data) {
	 		reloadTweets();

		},
		error : function() {
		}
	});
}
function reloadTweets(){
		$( ".panel" ).remove();
 		getTweets();
}
function loadTweet(responseJson) {
    $.each(responseJson, function(index, tweet) {   
    	var $divMain =  $("<div>").addClass("panel tweet").appendTo($("#main-test"));
        var $div = $("<div>").addClass("panel-heading").appendTo($divMain); 
        $("<table>").appendTo($div) 
    var $table = $("<table>").appendTo($div)          
    $("<tr>").appendTo($table)
            .append($("<td>").addClass("col-md-11").append($("<div>").addClass("tweet-header-user").text(tweet.user)))       
            .append($("<td>").addClass("col-md-1").append($("<div>").addClass("tweet-header-date").text(tweet.publicationDate)));     
    $("<p>").appendTo($div).text(tweet.hashTag);
    $("<div>").appendTo($div).text(tweet.description);
    $("<div>").appendTo($div).addClass("panel-footer tweet tweet-footer")
    		.append($("<span>").addClass("glyphicon glyphicon-trash delete-button").attr("id",tweet.idTweet)); 
    });
}
</script>
</html>