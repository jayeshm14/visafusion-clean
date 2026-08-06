<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topAgent.asp" --></td>
              </tr>
              <tr>
                <td>
               <table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"   > 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                              
                              <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              
                              <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="33"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Sent</b></font></td>
                              
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Email</b></font></td>
                            </tr>
                            <%  
           paxid=request("paxid")    
           countryid=request("countryID")
            date1=date()-3
           
set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rsHistory=server.createobject("adodb.recordset") 
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent, Mainentry.refferer, Mainentry.companyname from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid="&paxID&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno"
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 

while not rs.eof
refno=rs.fields("refno")  
intremark=ucase(rs.fields("internalremark"))
retrieveremark=ucase(rs.fields("AgentInstruction"))  
agent=rs("agent")
status=rs("statusid")
country=rs("countryID")
recdate=rs.fields("receivedate")
if  recdate <> "" then
recdate=day(recdate)&"/"&Month(recdate)&"/"&year(recdate)
End if

subdate=rs.fields("subdate")
if  subdate <> "" then
subdate=day(subdate)&"/"&Month(subdate)&"/"&year(subdate)
End if

coldate=rs.fields("coldate")
if  coldate <> "" then
coldate=day(coldate)&"/"&Month(coldate)&"/"&year(coldate)
End if
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
sentdate=rs.fields("sentdate")
if  sentdate <> "" then
sentdate=day(sentdate)&"/"&Month(sentdate)&"/"&year(sentdate)
End if
paxname=rs("paxname")
response.write "<tr bgcolor='#ffffe4'><td colspan=7><font size='2' face='Arial' color='#3300CC'><b>"& ucase(paxname)&"</b><font size=2 face='arial' color=#C35068> for </font><font size=2 face='arial' color=#C35068> "
Call WriteIDDescription("Embassy",country)
response.write "</font> </font></td><td><font face='arial' size=2 color='#000000'> Agent: "
call writeIddescription("agents",agent)
response.write "</font></td></tr>"
response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td><td><font face='arial' size=2 color='#000000'>"& recdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& subdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& coldate &"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td><font face='arial' size=2 color='#000000'> "
if status <> "" then
call writeIddescription("status",status)
end if
response.write "</font></td><td><font face='arial' size=2 color='#000000'>&nbsp;"& sentdate &"&nbsp;</font></td>"

response.write "<td><font face='arial' size=2 color='#000000'> <a href='contactus.asp' >EMAIL TO UDAAN</a></font></td></tr>"
if retrieveremark<>""  then
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align='left'><font size=2 face='arial' color='#0000CC'><b>Remark From Agent:</B> </font><font size=2 face='arial' color=#C35068>"&retrieveremark&"</font></td></tr>"
end if
'if intremark<>""  then
'response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align='left'><font size=2 face='arial' color='#0000CC'><b>Internal Remark :</b><font size=2 face='arial' color=#C35068> "&intremark&"</font></font></td></tr>"
'end if
response.write "<tr bgcolor='#F0F0FF'><td colspan=5 ><font size=2 face='arial' color='#3300CC'><b>Status: </b></font><font size=2 face='arial' color=#C35068>" 
Call WriteIDDescription("Status",rs("statusID"))
REsponse.write " </font><td colspan=4 > <font size='2' face='Arial' color='#0000CC'><b>REM: </b></font><font size=2 face='arial' color=#C35068>"&ucase(rs("remarks"))&"</font></td></tr>"
if trim(rs("refferer"))<>"" or trim(rs("companyname"))<>"" then
response.write "<tr bgcolor='#F0F0FF'><td colspan=5 ><font size=2 face='arial' color='#3300CC'><b>Referer: </b></font><font size=2 face='arial' color=#C35068>" 
response.write rs("refferer")
REsponse.write " </font><td colspan=4 > <font size='2' face='Arial' color='#0000CC'><b>Company / File No.: </b></font><font size=2 face='arial' color=#C35068>"&ucase(rs("companyname"))&"</font></td></tr>"
end if
response.write "<tr bgcolor='#F0F0FF'><td height=10 colspan=11>"


%>
 <table border=0 width=100%><tr><td colspan=2 align="center"><b>History Of the Events</b></td></tr>
 <tr><td><b>Action</b></td>
 <td><b>Date</b></td>
 <td><b>Remarks</b></td>
 <td><b>Updated By</b></td></tr>
 <%
stmtHistory = "select StatusHistory.statusID,StatusHistory.date,StatusHistory.updatedby,StatusHistory.Remarks from StatusHistory where StatusHistory.paxid="&cdbl(paxid)&" and StatusHistory.countryID="&cint(rs("countryID")) & " Order by Date desc"

rsHistory.open stmtHistory,con,2,3
While not rsHistory.Eof
response.write "<tr><td>"
call WriteIDDEscription("status",rsHistory("statusID"))
response.write "</td><td>"& FormatDateTime(rsHistory("Date"),1)&" at "&formatdatetime(rsHistory("Date"),3)&"</td><td>"& ucase(rsHistory("Remarks"))&"</td><td>"& ucase(rsHistory("Updatedby"))&"</td></tr>"

rsHistory.movenext
Wend
rsHistory.close()

response.write "</table></td></tr><tr bgcolor='#F0F0FF'><td height=10 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()

%> 
                    </table>
                
                </table></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
   <tr>
                <td><!-- #include file="homeBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
