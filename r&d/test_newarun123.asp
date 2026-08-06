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
towho="arun@udaanindia.com"
'towho="arun_1308@rediffmail.com"
'if towho <> "" then

fromwho="UDAAN <udaan@udaanindia.com>"
subject="Update Of United Kingdom!!!"

body="<html><head><meta http-equiv='Content-Language' content='en-us'><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>Updates of United Kingdom</title></head><body><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='72%' id='AutoNumber1'>  <tr>    <td width='100%'><img border='0' img src='http://www.udaanindia.com/images/topn1.jpg' width='560' height='71'></td>  </tr>  <tr>    <td width='100%'>    <p class='MsoNormal' align='center'><b>      <font color='#800000' face='Vrinda' style='font-size: 16pt'><u>Update of     United Kingdom – Change in Visa fee and Visa Form</u></font></b></p>    <p class='MsoNormal' align='left'><font color='#000080'>    <span style='font-size:14.0pt; font-weight:700'>Dear     Travel Partners,</span></font></p>    <p class='MsoNormal' align='left'>  <font face='Arial'><span style='font-size:14.0pt'>    <font color='#000080'>This is to bring to your     kind notice that the visa fee and visa form of United Kingdom has been     revised. The following information has been updated on our website i.e</font>    <a href='http://www.udaanindia.com/' style='color: blue; text-decoration: underline; text-underline: single'> www.udaanindia.com</a>.</span></font></p>&nbsp;</td>  </tr></table></body></html>"

sendMail fromwho, towho, subject, body
'end if
'rs.movenext
'wend
'end if
response.write body

response.write("ANOTHER UPDATE")
'***************End Send Mail******************
%>