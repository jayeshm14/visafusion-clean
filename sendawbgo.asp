<!-- #include file="connection.asp" -->
<%
today=date() 

SendEmail=request.form("submit")
agentAddress=getAgentAddress(request("agent"))

EmailBody=EmailBody& "<table width='520' border='0' align='center' height='329'>  <tr>     <td>       <div align='center'>"&agentAddress&"</div>    </td>  </tr>  <tr>     <td height='197'>       <div align='JUSTIFY'>         <p>DEAR SIR,</p>        <p> THIS IS TO INFORM YOU THAT, WE HAVE SENT YOUR DOX ON <B>"&FormatDateTime(usrtosysdate(REQUEST("sdate")),1)&"</B>           BY :- </p>        <p align='left'><B>"&REQUEST("SREMARK")&"</B></p>"
EmailBody=EmailBody& "<p><br>          KINDLY NOTE THE AIRWAY BILL NO. IS GIVEN HERE BELOW.</p>        <p align='center'> <font size='7'><b>"&REQUEST("AWB")&"</b></font></p>        <p>REGARDS</p>        <p>UDAAN INDIA PVT. LTD. </p>        <hr>      </div>    </td>  </tr>  <tr>    <td height='2'>      <div align='center'><b><font size='2' face='Arial'>-: <u>FOR ANY QUERY PLEASE         CONTACT AT</u> :</font></b><font size='2' face='Arial'>-<br>        <b>"&udaanname&"</b><br>"
EmailBody=EmailBody& ""&udaanaddress&"</font> <font size='2' face='Arial'><br>        "&udaancontact&"</font> </div>    </td>  </tr></table>"

response.write EmailBody

set rsAgentEmail=server.createObject("ADODB.recordset")
rsAgentEmail.open "select * from Agents where agentsid="&request("agent"),con
if not rsAgentEmail.EOF then
if rsAgentEmail("emailid")<>"" then
agentEmail=rsAgentEmail("emailid")
doemail="yes"
End if
end if
rsAgentEmail.close()

if trim(request("awb"))="" then
doemail="no"
end if

emailSubject= "AWB NO OF SENT DOX. ON "&formatdateTime(cdate(request("sdate")),1)

If doemail="yes" and SendEmail="Send AWB" then
'Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
'objNewEmail.mailFormat=0
'objNewEmail.bodyFormat=0
'objNewEmail.from=udaanEmail
'objNewEmail.to= agentEmail
'objNewEmail.subject=emailSubject
'objNewEmail.body= emailBody
'objNewEmail.send
'Set objNewEmail = Nothing

DIM myMail
 SET myMail = Server.CreateObject("CDO.Message")
 Set myMailConfig = Server.CreateObject ("CDO.Configuration") 

 myMailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "relay.spectranet.com" 
 myMailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
 myMailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
 myMailConfig.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60 
 myMailConfig.Fields.Update 

 Set myMail.Configuration = myMailConfig 

 myMail.From = udaanEmail
 myMail.To = agentEmail
 myMail.Subject = emailSubject
 myMail.HTMLBody = emailBody
 myMail.Send
 SET myMail = Nothing
 Set myMailConfig = Nothing 

Response.write "<p align=center> Email has been sent to the agent at <b> "&agentEmail&"</b></p>"
End if

set rsawb=server.createObject("ADODB.recordset")
rsawb.open "select * from sentawb where agentsid="&request("agent")&" and awb='"&request("awb")&"'",con
if rsawb.EOF then
if request("awb")<>"" and SendEmail="Send AWB" then
sqlmail="insert into sentawb values('"&request("agent")&"','"&usrtosysdate(request("sdate"))&"','"&agentEmail&"','"&request("sremark")&"','"&request("awb")&"')"
con.execute(sqlmail)
end if
end if
rsawb.close()

%>
