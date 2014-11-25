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
			<td>Loan Term: </td>
			<td><input type="text" name="loadTerm"/></td>
		</tr>
		<tr>
			<td>Zip Code: </td>
			<td><input type="text" name="zipCode"/></td>
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