<%
'***************Send Mail******************
SUB sendMail(fromwho,towho,subject,body)
 DIM myMail
 SET myMail = Server.CreateObject("CDONTS.Newmail")
 myMail.MailFormat = 0
 myMail.BodyFormat = 0
 myMail.From = fromwho
 myMail.To = towho
 myMail.Subject = subject
 myMail.Body = body
 myMail.Send
 SET myMail = Nothing
END SUB

towho="usb_76@yahoo.com"
fromwho=request("email")
subject="Query form UdaanIndia.com"

body="This Mail Has sent by a user from udaanindia.com please find detail about sender below.<br><br>Name : "&request("name")&"<br>Company Name : "&request("cname")&"<br>Phone : "&request("phone")&"<br>Fax : "&request("fax")&"<br>Email : "&request("email")&"<br>City : "&request("city")&"<br><br><b>Message :</b><br><br>"&Request("msgtxt")&"<br><br>"

if towho <> "" then
	sendMail fromwho, towho, subject, body
end if

'***************End Send Mail******************
response.write body

'response.redirect("contactsend.asp")
%>