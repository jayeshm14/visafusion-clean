<!-- #include file="connection.asp" -->
<%

categoryid=getIDForDescription("category","Attestation")
attflag="Y"
set rsAgentEmail1=server.createObject("ADODB.recordset")
set rsHotel=server.createObject("ADODB.recordset")
set rsCab=server.createObject("ADODB.recordset")
AgentStmt="select agent,category from mainentry where refno="&request("refno")
rsAgentEmail1.open AgentStmt,con
if not rsAgentEmail1.EOF then
agent=rsAgentEmail1("agent")
category=rsAgentEmail1("category")
end if
rsAgentEmail1.close()
EmailBody=EmailBody &"<table width=""85%"" border=""0"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td align=""center""><b><font  size=5 face=""arial"">"&UdaanName&"</font></b></td></tr>"
EmailBody=EmailBody &"<tr><td  align=""center""><font face='arial' size=2 color='#000000'>"&UdaanAddress&"</font></TD></TR>"
EmailBody=EmailBody &"<tr><td align=""center""><font face='arial' size=2 color='#000000'>"&UdaanContact&"</font></td></tr></table>"
 mydate=date()-30
 mydate=Cdate(mydate)
 if request(Date1)="" then
 today=date() 
 else
 today=date() 
 end if 
 SendEmail=request.form("submit")
         
agentAddress=getAgentAddress(agent)
                             
EmailBody=EmailBody & agentAddress
EmailBody=EmailBody& "<table width=""44%"" border=""0"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td><tr><td colspan=8 align=""center"">"
 

set rs=server.createobject("adodb.recordset")

stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.entrytype,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and paxstatus.refno=entrydetails.refno and entrydetails.refno=mainentry.refno and Mainentry.refno ="&request("refno")
if request("paxID")<>"" and request("country")<>"" then
stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.entrytype,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and paxstatus.refno=entrydetails.refno and entrydetails.refno=mainentry.refno and Mainentry.refno ="&request("refno")&" and paxstatus.paxid="&request("paxID")&" and paxstatus.countryid="&request("country")
end if

rs.open stmt,con
receivedate=rs.fields("receivedate")
externalRemark=rs.fields("externalRemark")
EmailBody=EmailBody& "<table width=""75%"" border=""1"" align=""center"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#000000""><tr><td height=""19""><div align=""center""><b><font size=""3"" color=""RED"" face=""Arial, Helvetica, sans-serif"">"
EmailBody=EmailBody& "URGENT MESSAGE/STATUS</font></b></div></td></tr></table>"

EmailBody=EmailBody& "<table width=""75%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" ><tr><td height=""19"" align=""left""><font size=""2"" color=""RED"" face=""Arial, Helvetica, sans-serif""><B>"
EmailBody=EmailBody& "REF.# "& request("refno") 
EmailBody=EmailBody& "</B></td><td height=""19"" align=""Right""><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">RECIEVED ON "&formatDatetime(receivedate,1)&"</font></b></tr></table>"

EmailBody=EmailBody& "</td></tr><tr><td height=""2""> "
EmailBody=EmailBody& "<table width=""83%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" ><tr><td>" 
           
EmailBody=EmailBody& "<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0""><tr>"
EmailBody=EmailBody& "<td width=""560"">" 
EmailBody=EmailBody& "<table width=""100%"" border=""0"" bgcolor=""#FFFFFF"" cellpadding=""0"" cellspacing=""0"" background=""images/backform.jpg"">"
EmailBody=EmailBody& "<tr> <table width=""658"" border=""1"" align=""center"">"
EmailBody=EmailBody& "<tr bgcolor=""#FFFFFF"">"
EmailBody=EmailBody& "<td width=""95""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>PAX Name</b></font></td>"
EmailBody=EmailBody& "<td width=""52""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Country</b></font></td>"
if  not category=categoryid then
EmailBody=EmailBody& "<td width=""52""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Entry</b></font></td>"
end if 
EmailBody=EmailBody& "<td width=""47""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Status</b></font></td>"
                              
EmailBody=EmailBody& "<td width=""46""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Submit</b></font></td>"
EmailBody=EmailBody& "<td width=""65""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Collection</b></font></td>"
EmailBody=EmailBody& "<td width=""36""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Total</b></font></td>"
EmailBody=EmailBody& "</tr>"

if rs.eof then 
EmailBody=EmailBody& "<tr><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 

while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
check=rs.fields("colcheck")
remarks=rs.fields("remarks")



if tempaxName <> ucase(rs.fields("paxname")) then

paxname=ucase(rs.fields("paxname"))

emailpaxName=ucase(rs.fields("paxname"))
attflag="Y"
else
paxname=""
attflag="N"
end if

if check="chk" then
coldate="CHK - "&coldate
end if
if rs.fields("countryID")<>"" then
countryName=getDescriptionForID("embassy",rs.fields("countryID"))
else
countryName=""
end if
if rs.fields("entrytype")<>"" then
EntrytypeDesc=getDescriptionForID("entrytype",rs.fields("entrytype"))
else
EntrytypeDesc=""
end if


EmailBody=EmailBody& "<tr>"

EmailBody=EmailBody& "<td><font face='arial' size=2 color='#000000'><B>"&paxname
if category=categoryid  and attflag="Y"  then
EmailBody=EmailBody&" (ATTEST)"
end if
EmailBody=EmailBody&"</B></font></td><td><font face='arial' size=2 color='#000000'>"&countryName&"</td>"
if not category=categoryid then
EmailBody=EmailBody&"<td><font face='arial' size=2 color='#000000'>"&EntrytypeDesc&"</font></td>"
end if

EmailBody=EmailBody& "<td><font face='arial' size=2 color='#000000'>"& getDescriptionForID("status",rs.fields("statusid"))
EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td>"
tempaxName=paxname
if trim(remarks)<>"" then
EmailBody=EmailBody& "<tr><td></td><td  colspan=7><font face='arial' size=2 color='#000000'><B>REMARK : </B>"&ucase(remarks)&"</font></td></tr>"
end if
rs.movenext
wend
end if
rs.close()
 
EmailBody=EmailBody& "</table>"
EmailBody=EmailBody& "<table width=75% border=0 cellspacing=1 cellpadding=1 align=""center"">"              
HotelStmt="select * from paxhotel where refno="&request("refno")
rsHotel.open HotelStmt,con
if not rsHotel.EOF then
while not rsHotel.EOF
EmailBody=EmailBody& "<tr><td colspan=5><font face='arial' size=2 color='#000000'>Hotel Booking Done for "&ucase(rsHotel("name")) &" from "&SysToUsrDate(rsHotel("arrivalDate"))&" to "&SysToUsrDate(rsHotel("departDate"))&"</font></td></tr>"
rsHotel.movenext
wend 
end if
rsHotel.close()
HotelStmt="select * from paxcab where refno="&request("refno")
rsHotel.open HotelStmt,con
if not rsHotel.EOF then
while not rsHotel.EOF
EmailBody=EmailBody& "<tr><td  colspan=5><font face='arial' size=2 color='#000000'>Cab Booking Done for "&ucase(rsHotel("name")) &" from "&SysToUsrDate(rsHotel("sDate"))&" to "&SysToUsrDate(rsHotel("endDate"))&"</font></td></tr>"
rsHotel.movenext
wend
end if
rsHotel.close()
if trim(request("awb")) <> "" Then 
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""2"" color=""#000000""><b>Today's AWB Number:</B> "&  request("awb")& "</font></td></tr>"
End If
if externalRemark<>"" then
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><BR><font size=""3""><b>MESSAGE FOR AGENT : "& ucase(externalRemark)& "</b></font></td></tr>"
end if 
EmailBody=EmailBody& "<tr><td colspan=""5""><br><font size=""2"" color=""#000000""><b>Regards,<br>"&Session("lname")&"</b></font></td></tr>"

if trim(todaysupdate(today)) <> "" Then 
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><br><font size=""2"" color=""#000000""><b>Today's Update</b></font></td>"
EmailBody=EmailBody& "</tr><tr><td colspan=""5"" size=""50""> <font size=""2"" color=""#000000""><b>"&  todaysupdate(today)& "</b></font>"
EmailBody=EmailBody& "</td></tr>"
                 End If
  
EmailBody=EmailBody& "<tr><td colspan=""5""><br><font size=""3"" color=""#000000""><b>Holiday list for next 30 days.<!--"& MonthName(month(today))&", " & year(today)&" --></b></font></td>"
EmailBody=EmailBody& "</tr> <tr><td colspan=""5"" size=""50""> "
EmailBody=EmailBody& "<font size=""2"" color=""#000000""><b>"
holidaylist= MonthlyHolidayList(today)
EmailBody=EmailBody& holidaylist  
EmailBody=EmailBody& "</b></font></td></tr>"
EmailBody=EmailBody& "<tr> <td colspan=""2""></td><td colspan=""2""></td></tr></table>"
EmailBody=EmailBody& "</td></tr></table></td></td></tr></table>"
EmailBody=EmailBody& "</td></tr></table></td></tr></table>"
response.write EmailBody
set rsAgentEmail=server.createObject("ADODB.recordset")
rsAgentEmail.open "select * from Agents where agentsid="&agent,con
if not rsAgentEmail.EOF then
if rsAgentEmail("emailid")<>"" then
agentEmail=rsAgentEmail("emailid")
doemail="yes"
End if
end if
rsAgentEmail.close()

emailSubject= "STATUS FOR REF.# "&request("refno")&" on "&formatdateTime(today,1)
if request("paxID")<>"" and request("country")<>"" then
emailSubject= "STATUS FOR "&emailpaxName&"("&countryname&")"

end if 

If doemail="yes" then
'********** Old Code ********************************
'Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
'objNewEmail.mailFormat=0
'objNewEmail.bodyFormat=0
'objNewEmail.from=udaanEmail
'objNewEmail.to= agentEmail
'objNewEmail.subject=emailSubject
'objNewEmail.body= emailBody
'objNewEmail.send
'Set objNewEmail = Nothing

'Response.write "<p align=center> Email has been sent to the agent at following address: <b> "&agentEmail&"</b></p>"
'*********** Old code End ****************************************

'*********Add New CODE for ASPEMail Component ***************
  On Error Resume Next
  Set oSMTP = Server.CreateObject("OSSMTP.SMTPSession")

  oSMTP.Server = "relay.spectranet.com"
  oSMTP.Port = "25"
  oSMTP.MailFrom = "udaan@udaanindia.com"

  ' replace with destination email
  oSMTP.SendTo = agentEmail
  oSMTP.MessageSubject = emailSubject
  oSMTP.MessageHTML = emailBody

  oSMTP.RaiseError = True 'raise SMTP errors

  oSMTP.SendEmail
  If Err.Number <> 0 Then
    Response.Write "<br><img src=images/alert1.gif> <b>Error " & Err.Number & ": " & Err.Description & "</b> "
  Else
    Response.write "<p align=center> Email has been sent to the agent at following address: <b> "&agentEmail&"</b></p>"
  End If
'********** New Code ********************************




End if
%>
  