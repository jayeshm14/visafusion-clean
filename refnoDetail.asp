<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
                      
                
<%
categoryid=getIDForDescription("category","Attestation")
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

 mydate=date()-30
 mydate=Cdate(mydate)
 if request(Date1)="" then
 today=date() 
 else
 today=date() 
 end if 
 SendEmail=request.form("submit")
 

           
agentName=getDescriptionForID("agents",agent)
                             

EmailBody=EmailBody& "<table width=""44%"" border=""0"" cellpadding=""0"" cellspacing=""0"" align=""center""><tr><td><tr><td colspan=8 align=""center"">"
 

set rs=server.createobject("adodb.recordset")

stmt ="select Entrydetails.Totalpax, paxstatus.colcheck,paxstatus.entrytype,paxstatus.refno,paxstatus.paxID,MainEntry.externalRemark,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and paxstatus.refno=entrydetails.refno and entrydetails.refno=mainentry.refno and Mainentry.refno ="&request("refno")

rs.open stmt,con
receivedate=rs.fields("receivedate")
internalRemark=rs.fields("internalRemark")
externalRemark=rs.fields("externalRemark")
EmailBody=EmailBody& "<table width=""75%"" border=""1"" align=""center"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#000000""><tr><td height=""19""><div align=""center""><b><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">"
EmailBody=EmailBody& "DETAILED SUMMARY </font></b></div>"
EmailBody=EmailBody& "</td></tr></table>"
EmailBody=EmailBody& "<table width=""75%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#000000""><tr><td height=""19""><b><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">"
EmailBody=EmailBody& "REF.# "& request("refno")&"</font></b>"
EmailBody=EmailBody& " <td align='right'> <b><font size=""2"" color=""#000000"" face=""Arial, Helvetica, sans-serif"">RECIEVED ON "&formatDatetime(receivedate,1)&"</font></b></td></tr></table>"

EmailBody=EmailBody& "</td></tr><tr><td height=""2""> "
EmailBody=EmailBody& "<table width=""83%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" ><tr><td>" 
           
EmailBody=EmailBody& "<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0""><tr>"
EmailBody=EmailBody& "<td width=""560"">" 
EmailBody=EmailBody& "<table width=""100%"" border=""0"" bgcolor=""#FFFFFF"" cellpadding=""0"" cellspacing=""0"" background=""images/backform.jpg"">"
EmailBody=EmailBody& "<tr> <table width=""658"" border=""1"" align=""center"">"
EmailBody=EmailBody& "<tr>"
EmailBody=EmailBody& "<td width=""95""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>PAX Name</b></font></td>"
EmailBody=EmailBody& "<td width=""52""><font size=""2"" face=""Arial, Helvetica, sans-serif"" color=""#000000""><b>Country</b></font></td>"
if not categoryid=category then
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
else
paxname=""
end if

if check="chk" then
coldate="CHK - "&coldate
end if
country=rs.fields("countryID")

if country<>"" then
countryName=getDescriptionForID("embassy",country)
else
countryName=""
end if
if rs.fields("entrytype")<>"" then
EntrytypeDesc=getDescriptionForID("entrytype",rs.fields("entrytype"))
else
EntrytypeDesc=""
end if
EmailBody=EmailBody& "<tr>"

EmailBody=EmailBody& "<td><font face='arial' size=2 color='#000000'><a href='collectionFormPax.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&pname="&paxname&"&page="&request("page")&"&cmd="&request("cmd")&"' >"&paxname&"</a></font></td><td><font face='arial' size=2 color='#000000'><a href='collectionFormPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&country&"&pname="&rs.fields("paxname")&"&page="&request("page")&"&cmd="&request("cmd")&"' > "&countryName&"</a></td>"

if not categoryid=category then
EmailBody=EmailBody& "<td><font face='arial' size=2 color='#000000'>"&EntrytypeDesc&"</font></td>"
end if
tempaxName=ucase(rs.fields("paxname"))
EmailBody=EmailBody& "<td><font face='arial' size=2 color='#000000'>"& getDescriptionForID("status",rs.fields("statusid"))
EmailBody=EmailBody& "</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td>"
if trim(remarks)<>"" then
EmailBody=EmailBody& "<tr><td></td><td  colspan=7><font face='arial' size=2 color='#000000'>"&ucase(remarks)&"</font></td></tr>"
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
EmailBody=EmailBody& "<tr><td  colspan=5><font face='arial' size=2 color='#000000'>Hotel Booking Done for "&ucase(rsHotel("name")) &" from "&SysToUsrDate(rsHotel("arrivalDate"))&" to "&SysToUsrDate(rsHotel("departDate"))&"</font></td></tr>"
end if
rsHotel.close()
HotelStmt="select * from paxcab where refno="&request("refno")
rsHotel.open HotelStmt,con
if not rsHotel.EOF then

EmailBody=EmailBody& "<tr><td  colspan=5><font face='arial' size=2 color='#000000'>Cab Booking Done for "&ucase(rsHotel("name")) &" from "&SysToUsrDate(rsHotel("sDate"))&" to "&SysToUsrDate(rsHotel("endDate"))&"</font></td></tr>"
end if
rsHotel.close()
if trim(request("awb")) <> "" Then 
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""2"" color=""#000000""><b>Today's AWB Number:</B> "&  request("awb")& "</font></td></tr>"
End If
if internalRemark<>"" then
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""2"" color=""#000000""><b>Message:"& ucase(internalRemark)& "</b></font></td></tr>"
end if 
if externalRemark<>"" then
EmailBody=EmailBody& "<tr><td VALIGN=""TOP"" colspan=""5"" ><font size=""2"" color=""#000000""><b>Message:"& ucase(externalRemark)& "</b></font></td></tr>"
end if 
EmailBody=EmailBody& "<tr> <td colspan=""2""></td><td colspan=""2""></td></tr></table>"
EmailBody=EmailBody& "</td></tr></table></td></td></tr></table>"
EmailBody=EmailBody& "</td></tr></table></td></tr></table>"
response.write EmailBody
'End if
%>
  
                
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
