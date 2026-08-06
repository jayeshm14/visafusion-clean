<!-- #include file="connection.asp" -->
<%
categoryid=getIDForDescription("category","Attestation")
attflag="Y"
set rsAgentEmail1=server.createObject("ADODB.recordset")
set rsHotel=server.createObject("ADODB.recordset")
set rsCab=server.createObject("ADODB.recordset")
AgentStmt="select agent,category from mainentry where refno="&request("refno")
rsAgentEmail1.open AgentStmt,con
if not rsAgentEmail1.EOF then
agent=rsAgentEmail1("agent")
category=rsAgentEmail1("category")
end if
rsAgentEmail1.close()
EmailBody=EmailBody &"<table width=""85%"" border=""0"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td align=""center""><b><font  size=5 face=""arial"">"&UdaanName&"</font></b></td></tr>"
EmailBody=EmailBody &"<tr><td  align=""center""><font face='arial' size=2 color='#000000'>"&UdaanAddress&"</font></TD></TR>"
EmailBody=EmailBody &"<tr><td align=""center""><font face='arial' size=2 color='#000000'>"&UdaanContact&"</font></td></tr></table>"
set rsAgentEmail=server.createObject("ADODB.recordset")
rsAgentEmail.open "select * from Agents where agentsid="&agent,con
if not rsAgentEmail.EOF then
if rsAgentEmail("emailid")<>"" then
agentEmail=rsAgentEmail("emailid")
doemail="yes"
End if
end if
rsAgentEmail.close()
response.write agentEmail
%>