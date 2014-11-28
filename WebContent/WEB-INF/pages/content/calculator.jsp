<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Calculator</title>
</head>
<body>
<form action="calculating.html" method="post">
	<table>
		<tr>
			<td>Principal: </td>
			<td><input type="text" name="principal"/></td>
		</tr>		
		<tr>
			<td>Zip Code: </td>
			<td><input type="text" name="zipCode"/></td>
		</tr>
		<tr>
			<td>Loan Term: </td>
			<td>
				<input id="loanterm_30" type="radio" name="loadTerm" checked="checked" value="30"/>
				<label for="loanterm_30">30 years fixed</label>
				<input id="loanterm_20" type="radio" name="loadTerm" value="20"/>
				<label for="loanterm_20">20 years fixed</label>
				<input id="loanterm_15" type="radio" name="loadTerm" value="15"/>
				<label for="loanterm_15">15 years fixed</label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input id="loanterm_5_year_arm" type="radio" name="loadTerm"  value="5"/>
				<label for="loanterm_5_year_arm">5-year ARM</label>
				<input id="loanterm_7_year_arm" type="radio" name="loadTerm"  value="7"/>
				<label for="loanterm_7_year_arm">7-year ARM</label>
				<input id="loanterm_10_year_arm" type="radio" name="loadTerm"  value="10"/>
				<label for="loanterm_10_year_arm">10-year ARM</label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="reset" value="Clear"/>
				<input type="submit" value="Submit"/>
			</td>
		</tr>
	</table>

</form>


</body>
</html>