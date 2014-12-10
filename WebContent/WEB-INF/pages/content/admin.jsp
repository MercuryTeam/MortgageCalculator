<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  
  <link rel="stylesheet" href="<c:url value="css/bootstrap.css" />" media="screen"/>
  <link rel="stylesheet" href="<c:url value="css/calculator.css" />"/>
  
  <link rel="stylesheet" type="text/css" href="css\jquery-ui.min.css">
  <!--  
  <script src="js\angular.min.js"></script>
  -->
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
  <script src="js\jquery-1.11.1.min.js"></script>
  <script>
angular.module("mainModule", [])
	.controller("mainController", function($scope, $http) {
		$http.get('http://localhost:8080/MortgageCalculator/rest/admin').success(function(data) {
			$scope.rows = data.rate;
			});
		
		$scope.search = "";
		
		$scope.searchState = function(row) {
			if ($scope.search == "") return true;
			var searchArr = $scope.search.toLowerCase().split('');
			var stateArr = row.state.toLowerCase().split('');
			
			if (searchArr.length > stateArr.length) return false;			
			for (var i = 0; i < searchArr.length; i++) {
				if (searchArr[i] != stateArr[i]) return false;
			}
			
			return true;			
		};
		
		$scope.onClick = function(row) {
			//alert(row.state);
			
			var params = $.param({
		  		id: row.id,
				state: row.state,
		  		abbr: row.abbr,
				rate15: row.rate15,
				rate20: row.rate20,
				rate30: row.rate30,
				arm5: row.arm5,
				arm7: row.arm7,
		       	arm10: row.arm10
			});
            
			$http({
		   		method: "POST",
		     	url: "http://localhost:8080/MortgageCalculator/rest/admin/update",
		      	data: params,
		      	headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		   	}).success(function (data, status, headers, config) {
		         alert(data);
			});
			
		};
  		
	});
</script>
<style type="text/css">
.wchange{
	width:50px;
}
</style>
<title>JP Morgan Chase Bank Mortgage Center</title>
</head>
<body ng-app="mainModule" ng-controller="mainController">
	
  <section id="title" class="row">
    <p class="col-md-3"></p>
    <img id="logo01" class="col-md-3" src="img/2.png"/>
    <p class="col-md-1 col-md-offset-2"><form class="navbar-form" role="search">
      <div class="form-group">
        <input type="text" class="form-control" placeholder="Search" ng-model="search">
      </div>
      <button type="submit" class="btn btn-default">GO</button>
    </form>
  </section>

  <section class="row">

    <ul id="nav01" class="nav row col-md-8 col-md-offset-3">
      

      
      <li class="col-md-1"><a href="calculator.html">Home</a></li>
      <li class="col-md-1"><a href="#">Aboutus</a></li>
      <li class="col-md-2"><a href="#">Investor Relations</a></li>
     
      <li class="dropdown col-md-2">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">More Information <b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="#">How to write a review</a></li>
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
      <li class="dropdown col-md-2 col-md-offset-1">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Welcome, ${username}<b class="caret"></b></a>
        <ul class="dropdown-menu">
          <li><a href="#">Change profile info</a></li>
          <li><a href="#">Change my password</a></li>
          <li><a href="#">customer service</a></li>
          <li class="divider"></li>
          <li><a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</li>
          <li><a href="#">submit a ticket</a></li>
        </ul>
      </li>
    </ul>
  </section>





<section class="body01 row col-md-8 col-md-offset-2">
  <section class="row col-md-12" id="last02">
 
            
    
<section >

	<div  class="CSSTableGenerator2" >
		
		
		<table width="1000px">
                    <th>
                      <td class="wchange">
                        Id
                      </td>
                      <td class="wchange">
                        State
                      </td >
                      <td class="wchange">
                        15-year fixed
                      </td>
                      <td class="wchange">
                        20-year fixed
                      </td>
                      <td class="wchange">
                        30-year fixed
                      </td>
                      <td class="wchange">
                        5/1 ARM
                      </td>
                      <td class="wchange">
                        7/1 ARM
                      </td>
                      <td class="wchange">
                        5/1 ARM
                      </td>
                      <td class="wchange">
                        Edit
                      </td>
                      
                    </th>
                    <tr ng-repeat="row in rows | filter: searchState">
                      <td class="wchange">{{row.id}}</td>
                      <td class="wchange"><input type="text" ng-model="row.state" /></td>
                      <td class="wchange"><input type="text" ng-model="row.rate15" /></td>
                      <td class="wchange"><input type="text" ng-model="row.rate20" /></td>
                      <td class="wchange"><input type="text" ng-model="row.rate30" /></td>
                      <td class="wchange"><input type="text" ng-model="row.arm5" /></td>
                      <td class="wchange"><input type="text" ng-model="row.arm7" /></td>
                      <td class="wchange"><input type="text" ng-model="row.arm10" /></td>
                      <td class="wchange"><button type="button" ng-click="onClick(row)">Update</button></td>
                    </tr>
                  </table>
	</div>
</section>



  

</section>


</section>




<div id="dvd"></div>


<!--  
<footer class="row">
<section class="col-md-6 col-md-offset-3 row">
  <aside class="col-md-3 asd"><b>Explore</b>
      <br><a href="">About us</a>
       <br><a href="">Investor Relations</a>
        <br><a href="">Corporate Responsiblility</a>
         <br><a href="">Careers</a>
         <br><a href="">Site Map</a>
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

-->

<script src="<c:url value="js/bootstrap.min.js" />"></script>










</body>
</html>
