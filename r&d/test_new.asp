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


set rs=server.createobject("ADODB.RecordSet")
rs.open "select companyname,emailid from agents where emailid<>'' and agentsid>='2501' and agentsid<='3000' order by companyname" , myconn, 3,3

if rs.eof then
Response.write "you have no agent"
else

while not rs.eof

towho=rs("emailid")
'towho="usbhardwaj@udaanindia.com"

if towho <> "" then

fromwho="UDAAN <usbhardwaj@udaanindia.com>"
subject="Surya Vilas - Luxury Resort & Spa!!!"

body="<html><head><title></title></head><body><div align='center'><img src='http://www.udaanindia.com/updateimg/kochhar.jpg' width='768' height='1024'></div></body></html>"


response.write (rs("companyname")&"----->>>>>>"&towho&"<br>")
sendMail fromwho, towho, subject, body

end if
rs.movenext
wend
end if

response.write body
response.write("WELGROW AD HAS GOing 3000 !!!!")
'***************End Send Mail******************
%>