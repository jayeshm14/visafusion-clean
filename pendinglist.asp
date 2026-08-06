<!-- #include file="connection.asp" -->
<%

today=date() 


stmt="select paxstatus.refno,entrydetails.paxname,agents.description,paxstatus.subdate, embassy.description,mainentry.externalremark from paxstatus,entrydetails,embassy,agents,mainentry where paxstatus.statusid>400 and paxstatus.statusid<410 and paxstatus.refno=entrydetails.refno and paxstatus.paxid=entrydetails.paxid and paxstatus.refno=mainentry.refno and mainentry.agent=agents.agentsid and embassy.embassyid=paxstatus.countryid order by paxstatus.countryid"

'response.write stmt
set rs=server.createobject("adodb.recordset")
rs.open stmt,con,3,3

%>
<html>
<head>
<title>www.udaanindia.com</title>
</head>
<body>
<table width="700" border="1" align="center">
  <tr bgcolor="#CCCCFF"> 
    <td width="25"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Ref 
      #</font></b></font></td>
        <td width="90"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">PAX 
      Name</font></b></font></td>
        <td width="100"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Agent 
      Name</font></b></font></td>
    <td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Country</font></b></font></td>
        <td width="40"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Sub. Date 
      </font></b></font></td>
  </tr>
  <%                            
if rs.eof then %> 
  <tr bgcolor="#F0F0FF"> 
    <td colspan=12 align=center><font face="arial" size=2 color="#ff0000">NO PENDINGS FOUND</font></td>
  </tr>
  <%
else
while not rs.eof
refno=rs(0)  
Remark=ucase(rs(5))
agent=rs(2)
paxname=rs(1)
subdate=rs(3)
country=rs(4)

if  subdate <> "" then
subdate=day(subdate)&"/"&Month(subdate)&"/"&year(subdate)
End if


%> 
  <tr bgcolor="#F0F0FF" valign="top"> 
    <td width="25"><font face="arial" size="2" color="#000000"><%=refno%></font></td>
    <td width="90"><font size="2" color="#000000"><%=paxname %> </font></td>
    <td width="100"><font size="2" color="#000000"><%=agent%> </font></td>
    <td colspan="2"><font size="2" color="#000000"><%=country%> &nbsp;</font></td>
    <td width="40"><font size="2" color="#000000"><%=subdate%> &nbsp; </font></td>
  </tr>
  <% if Remark<>""  then %> 
  <tr bgcolor="#F0F0FF" valign="top"> 
    <td colspan=13 align="left"><font size=2 face="arial" color="#0000CC"><b><font color="#000000">Remark 
      :</font></B> </font><font size="2" face="arial" color="#000000"><%=Remark%></font></td>
  </tr>
  <% end if %>
  <tr bgcolor="#F0F0FF"> 
    <td height=5 colspan=13 bgcolor="#A0A0A0"></td>
  </tr>
  <%
rs.movenext
wend
 end if
%> <%
rs.close()
%> 
</table>
</body>
</html>

