<!-- #include file="connection.asp" -->
<%
response.buffer=true

'***************Send Mail******************
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
   '.Send
  End With
End Sub

'SUB sendMail(fromwho,towho,subject,body)
' DIM myMail
' SET myMail = Server.CreateObject("CDONTS.Newmail")
' myMail.MailFormat = 0
' myMail.BodyFormat = 0
' myMail.From = fromwho
' myMail.To = towho
' myMail.Cc = towho1
' myMail.Subject = subject
' myMail.Body = body
' myMail.Send
' SET myMail = Nothing
'END SUB

'***************End Send Mail******************

tdate=request("date")&"/"&request("month")&"/"&request("year")
tdate=usrtosysdate(tdate)
name=request("pre")&" "&request("fname")&" "&request("lname")
busitype=request("busi")
if ucase(busitype)="OTHER" then
busitype="OTHER ("&request("othbusi")&")"
end if
company=request("company")
desig=request("desig")
add=request("add")
area=request("area")
city=request("city")
pin=request("pincode")
country=request("country")
phone=request("phoneno")
fax=request("faxno")
email=request("u_mail")
hpage=request("hpage")
uid=request("uid")
pwd=request("u_pwd")

how=request.form("how")
if ucase(how)="DIRECTMAIL" then
howknow="THROUGH DIRECT MAIL ANNOUNCING udaanindia.com"
elseif ucase(how)="METAT" then
howknow="MET AT THE "&ucase(request("metat1"))&" CONFERENCE / EXHIBITION IN "&ucase(request("metat2"))
elseif ucase(how)="CONFRIEND" then
howknow="THROUGH CONTACT / FRIEND, NAMELY "&ucase(request("friend"))
elseif ucase(how)="UDAANPROM" then
howknow="THROUGH UDAAN PROMOS "&ucase(request("promos"))
elseif ucase(how)="OTHMEANS" then
howknow="THROUGH OTHER MEANS "&ucase(request("othmeans"))
end if

set rs1=server.createobject("adodb.recordset")
stmt1="select * from udaan_users where username='"&uid&"'"
rs1.open stmt1,con,2,3

if not rs1.eof then

usb=2

else

set rs=server.createobject("adodb.recordset")
stmt="select * from registration where uid='"&uid&"'"
rs.open stmt,con,2,3

if not rs.eof then
usb=2
else
usb=1
rs.addnew
rs("uid")=uid
rs("pwd")=pwd
rs("name")=name
rs("desig")=desig
rs("company")=company
rs("busitype")=busitype
rs("address")=add
rs("area")=area
rs("city")=city
rs("pincode")=pin
rs("country")=country
rs("phoneno")=phone
rs("faxno")=fax
rs("emailid")=email
rs("hpage")=hpage
rs("howknow")=howknow
rs("date")=date
rs.update
rs.close

strto=email
strfrom="info@udaanindia.com"
strsubject="Registration details of UdaanIndia.com"

strmessage="<html><head><title>Untitled Document</title><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'></head><body bgcolor='#FFFFFF'><table width='90%' border='0'>  <tr>     <td colspan='2'>       <div align='justify'><font face='Arial, Helvetica, sans-serif' size='3'><b>Hi         "&name&",</b><br>        <br>        Welcome to <a href='www.udaanindia.com'><b>www.UdaanIndia.com</b></a>         <br>        <br>        Now you are a registered USER of our website. <br>        <br>        The registration now enables you to make queries related to approx. 230         countries of the world – with regard to the Visa documentation procedures         as applicable for Indian nationals, for about 23 categories of Visas.         <br>        <br>        Now you can also LOG-ON ( for that you will need both USER ID and PASSWORD         ) and access your own page, wherein you can check the status of the Visa         cases in progress at <b>“UDAAN”</b>.</font></div>    </td>  </tr>  <tr>     <td colspan='2'>&nbsp;</td>  </tr>  <tr bgcolor='#00CC99'>     <td colspan='2'><b><font face='Arial, Helvetica, sans-serif' size='3'>Login       Details</font></b></td>  </tr>  <tr bgcolor='#FFFFCC'>     <td height='22' width='28%'><b><font face='Arial, Helvetica, sans-serif' size='3'>User       ID</font></b></td>    <td height='22' width='72%'><b><font face='Arial, Helvetica, sans-serif' size='3'>"&uid&"</font></b></td>  </tr>  <tr bgcolor='#FFFFCC'>     <td width='28%'><b><font face='Arial, Helvetica, sans-serif' size='3'>Password</font></b></td>    <td width='72%'><b><font face='Arial, Helvetica, sans-serif' size='3'>"&pwd&"</font></b></td>  </tr>  <tr>     <td colspan='2'>       <div align='justify'><font face='Arial, Helvetica, sans-serif' size='3'><br>     <br>   "
strmessage=strmessage &"<br>        For any technical queries about the Website, mail to : <a href='mailto:usbhardwaj@udaanindia.com'>usbhardwaj@udaanindia.com</a>         <br>        <br>        <b>Uma Shankar Bhardwaj. </b><b><br>        </b><br>        <b>Udaan India Private Limited. </b></font></div>    </td>  </tr></table><br><br><br></body></html>"

if strTo <> "" then
	sendMail strFrom, strTo, strSubject, strMessage
end if

end if

end if

response.redirect"regsubdone.asp?usb="&usb&"&anp=34&cd=2345&seckey=xyz25g78mumad204shankar22npr054416bhardwajpanftphjkslsktls&jn=253&ses=k3456l7dj9mathurajavyemsn&company=udaan"
%>
