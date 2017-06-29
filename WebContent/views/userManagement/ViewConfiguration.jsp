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
<link rel="stylesheet" type="text/css" runat="server"
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

<body id="body">

	<div class="user-block">
		<div class="col-sm-2">Your mail is:</div>
		<div class="col-sm-10">
			<form id="mail">
				<input class="replaceMail" type="mail" name="mail"
					placeholder="Email" required value="${param.userName}"
					pattern="[^@\s]+@[^@\s]+\.[^@\s]+" title="Enter a valid email">
			</form>
		</div>
	</div>

	<div class="user-block">
		<div class="col-sm-2">Private profile:</div>
		<div class="col-sm-10">
			<input type="checkbox" class="button-checkbox">
		</div>
	</div>

	<div class="user-block">
		<div class="col-sm-2">
			<div class="btn btn-default btn-lg save-button">Save changes</div>
		</div>
		<div class="col-sm-10">
			<div class="display-msg"></div>
		</div>
	</div>

</body>

<script>
	$(document)
			.ready(
					function() {
						var userId = $(".user-id").attr('id');
						var sessionId = '${sessionScope.user}';
						getPersonalInfo(userId, sessionId);

						$(document)
								.on(
										'click',
										'.save-button',
										function() {
											if ($(".replaceMail")
													.is(":invalid") == false) {
												var mail = $(".replaceMail")
														.val();
												$
														.ajax({
															url : '${pageContext.request.contextPath}/UserAccountController',
															type : 'GET',
															data : {
																callType : 'changeConfig',
																userId : userId,
																sessionId : sessionId,
																mail : mail,
																privacy : $(
																		".button-checkbox")
																		.is(
																				':checked')
															},
															success : function(
																	data) {
																window.location.href = '${pageContext.request.contextPath}/views/ViewMenuLogged.jsp';
															},
														});
											}

											else {
												$(".Msg").remove();
												$("<div>")
														.addClass("Msg")
														.text(
																"Enter a valid email")
														.appendTo(
																'.display-msg');
											}

										});
					});

	function getPersonalInfo(userId, sessionId) {
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				callType : 'enterConfig',
				userId : userId,
				sessionId : ""
			},
			success : function(data) {
				$
				.each(data, function(index,user) {
					if(user.userName == sessionId){
						$('.replaceMail').val(user.mail);
						if(user.visibility == 'private'){
							$('.button-checkbox').prop('checked', 'true');	
						} else {
							$('.button-checkbox').prop('checked', 'false');	
						}
					}
				})
			},
			error : function() {
			}
		});
	}
</script>

</body>
</html>