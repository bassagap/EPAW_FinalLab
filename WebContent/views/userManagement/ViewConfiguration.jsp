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

<div class="user-block">
	<div class="col-sm-2">Your mail is: </div>
	<div class="col-sm-10">
		<input type="mail" id="replaceMail" name="search" placeholder="None" />
	</div>
</div>

<div class="user-block">
	<div class="col-sm-2">
		Private profile: 
	</div>
	<div class="col-sm-10">
	
		<span class="button-checkbox">
	        <button type="button" class="btn" data-color="warning">Private</button>
	        <input type="checkbox" class="hidden" checked />
    </span>
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
$(document).ready(function() {
	var userId =  $(".user-id").attr('id');
	var sessionId =  '${sessionScope.user}';
	
	getPersonalInfo(userId);
		
	$(document).on('click','.save-button',function(){
		
		var mail = $("#replaceMail").val(); 
		
		$.ajax({
			url : '${pageContext.request.contextPath}/UserAccountController',
			type : 'GET',
			data : {
				callType: 'changeConfig',
				userId : userId,
				sessionId: "",
				mail : mail,
				privacy : $("#button-checkbox").is(':checked')
			},
			success: function(data){
				$(".Msg").remove();
				$("<div>").addClass("Msg").text("Changes saved").appendTo('.display-msg');
				getPersonalInfo(userId);
			},
		});
	});
});

function getPersonalInfo(userId,sessionId){
	$.ajax({
		url : '${pageContext.request.contextPath}/UserAccountController',
		type : 'GET',
		data : {
			callType: 'enterConfig',
			userId : userId,
			sessionId: ""
		},
		success: function(data){
			loadInfo(data);
	    },
	    error: function(){
	        console.log("The request failed");
	    }
	});
}
function loadInfo(data) {
	$('#replaceMail').val(data[1]);
	$('.button-checkbox').prop('checked', data[2] == 'true');
	console.log($("#button-checkbox").is(':checked'));
};

$(function () {
    $('.button-checkbox').each(function () {

        // Settings
        var $widget = $(this),
            $button = $widget.find('button'),
            $checkbox = $widget.find('input:checkbox'),
            color = $button.data('color'),
            settings = {
                on: {
                    icon: 'glyphicon glyphicon-check'
                },
                off: {
                    icon: 'glyphicon glyphicon-unchecked'
                }
            };

        // Event Handlers
        $button.on('click', function () {
            $checkbox.prop('checked', !$checkbox.is(':checked'));
            $checkbox.triggerHandler('change');
            updateDisplay();
        });
        $checkbox.on('change', function () {
            updateDisplay();
        });

        // Actions
        function updateDisplay() {
            var isChecked = $checkbox.is(':checked');

            // Set the button's state
            $button.data('state', (isChecked) ? "on" : "off");

            // Set the button's icon
            $button.find('.state-icon')
                .removeClass()
                .addClass('state-icon ' + settings[$button.data('state')].icon);

            // Update the button's color
            if (isChecked) {
                $button
                    .removeClass('btn-default')
                    .addClass('btn-' + color + ' active');
            }
            else {
                $button
                    .removeClass('btn-' + color + ' active')
                    .addClass('btn-default');
            }
        }

        // Initialization
        function init() {

            updateDisplay();

            // Inject the icon if applicable
            if ($button.find('.state-icon').length == 0) {
                $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
            }
        }
        init();
    });
});
</script>
	
</body>
</html>