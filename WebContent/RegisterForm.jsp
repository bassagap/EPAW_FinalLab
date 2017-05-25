<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="models.BeanUser" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> USport </title>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">	
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/smooth.js"></script>
<script type="text/javascript" src="js/optionalFields.js"></script>
<script type="text/javascript" src="js/scroll.js"></script>
<link href="style/style.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function(){
    $("#registerForm").validate();
  });
</script>
</head>
<body>

<% 
BeanUser user = null;
if (request.getAttribute("user")!=null) {
	user = (BeanUser)request.getAttribute("user");
}
else {
	user = new BeanUser();
}
%>	

<div class="singup" id="Register">
	<form action="/Lab3/FormController" method="post" id="registerForm">
		<!--===============USERNAME===================-->
		<div class="field">
			<input type="text" name="userName" id="userName" placeholder="Username" value="<%=user.getUserName() %>" required minlength="6" maxlength="16"/>
			<% 	
				if ( user.getError()[0] == 1) {
					out.println("The username already exists in our DB!");
				}
			%>		
		</div>
		
		<!--===============PASSWORD===================-->
		<div class="field">
			<input type="password" name="password" id="password" placeholder="Password" value="<%=user.getPassword() %>" required minlength="6", maxlength="30" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[a-z]).*$" title="Must contain at least one number and special character."/>
		</div>
		
		<!--===============T&C===================-->
		<div class="field">
			<input type="checkbox" id="tc" name="tc" required/>
			<label for="tc"><span></span>I accept the <a href="#"><u>Terms and conditions</u></a></label>
		</div>
		
		<!--===============OPTIONAL FIELDS===================-->
		<div id="optionalButton">
			<div class="button" onclick="showOptional()()"> Click here to fulfil the optional fields </div>
			<p style="margin-left:25%">And participate on rankings (or do it later)</p>
		</div>
		<div id="optional" class="optional">
		
		<h3><span class="line-center">Optional Fileds</span></h3>
		<!--===============SPORTSLIST===================-->
		<dl class="dropdown"> 
			<dt>
				<p style="color:black"><b>My sports:</b> 
					<span class="multiSel" id="multiSel"></span>
				<a>
				  <span>Select Your Sports</span>    
				</a>
			</dt>
			<dd>
				<div class="mutliSelect">
					<ul>
						<li>
							<input type="checkbox" value="Soccer" id="s1"/>
							<label for="s1"><span></span>Football/Soccer</label></li>
						<li>
							<input type="checkbox" value="Cricket" id="s2"/>
							<label for="s2"><span></span>Cricket</label></li>
						<li>
							<input type="checkbox" value="Basketball" id="s3"/>
							<label for="s3"><span></span>Basketball</label></li>
						<li>
							<input type="checkbox" value="Hockey" id="s4"/>
							<label for="s4"><span></span>Hockey</label></li>
						<li>
							<input type="checkbox" value="Tennis" id="s5"/>
							<label for="s5"><span></span>Tennis</label></li>
						<li>
							<input type="checkbox" value="Cycling"id="s6"/>
							<label for="s6"><span></span>Cycling</label></li>
						<li>
							<input type="checkbox" value="Athletics"id="s7"/>
							<label for="s7"><span></span>Athletics</label></li>
						<li>
							<input type="checkbox" value="Rugby"id="s8"/>
							<label for="s8"><span></span>Rugby</label></li>
						<li>
							<input type="checkbox" value="Boxing"id="s9"/>
							<label for="s9"><span></span>Boxing</label></li>
						<li>
							<input type="checkbox" value="Volleyball"id="s10"/>
							<label for="s10"><span></span>Volleyball</label></li>
						<li>
							<input type="checkbox" value="Golf"id="s11"/>
							<label for="s11"><span></span>Golf</label></li>
					</ul>
					
					<div class="field">
						<input type="text" name="otherSport" id="otherSport" style="width:55%;display: inline-block;" id="sport" placeholder="Other sport that it's not in the list" minlength="3" maxlength="16"/>
						<div class="button" style="width:30%;display: inline-block;" onclick="addSport()"> Add </div>
					</div>
				</div>
			</dd>
		</dl>
		
		<!--===============GENDER===================-->
		<div class ="field">
			<input list="gender" name="gender" placeholder="Gender" value="<%=user.getGender() %>">
			<datalist id="gender">
				<option value="Male"></option>
				<option value="Female"></option>
			</datalist>
		</div>
		
		<!--===============BIRTHDATE===================-->
		<div class="field">
			<p> Introduce your birthday</p>
			<div id="dateOfBirth" class="dateOfBirth">
				<input id="day" type="number" maxlength="2" placeholder="DD" min="1" max="31"/> /              
				<input id="month" type="number" maxlength="2" placeholder="MM" min="1" max="12"/>/
				<input id="year" type="number" maxlength="4" placeholder="YYYY"  min="1895" max="2017"/>
			</div>
		</div>
	
		<!--===============WEIGHT===================-->
		<div class="field">
			<input type="number" name="weight" id="weight" placeholder="Weight" value="<%=user.getWeight() %>" style="width: 20%;" min="10" max="200"> &nbsp&nbsp kg
		</div>
		
		<!--===============EMAIL===================-->
		<div class="field">
			<input type="mail" name="mail" placeholder="Email" value="<%=user.getMail() %>" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
		</div>
		</div>
		<input class="button" type="submit" value="Submit" style="width:100%" >
	</form>
</div>

<script>
$(".dropdown dt a").on('click', function() {
  $(".dropdown dd ul").slideToggle('fast');
});

$(".dropdown dd ul li a").on('click', function() {
  $(".dropdown dd ul").hide();
});

function getSelectedValue(id) {
  return $("#" + id).find("dt a span.value").html();
}

$(document).bind('click', function(e) {
  var $clicked = $(e.target);
  if (!$clicked.parents().hasClass("dropdown")) $(".dropdown dd ul").hide();
});

$('.mutliSelect input[type="checkbox"]').on('click', function() {

  var title = $(this).closest('.mutliSelect').find('input[type="checkbox"]').val(),
    title = $(this).val() + ", ";

  if ($(this).is(':checked')) {
    var html = '<span title="' + title + '">' + title + '</span>';
    $('.multiSel').append(html);
    $(".hida").hide();
  } else {
    $('span[title="' + title + '"]').remove();
    var ret = $(".hida");
    $('.dropdown dt a').append(ret);
  }
});
</script>

</div>
</body>
</html>