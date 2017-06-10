<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="models.BeanTweet"
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.js">
	
</script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script> 
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Raleway" />
</head>
<body>
	<table>
		<tr>
			<td class="col-md-11">
				<form>
					<input type="text" name="search" placeholder="Search...">
				</form>
			</td>
			<td class="col-md-1">
				<button id = "id-button" type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#myModal">
					<i class="glyphicon glyphicon-plus" aria-hidden="true"></i> Add
					Tweet
				</button>
			</td>
		</tr>
	</table>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">New Tweet</h4>
              </div>
              <div class="modal-body">
                <form>
					<input type="text" name="new-tweet" placeholder="New tweet...">
				</form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
              </div>
            </div>
          </div>
        </div>

	<div id="main-test">
	
	</div>
</body>
<script>
$(document).ready( function() {      
    $.get('../TweetController', function(responseJson) {          
        $.each(responseJson, function(index, tweet) {   
        	var $divMain =  $("<div>").addClass("panel tweet").appendTo($("#main-test"));
            var $div = $("<div>").addClass("panel-heading").appendTo($divMain); 
        	console.log(tweet.user);
        var $table = $("<table>").appendTo($div)          
        $("<tr>").appendTo($table)
                .append($("<td>").addClass("col-md-11").append($("<div>").addClass("tweet-header-user").text(tweet.user)))       
                .append($("<td>").addClass("col-md-1").append($("<div>").addClass("tweet-header-date").text(tweet.publicationDate)));     
        $("<div>").appendTo($div).text(tweet.description);
        $("<div>").appendTo($div).addClass("panel-footer tweet tweet-footer")
        		.append($("<span>").addClass("glyphicon glyphicon-trash delete-button")); 
        });
    });
});
</script>
</html>