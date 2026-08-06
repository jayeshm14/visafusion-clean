<%
strTo="udaan@udaanindia.com"

if request("priv")="" then
strFrom=request("email")
else
strFrom="info@udaanindia.com"
end if

strSubject="Query form UdaanIndia.com"

priv=request("priv")
if ucase(priv)="AGT" then
user=request("uid")
elseif ucase(priv)="GUEST" then
user="Registered User ("&request("uid")&")"
else
user=" A User"
end if

strMessage="This Mail Has sent by <b>"&user&"</b> from udaanindia.com please find detail about sender below.<br><br>Name : "&request("name")&"<br>Company Name : "&request("cname")&"<br>Phone : "&request("phone")&"<br>Fax : "&request("fax")&"<br>Email : "&request("email")&"<br>City : "&request("city")&"<br><br><b>Message :</b><br><br>"&Request("msgtxt")&"<br><br>"

if strTo <> "" then
	sendMail strFrom, strTo, strSubject, strMessage
end if

Sub SendMail(strFrom, strTo, strSubject, strMessage)
  Dim cdoConfig
  Dim objMail
  
  Set cdoConfig = Server.CreateObject("CDO.Configuration")
  With cdoConfig.Fields
   .Item("sendusing") = 2
   .Item("smtpserver") = "127.0.0.1"
   .Item("smtpport") = "2500"
   .Update
  End With 
 
  Set objMail = Server.CreateObject("CDO.Message")
 
  With objMail
   Set .Configuration = cdoConfig
   .From = strFrom 
   .To = strTo
   
   .Subject = strSubject
   '.TextBody = strMessage 
   .HTMLBody = strMessage
   .Send
  End With
End Sub
 
%>
 
<%
'***************Send Mail******************
'SUB sendMail(fromwho,towho,subject,body)
' DIM myMail
' SET myMail = Server.CreateObject("CDONTS.Newmail")
' myMail.MailFormat = 0
' myMail.BodyFormat = 0
' myMail.From = fromwho
' myMail.To = towho
' myMail.Subject = subject
' myMail.Body = body
' myMail.Send
' SET myMail = Nothing
'END SUB

'towho="udaan@udaanindia.com"

'if request("priv")="" then
'fromwho=request("email")
'else
'fromwho="info@udaanindia.com"
'end if

'subject="Query form UdaanIndia.com"

'priv=request("priv")
'if ucase(priv)="AGT" then
'user=request("uid")
'elseif ucase(priv)="GUEST" then
'user="Registered User ("&request("uid")&")"
'else
'user=" A User"
'end if

'body="This Mail Has sent by <b>"&user&"</b> from udaanindia.com please find detail about sender below.<br><br>Name : "&request("name")&"<br>Company Name : "&request("cname")&"<br>Phone : "&request("phone")&"<br>Fax : "&request("fax")&"<br>Email : "&request("email")&"<br>City : "&request("city")&"<br><br><b>Message :</b><br><br>"&Request("msgtxt")&"<br><br>"

'***************End Send Mail******************
'response.write body

response.redirect("contactsend.asp")
%>