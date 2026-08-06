<%
response.buffer=true
val1=trim(request("submit"))
response.write (val1)
if val1="Edit" then
response.redirect "EditUser.asp?username="&request("username")
elseif val1="Add" then
response.redirect "NewUser.asp"
elseif val1="Delete" then
response.redirect "DeleteUser.asp?username="&request("username")
End if

%>