<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"  import="models.BeanUser"%>
    
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple Sidebar - Start Bootstrap Template</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/simple-sidebar.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<% 
BeanUser user = null;
if (request.getAttribute("user")!=null) {
	user = (BeanUser)request.getAttribute("user");
}
else {
	user = new BeanUser();
}
%>
<body>

    <div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
               <li class="sidebar-brand">
                    <div class = "user-image" style="background-image:url('img/user_logo.png')"></div><a>Login</a>
                </li>
				<li class = "Register">
					<a>Register</a>
				</li>
       			<li class = "No-Register">
       				<a>Enter Without Register</a>
       			</li>
                <li class = "About"><a>About</a></li>
            </ul>
        </div>
        
         <a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                     </div>
                </div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
   $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });

    </script>

</body>
<script>
$(document).ready(function(){
	$(".Register").click(function(){
    	$.ajax({url: "ViewRegisterForm.jsp", success: function(result){
        	$("#page-content-wrapper").html(result);
    	}});
	});
	
   	$.ajax({url: "ViewLoginForm.jsp", type: "POST", data : {userName: '${user.userName}', error: '${user.error[0]}'}, success: function(result, responseText, session){	
       	$("#page-content-wrapper").html(result);
   	}});
   	
	$(".No-Register").click(function(){
		$.ajax({
	           url:'LoginController',
	           type:'GET', 
	           data: {userType: "anonymous"},
	           success:function(data){
	        		 window.location.href = "ViewMenuLogged.jsp";  		
	           },
	           error:function(){
	           }});
	});
});
</script>
</html>
