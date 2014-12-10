<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  
  <link rel="stylesheet" href="<c:url value="css/bootstrap.css" />" media="screen"/>
  <link rel="stylesheet" href="<c:url value="css/calculator.css" />"/>
  
  <link rel="stylesheet" type="text/css" href="css\jquery-ui.min.css">
   
  <script src="js\angular.min.js"></script>
  
  
  <script src="js\jquery-1.11.1.min.js"></script>
  <script>
  $(document).ready(function(){
	  $('#change11').click(function(){
		  
		  if($(this).val()=='Charters'){
			  $(this).val('Data');
		  }else{
			  $(this).val('Charters');
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
	  
  });
  
  
  
  </script>
  <script>
    
    
    
    
    var app = angular.module("app", []);
    app.controller("mainController", function ($scope, $http) {
      $scope.schedule = {
        principal: 300000,
        zipCode:"",
        city:"",
        state:"",
        loadTerm:"30",
        extra:0,
        extraDuration:0 
      };
      $scope.schedules = [];
      
      $scope.canShow = false;
      
      $scope.years = ["First Year", "Second Year", "Third Year", "Fourth Year", "Fifth Year", "6th Year", "7th Year",
                      "8th Year", "9th Year", "10th Year", "11th Year", "12th Year", "13th Year", "14th Year", "15th Year",
                      "16th Year", "17th Year", "18th Year", "19th Year", "20th Year", "21th Year", "22th Year", "23th Year",
                      "24th Year", "25th Year", "26th Year", "27th Year", "28th Year", "29th Year", "30th Year"];
      
      var oriSchedule = angular.copy($scope.schedule);
	  var at = {
			    at_6: function() { },
			    at_7: function() { },
			    at_8: function() { },
			    at_9: function() { },
			    at_10: function() { },
			    at_11: function() { },
			    at_12: function() { },
			    at_13: function() { },
			    at_14: function() { },
			    at_15: function() { },
			    at_16: function() { },
			    at_17: function() { },
			    at_18: function() { },
			    at_19: function() { },
			    at_20: function() { },
			    at_21: function() { },
			    at_22: function() { },
			    at_23: function() { },
			    at_24: function() { },
			    at_25: function() { },
			    at_26: function() { },
			    at_27: function() { },
			    at_28: function() { },
			    at_29: function() { },
			    at_30: function() { }
			    
			};	
      $scope.resetForm = function () {
        $scope.schedule = angular.copy(oriSchedule);
        $scope.scheduleForm.$setPristine();
        $scope.canShow = false;
      };

      $scope.isScheduleChanged = function () {
        return !angular.equals($scope.schedule, oriSchedule);
      };
      
      $scope.onChange = function(schedule) {
      	if (schedule.zipCode.length == 5) {
      		var url = "http://ziptasticapi.com/" + schedule.zipCode;
      		$http.get(url)
      	    .success(function(data){    
      	    	schedule.city = data.city;
      	    	schedule.state = data.state;
      	    	$scope.submitData($scope.schedule, 'ajaxResult');
      	    });
      		
      	} else {
      		schedule.city = "";
  	    	schedule.state = "";
      	}
      };
      
      
      $('#slider').slider({
          min:200000,
          max:2000000,
          value:300000,
          orientation: "horizontal",
          step:1000,
          slide: function(event, ui) {
              var el = $('input[name=slider]');
              var scope = angular.element(el[0]).scope();
              scope.$apply(function() {
                  scope.schedule.principal = ui.value;
              });
             
              
          
          },
          stop:function(){
        	  $scope.submitData($scope.schedule, 'ajaxResult');
        	  
          }
      });
      
      $('#slider1').slider({
          min:0,
          max:5000,
          value:0,
          orientation: "horizontal",
          step:10,
          slide: function(event, ui) {
              var el = $('input[name=extra]');
              var scope = angular.element(el[0]).scope();
              scope.$apply(function() {
                  scope.schedule.extra = ui.value;
              });
            
              
          
          },
          stop:function(){
        	  $scope.submitData($scope.schedule, 'ajaxResult');
        	  
          }
      });
      
      $('#slider2').slider({
          min:0,
          max:360,
          value:0,
          orientation: "horizontal",
          step:1,
          slide: function(event, ui) {
              var el = $('input[name=extraDuration]');
              var scope = angular.element(el[0]).scope();
              scope.$apply(function() {
                  scope.schedule.extraDuration = ui.value;
              });
           
             
          
          },
          stop:function(){
        	  $scope.submitData($scope.schedule, 'ajaxResult');
        	  
          }
      });
      
      $scope.toggleButton = function(){
    	  if($scope.canShow==true){
    		  $scope.canShow=false;
    	  }else{
    		  $scope.canShow=true;
    	  }
    	  
    	  
    	  if(this.value =='Charters'){
				this.value='Data';
			}else{
				this.value='Charters';
			}
		
    	  
      };
     
      
      
      
    
      $scope.range = function(schedules) {
    	  var len = schedules.length;
    	  var year = Math.floor(len /12);
    	  var range = [];
    	  
    	  for (var i = 0; i < year; i++) {
    		  range.push(i);
    	  }
    	  if (len % 12 != 0) {
    		  range.push(year);
    	  }
    	  
    	  return range;
      };
      
      $scope.weWants = function(schedules, year) {
    	  var len = schedules.length;
    	  var start = year * 12;
    	  var end = ((year + 1) * 12 < len) ? (year + 1) * 12 : len;
    	  return schedules.slice(start, end);
      };
      
      $scope.refresh = function() {
    	  $('#group-of-three').accordion("refresh");
      };
      
      
      
      
      
      $scope.onFormChange = function ()
      {
    	  submitData(schedule, 'ajaxResult');
      };
      
      
      $scope.submitData = function (schedule, resultVarName) {
    	if (schedule.state=="") return false; 
     	var params = $.param({
          principal: schedule.principal,
          state: schedule.state,
          loadTerm: schedule.loadTerm,
          extraDuration:schedule.extraDuration,
          extra:schedule.extra
        	  
          
        });
        $http({
          method: "POST",
          url: "http://localhost:8080/MortgageCalculator/rest/calculating",
          data: params,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        }).success(function (data, status, headers, config) {
          $scope[resultVarName] = data;
          $scope.schedules = data.Schedule;
          //$scope.canShow = true;
          // Draw chart
          drawChart(data);
         
        }) .error(function (data, status, headers, config) {
          $scope[resultVarName] = "SUBMIT ERROR";
        });
      };
    }); 





</script>
<title>JP Morgan Chase Bank Mortgage Center</title>
</head>
<body>
	
  <section id="title" class="row">
    <p class="col-md-3"></p>
    <img id="logo01" class="col-md-3" src="img/2.png"/>
    <p class="col-md-1 col-md-offset-2"><form class="navbar-form" role="search">
      <div class="form-group">
        <input type="text" class="form-control" placeholder="Search">
      </div>
      <button type="submit" class="btn btn-default">GO</button>
    </form>
  </section>

  <section class="row">

    <ul id="nav01" class="navbar row col-md-8 col-md-offset-3" style="list-style-type: none;">
      

      
      <li class="col-md-1"><a href="calculator.html">HOME</a></li>
      <li class="col-md-1"><a href="#">ABOUTUS</a></li>
      <li class="col-md-2"><a href="#">INVESTOR RELATIONS</a></li>
     
      <li class="dropdown col-md-2">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">MORE INFORMATION<b class="caret"></b></a>
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
          <li><a id="role01" href="#">${role}</a></li>
          <li><a href="#">customer service</a></li>
          <li class="divider"></li>
          <li><a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</li>
          <li><a href="#">submit a ticket</a></li>
        </ul>
      </li>
    </ul>
  </section>





<section class="body01 row col-md-8 col-md-offset-3">
  <section class="row col-md-9" id="last02">
    
    <div ng-app="app">
      <div ng-controller="mainController">
        
        <form name="scheduleForm" ng-submit="submitData(schedule, 'ajaxResult')" novalidate>
          <div class = "row">
          <div class="col-md-12">
          <label for="slider">Principal</label>
          <div id="tslider" class="alert alert-success">Choose from $ 200000 to $ 2000000. Current principal: <b>$ {{schedule.principal}}</b></div>
          <br>
           <div id="slider"></div>
           
			<input style="display:none;" type="text" name="slider" ng-change="onFormChange()" ng-model="schedule.principal" />
			<br>
		  </div>
		  
          <!-- <div class="col-md-1"><label for="principal">Principal</label></div>
          <div class="col-md-3">
           
          <input class="form-control" id="inputSuccess1" type="text" name="principal" id="principal" ng-model="schedule.principal" required/>
          
          </div> -->
          
          
          <div class="col-md-1"> <label for="zipCode">ZipCode</label></div>
          <div class="col-md-3">
         
          <input class="form-control" id="inputSuccess1" type="text" name="zipCode" id="zipCode" ng-change="onChange(schedule)" ng-model="schedule.zipCode" required/><br>
          </div>
          
          
          
          <div class="col-md-1"> <label for="city">City:</label></div>
          <div class="col-md-3">
         
          <b>{{schedule.city}}</b><br>
          </div>
          
          
          
          
          <div class="col-md-1"><label for="state">State:</label></div>
          <div class="col-md-3">
          <b>{{schedule.state}}</b><br>
          <select style="display:none;" id="state" class="auto" ng-change="onFormChange()" ng-model="schedule.state" >
									<option value="" selected="selected"></option>
									<option value="AL">AL</option>
									<option value="AK">AK</option>
									<option value="AZ">AZ</option>
									<option value="AR">AR</option>
									<option value="CA">CA</option>
									<option value="CO">CO</option>
									<option value="CT">CT</option>
									<option value="DE">DE</option>
									<option value="DC">DC</option>
									<option value="FL">FL</option>
									<option value="GA">GA</option>
									<option value="HI">HI</option>
									<option value="ID">ID</option>
									<option value="IL">IL</option>
									<option value="IN">IN</option>
									<option value="IA">IA</option>
									<option value="KS">KS</option>
									<option value="KY">KY</option>
									<option value="LA">LA</option>
									<option value="ME">ME</option>
									<option value="MD">MD</option>
									<option value="MA">MA</option>
									<option value="MI">MI</option>
									<option value="MN">MN</option>
									<option value="MS">MS</option>
									<option value="MO">MO</option>
									<option value="MT">MT</option>
									<option value="NE">NE</option>
									<option value="NV">NV</option>
									<option value="NH">NH</option>
									<option value="NJ">NJ</option>
									<option value="NM">NM</option>
									<option value="NY">NY</option>
									<option value="NC">NC</option>
									<option value="ND">ND</option>
									<option value="OH">OH</option>
									<option value="OK">OK</option>
									<option value="OR">OR</option>
									<option value="PA">PA</option>
									<option value="RI">RI</option>
									<option value="SC">SC</option>
									<option value="SD">SD</option>
									<option value="TN">TN</option>
									<option value="TX">TX</option>
									<option value="UT">UT</option>
									<option value="VT">VT</option>
									<option value="VA">VA</option>
									<option value="WA">WA</option>
									<option value="WV">WV</option>
									<option value="WI">WI</option>
									<option value="WY">WY</option>
								</select>
          </div>
         
          
          
          
          
          </div>
          <label for="loadTerm">Loan Term</label>
          <div class = "row">
          	<div class="col-md-3"><input id="loanterm_30" type="radio" name="loadTerm"  value="30" ng-change="submitData(schedule, 'ajaxResult')" ng-model="schedule.loadTerm"/>
          <label for="loanterm_30">30 years fixed</label></div>
          	<div class="col-md-3 col-md-offset-1"><input id="loanterm_20" type="radio" name="loadTerm" value="20" ng-change="submitData(schedule, 'ajaxResult')" ng-model="schedule.loadTerm"/>
          <label for="loanterm_20">20 years fixed</label>
          </div>
          	<div class="col-md-3 col-md-offset-1"><input id="loanterm_15" type="radio" name="loadTerm" value="15" ng-change="submitData(schedule, 'ajaxResult')"  ng-model="schedule.loadTerm"/>
          <label for="loanterm_15">15 years fixed</label>
          </div>
          
          	<div class="col-md-3"><input id="loanterm_5_year_arm" type="radio" name="loadTerm"  value="5" ng-change="submitData(schedule, 'ajaxResult')"  ng-model="schedule.loadTerm"/>
          <label for="loanterm_5_year_arm">5-year ARM</label>
          </div>
          	<div class="col-md-3 col-md-offset-1"><input id="loanterm_7_year_arm" type="radio" name="loadTerm" ng-change="submitData(schedule, 'ajaxResult')"   value="7" ng-model="schedule.loadTerm"/>
          <label for="loanterm_7_year_arm">7-year ARM</label>
          
          </div>
          <div class="col-md-3 col-md-offset-1">
          	<input id="loanterm_10_year_arm" type="radio" name="loadTerm"  value="10" ng-change="submitData(schedule, 'ajaxResult')"  ng-model="schedule.loadTerm"/>
          <label for="loanterm_10_year_arm">10-year ARM</label>
          </div>
          
          </div>
             
             
             
             <div class="col-md-6">
          <label for="extra">Extra</label>
          <div id="tslider1" class="alert alert-success">Choose from $ 0 to $ 5000. Current extra: <b>$ {{schedule.extra}}</b></div>
          <br>
           <div id="slider1"></div>
           
			<input style="display:none;" type="text" name="extra" ng-change="submitData(schedule, 'ajaxResult')" ng-model="schedule.extra" />
			<br>
		  </div>
             
             <div class="col-md-6">
          <label for="extraDuration">Extra</label>
          <div id="tslider1" class="alert alert-success">Choose from 0 to 360. Current extra: <b>{{schedule.extraDuration}}</b></div>
          <br>
           <div id="slider2"></div>
           
			<input style="display:none;" type="text" name="extraDuration" ng-change="submitData(schedule, 'ajaxResult')" ng-model="schedule.extraDuration" />
			<br>
		  </div>
             
             
          
          
          
         
          
          
          <br>
          <button class="btn btn-primary" type="button" ng-click="resetForm()" ng-disabled="!isScheduleChanged()">Reset</button>
          <!-- <button class="btn btn-success" type="submit" ng-disabled="scheduleForm.$invalid">Submit</button> -->
          
          <input class="btn btn-success"  ng-click="toggleButton()" type="button" id="change11" value="Charters"/>
          

        </form>
        <br />
        <div ng-show="canShow" id="alterred01">
  

        <div id="ui-examples">
          <div class="example accordion">
            <div id="group-of-three">
              <h1 ng-repeat-start="i in range(schedules)" >{{years[i]}}</h1>
              <div class="king" ng-repeat-end ng-init="refresh()">
                <div class="CSSTableGenerator">
                  <table >
                    <tr>
                      <td>
                        Month
                      </td>
                      <td >
                        Interest
                      </td>
                      <td>
                        PayPrincipal
                      </td>
                      <td>
                        Payment
                      </td>
                      <td>
                        RemainPrincipal
                      </td>
                    </tr>
                    <tr ng-repeat="weWant in weWants(schedules, i)">
                      <td>{{weWant.month| number}}</td>
                      <td>{{weWant.interest| number}}</td>
                      <td>{{weWant.payPrincipal | number}}</td>
                      <td>{{weWant.payment | number}}</td>
                      <td>{{weWant.remainPrincipal | number}}</td>
                      
                      
                    </tr>
                  </table>
                </div>
                
              </div>     
              
            </div>
			
            <!-- slice display -->

          </div>
        </div>
      </div>
      <section class="row">
      
       <section class="col-md-6">
      		<div id="ccc01"></div>
	
	
      
      </section>
      <section class="col-md-6">
      
	
			<div id="ccc03"></div>
      
      </section>
      <section>
      <div id="ccc02"></div>
     
      </section>
      
      
      
      </section>
     
      
      
      
      
      
      
    </div>
  </div>



  

</section>
<section id="last11"class="col-md-3">IN THE NEWS<br><br>
  <a href="">Houtson Skills Gap Report Released</a><br><br><a href="">NYC Skills Gap Report Released</a><br><br><a href="">Helping Fight Ebola</a><br><br><a href="">Chase Joins HBO and Starbucks to Salute U.S Veterans and Their Families</a>
  <br><br><br><br>CORPORATE RESPONSIBILITY<br><br>
  <a href="">Detroit Service Corps to Strengthen the City's Nonprofit Community</a><br><br><a href="">New research from the Global Cities Initiative finds foreign students are a growing force in U.S. economy</a><br><br><a href="">Small Business, Big Investment: $30 Million to Help Entrepreneur Networks</a><br><br><a href="">Update on $100 million Detroit commitment</a>
  <br><br><br><br>











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


<script src = "js\jquery-1.11.1.min.js"></script>
<script>window.jQuery || document.write('<script src="../../jquery/jquery.min.js"><\/script>');</script>
<script src = "js\jquery-ui.min.js"></script>

 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
google.load('visualization', '1.0', {'packages':['corechart']});
google.load("visualization", "1.0", {'packages':["gauge"]});
</script>
<script type="text/javascript">  
	  var pieOptions = {
			title:'Interest VS Principal',
        	width:400,
        	height:300,
	  };
	  
	  var lineOptions = {
			  title:'Amortlization',
              width: 1000,
              height: 563,
              hAxis: {
                title: 'Month'
              },
              vAxis: {
                title: 'Dollars'
              },
              animation:{
                  duration: 2000,
                  easing: 'linear'
              }
      };

      var gaugeOptions = {
       		width: 400, height: 120,
        	redFrom: 90, redTo: 100,
         	yellowFrom:75, yellowTo: 90,
         	minorTicks: 5,
         	animation:{
                duration: 2000,
                easing: 'linear'
              }
        };
      
      var chart = new google.visualization.PieChart(document.getElementById('ccc01'));
      var lineChart = new google.visualization.LineChart(document.getElementById('ccc02'));
      var gaugeChart = new google.visualization.Gauge(document.getElementById('ccc03'));
      
      function drawChart(s) {
        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Type');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Principal', Number(s.Principal)],
          ['Interest', Number(s.TotalInterest)]
        ]);

        // draw our chart, passing in some options.        
        chart.draw(data, pieOptions);
        
        // Create line chart
        var lineData = new google.visualization.DataTable();
        lineData.addColumn('number', 'X');
        lineData.addColumn('number', 'PayPrincipal');
        lineData.addColumn('number', 'RemainPrincipal');
        lineData.addColumn('number', 'Interest');
        var rows = [];
        var schedule = s.Schedule;
        var payPrincipal = 0;
        var interest = 0;
        rows.push([0, 0, Number(s.Principal), 0]);
        for (var i = 0; i < schedule.length; i++) {
        	payPrincipal += Number(schedule[i].payPrincipal);
        	interest += Number(schedule[i].interest);
        	rows.push([i + 1, payPrincipal, Number(schedule[i].remainPrincipal), interest]);
        }
        lineData.addRows(rows);      
                
       	lineChart.draw(lineData, lineOptions);

       	// Create Gauge
       	var savedInterest = Number(s.SavedInterest);
       	var interest = Number(s.TotalInterest);
       	var allInterest = savedInterest + interest;
       	var saved = Math.round(100 * savedInterest / allInterest);
       	var paid = Math.round(100 * interest / allInterest);
       	var gaugeData = google.visualization.arrayToDataTable([
       	    ['Label', 'Value'],
       	    ['Saved', saved],
       	 	['Paid', paid]
       	]);       	

        gaugeChart.draw(gaugeData, gaugeOptions);
      }
</script>

<script>
  $(document).ready(function(){

    
    $('#group-of-three').accordion({
      
      
      'event': 'mouseenter'
    });
    $('#acc-skip2').click(function(e){
      e.preventDefault();
      $('#group-of-three').accordion('option','active',1);
    });
    $('#acc-skip3').click(function(e){
      e.preventDefault();
      $('#group-of-three').accordion('option','active',2);
    });

  });
</script>




</body>
</html>