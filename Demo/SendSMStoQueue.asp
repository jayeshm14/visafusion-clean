<%
refno=request("refno")
pname=request("pname")
agent=request("agentID")
countryID=request("country")
updatedby=request("updatedby")
SMSstatus=request("SMSstatus")
if SMSstatus>400 and SMSstatus <500 then
message= getDescriptionForID("Status",SMSstatus) &" Status for Refno- "&refno&" PAX- "&pname&" Country- "&getDescriptionForID("Embassy",countryID)
message=message&". For details logon to www.udaanindia.com."
end if

set rs=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
stmt="select smsno from agents where (smsno is not null and ltrim(rtrim(smsno)) <>'') and agentsID="&agent

 rs.open stmt,con,2,3
 if not rs.eof then
 cellno=rs("smsno")
 stmt2="select * from smsqueue where 1=2"
  rs2.open stmt2,con,2,3
  
if rs2.eof then
rs2.addnew
rs2.fields("cellno")=cellno
rs2.fields("refno")=refno
rs2.fields("agentID")=agent
rs2.fields("paxname")=pname
rs2.fields("Message")=message
rs2.fields("sentby")=updatedby
rs2.fields("sentdate")=now()
rs2.update
rs2.Close
Response.Write("SMS Sent at "& cellno)
end if

 else
 Response.Write("SMS Number not available for SMS Update.")
 end if
 rs.Close
%>

