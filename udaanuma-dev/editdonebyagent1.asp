<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer=true

'SUB sendMail(fromwho,towho,subject,body)
' DIM myMail
' SET myMail = Server.CreateObject("CDONTS.Newmail")
' myMail.MailFormat = 0
' myMail.BodyFormat = 0
' myMail.From = fromwho
' myMail.To = towho
'' myMail.Cc = towho1
' myMail.Subject = subject
' myMail.Body = body
' myMail.Send
' SET myMail = Nothing
'END SUB

'towho="usbhardwaj@udaanindia.com"
'subject="Agant update information"
'fromwho="info@udaanindia.com"


	agentdes=request("agent")
	newagentdes=request("newagent")
	agent=cint(request("agentid"))
	
	set rs=server.createobject("adodb.recordset")
	set rs2=server.createobject("adodb.recordset")
	stmt="select * from  agents where description='" &newagentdes &"' and '"& agentdes&"' <> '"&newagentdes&"'"
	rs.open stmt,con,2,3
	
if not rs.eof then

 'response.write "agent name already exist"
  response.clear
'  myurl= "agenthome.asp?agent="&newagentdes&"&flag=1"
  response.redirect(myurl)
  rs.close
else
rs.close
  agent=cint(request("agentid"))
  
  stmt="select * from agents where agentsID="&agent
  
  rs.open stmt,con,2,3
  if not rs.eof then
    rs("description")=newagentdes
rs("companyname")=request("company")
rs("complexname")=request("complexname")
rs("street1")=request("street1")
rs("street2")=request("street2")
rs("area")=request("area")
rs("city")=request("city")
rs("pincode")=request("pincode")
rs("phoneno")=request("phoneno")
rs("faxno")=request("faxno")
rs("emailid")=request("emailid")
rs("directorname")=request("directorname")
rs("acno")=request("acno")
rs("IATA")=request("IATA")
rs("TAAI")=request("TAAI")
rs("TAFI")=request("TAFI")
rs("DirectorPH")=request("DirectorPH")
rs("AcMgrPH")=request("AcMgrPH")
rs("VisaInchargeName")=request("VisaInchargeName")
rs("VisaInchargePH")=request("VisaInchargePH")

rs.update




'if towho <> "" then

'body="<html><head><title>Untitled Document</title><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'></head><body bgcolor='FFFFFF'><table width='100%' border='1' cellpadding='0' cellspacing='0'>  <tr>     <td colspan='2'>       <div align='center'><b><font size='4'>Information Updated by Usar<br>        </font></b></div>    </td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face='arial'>AGENT NAME</font></td>    <td width='53%'><font color=red face=''>"&ucase(agentdes)&" </font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>COMPANY NAME</font></td><td width='53%'> "& ucase(request("company")) &" </td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>COMPLEX NAME</font></td>    <td width='53%'> "& ucase(request("complexname")) &" </td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>STREET-1 </font></td>    <td width='53%'> "& ucase(request("street1")) &" </td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>STREET-2</font></td>    <td width='53%'> "& ucase(request("street2")) &" </td>  </tr>  <tr><td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>AREA </font></td>    <td width='53%'><font color=red face=''> "& ucase(request("area")) &"</font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>CITY </font></td>    <td width='53%'><font color=red face=''> "& ucase(request("city")) &"</font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>PIN CODE </font></td>    <td width='53%'><font color=red face=''> "& ucase(request("pincode")) &"</font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>PHONE NO:</font></td>    <td width='53%'><font color=red face=''> "& ucase(request("phoneno")) &"</font></td>  </tr>"
'body=body&"           <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>FAX NO:</font></td>    <td width='53%'><font color=red face=''> "& ucase(request("faxno")) 
'body=body&"</font></td>  </tr><tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red>EMAILID</font></td>    <td width='53%'><font color=red> "& request("emailid")&"</font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>DIRECTOR NAME </font></td>    <td width='53%'><font color=red face=''> "& ucase(request("directorname")) &"</font></td>  </tr>  <tr>     <td width='47%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>A/C INCHARGE NO.</font></td>    <td width='53%'><font color=red face=''> "& ucase(request("acno")) &"</font></td>  </tr> <td align=center colspan='2' height='2'> &nbsp;&nbsp;&nbsp;&nbsp; </td>  </tr>  </table></body></html>"

'	sendMail fromwho, towho, subject, body
'end if

strTo="pankaj@udaanindia.com.com"
strFrom="info@udaanindia.com"
strSubject="Agant update information"

strMessage="<html><head><title>Untitled Document</title><meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'></head><body bgcolor='FFFFFF'><table width='100%' border='1' cellpadding='0' cellspacing='0'>  <tr>     <td colspan='2'>       <div align='center'><b><font size='4'>Information Updated by Usar<br>        </font></b></div>    </td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face='arial'>AGENT NAME</font></td>    <td width='69%'><font color=red face=''>"&ucase(agentdes)&" </font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>COMPANY NAME</font></td>    <td width='69%'> "& ucase(request("company")) &" </td>  </tr>"
strMessage=strMessage&"<tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>COMPLEX NAME</font></td>    <td width='69%'> "& ucase(request("complexname")) &" </td>  </tr>  <tr>     <td width='31%'> &nbsp;&nbsp;&nbsp;<font color='#FF0000'>AGENCY`S AFFILIATION</font></td>    <td width='69%'>IATA- "& ucase(request("IATA")) &" TAAI - "& ucase(request("TAAI")) &" TAFI - "& ucase(request("TAFI")) &" </td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>STREET-1 </font></td>    <td width='69%'> "& ucase(request("street1")) &" </td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>STREET-2</font></td>    <td width='69%'> "& ucase(request("street2")) &" </td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>AREA </font></td>    <td width='69%'><font color=red face=''> "& ucase(request("area")) &"</font></td> "
strMessage=strMessage&"</tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>CITY </font></td>    <td width='69%'><font color=red face=''> "& ucase(request("city")) &"</font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>PIN CODE </font></td>    <td width='69%'><font color=red face=''> "& ucase(request("pincode")) &"</font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>PHONE NO:</font></td>    <td width='69%'><font color=red face=''> "& ucase(request("phoneno")) &"</font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>FAX NO:</font></td>    <td width='69%'><font color=red face=''> "& ucase(request("faxno"))&" </font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red>EMAILID</font></td>    <td width='69%'><font color=red> "& request("emailid")&"</font></td>  </tr>"
strMessage=strMessage&"<tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>DIRECTOR NAME /       MOBILE </font></td>    <td width='69%'><font color=red face=''> "& ucase(request("directorname"))&"/ "& ucase(request("DirectorPH")) &"</font></td>  </tr>  <tr>     <td width='31%'>&nbsp;&nbsp;&nbsp;<font color=red face=''>A/C INCHARGE NAME       / MOBILE </font></td>    <td width='69%'><font color=red face=''> "& ucase(request("acno")) &"/ "& ucase(request("AcMgrPH")) &"</font></td>  </tr>  <tr>     <td align=center width='31%' height='2'>       <div align='left'> &nbsp;&nbsp;&nbsp;<font color='#FF0000'>VISA`S INCHARGE'S         NAME /MOBILE NO.</font></div>    </td>    <td align=center width='69%' height='2'>      <div align='left'><font color=red face=''>"& ucase(request("VisaInchargeName"))         &"/ "& ucase(request("VisaInchargePH")) &"</font></div>    </td>  </tr>  <td align=center colspan='2' height='2'> &nbsp;&nbsp;&nbsp;&nbsp; </td>  </tr></table></body></html> "


if strTo <> "" then
	sendMail strFrom, strTo, strSubject, strMessage
end if

Sub SendMail(strFrom, strTo, strSubject, strMessage)
  Dim cdoConfig
  Dim objMail
  
  Set cdoConfig = Server.CreateObject("CDO.Configuration")
  With cdoConfig.Fields
   .Item("sendusing") = 2
   .Item("smtpserver") = "relay.spectranet.com"
   .Item("smtpport") = "25"
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


  end if
  response.clear
'  myurl= "agenthome.asp?agent="&newagentdes&"&flag=2"
'  response.redirect(myurl)
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
</head>
<body>
<table width="765" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><!-- #include file="topagent.asp" -->
    </td>
  </tr>
  <tr>
    <td>
<table width=780 border=0 align=center cellpadding=0 cellspacing=0><tr> 
    <td align=left valign=top background="images/bigtablebg.gif">
          <table width=680 border=0 align=center cellpadding=0 cellspacing=0 bgcolor="BD402C">
            <tr> 
    <td align="center">&nbsp;<br>
<table width=580><tr>
                    <td height="21" background="images/yellowbgband.gif" align="center"> 
                      <p class="lbltext"> THANKS</p>
                    </td>
</tr></table>
<tr>
<td align="center">
<br>
        <b><font size="5" color="#FF9900"><br>
          Thanks !</font><br>
          <br>
<br>
          </b>
        <p align="center" class="updatetext"><strong> Your Information has been Updated Successfully. </strong></p><br>
          <p align="center" class="updatetext"><strong>Thanks For Giving your latest information. </strong></p>
<br><br><br><br>
</td></tr></table>
</td></tr></table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="homeBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
