<%
'***************Send Mail******************
SUB sendMail(fromwho,towho,subject,body)
 DIM myMail
 SET myMail = Server.CreateObject("CDONTS.Newmail")
 myMail.MailFormat = 0
 myMail.BodyFormat = 0
 myMail.From = fromwho
 myMail.To = towho
' myMail.Cc = towho1
 myMail.Subject = subject
 myMail.Body = body
 myMail.Send
 SET myMail = Nothing
END SUB

set myconn=server.createobject("ADODB.Connection")
myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"
'myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=netdb"

set rs=server.createobject("ADODB.RecordSet")
rs.open "select companyname,emailid from agents where emailid<>'' and agentsid>='1' and agentsid<'100' order by companyname" , myconn, 3,3
'rs.open "select companyname, agentsid,emailid,description from agents where city like '%CALCUTTA%' or city like '%CCU%' or city like '%KOLKATA%' or city like '%KOLKATTA%' or city like '%KOLKLATA%' order by description", myconn, 3,3
if rs.eof then
Response.write "you have no agent"
else

while not rs.eof

towho=rs("emailid")
'towho="usbhardwaj@udaanindia.com"

if towho <> "" then

fromwho="Pankaj<pankaj@udaanindia.com>"
subject=" Update......Embassy of Sweden. "



body=""
body=body & ""
body=body & ""
body=body & ""
body=body & ""


response.write (rs("companyname")&"----->>>>>>"&towho&"<br>")
'sendMail fromwho, towho, subject, body
end if
rs.movenext
wend
end if
response.write body
'***************End Send Mail******************
%>