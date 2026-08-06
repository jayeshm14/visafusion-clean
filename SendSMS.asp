<!-- #include file="connection.asp" -->
<html>
<head>
<title>Sending SMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="REFRESH" CONTENT=60>
</head>
<table>


	<%
 set rs=server.createobject("adodb.recordset")
 set rs2=server.createobject("adodb.recordset")
 set rs3=server.createobject("adodb.recordset")
 stmt="select * from smsQueue where message is not null and (cellno is not null and ltrim(rtrim(cellno)) <>'')"
 
 response.Write "<BR>Last Updated at: "&now()
 
 
 rs.open stmt,con,2,3
if not rs.EOF then

while not rs.eof 
refno=rs.fields("refno")
cellno=rs.fields("cellno")
pname=rs.fields("paxname")
agent=rs.fields("agentID")
message=rs.fields("Message")
sentby=rs.fields("sentby")
if refno=0 then 
DisplayNameGSM=BulkSMSDisplayName
else
DisplayNameGSM=SMSDisplayName
end if
DisplayNameCDMA = 919818720698

Response.Write("<BR>Connecting... ")
'SMSUrl="http://sms.spectranet.com/sms3/cgi-bin/bulksms.cgi?username=udaanind&pwd=india123&to="&cellno&"&msg="&message&"&sendas="&DisplayName
SMSUrl="http://api.messaging4u.com/india/SendingSMS.aspx?username=udaanindia&pwd=rajan1604&to="&cellno&"&msg="&message&"&gsmsenderid="&DisplayNameGSM&"&cdmasenderid="&DisplayNameCDMA

  Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
 oHTTP.Open "GET",SMSUrl , false
 oHTTP.Send
 responsestr=oHTTP.ResponseText
 Response.Write("SMS Sent at "&cellno &" SMS Status: "&responsestr)
 'response.write ("<br>" &SMSUrl)

'  stmt2="select * from smshistory where 1=2"
 
  
' rs2.open stmt2,con,2,3
'if rs2.eof then
' rs2.addnew

'rs2.fields("cellno")=cellno
'rs2.fields("refno")=refno
'rs2.fields("paxname")=pname
'rs2.fields("agentID")=agent
'rs2.fields("Status")=responsestr
'rs2.fields("Message")=message
'rs2.fields("sentby")=sentby
'rs2.fields("sentdate")=now()

'rs2.update
'rs2.Close
stmt3="delete from smsQueue  where agentID="&agent &" and refno="&refno
con.execute stmt3
'end if
rs.MoveNext
wend
Response.Write("<BR><BR><B>SMS Update completed</B>")
rs.Close
else
Response.Write("<BR><B>No more SMS available for Sending SMS Update.</B>")
End if
 
%>
</HTML>
