<!-- #include file="connection.asp" -->
<%
categoryid=getIDForDescription("category","Attestation")
canadaid=getIDForDescription("embassy","canada")
newzealandid=getIDForDescription("embassy","newzealand")

 mydate=date()-30
 mydate=Cdate(mydate)
 if request(Date1)="" then
 today=date() 
 else
 today=date() 
 end if 
 SendEmail=request.form("submit")

if SendEmail="Email Status" then
stdate=today
else
stdate=today-1
end if

if trim(request("awb"))="" then
set rsawb=server.createObject("ADODB.recordset")
rsawb.open "select * from sentawb where agentsid="&request("agent")&" and date='"&today-1&"'",con
awbstr=""
if not rsawb.EOF then
awbflag=1
while not rsawb.eof
awbstr=awbstr&""&rsawb("awb")&" ("&rsawb("remark")&"), "
rsawb.movenext
wend
end if
else
awbstr=request("awb")
end if
awbstr=rtrim(awbstr)
if awbflag=1 then
awbcnt=len(awbstr)
awbcnt=awbcnt-1
awbstr=left(awbstr,awbcnt)
end if

'response.write stdate

agentAddress=getAgentAddress(request("agent"))

EmailBody=EmailBody & "<html><head><title>UDAANINDIA.COM</title></head><BODY bgColor=#cccccc>"
EmailBody=EmailBody & agentAddress
EmailBody=EmailBody& "<table width=""75%"" border=""1"" align=""center"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#000000""><tr><td height=""19""><div align=""center""><b><font size=""3"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">"
EmailBody=EmailBody& "STATUS SHEET FOR "& formatDatetime(today,1)&"</font></b></div>"
EmailBody=EmailBody& "</td></tr></table>"
EmailBody=EmailBody& "<table width=""658"" border=""1"" align=""center"">"
EmailBody=EmailBody& "<tr bgcolor=""#FFFFFF""> <td width=""59""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Recieved</b></font></td>"
EmailBody=EmailBody& "<td width=""39""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Ref #</b></font></td>"
EmailBody=EmailBody& "<td width=""95""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>PAX Name</b></font></td>"
EmailBody=EmailBody& "<td width=""52""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Country</b></font></td>"
EmailBody=EmailBody& "<td width=""47""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Status</b></font></td>"
                              
EmailBody=EmailBody& "<td width=""46""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Submit</b></font></td>"
EmailBody=EmailBody& "<td width=""65""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Collection</b></font></td>"
EmailBody=EmailBody& "<td width=""36""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Sent</b></font></td>"
EmailBody=EmailBody& "</tr>"

SentSatusID=getIDForDescription("status","Sent")

set rs=server.createobject("adodb.recordset")
if request("agent")<>"" then
stmt ="select Entrydetails.Totalpax, mainentry.poe, mainentry.entrydatetime, paxstatus.colcheck,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.category,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,MainEntry.receivedate, Mainentry.Agent,Mainentry.refferer, Mainentry.companyname from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&"  order by mainentry.receivedate,paxstatus.refno"
'response.write stmt
end if 
checkrefno=""
remarksforClient=""
rs.open stmt,con

if rs.eof then 
EmailBody=EmailBody& "<tr><td colspan=8 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 

while not rs.eof

showFlag="Y"
paxStatusID=rs.fields("statusID") 
paxSentDate=rs.fields("sentdate") 
paxCountryID=rs.fields("countryID")

if paxSentDate<> "" or not IsNull(paxSentDate)  then
if SentSatusID=paxStatusID and paxSentDate < stdate then
showFlag="N"
end if
end if

if showFlag="Y" then
paxID=rs.fields("paxID") 
category=rs.fields("category")
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
check=rs.fields("colcheck")
remarks=rs.fields("remarks")

refferer=rs.fields("refferer")
companyname=rs.fields("companyname")
poe=rs.fields("poe")

laterec=""
edatetime=rs.fields("entrydatetime")

if paxCountryID<>canadaid and paxCountryID<>newzealandid then
if year(today)=year(edatetime) and month(today)=month(edatetime) and day(today)=day(edatetime) then
if formatdatetime(edatetime,4) > formatdatetime(cdate("12:00:00 PM"),4) and paxStatusID<>201 then
laterec="<font size=""2"" color=""red"" face=""Arial, Helvetica, sans-serif""><b>LATE FOR SUBMISSION. </b></font> "
end if
end if
end if

paxname=rs.fields("paxname")
one_name=trim(rs.fields("paxname"))
externalremarks=rs.fields("externalremark")

if trim(externalremarks)<>"" and refno<>checkrefno then
	remarksforClient="<b><font size=""2"" color=""red"" face=""Arial, Helvetica, sans-serif"">Ref #"&refno&" : "&ucase(externalremarks)&"</font></b><br>"
end if

checkrefno=refno

if check="chk" and coldate<>"" then
coldate="CHK - "&coldate
end if

EmailBody=EmailBody& "<tr><td><font face='arial' size=2 color='#000000'>"

one_date=receivedate
if  strComp(one_date,old_date) then
	EmailBody=EmailBody&"<b>"&receivedate&"</b>"
	old_date=one_date
else
	EmailBody=EmailBody&"&nbsp;"
end if

EmailBody=EmailBody& "</font></td><td><font face='arial' size=2>"

one_ref=refno
if  strComp(one_ref,old_ref) then
	EmailBody=EmailBody&"<b>"&refno&"</b>"
	old_ref=one_ref
else
	EmailBody=EmailBody&"&nbsp;"
end if

EmailBody=EmailBody& "</font></td>"
EmailBody=EmailBody& "<td width=200><font face='arial' size=2 color='#000000'>"

if  strComp(one_name,old_name) then
	EmailBody=EmailBody&"<b>"& rs.fields("paxname")&"</b>"
	old_name=one_name
else
	EmailBody=EmailBody&"&nbsp;"
end if

if category=categoryid   then
	EmailBody=EmailBody&" (ATTEST)"
end if

EmailBody=EmailBody&"</font></td><td><font face='arial' size=2 color='#000000'>"&getDescriptionForID("embassy",paxCountryID)

EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"& getDescriptionForID("status",paxStatusID)
EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"&nbsp;</font></td><td nowrap><font face='arial' size=2 color='#000000'>"&coldate&"&nbsp;</font></td><td nowrap><font face='arial' size=2 color='#000000'>"&systousrdate(paxSentDate)&"&nbsp;</font></td>"

if trim(remarks)<>"" or trim(refferer)<>"" or trim(companyname)<>"" or poe<>"1" or laterec<>"" then
	EmailBody=EmailBody& "<tr><td  colspan=3><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif""><b>"
if trim(refferer)<>"" then
	EmailBody=EmailBody& "Reff. : "&refferer&""
end if

if poe<>"1" then
poe=getDescriptionForID("poe",poe)
EmailBody=EmailBody& "&nbsp; &nbsp; << <b><font color='red'>"&poe&"</font></b> >><br>"
else
EmailBody=EmailBody& "<br>"
end if

if trim(companyname)<>"" then
	EmailBody=EmailBody& "Co./File No.: "&companyname&" "
end if
	EmailBody=EmailBody& "&nbsp;</font></b></td><td colspan=5>"&laterec&"<font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif""><b>"&ucase(remarks)&"&nbsp;</b></font></td></tr>"
end if

end if
'end of the show flag if statement
if remarksforClient <> "" then
	EmailBody=EmailBody& "<tr><td  colspan=8> "& remarksforClient &"</td></tr>"
	remarksforClient = ""
end if

rs.movenext
wend
end if
rs.close()

 
EmailBody=EmailBody& "</table>"
EmailBody=EmailBody& "<table width=""658"" border=0  align=""center"">"   

if awbstr <> "" Then 
	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><BR><font size=""4"" color=""RED""><b><CENTER>YESTERDAY'S AWB NUMBER : <br>"&  awbstr & "</CENTER></b></font></td></tr>"
End If

'if trim(remarksforClient)<>"" then
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""5"" color=""red""><b><br><u>URGENT MESSAGE FOR FOLLOWING REF NO(s):</u></b></font></td></tr>"
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""3"" color=""#000000""><b>"& ucase(remarksforClient) & "</b></font><br></td></tr>"
'End If

if trim(request("sremark"))<>"" then
	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""5"" color=""red""><b><br><u>SPECIAL REMARKS FOR AGENT :</u></b></font></td></tr>"
	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""3"" color=""#000000""><b>"& ucase(request("sremark")) & "</b></font><br></td></tr>"
End If
           
if trim(todaysupdate(today)) <> "" Then 
	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" align=""center""><font size=""2"" color=""#000000""><b>Today's Update</b></font></td>"
	EmailBody=EmailBody& "</tr><tr><td colspan=""5"" size=""50""> <font size=""2"" color=""#000000""><b>"&  todaysupdate(today)& "</b></font>"
	EmailBody=EmailBody& "</td></tr>"
End If

'EmailBody=EmailBody& "<tr><td colspan=""5"" align=""center""><font size=""2"" color=""#000000"" ><b>HOLIDAY LIST FOR NEXT 30 DAYS </b></font></td>"
'EmailBody=EmailBody& "</tr> <tr><td colspan=""5"" size=""50""> "
'EmailBody=EmailBody& "<font size=""2"" color=""#000000""><b>"
         holidaylist= MonthlyHolidayList(today)
'EmailBody=EmailBody& holidaylist  
'EmailBody=EmailBody& "</b></font></td></tr>"

EmailBody=EmailBody &"<tr><td>SENT BY : <b>" &session("lname")& "</b> CONTACT ME ON EXTN : "& session("extn")
EmailBody=EmailBody &"</td></tr></table><table width=""658"" border=""1"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td><b><font  size=2 face=""arial"">FORWARDED BY: <br><font size=""4"">"&UdaanName&"</font><br> "&UdaanContact&"<br>"
EmailBody=EmailBody &"</font></b></TD></TR></table>"
EmailBody=EmailBody & "</body></html>"

response.write EmailBody


set rsAgentEmail=server.createObject("ADODB.recordset")
rsAgentEmail.open "select * from Agents where agentsid="&request("agent"),con
if not rsAgentEmail.EOF then
if rsAgentEmail("emailid")<>"" then
agentEmail=rsAgentEmail("emailid")
doemail="yes"
End if
end if
rsAgentEmail.close()

emailSubject= "Daily Status Report for "&formatdateTime(today,1)

If doemail="yes" and SendEmail="Email Status" then

'**** Commented OLD Code ***************
'Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
'objNewEmail.mailFormat=0
'objNewEmail.bodyFormat=0
'objNewEmail.from="udaan@spectranet.com"
'objNewEmail.to= agentEmail
'objNewEmail.subject=emailSubject
'objNewEmail.body= emailBody
'objNewEmail.send
'Set objNewEmail = Nothing
'*****************************************
'*********Add New CODE for ASPEMail Component ***************

  On Error Resume Next
  Set oSMTP = Server.CreateObject("OSSMTP.SMTPSession")

  oSMTP.Server = "relay.spectranet.com"
  oSMTP.Port = "25"
  oSMTP.MailFrom = "udaan@spectranet.com"

  ' replace with destination email
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



sqlmail="insert into sentmails values('"&request("agent")&"','"&FormatDateTime(now(),0)&"','"&agentEmail&"','"&request("awb")&"')"
con.execute(sqlmail)
End if

''set textfile1=server.createobject("scripting.FileSystemObject")
''set fileobj=textfile1.createtextFile ("c:\rajvenesh.html")
''fileobj.WriteLIne emailBody
''fileobj.close

%>
