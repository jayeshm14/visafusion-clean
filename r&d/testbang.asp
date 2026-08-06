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
myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=usb"

set rs=server.createobject("ADODB.RecordSet")
rs.open "select companyname,directorname,emailid from bangagents " , myconn, 3,3
if rs.eof then
response.write "you have no agent"
else

while not rs.eof

towho=rs("emailid")
'towho="manish.udaan@spectranet.com, rajan.udaan@spectranet.com"

if towho <> "" then

fromwho="udaan@spectranet.com"
subject="Udaan Invitation "

body="<html><head><title>Untitled Document</title><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'></head><body bgcolor='#FFFFFF'><table width='73%' border='1' bgcolor='#000033'>  <tr>    <td>      <p><b><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><div align='justify'>OUR         DEAR BANGALOREAN FRIENDS, </font></b></p>      <p><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><b>WE         AT 'UDAAN' CORDIALLY INVITE YOU TO JOIN US FOR A BRIEF PRESENTATION ON         VISAS, FOLLOWED BY COCKTAILS AND DINNER. </b></font></p>      <p><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><b>VENUE         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:         &nbsp;&nbsp;&nbsp;&nbsp;COLOURS. <br>        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         'THE CHANCERY' LAVELLE RAOD,<br>        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         BANGALORE. </b></font></p>      <p><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><b>DATE         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         MARCH 9TH, 2002 - SATURDAY. </b></font></p>      <p><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><b>TIME         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1930 HRS ONWARDS. </b></font></p>      <p><font color='#FF0033' face='Arial, Helvetica, sans-serif' size='4'><b>WE         UNDERSTAND THAT THE SAME HAS NOT BEEN INTIMATED TO YOU WELL IN ADVANCE,         WE WOULD BE GLAD IF YOU COULD KINDLY GRACE THE OCCASION.</div> </b></font></p>    </td>  </tr></table></body></html>"
'body=body&""
'body=body&""
'body=body&""
'body=body&""
'body=body&""

response.write (rs("companyname")&"----->>>>>>"&towho&"<br>")

'	sendMail fromwho, towho, subject, body
end if
rs.movenext
wend
end if
response.write body
'***************End Send Mail******************
%>