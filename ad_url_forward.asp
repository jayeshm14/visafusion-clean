<!-- #include file="connection.asp" -->
<%
'response.buffer=true

set rs=server.createobject("adodb.recordset")
stmt="select * from adcount where Hitdate = '"& FormatDateTime(now(),2)&"' and AddLocation = '"& request("Location")&"'"
rs.open stmt,con,2,3
response.write stmt
if TRIM(request("Location"))= "" then
	response.write "You have not given any location."

ELSE
	if rs.EOF then
		rs.addnew
		rs("AddLocation") = cint(request("Location"))
		rs("Hitdate")= FormatDateTime(now(),2)
		rs("adcount")= 1
		rs.update
	else
		rs("AddLocation") = cint(request("Location"))
		rs("adcount")= cint(rs("adcount")) + 1
		rs.update
	end if
end if
rs.close

if request("Location") = "1" then
  myurl= "http://www.tripzindia.com"
elseif request("Location") = "2" then
  myurl= ""
elseif request("Location") = "3" then
  myurl= ""
elseif request("Location") = "4" then
  myurl= "http://www.traveljobsindia.com"
elseif request("Location") = "5" then
  myurl= ""
elseif request("Location") = "6" then
  myurl= ""
elseif request("Location") = "7" then
  myurl= ""
elseif request("Location") = "7" then
  myurl= ""
elseif request("Location") = "8" then
  myurl= ""
elseif request("Location") = "9" then
  myurl= ""
elseif request("Location") = "10" then
  myurl= ""
elseif request("Location") = "11" then
  myurl= ""
elseif request("Location") = "12" then
  myurl= ""
elseif request("Location") = "13" then
  myurl= ""
elseif request("Location") = "14" then
  myurl= ""
elseif request("Location") = "15" then
  myurl= ""
end if
if myurl="" then
	myurl= "http://www.udaanindia.com"
end if
  response.redirect(myurl)
%>
