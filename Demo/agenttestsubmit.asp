<%
response.buffer=true
val1=request("submit")
response.write (val1)
if val1="Edit" then
response.redirect "editAgent.asp?agent="&request("agent")
elseif val1="Add" then
response.redirect "newAgent.asp"
elseif val1="View Status" then
response.redirect "getAgentstatus.asp?agent="&request("agent")
elseif val1="E-mail Status" then
response.redirect "todayAgentStatus.asp?agent="&request("agent")
elseif val1="Statement" then
response.redirect "agentStatement.asp?agent="&request("agent")
elseif val1="Receipt" then
response.redirect "paymentReceive.asp?agent="&request("agent")
elseif val1="View" then
response.redirect "viewagent.asp?agent="&request("agent")
elseif val1="Send AWB" then
response.redirect "sendawb.asp?agent="&request("agent")
End if

%>