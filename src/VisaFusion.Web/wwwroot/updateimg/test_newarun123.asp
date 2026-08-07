 <%
'***************Send Mail******************
SUB sendMail(fromwho,towho,subject,body)
  On Error Resume Next
  Set oSMTP = Server.CreateObject("OSSMTP.SMTPSession")

  oSMTP.Server = "relay.spectranet.com"
  oSMTP.Port = "25"
  oSMTP.MailFrom = fromwho

  ' replace with destination email
  oSMTP.SendTo = towho
  oSMTP.MessageSubject = subject
  oSMTP.MessageHTML = body

  oSMTP.RaiseError = True 'raise SMTP errors

  oSMTP.SendEmail
 
 If Err.Number <> 0 Then
    Response.Write "<br><img src=images/alert1.gif> <b>Error " & Err.Number & ": " & Err.Description & "</b> "
 End If
END SUB

set myconn=server.createobject("ADODB.Connection")
myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"
'myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=netdb"

'set rs=server.createobject("ADODB.RecordSet")
'rs.open "select companyname,emailid from agents where emailid<>'' and agentsid>='4001' and agentsid<'6000' order by companyname" , myconn, 3,3
'rs.open "select companyname, agentsid,emailid,description from agents where city like '%CALCUTTA%' or city like '%CCU%' or city like '%KOLKATA%' or city like '%KOLKATTA%' or city like '%KOLKLATA%' order by description", myconn, 3,3
'if rs.eof then
'Response.write "you have no agent"
'else

'while not rs.eof

'towho=rs("emailid")

'towho="usbhardwaj@udaanindia.com"
towho="arun_1308@gmail.com"
'if towho <> "" then

fromwho="UDAAN <udaan@udaanindia.com>"
subject="Portugal Updates"

body="<img src='file://Server/D/udaanuma/updateimg/accounts.gif'>"



sendMail fromwho, towho, subject, body
'end if
'rs.movenext
'wend
'end if
response.write body

response.write("Happy Diwali")
'***************End Send Mail******************
%>