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
rsuma.open stmtuma,con,3,3
usb=0
uma=2

if not rsuma.eof then

while not rsuma.eof

'if rsuma("agentsid")<>"" then
stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.category,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,MainEntry.receivedate, Mainentry.Agent,Mainentry.refferer, Mainentry.companyname from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&rsuma("agentsid")&" and (paxstatus.sentdate>'"&stdate&"' or paxstatus.sentdate is null) order by mainentry.receivedate,paxstatus.refno"
'end if 
'checkrefno=""
'remarksforClient=""
rs.open stmt,con,3,3

if rs.eof then 

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

end if
'end of the show flag if statement

rs.movenext
wend
end if
rs.close()

agentEmail=rsuma("emailid")

description=rsuma("description")
agentsid=rsuma("agentsid")

if uma=1 then
usb=usb+1
response.write("<input type='checkbox' name='check'><a href='getagentstatus.asp?agent="&agentsid&"'>"&description&"</a> ---> "&rsuma("emailid")&"<br>")
sqlmail="insert into sentmails values('"&agentsid&"','"&FormatDateTime(now(),0)&"','"&agentEmail&"','"&request("awb")&"')"
con.execute(sqlmail)
end if

rsuma.movenext
wend
end if
response.write "<br><br>"&usb
%>
