<%
response.buffer=true
val1=request("submit")
if val1="Edit" then
response.redirect "neweditAgent.asp?agent="&request("agent")
elseif val1="Add" then
response.redirect "newnewAgent.asp"
elseif val1="Delete" then
response.redirect "newagentdelete.asp?agent="&request("agent")
elseif val1="View" then
response.redirect "newviewagent.asp?agent="&request("agent")
End if
%>