<%@ Language=VBScript %>
<%
response.buffer= true
%>
<!-- #include file="connection.asp" -->
<%
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>

<html>
<head>
<title>UdaanIndia.com</title>
<link rel="stylesheet" href="Styles.css">
</head>
<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  
           <tr><td>&nbsp;</td></tr>
         
              <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">Country that you are handling</span></div>
          </td>
        </tr>
<TR><td>&nbsp;</td></tr>
      <tr> 
          <td height="19"> 
          </td>
        </tr>
  <table width="64%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
    <tr> 
      <td height="2"> 
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td><img src="images/linetop.jpg" width="675" height="13"></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                 
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
<td width="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>B</b></font></td>
                              
                                </tr>
<%                          
 mydate=date()-3
 mydate=Cdate(mydate)
 today=date() 

set rsu=server.createobject("adodb.recordset")
stmtu="select * from udaan_users where username='"&lcase(trim(session("uname")))&"'"
'response.write stmtu
rsu.open stmtu,con,2,3
if rsu.eof or rsu("country") = "" then
Response.write("You have not select any Country")
else

set rs=server.createobject("adodb.recordset")
countryID= rsu("country")
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID in("&countryID&") and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxstatus.countryID, mainentry.refno"
'response.write stmt

rs.open stmt,con
if rs.eof then 
response.write "<tr><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))

coldate=SysToUsrDate(rs.fields("coldate"))


check=rs.fields("colcheck")

if check="chk" and coldate<>"" then
coldate="CHK - "&coldate
end if

response.write "<tr><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='editentry.asp?refno="&refno&"'>"
call writeIDDescription("agents",agent)
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"

if rs.fields("countryID")="" then
call writeIDDescription("embassy",0)
else 
response.write "<a href='collectionFormPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
response.write "</a>"
end if

response.write "</td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font>&nbsp;</td><td><font face='arial' size=2 color='#000000'>"

if coldate <> "" then
response.write coldate
else
response.write "&nbsp;"
response.write"</font></td>"
end if
response.write"<td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td>"

response.write"<td><font face='arial' size=2 color='#000000'>"
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"<a href='refnototaldetailsub.asp?refno="&refno&"'> "
end if
response.write rs.fields("bill")&"</font>"
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"</a>"
end if
response.write"</td></tr>"

response.write "<tr><td height=2 colspan=11></td></tr>"
rs.movenext
wend
end if
rs.close()
end if
%> 
 </table>
