<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<!-- <script src="http://code.jquery.com/jquery.js"></script> 
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
	-->
	
	<script src="js/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" href="<c:url value="css/bootstrap.css" />" media="screen"/>
    <link rel="stylesheet" href="<c:url value="css/mortgage.css" />"/>
    
    <script src="js/angular.min.js"></script>
    
	<title>JP Morgan Chase Bank Mortgage Center</title>
	<script>
	$(document).ready(function() {
		$('.login33').show();
		$('.login34').show();
		$('.login35').hide();
		$('#needlogin').hide();
		if($('#joke').text()=="anonymousUser"){
			//alert($('#joke').val());
		}else{
			//var sesioninfo = $('#joke').text();
			$('.login33').hide();
			$('.login34').hide();
			$('.login35').show();
		}
		$('#mtgc').click(function(event){
			if($('#joke').text()=="anonymousUser"){
				$('#mdl').modal('show');
				event.preventDefault();
				$('#needlogin').show();
			}
		});
		
		 if($('#role01').text()=='[ROLE_ADMIN]'){
			  $('#role01').text("MyAdmin");
			  $('#role01').attr("href", "admin.html");
		  }
		  if($('#role01').text()=='[ROLE_USER]'){
			  $('#role01').text("Registed user");
			  //$('#role01').attr("href", "admin.html");
		  }
		
		
		
		
		$('#login001').click(function(){
			$('#registerPass').hide();	
			$('#needlogin').hide();
		});
		$('#rgr01').click(function(){
			$("#registerUsername").hide();
			$("#registerEmail").hide();
			$('#username1').removeClass("has-success","has-feedback","ng-dirty");
			$('#email1').removeClass("has-success","has-feedback","ng-dirty");
			$('#email2').removeClass("has-success","has-feedback","ng-dirty");
			$('#password1').removeClass("has-success","has-feedback","ng-dirty");
			$('#password2').removeClass("has-success","has-feedback","ng-dirty");
			$('#username').removeClass("ng-dirty");
			$('#password').removeClass("ng-dirty");
			$('#email').removeClass("ng-dirty");
			$('#cEmail').removeClass("ng-dirty");
			$('#cPassword').removeClass("ng-dirty");
			$('#username').val('');
			$('#password').val('');
			$('#email').val('');
			$('#cEmail').val('');
			$('#cPassword').val('');
			$('#un1').hide();
			$('#emailValid').hide();
			$('#em1').hide();
			$('#em2').hide();
			$('#registerEmail').hide();
			$('#passwordShort').hide();
			$('#passwordDiff').hide();
			$('#pw2').hide();
			$('#pw1').hide();
			$('#subPass').hide();	
			
		});
		$('#rclr').click(function(){
			$("#registerUsername").hide();
			$("#registerEmail").hide();
			$('#username1').removeClass("has-success","has-feedback","ng-dirty");
			$('#email1').removeClass("has-success","has-feedback","ng-dirty");
			$('#email2').removeClass("has-success","has-feedback","ng-dirty");
			$('#password1').removeClass("has-success","has-feedback","ng-dirty");
			$('#password2').removeClass("has-success","has-feedback","ng-dirty");
			$('#username').val('');
			$('#un1').hide();
			$('#emailValid').hide();
			$('#em1').hide();
			$('#em2').hide();
			$('#registerEmail').hide();
			$('#passwordShort').hide();
			$('#passwordDiff').hide();
			$('#pw2').hide();
			$('#pw1').hide();
			$("#emailExsist").hide();
			$('#username').removeClass("ng-dirty");
			$('#password').removeClass("ng-dirty");
			$('#email').removeClass("ng-dirty");
			$('#cEmail').removeClass("ng-dirty");
			$('#cPassword').removeClass("ng-dirty");
			$('#subPass').hide();	
			
		});
		
		
		
		if ("<c:out value='${param.login_error}'/>" != "") {
		  	$('#wrongCredentials').show();
		  	$('#mdl').modal('show');
		}
		$('#username').keyup(function() {
			if($('#username').val()){
				
				$.ajax({
					url : 'http://localhost:8080/MortgageCalculator/rest/registering/usernameCheck',
					type : "get",
					dataType : "html",
					data : {
						username:$('#username').val()
					},
					success : function(response) {
						var result = response.toString().trim();
						if (result == "true") {
							$("#registerUsername").show();
							$('#username').val('');
							$('#username1').removeClass("has-success","has-feedback");
							$('#un1').hide();
						} 
						else{
							
								$('#username1').addClass("has-success","has-feedback");
								$("#registerUsername").hide();
								$('#un1').show();
								
							
							
						}
					},
					error : function(msg) {
						alert(msg);
					}
				});
				
				
				
			}
			
			if(!$('#username').val()){
				
				$('#un1').hide();
			}
			
			   
			});
		$('#username').blur(function() {
			if($('#username').val()){
				
				$.ajax({
					url : 'http://localhost:8080/MortgageCalculator/rest/registering/usernameCheck',
					type : "get",
					dataType : "html",
					data : {
						username:$('#username').val()
					},
					success : function(response) {
						var result = response.toString().trim();
						if (result == "true") {
							$("#registerUsername").show();
							$('#username').val('');
							$('#username1').removeClass("has-success","has-feedback");
							$('#un1').hide();
						} 
						else{
							
								$('#username1').addClass("has-success","has-feedback");
								$("#registerUsername").hide();
								$('#un1').show();
								
							
							
						}
					},
					error : function(msg) {
						alert(msg);
					}
				});
				
				
				
			}
			
			if(!$('#username').val()){
				
				$('#un1').hide();
			}
			
			   
			});
		$('#email').keyup(function() {
			var emailContent = $('#email').val();
			var re = /^[-a-z0-9_]+(\.[-a-z0-9_]+)*@[-a-z0-9_]+(\.[-a-z0-9]+)+$/gi;
			if($('#email').val()){
			$.ajax({
					url : 'http://localhost:8080/MortgageCalculator/rest/registering/emailCheck',
					type : "get",
					dataType : "html",
					data : {
						email:$('#email').val()
					},
					success : function(response) {
						var result = response.toString().trim();
						if (result == "true") {
							$("#emailExsist").show();
							$('#email').val('');
							$('#email1').removeClass("has-success","has-feedback");
							$('#emailValid').hide();
							$('#em1').hide();
						}
						else{
							if(re.test(emailContent)){
								
								$('#email1').addClass("has-success","has-feedback");
								$('#em1').show();
								$('#emailValid').hide();
								$("#emailExsist").hide();
							}else{
								$('#email1').removeClass("has-success","has-feedback");
								$('#em1').hide();
								$('#emailValid').show();
							}
							
							
						
						
					}
					},
					error : function(msg) {
						alert(msg);
					}
				});
	
			//$('#email').val('');
			//$("#registerEmail").show();
			
			}
			if(!$('#email').val()){
				$('#email1').removeClass("has-success","has-feedback");
				$('#em1').hide();
			}
			});
		$('#email').blur(function() {
			var emailContent = $('#email').val();
			var re = /^[-a-z0-9_]+(\.[-a-z0-9_]+)*@[-a-z0-9_]+(\.[-a-z0-9]+)+$/gi;
			if($('#email').val()){
			$.ajax({
					url : 'http://localhost:8080/MortgageCalculator/rest/registering/emailCheck',
					type : "get",
					dataType : "html",
					data : {
						email:$('#email').val()
					},
					success : function(response) {
						var result = response.toString().trim();
						if (result == "true") {
							$("#emailExsist").show();
							$('#email').val('');
							$('#email1').removeClass("has-success","has-feedback");
							$('#emailValid').hide();
							$('#em1').hide();
						}
						else{
							if(re.test(emailContent)){
								
								$('#email1').addClass("has-success","has-feedback");
								$('#em1').show();
								$('#emailValid').hide();
								$("#emailExsist").hide();
							}else{
								$('#email1').removeClass("has-success","has-feedback");
								$('#em1').hide();
								$('#emailValid').show();
							}
							
							
						
						
					}
					},
					error : function(msg) {
						alert(msg);
					}
				});
	
			//$('#email').val('');
			//$("#registerEmail").show();
			
			}
			if(!$('#email').val()){
				$('#email1').removeClass("has-success","has-feedback");
				$('#em1').hide();
			}
			});
		$('#cEmail').keyup(function() {
			if($('#cEmail').val()){
				if($('#email').val()==$('#cEmail').val()){
					$('#registerEmail').hide();
					$('#email2').addClass("has-success","has-feedback");
					$('#em2').show();
				}else{
					$('#email2').removeClass("has-success","has-feedback");
					$('#em2').hide();
					$('#registerEmail').show();
				}
				
				
				
				
				
			}
			
			else if(!$('#cEmail').val()){
				$('#email2').removeClass("has-success","has-feedback");
				$('#em2').hide();
			}
			
			   
			});
		$('#cEmail').blur(function() {
			if($('#cEmail').val()){
				if($('#email').val()==$('#cEmail').val()){
					$('#registerEmail').hide();
					$('#email2').addClass("has-success","has-feedback");
					$('#em2').show();
				}else{
					$('#email2').removeClass("has-success","has-feedback");
					$('#em2').hide();
					$('#registerEmail').show();
				}
				
				
				
				
				
			}
			
			else if(!$('#cEmail').val()){
				$('#email2').removeClass("has-success","has-feedback");
				$('#em2').hide();
			}
			
			   
			});
		$('#email').keyup(function() {
			if(($('#cEmail').val())&& ($('#cEmail').hasClass('ng-dirty'))){
				if($('#email').val()==$('#cEmail').val()){
					$('#registerEmail').hide();
					$('#email2').addClass("has-success","has-feedback");
					$('#em2').show();
				}else{
					$('#email2').removeClass("has-success","has-feedback");
					$('#em2').hide();
					$('#registerEmail').show();
				}
				
				
				
				
				
			}
			
			else if(!$('#cEmail').val()){
				$('#email2').removeClass("has-success","has-feedback");
				$('#em2').hide();
			}
			
			   
			});
		$('#email').blur(function() {
			if(($('#cEmail').val())&& ($('#cEmail').hasClass('ng-dirty'))){
				if($('#email').val()==$('#cEmail').val()){
					$('#registerEmail').hide();
					$('#email2').addClass("has-success","has-feedback");
					$('#em2').show();
				}else{
					$('#email2').removeClass("has-success","has-feedback");
					$('#em2').hide();
					$('#registerEmail').show();
				}
				
				
				
				
				
			}
			
			else if(!$('#cEmail').val()){
				$('#email2').removeClass("has-success","has-feedback");
				$('#em2').hide();
			}
			
			   
			});
		$('#password').keyup(function() {
			if($('#password').val()&&($($('#password').hasClass('ng-dirty')))){
				if($('#password').val().length>=6){
					$('#password1').addClass("has-success","has-feedback");
					$('#pw1').show();
					$('#passwordShort').hide();
				}else{
					$('#password1').removeClass("has-success","has-feedback");
					$('#pw1').hide();
					$('#passwordShort').show();
				}
			}
			if(!$('#password').val()&&($($('#password').hasClass('ng-dirty')))){
				$('#password1').removeClass("has-success","has-feedback");
				$('#pw1').hide();
			}
			
			
			if($('#password1').hasClass("has-success","has-feedback")){
				if($('#cPassword').val()){
					if($('#cPassword').val()==$('#password').val()){
						$('#passwordDiff').hide();
						$('#password2').addClass("has-success","has-feedback");
						$('#pw2').show();
					}else{
						$('#password2').removeClass("has-success","has-feedback");
						$('#pw2').hide();
						$('#passwordDiff').show();
					}
					
					
					
					
					
				}
			}
			
			
			
			
			   
			});
		$('#password').blur(function() {
			if($('#password').val()&&($($('#password').hasClass('ng-dirty')))){
				if($('#password').val().length>=6){
					$('#password1').addClass("has-success","has-feedback");
					$('#pw1').show();
					$('#passwordShort').hide();
				}else{
					$('#password1').removeClass("has-success","has-feedback");
					$('#pw1').hide();
					$('#passwordShort').show();
				}
			}
			if(!$('#password').val()&&($($('#password').hasClass('ng-dirty')))){
				$('#password1').removeClass("has-success","has-feedback");
				$('#pw1').hide();
			}
			
			
			if($('#password1').hasClass("has-success","has-feedback")){
				if($('#cPassword').val()){
					if($('#cPassword').val()==$('#password').val()){
						$('#passwordDiff').hide();
						$('#password2').addClass("has-success","has-feedback");
						$('#pw2').show();
					}else{
						$('#password2').removeClass("has-success","has-feedback");
						$('#pw2').hide();
						$('#passwordDiff').show();
					}
					
					
					
					
					
				}
			}
			
			
			
			
			   
			});
		
		
		$('#cPassword').keyup(function() {
			if($('#password1').hasClass("has-success","has-feedback")){
				if($('#cPassword').val()){
					if($('#cPassword').val()==$('#password').val()){
						$('#passwordDiff').hide();
						$('#password2').addClass("has-success","has-feedback");
						$('#pw2').show();
					}else{
						$('#password2').removeClass("has-success","has-feedback");
						$('#pw2').hide();
						$('#passwordDiff').show();
					}
					
					
					
					
					
				}
			}
			
			
			   
			});
		$('#cPassword').blur(function() {
			if($('#password1').hasClass("has-success","has-feedback")){
				if($('#cPassword').val()){
					if($('#cPassword').val()==$('#password').val()){
						$('#passwordDiff').hide();
						$('#password2').addClass("has-success","has-feedback");
						$('#pw2').show();
					}else{
						$('#password2').removeClass("has-success","has-feedback");
						$('#pw2').hide();
						$('#passwordDiff').show();
					}
					
					
					
					
					
				}
			}
			
			
			   
			});
		

		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		
		$('#register').click(function(event){
			var valid = 0;
			if($('#username1').hasClass("has-success","has-feedback","ng-dirty")){
				valid++;
			}
			if($('#email1').hasClass("has-success","has-feedback","ng-dirty")){
				valid++;
			}
			if($('#email2').hasClass("has-success","has-feedback","ng-dirty")){
				valid++;
			}
			if($('#password1').hasClass("has-success","has-feedback","ng-dirty")){
				valid++;
			}
			if($('#password2').hasClass("has-success","has-feedback","ng-dirty")){
				valid++;
			}
			if(valid==5){
				$.ajax({
					url : 'http://localhost:8080/MortgageCalculator/rest/registering',
					type : "post",
					dataType : "html",
					data : {
						username:$('#username').val(),
						password:$('#password').val(),
						email:$('#email').val()
					},
					success : function(response) {
						
						$('#Register').modal('hide');
						$('#mdl').modal('show');		
						$('#registerPass').show();	
						
						
					},
				
					error : function(msg) {
						alert(msg);
					}
				});
				
			}else{
				
				$('#subPass').show();	
			}
			
			
			
			
			
			
			//return false;
		});
		
		
		
		
		
		
		
		

		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		//********************************************************************************************************************
		
		
		
		
		
		
		$('#gtx').click(function(){
			$("#usernameAndPasswordReq").hide();
			$("#usernameReq").hide();
			$("#passwordReq").hide();
			$("#passwordReq2").hide();
			$("#wrongCredentials").hide();	
		});
		
		$("#gg").on("click", loginValidation);	
		$("input").keydown(function(){
			    //$(this).css("background-color","green");
		});
		$("input").keyup(function(){
				  //$(this).css("background-color","whi");
		});
		$("input").focus(function(){
			$(this).css("background-color","#CCF9CC");
		});
		$("input").blur(function(){
			$(this).css("background-color","white");
			if( !$(this).val()){
				$(this).addClass("empty01");
			}
			if($(this).val()){
				$(this).removeClass("empty01");
			}
		});
		
		
		
	});

	function loginValidation() {
		
		$("#usernameAndPasswordReq").hide();
		$("#usernameReq").hide();
		$("#passwordReq").hide();
		$("#passwordReq2").hide();
		$("#wrongCredentials").hide();	
	  	if($("#j_username").val().length == 0 && $("#j_password").val().length == 0) {
	  		$("#usernameAndPasswordReq").show();
	  		return false;
	  	} else if ($("#j_username").val().length == 0) {
	  		$('#usernameReq').show();
	  		return false;
	  	} else if ($("#j_password").val().length == 0) {
	  		$("#passwordReq").show();
	  		return false;
	  	} else if ($("#j_password").val().length < 6) {
	  		$("#passwordReq2").show();
	  		return false;
	  	} else {
	  		return true;
	  	}
	}
	
	
	
	//var str = 'For more information, see Chapter 3.4.5.1';
	//var re = /^[-a-z0-9_]+(\.[-a-z0-9_]+)*@[-a-z0-9_]+(\.[-a-z0-9]+)+$/i;
	//var found = str.match(re);
	
	//var re = new RegExp('/^[-a-z0-9_]+(\.[-a-z0-9_]+)*@[-a-z0-9_]+(\.[-a-z0-9]+)+$/');
	
	
	
	
	
</script>
<script>
angular.module("mainModule", [])
	.controller("mainController", function ($scope) {
		$scope.isTextChanged = false;
		$scope.isTextChanged2 = false;
		$scope.isTextChanged3 = false;
		$scope.isTextChanged4 = false;
		$scope.isTextChanged5 = false;
		$scope.isTextChanged6 = false;
		
		$scope.isEmailChanged = false;
		$scope.textChangesCounter = 0;
		$scope.emailChangesCounter = 0;

  		$scope.onTextChange = function () {
    		$scope.isTextChanged = true;
    		$scope.textChangesCounter++;
  		};
  		$scope.onTextChange2 = function () {
    		$scope.isTextChanged2 = true;
    		$scope.textChangesCounter++;
  		};
  		$scope.onTextChange3 = function () {
    		$scope.isTextChanged3 = true;
    		$scope.textChangesCounter++;
  		};
  		$scope.onTextChange4 = function () {
    		$scope.isTextChanged4 = true;
    		$scope.textChangesCounter++;
  		};
  		$scope.onTextChange5 = function () {
    		$scope.isTextChanged5 = true;
    		$scope.textChangesCounter++;
  		};
  		$scope.onTextChange6 = function () {
    		$scope.isTextChanged6 = true;
    		$scope.textChangesCounter++;
  		};

  		

  		$scope.getItemState = function (item) {
    		if (item.$pristine) {
      			return "pristine";
    		} else if (item.$dirty) {
      			return "dirty";
    		} else {
      			return "";
    		}
  		};
	});
</script>
</head>
<body ng-app="mainModule">
	<section id="title" class="row bcc topp">
		<p class="col-md-3"></p>
		<img id="logo01" class="col-md-3" src="img/2.png"/>
		<p class="col-md-1 col-md-offset-2">
		<form class="navbar-form" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">GO</button>
      </form>
	</section>

	<section class="row bcc">
	<div class="col-md-3 bcb">&nbsp;</div>
	<ul id="nav01" class="row col-md-8 navbar bcc" style="list-style-type: none;"> 
      

    
    <li class="col-md-1"><a href="calculator.html">HOME</a></li>
    <li class="col-md-1"><a href="#">ABOUTUS</a></li>
    <li class="col-md-1"><a id="mtgc" href="FunctionCalculator.html">MORTGAGE</a></li>
    <li class="dropdown col-md-2">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">MORE INFORMATION<b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</li>
          <li><a href="#">Change my password</a></li>
          <li><a href="#">Fetch my account</a></li>
          <li class="divider"></li>
          <li class="dropdown-header">REDEEM SECTION</li>
          <li><a href="#">Through ticket code</a></li>
          <li><a href="#">Through QR code</a></li>
        </ul>
    </li>
    <li class="col-md-1"><a href="https://www.chase.com/">chase.com</a></li>
     <li class="col-md-1"><a href="https://www.jpmorgan.com/">jpmorgan.com</a></li>
     <li class="col-md-1 col-md-offset-1 login33"><a id="login001" href="#info" data-toggle="modal" data-target="#mdl">Login</a></li>
     <li class="col-md-1 login34"><a href="#info" data-toggle="modal" data-target="#Register" id="rgr01">Register</a></li>
     <li class="dropdown col-md-2 col-md-offset-2 login35">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">${username}<b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</li>
          <li><a id="role01" href="#">${role}</a></li>
          <li><a href="#">Fetch my account</a></li>
          <li class="divider"></li>
          <li class="dropdown-header">REDEEM SECTION</li>
          <li><a href="#">Through ticket code</a></li>
          <li><a href="#">Through QR code</a></li>
        </ul>
    </li>
</ul>
<div class="col-md-1 bcb">&nbsp;</div>
	</section>


<div class="modal fade" id="mdl" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Sign in now!</h4>
      </div>
      <div class="modal-body">
        <form id="login-form" name="f" class="form-horizontal" action="<c:url value='/MortgageCalculator/j_spring_security_check'/>" method="post" role="form">
       	<div class="alert alert-success col-sm-12 col-sm-offset-0" style="display:none;" id="registerPass">
	<p>Congratulations! You have registered in our system, Click the link here to verify:<a href="http://www.google.com">your mail</a></p>
</div>
<div class="alert alert-info col-sm-12 col-sm-offset-0" style="display:none;" id="needlogin">
	<p>Please Login first before you want to calculate your mortgage. Thank you!</p>
</div>
          <div class="form-group">
          <label for="Username" class="col-sm-2 control-label">Username</label>
          <div class="col-sm-10">
           <input type="text" class="form-control" name="j_username" id="j_username" placeholder="Username">
         </div>
         </div>
       <div class="alert alert-warning col-sm-10 col-sm-offset-2" style="display:none;" id="usernameReq">
	<p>Your username is empty!</p>
</div>
 
      <div class="form-group">
       <label for="password" class="col-sm-2 control-label">Password</label>
        <div class="col-sm-10">
          <input type="password" class="form-control" name="j_password" id="j_password" placeholder="Password">
      </div>
     </div>
     <!-- Alerts for missing form info  --> 
<div class="alert alert-warning col-sm-10 col-sm-offset-2" style="display:none;" id="usernameAndPasswordReq">
	<p>Username and password are required</p>
</div>


<div class="alert alert-warning col-sm-10 col-sm-offset-2" style="display:none;" id="passwordReq">
	<p>Your password is empty!</p>
</div>
<div class="alert alert-warning col-sm-10 col-sm-offset-2" style="display:none;" id="passwordReq2">
	<p>Your must enter at least 6 characters for your password!</p>
</div>
<div class="alert alert-danger col-sm-10 col-sm-offset-2" id="wrongCredentials" style="display:none;">
	<p>Your password and username does not match!<br> Or you can register here:<a href="#info" data-toggle="modal" data-target="#Register">Register</a></p>
</div>
       
       <button id="gg" type="submit" class="btn btn-success">Login</button>
      <button id="gtx" class="btn btn-info" type="reset">Clear</button>
      
      
        </form>
	
      </div>

    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<div class="modal fade" ng-controller="mainController" id="Register" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Register here please:</h4>
      </div>
      <div class="modal-body">
        <form id="register-form" name="f" class="form-horizontal" action="" method="post" role="form">
       
          <div class="form-group">
          	<label for="username" class="col-sm-2 col-sm-offset-1 control-label">Username</label>
          	<div id="username1" class="col-sm-7">
           	<input type="text" class="form-control register01 col-md-8" name="username" id="username"  ng-model="textValue" ng-change="onTextChange()" placeholder="Username">
         	</div><div class="col-sm-1"><img class="iccc" id="un1" style="display:none;"  alt="" src="img/r1.png"/></div>
         	
         	
         </div>
          <div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="registerUsername">
			<p>This user name has already bean used. Please enter something else!</p>
	   </div>
         <div class="form-group">
          	<label for="email" class="col-sm-2 col-sm-offset-1 control-label">Email</label>
          	<div id="email1" class="col-sm-7">
           	<input type="text" class="form-control register01" name="email" id="email" ng-model="emailValue" ng-change="onTextChange2()" placeholder="Email">
         	</div><div class="col-sm-1"><img class="iccc" id="em1" style="display:none;"  alt="" src="img/r1.png"/></div>
         </div>
         <div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="emailValid">
	<p>Please enter an real email address!</p>
</div>
<div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="emailExsist">
	<p>This email address has been registered!</p>
</div>
         <div class="form-group">
          	<label for="cEmail" class="col-sm-2 col-sm-offset-1 control-label">Confirm Email</label>
          	<div id="email2" class="col-sm-7">
           	<input type="text" class="form-control register01" name="cEmail" id="cEmail" ng-model="emailValueC" ng-change="onTextChange3()"  placeholder="Confirm Email">
         	</div><div class="col-sm-1"><img class="iccc" id="em2" style="display:none;"  alt="" src="img/r1.png"/></div>
         	
         </div>
         <div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="registerEmail">
	<p>Email does not match that you just confirmed!</p>
</div>
         <div id="password1" class="form-group">
          	<label for="password" class="col-sm-2 col-sm-offset-1 control-label">Password</label>
          	<div class="col-sm-7">
           	<input type="password" class="form-control register01" name="password" id="password" ng-model="pwdValue" ng-change="onTextChange4()"  placeholder="Password">
         	</div><div class="col-sm-1"><img class="iccc" id="pw1" style="display:none;"  alt="" src="img/r1.png"/></div>
         </div>
         <div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="registerPassword">
	<p>Your password must have at least 6 charaters!</p>
</div>



<div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="passwordShort">
	<p>You must enter a password with more than 6 characters!</p>
</div>
         <div id="password2" class="form-group">
          	<label for="cPassword" class="col-sm-2 col-sm-offset-1 control-label">Confirm Password</label>
          	<div class="col-sm-7">
           	<input type="password" class="form-control register01" name="cPassword" id="cPassword" ng-model="pwdValue2" ng-change="onTextChange5()"  placeholder="Confirm Password">
         	</div><div class="col-sm-1"><img class="iccc" id="pw2" style="display:none;" alt="" src="img/r1.png"/></div>
         </div>  
       <!-- Alerts for missing form info  --> 
       
      

<div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="registerPassword">
	<p>Your password must have at least 6 charaters!</p>
</div>



<div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="passwordShort">
	<p>You must enter a password with more than 6 characters!</p>
</div>
<div class="alert alert-warning col-sm-7 col-sm-offset-3" style="display:none;" id="passwordDiff">
	<p>Your password is different from what you just confirmed!</p>
</div>
<div class="alert alert-warning col-sm-7 col-sm-offset-3" id="wrongCredentials" style="display:none;">
	<p>Your password and username does not match!<br> Or you can register here:<a href="#info" data-toggle="modal" data-target="#Register">Register</a></p>
</div>

<div class="alert alert-danger col-sm-9 col-sm-offset-1" style="display:none;" id="subPass">
			<p>Please complete all blanks before submission!</p>
	   </div>
       

	<button id="register" type="submit" class="btn btn-success col-sm-offset-1">Register</button>
      <button class="btn btn-info" type="reset" id="rclr">Clear</button>
       
      
        </form>

      </div>

    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->
<!-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -->








<section id="carousel01" class="row bcc">
	<div id="this-carousel-id" class="carousel slide col-md-12"><!-- class of slide for animation -->
  <ol class="carousel-indicators">
        <li data-target="#this-carousel-id" data-slide-to="0" class="active"></li>
        <li data-target="#this-carousel-id" data-slide-to="1"></li>
        <li data-target="#this-carousel-id" data-slide-to="2"></li>
      </ol>
  <div class="carousel-inner">
    <div class="item active"><!-- class of active since it's the first item -->
      <img class="crimg" src="img/a.jpg" alt="" />
      <div class="carousel-caption">
        <p class="illus hold leftn">
        	<a href="" class="ctitle">Turning a Lifelong Love of Science into a Lifelong Love of Self</a><br>
        	We've expanded our 18 year commitment to include a work-study program for teens.
        	<br><button class="btn btn-lg btn-primary">Learn more.</button>
        </p>
      </div>
    </div>
    <div class="item">
      <img class="crimg" src="img/c.jpg" alt="" />
      <div class="carousel-caption">
        <p class="illus hold leftn">
        	<a href="" class="ctitle">Coding Competitions Across the Globe</a><br>
        	500 participants in India solve coding problems for nonprofits.
        	<br><button class="btn btn-lg btn-primary">Learn more.</button>
        </p>
      </div>
    </div>
    <div class="item">
      <img class="crimg" src="img/b.jpg" alt="" />
      <div class="carousel-caption">
        <p class="illus hold leftn">
        	<a href="" class="ctitle">Invested in Detroit's Future</a><br>
        	$100 million over the next five years will support and accelerate the city's dynamic recovery.
        	<br><button class="btn btn-lg btn-primary">Learn more.</button>
        </p>
      </div>
    </div>
     <div class="item">
      <img class="crimg" src="img/lg5.jpg" alt="" />
      <div class="carousel-caption">
        <p class="illus hold leftn">
        	<a href="" class="ctitle">$30 Million to Support Small Business</a><br>
        	Our Small Business Forward initiative will help small business clusters and entrepreneurs grow and boost local economies.
        	<br><button class="btn btn-lg btn-primary">Learn more.</button>
        </p>
      </div>
    </div>
    
  </div><!-- /.carousel-inner -->
  <!--  Next and Previous controls below
        href values must reference the id for this carousel -->
    <a class="carousel-control left" href="#this-carousel-id" data-slide="prev"><div class="inccc icl"><img class="myicn" src="img/slide_prev_white.png" alt=""></div></a>
    <a class="carousel-control right" href="#this-carousel-id" data-slide="next"><div class="inccc icr"><img class="myicn" src="img/slide_next_white.png" alt=""></div></a>

</div><!-- /.carousel -->
</section>


<section class="body01 row col-md-8 col-md-offset-3">
  <section class="row col-md-9" id="last02">
  	<aside class="col-md-12 body04 body00 body30">
  	<div class="row">
  		<div class="col-md-7">
		  	<a href="">Behind Every Collaboration is a Story</a>
		  	<br>
		  	These are the stories of the neighborhoods, businesses, programs and ideas that are moving our communities forward.
		  	<br><br>
		  	See stories for:<br>
			<a href="">Chicago</a> &nbsp;&nbsp;&nbsp;<a href="">Denver</a> &nbsp;&nbsp;&nbsp;<a href="">Detroit</a> &nbsp;&nbsp;&nbsp;<a href="">Seattle</a>
		 </div>
		 <div class="col-md-5"><img id="img00" src="img/o1.jpg"></div>
		 
	</div>
  	



  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i1.png">
      <div class="try"><a href="">$35MM Commitment to Improve Consumer Financial Security</a><br>
      Our 2-year initiative will provide grants to support nonprofits which help promote financial security.<br><br>
      <a href="">Learn More</a></div>
      
    </div>
  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i2.jpg">
      <div class="try"><a href="">Houston Skills Gap Report</a><br>
      Report identifies needs and opportunities in key economic sectors, focusing on petrochemical industry and commercial/industrial construction.<br>
      <a href="">Learn More</a></div>
      
    </div>
  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i3.jpg">
      <div class="try"><a href="">Honoring the Military, Veterans and Their Families</a> <br>
      We have committed $45MM to military and veteran programs and initiatives, as of 11/14.
       <br><br><a href="">Learn More</a></div>
      
    </div>
  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i4.jpg">
      <div class="try"><a href="">Helping Fight Ebola</a><br>
      There is an immediate global need to help prevent Ebola from spreading further. We're committing up to $600K to this effort to provide resources and support to West Africa.<br><a href="">Learn More</a></div>
    </div>
  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i5.jpg">
      <div class="try"><a href="">Skills-based Volunteers Deployed to Detroit</a><br>
      One dozen top-performing employees from around the world will work for three weeks with non-profit partners.<br>
      <br><a href="">Learn More</a></div>
    </div>
  </aside>
  <aside class="col-md-4 body02 body03">
    <div class="inner">
      <img class="iimg" src="img/i6.jpg">
      <div class="try"><a href="">Collaboration for Conservation</a> <br>
      With The Nature Conservancy, we launched NatureVest, to create a mainstream market for investment in conservation.<br><br>
      <a href="">Learn More</a></div>
    </div>
  </aside>

  </section>
  <section id="last11"class="col-md-3">IN THE NEWS<br><br>
  <a href="">Houtson Skills Gap Report Released</a><br><br><a href="">NYC Skills Gap Report Released</a><br><br><a href="">Helping Fight Ebola</a><br><br><a href="">Chase Joins HBO and Starbucks to Salute U.S Veterans and Their Families</a>
  <br><br><br><br>CORPORATE RESPONSIBILITY<br><br>
  <a href="">Detroit Service Corps to Strengthen the City's Nonprofit Community</a><br><br><a href="">New research from the Global Cities Initiative finds foreign students are a growing force in U.S. economy</a><br><br><a href="">Small Business, Big Investment: $30 Million to Help Entrepreneur Networks</a><br><br><a href="">Update on $100 million Detroit commitment</a>
  <br><br><br><br>











  </section>

</section>




<div id="dvd"></div>


	
<footer class="row">
  <section class="col-md-6 col-md-offset-3 row">
    <aside class="col-md-3 asd"><b>Explore</b>
        <br><a href="">About us</a>
         <br><a href="">Investor Relations</a>
          <br><a href="">Corporate Responsiblility</a>
           <br><a href="">Careers</a>
           <br><a href="">Site Map</a>
           <p id="joke" style="display:none;">${username}</p>
    </aside>
     <aside class="col-md-3 asd"><b>Related Sites</b>
        <br><a href="">Chase</a>
         <br><a href="">En Español</a>
          <br><a href="">Chase Canada</a>
           <br><a href="">J.P. Morgan</a>
           <br><a href="">Chase Careers</a>
           <br><a href="">J.P. Morgan Careers</a>

    </aside>
    <aside class="col-md-3 asd">Terms & Privacy
        <br><a href="">Privacy & Security</a>
         <br><a href="">Terms & Conditions</a>
          <br><a href="">USA Patriot Act Certification</a>
           <br><a href="">Cookie Policy</a>

    </aside>

    <aside class="col-md-3 asd">Connect With Us
        <br><a href="">Contact Us</a>
         <br><a href="">Facebook icon Chase Facebook</a>
          <br><a href="">Follow Us@Chase</a>
           <br><a href="">Follow Us@JPMorgan</a>
           <br><a href="">JPMorgan Chase LinkedIn</a>
           <br><a href="">Chase LinkedIn</a>
           <br><a href="">J.P. Morgan LinkedIn</a>
           <br><a href="">Chase YouTube Channel</a>
          <br><a href="">J.P. Morgan YouTube Channel</a>

    </aside>
  </section>
  <section id="logo02" class="col-md-6 col-md-offset-3 row">
   <aside class="col-md-4 col-md-offset-8">
     <img src="img/ftr.png">
     <br>
     <div class="row"></div>
     <p id="last" class="col-md-12 col-md-offset-7">&copy; 2014 JPMorgan Chase & Co.</p>
   </aside>
  </section>




</footer>
	

	<script src="js/jquery-1.11.1.min.js"></script>
	<!-- <script src="<c:url value="http://code.jquery.com/jquery.js" />"></script> -->
		<script src="<c:url value="js/bootstrap.min.js" />"></script>

</body>
</html>



