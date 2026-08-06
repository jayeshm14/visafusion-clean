<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer=true
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td>
              <%

set rs=server.createobject("adodb.recordset")
rs.open "select* from udaan_users where username='"&request("username")&"'",con,2,3
if rs.eof then
rs.addnew
rs("username")=lcase(request("username"))
rs("password")=lcase(request("pass1"))
rs("privilege")=lcase(request("privilege"))
rs("firstname")=lcase(request("fname"))
rs("lastname")=lcase(request("lname"))
rs("emailid")=lcase(request("emailid"))
rs("address1")=lcase(request("street1"))
rs("address2")=lcase(request("street2"))
rs("city")=lcase(request("city"))
rs("state")=lcase(request("state"))
rs("country")=lcase(request("country"))
rs("phoneno")=lcase(request("phoneno"))
rs("faxno")=lcase(request("faxno"))
rs("pincode")=lcase(request("pincode"))

rs.update

if request("web")="yes" then
%>
<!-- #include file="connectionweb.asp" -->
<%

set rsweb=server.createobject("adodb.recordset")
rsweb.open "select* from udaan_users where username='"&request("username")&"'",webcon,2,3
if rsweb.eof then
rsweb.addnew
rsweb("username")=lcase(request("username"))
rsweb("password")=lcase(request("pass1"))
rsweb("privilege")=lcase(request("privilege"))
rsweb("firstname")=lcase(request("fname"))
rsweb("lastname")=lcase(request("lname"))
rsweb("emailid")=lcase(request("emailid"))
rsweb("address1")=lcase(request("street1"))
rsweb("address2")=lcase(request("street2"))
rsweb("city")=lcase(request("city"))
rsweb("state")=lcase(request("state"))
rsweb("country")=lcase(request("country"))
rsweb("phoneno")=lcase(request("phoneno"))
rsweb("faxno")=lcase(request("faxno"))
rsweb("pincode")=lcase(request("pincode"))

rsweb.update

'*********Add New CODE for ASPEMail Component ***************

set rsAgentEmail=server.createObject("ADODB.recordset")
mailstmt="select * from Agents where description='"&request("username")&"'"
response.write mailstmt
rsAgentEmail.open mailstmt,con

if not rsAgentEmail.EOF then
if rsAgentEmail("emailid")<>"" then
agentEmail=rsAgentEmail("emailid")

rsAgentEmail.close()

emailSubject= "UserID and Password from Udaanindia.com"

EmailBody = "<html><head><title>Untitled Document</title><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'></head><body bgcolor='#FFFFFF'><p><font face='Arial, Helvetica, sans-serif' size='2'>Hi,</font></p><p><font face='Arial, Helvetica, sans-serif' size='2'> "
EmailBody=EmailBody& "Welcome to www.udaanindia.com   Now you are a registered USER of our website. The registration now enables you   to make queries related to approx. 230 countries of the world - with regard   to the Visa documentation procedures as applicable for Indian nationals, for   about 23 categories of Visas. Now you can also LOG-ON (for that you will need   both USER ID and PASSWORD) and access your own page, wherein you can check the   status of the Visa cases in progress at 'UDAAN'. </font></p>"
EmailBody=EmailBody& "<p><font face='Arial, Helvetica, sans-serif' size='2'>Login Details:<br>  User ID: "&request("username")&" <br>  Password: "& request("pass1")&" </font></p><p><font face='Arial, Helvetica, sans-serif' size='2'>"
EmailBody=EmailBody& "We encourage you to kindly   change the password given to your office. The new password generated should   be of minimum eight characters (alpha / numeric) related to your company name.   </font></p><p><font face='Arial, Helvetica, sans-serif' size='2'>For any technical queries   about the Website, mail to: deepak@udaanindia.com <br>  Deepak Khera <br></font></p></body></html>"


  On Error Resume Next
  Set oSMTP = Server.CreateObject("OSSMTP.SMTPSession")

  oSMTP.Server = "relay.spectranet.com"
  oSMTP.Port = "25"
  oSMTP.MailFrom = "udaan@spectranet.com"

  'replace with destination email
  oSMTP.SendTo = agentEmail
  oSMTP.MessageSubject = emailSubject
  oSMTP.MessageHTML = emailBody

  oSMTP.RaiseError = True 'raise SMTP errors

  oSMTP.SendEmail
  If Err.Number <> 0 Then
    Response.Write "<br><img src=images/alert1.gif> <b>Error " & Err.Number & ": " & Err.Description & "</b> "
  Else
    Response.write "<p align=center> Email has been sent to the agent at <b> "&agentEmail&"</b></p>"
  End If
End if
end if
'*******************************************************************************



end if
end if
response.clear
myurl= "userhome.asp?uname="&request("username")&"&flag=1"
response.redirect(myurl)


'response.write"<b><font size='3' color='#CC0000'>USERNAME "& UCASE(request("username"))& " CREATED SUCCESSFULLY.</FONT><B>"
else
response.clear
myurl= "userhome.asp?uname="&request("username")&"&flag=2"
response.redirect(myurl)
'response.write"<table><tr><td><b><font size='3' color='#CC0000' >USER NAME "&UCASE(request("username"))&" ALREADY EXISTS PLEASE CHANGE THE USERNAME.</FONT></td></tr><tr><td><b><font size='3' color='#CC0000' ><input type=button onclick='javascript:history.back()' value='EDIT'></FONT></td></tr></table>"
end if
%>
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    
  
   <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  

</body>
</html>
