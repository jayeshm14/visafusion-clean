<%
response.buffer=true
val1=request("submit")
response.write (val1)
if val1="  Edit  " then
response.redirect "editembassy.asp?country="&request("country")
elseif val1="  Add  " then
response.write (val1)
response.redirect "newEmbassy.asp"


End if

%>