<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
</head>
<body>
<tr> 
  <td> 
    <tr valign="top"> 
      <td width="98%"> 
        <tr> 
          <td>
            <!-- #include file="topAgent.asp" --> 
<table width=780 border=0 align=center cellpadding=0 cellspacing=0><tr> 
    <td align=left valign=top background="images/bigtablebg.gif"> 
    <div align="center">
        <table width="658" border="0" align="center" background="#000C80">
          <tr bgcolor="FBBD06"   > 
            <td width="63"> 
              <p class="dynamicheadingagent">Ref#</p>
            </td>
            <td width="91" bgcolor="FBBD06"> 
              <p class="dynamicheadingagent">Recieved</p>
            </td>
            <td width="72">
<p class="dynamicheadingagent">Submit</p></td>
            <td width="102" bgcolor="FBBD06"> 
              <p class="dynamicheadingagent">Collection</p>
            </td>
            <td width="57">
<p class="dynamicheadingagent">Total</p></td>
            <td width="74">
<p class="dynamicheadingagent">Status</p></td>
            <td width="52">
<p class="dynamicheadingagent">Sent</p></td>
            <td width="113">
<p class="dynamicheadingagent">Email</p></td>
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
response.write "<tr><td colspan=11 bgcolor='BD402C'><p class=dynamictext1>NO DATA FOUND</p></td></tr>" 
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
response.write "<tr bgcolor='BD402C'><td colspan=6><p class='updatelinks'>"& ucase(paxname)&" for "
Call WriteIDDescription("Embassy",country)
response.write "</td><td  width='113' colspan=2><p class='dynamictext1'>"
call writeIddescription("agents",agent)
response.write "</td></tr>"
response.write "<tr bgcolor='BD402C'><td><p class='dynamictext1'>"&refno&"</p></td><td><p class='dynamictext1'>"& recdate &"</p></td><td><p class='dynamictext1'>"& subdate &"</p></td><td><p class='dynamictext1'>"& coldate &"</p></td><td><p class='dynamictext1'>"&rs.fields("totalpax")&"</p></td><td> <p class='dynamictext1'>"
if status <> "" then
call writeIddescription("status",status)
end if
response.write "</p></td><td><p class='dynamictext1'>"& sentdate &"</p></td>"

response.write "<td><p class='dynamictext1'><a href='contactus.asp' >E-mail To Udaan</a></p></td></tr>"
if retrieveremark<>""  then
response.write "<tr bgcolor='BD402C'><td colspan=11 align='left'><p class='dynamictext1'>Remark From Agent: "&retrieveremark&"</p></td></tr>"
end if
response.write "<tr bgcolor='BD402C'><td colspan=5 ><p class='dynamictext1'>Status: " 
Call WriteIDDescription("Status",rs("statusID"))
REsponse.write " </p><td colspan=4 ><p class='dynamictext1'>REM: "&ucase(rs("remarks"))&"</p></td></tr>"
if trim(rs("refferer"))<>"" or trim(rs("companyname"))<>"" then
response.write "<tr bgcolor='BD402C'><td colspan=5 ><p class='dynamictext1'>Referer: " 
response.write rs("refferer")
REsponse.write " </p><td colspan=4 > <p class='dynamictext1'>Company / File No.: "&ucase(rs("companyname"))&"</p></td></tr>"
end if
response.write "<tr bgcolor='BD402C'><td height=10 colspan=11>"


%> 
        <table border=0 width=100%>
          <tr>
            <td colspan=2 align="center"><p class="updatelinks">History Of the Events</p></td>
          </tr>
          <tr>
            <td><p class='updatelinks'>Action</p></td>
            <td><p class='updatelinks'>Date</p></td>
            <td><p class='updatelinks'>Remarks</p></td>
            <td><p class='updatelinks'>Updated By</p></td>
          </tr>
          <%
stmtHistory = "select StatusHistory.statusID,StatusHistory.date,StatusHistory.updatedby,StatusHistory.Remarks from StatusHistory where StatusHistory.paxid="&cdbl(paxid)&" and StatusHistory.countryID="&cint(rs("countryID")) & " Order by Date desc"

rsHistory.open stmtHistory,con,2,3
While not rsHistory.Eof
response.write "<tr><td><p class='dynamictext1'>"
call WriteIDDEscription("status",rsHistory("statusID"))
response.write "</p></td><td><p class='dynamictext1'>"& FormatDateTime(rsHistory("Date"),1)&" at "&formatdatetime(rsHistory("Date"),3)&"</p></td><td><p class='dynamictext1'>"& ucase(rsHistory("Remarks"))&"</p></td><td><p class='dynamictext1'>"& ucase(rsHistory("Updatedby"))&"</p></td></tr>"

rsHistory.movenext
Wend
rsHistory.close()

response.write "</table></td></tr><tr bgcolor='#FBBD06'><td height=5 colspan=11 bgcolor='#FBBD06'></td></tr>"
rs.movenext
wend
end if
rs.close()

%> 
        </table>
      </table>
    </div>
  </td>
</tr>
</table>
<div align="center"> </div>
<tr> 
  <td>
    <div align="center"><!-- #include file="homeBottom.asp" --></div>
  </td>
</tr>
<div align="center"> </div>
</body>
</html>
