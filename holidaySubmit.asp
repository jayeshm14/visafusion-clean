<%
response.buffer=true
val1=trim(request("submit"))
response.write (val1)
if val1="View" then
response.redirect "holidayList.asp"
elseif val1="Add" then
response.redirect "holiday_entry.asp"
elseif val1="delete" then
response.redirect "holidaydelete.asp"
End if

%>