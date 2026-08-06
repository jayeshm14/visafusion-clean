<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td align="center">
                 
            
<%
emailSubject=request("subject")
emailBody=request("message")

days=Request("days")

set rsAgentEmail=server.createobject("adodb.recordset")
doemail="no"
rsAgentEmail.open "select * from Agents ",con
if not rsAgentEmail.EOF then
Response.write "<B>EMAIL SENT TO  FOLLOWING ADDRESSES:<br>"
while not rsAgentEmail.EOF
agentEmail=rsAgentEmail("emailid")
if agentEmail<>"" then
Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
objNewEmail.from= udaanEmail
objNewEmail.to= Cstr(agentEmail)
objNewEmail.subject=emailSubject
objNewEmail.body= emailBody
'objNewEmail.send
Set objNewEmail = Nothing
response.write agentEmail&"<br>"
End if
rsAgentEmail.movenext

Wend
end if
rsAgentEmail.close()

 %>

        
               
                 </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
