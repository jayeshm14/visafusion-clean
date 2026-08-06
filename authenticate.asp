<% response.buffer=true%>
<!-- #include file="connection.asp" -->
<%
if len(connectionStatus) > 0 then
%>
<div style="color:red;font-weight:bold;"><%=connectionStatus%></div>
<%
   
end if
%>
<html>
<head> 
<title>log in</title>
<body>
<%
'if date=>"11/10/01" then
'response.redirect "relogin.asp?rsn=B"
'end if
response.write "privilege: " 
username1=request("username")
password1=request("pass")
username1=Replace(username1, "'", "�")
password1=Replace(password1, "'", "�")

set rs=server.createobject("adodb.recordset")
stmt="select * from udaan_users where username='"&lcase(username1)&"'and password='"&password1&"'"
rs.open stmt,con,2,3

if rs.eof then

set rsg=server.createobject("adodb.recordset")
stmtg="select * from registration where uid='"&username1&"'and pwd='"&password1&"'"
rsg.open stmtg,con,2,3

if rsg.eof then
response.redirect "relogin.asp?rsn=B"
else
session("name")=ucase(rsg.fields("name"))
session("uname")=username1
session("priv")="guest"
response.redirect "default.asp?un=" & rsg.fields("name") & "&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn=253&ses=k3456l7dj9javyemsn&company=udaan"
end if

else
session("lname")=ucase(rs.fields("firstname"))&" "&ucase(rs.fields("lastname"))
session("uname")=username1
IF ucase(session("uname"))="UDAAN-DEL" THEN
response.redirect "chat/Default.asp?uname="&ucase(username1)
END IF


if rs.fields("privilege")="adm" then
session("priv")="adm"
session("extn")=rs.fields("phoneno")
response.redirect "Administrator.asp?uname="&username1

elseif rs.fields("privilege")="su" then
session("priv")="adm"
session("su")="Y"
session("extn")=rs.fields("phoneno")
response.redirect "Administrator.asp?uname="&username1
elseif rs.fields("privilege")="emp" then
'checking for the opening time

today=date()

set rsAdm=server.createobject("adodb.recordset")
stmt1="select * from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)&"and closingtime is null"
rsAdm.open stmt1,con,2,3
If rsAdm.eof then
response.redirect "relogin.asp?rsn=O"
elseif rsAdm("closingtime")<>"" then
response.redirect "relogin.asp?rsn=C"
Else
session("priv")="emp"
session("extn")=rs.fields("phoneno")
response.redirect "Employee.asp?uname="&username1
End If
rsAdm.close


elseif rs.fields("privilege")="agt" then
session("priv")="agt"
agentid=getIDForDescription("Agents",username1)
response.redirect "Agent.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn="&agentid&"&ses=k3456l7dj9javyemsn&company=udaan"
end if
end if
rs.close
%>
</body></html>