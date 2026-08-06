<!-- #include file="connection.asp" -->
<%

categoryid=getIDForDescription("category","Attestation")

 mydate=date()-30
 mydate=Cdate(mydate)
 today=date() 

stdate=today-1

SentSatusID=getIDForDescription("status","Sent")
set rs=server.createobject("adodb.recordset")

set rsuma=server.createobject("adodb.recordset")
stmtuma ="select agentsid,emailid,description from agents where city like '%delhi%' or city like '%gurgaon%' or city like '%noida%' or city like '%faridabad%' or city like '%gaziabad%' order by description"
rsuma.open stmtuma,con
usb=0
uma=2

if not rsuma.eof then

while not rsuma.eof

stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.category,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,MainEntry.receivedate, Mainentry.Agent,Mainentry.refferer, Mainentry.companyname from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&rsuma("agentsid")&" and (paxstatus.sentdate>'"&stdate&"' or paxstatus.sentdate is null) order by mainentry.receivedate,paxstatus.refno"
rs.open stmt,con

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

 
description=rsuma("description")
agentsid=rsuma("agentsid")

if uma=1 then
usb=usb+1
response.write("<input type='checkbox' name='check'><a href='getagentstatus.asp?agent="&agentsid&"'>"&description&"</a> ---> "&rsuma("emailid")&"<br>")
end if

rsuma.movenext
wend
end if
response.write "<br><br>"&usb
%>
