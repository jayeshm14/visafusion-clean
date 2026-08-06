<!-- #include file="connection.asp" -->
<%

categoryid=getIDForDescription("category","Attestation")

 mydate=date()-30
 mydate=Cdate(mydate)
 today=date() 

stdate=today-1

SentSatusID=getIDForDescription("status","Sent")
set rs=server.createobject("adodb.recordset")
'set rsAgentEmail=server.createObject("ADODB.recordset")

set rsuma=server.createobject("adodb.recordset")
stmtuma ="select agentsid,emailid,description from agents where description>='"&request.form("start")&"' and description<='"&request.form("end")&"' order by description"
rsuma.open stmtuma,con
usb=0
uma=2

if not rsuma.eof then

while not rsuma.eof

'agentAddress=getAgentAddress(rsuma("agentsid"))

'EmailBody=EmailBody & "<html><head><title>UDAANINDIA.COM</title></head><BODY bgColor=#cccccc>"
'EmailBody=EmailBody & agentAddress
'EmailBody=EmailBody& "<table width=""75%"" border=""1"" align=""center"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#000000""><tr><td height=""19""><div align=""center""><b><font size=""3"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">"
'EmailBody=EmailBody& "STATUS SHEET FOR "& formatDatetime(today,1)&"</font></b></div>"
'EmailBody=EmailBody& "</td></tr></table>"
'EmailBody=EmailBody& "<table width=""658"" border=""1"" align=""center"">"
'EmailBody=EmailBody& "<tr bgcolor=""#FFFFFF""> <td width=""59""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Recieved</b></font></td>"
'EmailBody=EmailBody& "<td width=""39""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Ref #</b></font></td>"
'EmailBody=EmailBody& "<td width=""95""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>PAX Name</b></font></td>"
'EmailBody=EmailBody& "<td width=""52""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Country</b></font></td>"
'EmailBody=EmailBody& "<td width=""47""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Status</b></font></td>"
                              
'EmailBody=EmailBody& "<td width=""46""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Submit</b></font></td>"
'EmailBody=EmailBody& "<td width=""65""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Collection</b></font></td>"
'EmailBody=EmailBody& "<td width=""36""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Sent</b></font></td>"
'EmailBody=EmailBody& "</tr>"

'if rsuma("agentsid")<>"" then
stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.category,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,MainEntry.receivedate, Mainentry.Agent,Mainentry.refferer, Mainentry.companyname from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&rsuma("agentsid")&" and (paxstatus.sentdate>'"&stdate&"' or paxstatus.sentdate is null) order by mainentry.receivedate,paxstatus.refno"
'end if 
'checkrefno=""
'remarksforClient=""
rs.open stmt,con

if rs.eof then 
'EmailBody=EmailBody& "<tr><td colspan=8 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
uma=2
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
uma=1
'paxID=rs.fields("paxID") 
'category=rs.fields("category")
'refno=rs.fields("refno") 
'agent=rs.fields("agent")
'receivedate=SysToUsrDate(rs.fields("receivedate"))
'subdate=SysToUsrDate(rs.fields("subdate"))
'coldate=SysToUsrDate(rs.fields("coldate"))
'check=rs.fields("colcheck")
'remarks=rs.fields("remarks")

'refferer=rs.fields("refferer")
'companyname=rs.fields("companyname")

'paxname=rs.fields("paxname")
'one_name=trim(rs.fields("paxname"))
'externalremarks=rs.fields("externalremark")

'if trim(externalremarks)<>"" and refno<>checkrefno then
'	remarksforClient=remarksforClient&"<b><font size=""4"" color=""red"">Ref #"&refno&" : </font></b><font size=""3"">"&externalremarks&"</font><br>"
'end if

'checkrefno=refno

'if check="chk" and coldate<>"" then
'coldate="CHK - "&coldate
'end if

'EmailBody=EmailBody& "<tr><td><font face='arial' size=2 color='#000000'>"

'one_date=receivedate
'if  strComp(one_date,old_date) then
'	EmailBody=EmailBody&"<b>"&receivedate&"</b>"
'	old_date=one_date
'else
'	EmailBody=EmailBody&"&nbsp;"
'end if

'EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='red'>"

'one_ref=refno
'if  strComp(one_ref,old_ref) then
'	EmailBody=EmailBody&"<b>"&refno&"</b>"
'	old_ref=one_ref
'else
'	EmailBody=EmailBody&"&nbsp;"
'end if

'EmailBody=EmailBody& "</font></td>"
'EmailBody=EmailBody& "<td width=200><font face='arial' size=2 color='#000000'>"

'if  strComp(one_name,old_name) then
'	EmailBody=EmailBody&"<b>"& rs.fields("paxname")&"</b>"
'	old_name=one_name
'else
'	EmailBody=EmailBody&"&nbsp;"
'end if

'if category=categoryid   then
'	EmailBody=EmailBody&" (ATTEST)"
'end if

'EmailBody=EmailBody&"</font></td><td><font face='arial' size=2 color='#000000'>"&getDescriptionForID("embassy",paxCountryID)

'EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"& getDescriptionForID("status",paxStatusID)
'EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"&nbsp;</font></td><td nowrap><font face='arial' size=2 color='#000000'>"&coldate&"&nbsp;</font></td><td nowrap><font face='arial' size=2 color='#000000'>"&systousrdate(paxSentDate)&"&nbsp;</font></td>"

'if trim(remarks)<>"" or trim(refferer)<>"" or trim(companyname)<>"" then
'	EmailBody=EmailBody& "<tr><td  colspan=3><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif""><b>"
'if trim(refferer)<>"" then
'	EmailBody=EmailBody& "Reff. : "&refferer&"<br>"
'end if
'if trim(companyname)<>"" then
'	EmailBody=EmailBody& "Co./File No.: "&companyname&" "
'end if
'	EmailBody=EmailBody& "&nbsp;</font></b></td><td colspan=5><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif""><b>"&ucase(remarks)&"&nbsp;</b></font></td></tr>"
'end if

end if
'end of the show flag if statement

rs.movenext
wend
end if
rs.close()

 
'EmailBody=EmailBody& "</table>"
'EmailBody=EmailBody& "<table width=""658"" border=0  align=""center"">"   

'if trim(request("awb")) <> "" Then 
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><BR><font size=""4"" color=""RED""><b><CENTER>TODAY'S AWB NUMBER : "&  request("awb")& "</CENTER></b></font></td></tr>"
'End If

'if trim(remarksforClient)<>"" then
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""5"" color=""red""><b><br><u>URGENT MESSAGE FOR FOLLOWING REF NO(s):</u></b></font></td></tr>"
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""3"" color=""#000000""><b>"& ucase(remarksforClient) & "</b></font><br></td></tr>"
'End If

'if trim(request("sremark"))<>"" then
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""5"" color=""red""><b><br><u>SPECIAL REMARKS FOR AGENT :</u></b></font></td></tr>"
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""3"" color=""#000000""><b>"& ucase(request("sremark")) & "</b></font><br></td></tr>"
'End If
           
'if trim(todaysupdate(today)) <> "" Then 
'	EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" align=""center""><font size=""2"" color=""#000000""><b>Today's Update</b></font></td>"
'	EmailBody=EmailBody& "</tr><tr><td colspan=""5"" size=""50""> <font size=""2"" color=""#000000""><b>"&  todaysupdate(today)& "</b></font>"
'	EmailBody=EmailBody& "</td></tr>"
'End If

'EmailBody=EmailBody& "<tr><td colspan=""5"" align=""center""><font size=""2"" color=""#000000"" ><b>HOLIDAY LIST FOR "& MonthName(month(today))&", " & year(today)&" </b></font></td>"
'EmailBody=EmailBody& "</tr> <tr><td colspan=""5"" size=""50""> "
'EmailBody=EmailBody& "<font size=""2"" color=""#000000""><b>"
'         holidaylist= MonthlyHolidayList(today)
'EmailBody=EmailBody& holidaylist  
'EmailBody=EmailBody& "</b></font></td></tr><tr><td>"

'EmailBody=EmailBody &"SENT BY : <b>" &session("lname")& "</b> CONTACT ME ON EXTN : "& session("extn")
'EmailBody=EmailBody &"</td></tr></table><table width=""658"" border=""1"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td><b><font  size=2 face=""arial"">FORWARDED BY: <br><font size=""4"">"&UdaanName&"</font><br> "&UdaanContact&"<br>"
'EmailBody=EmailBody &"</font></b></TD></TR></table>"
'EmailBody=EmailBody & "</body></html>"


''rsAgentEmail.open "select emailid,description from Agents where agentsid="&rsuma("agentsid"),con
''if not rsAgentEmail.EOF then
'if rsuma("emailid")<>"" then
agentEmail=rsuma("emailid")
'doemail="yes"
'End if
description=rsuma("description")
agentsid=rsuma("agentsid")
''end if
''rsAgentEmail.close()

'emailSubject= "Daily Status Report for "&formatdateTime(today,1)

if uma=1 then
usb=usb+1
response.write("<input type='checkbox' name='check'><a href='getagentstatus.asp?agent="&agentsid&"'>"&description&"</a> ---> "&rsuma("emailid")&"<br>")
sqlmail="insert into sentmails values('"&agentsid&"','"&FormatDateTime(now(),0)&"','"&agentEmail&"','"&request("awb")&"')"
con.execute(sqlmail)
end if

'If doemail="yes" and uma=1 then
'Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
'objNewEmail.mailFormat=0
'objNewEmail.bodyFormat=0
'objNewEmail.from=udaanEmail
'objNewEmail.to= agentEmail
'objNewEmail.subject=emailSubject
'objNewEmail.body= emailBody
'objNewEmail.send
'Set objNewEmail = Nothing
'Response.write "<p align=center> Email has been sent to the agent at <b> "&agentEmail&"</b></p>"

'sqlmail="insert into sentmails values('"&agentsid&"','"&FormatDateTime(now(),0)&"','"&agentEmail&"','"&request("awb")&"')"
'con.execute(sqlmail)

'End if

rsuma.movenext
wend
end if
response.write "<br><br>"&usb
%>
