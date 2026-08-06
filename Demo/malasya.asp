<!-- #include file="connection.asp" -->
<%

set rs=server.createobject("adodb.recordset")
stmt="select entrydetails.paxname, entrydetails.passportno from entrydetails, paxstatus where paxstatus.statusid='101' and countryid='61' and entrydetails.refno=paxstatus.refno"
rs.open stmt,con,3,3

uma=1
while not rs.eof

response.write(uma&".&nbsp;&nbsp;"&rs("paxname")&" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"&rs("passportno")&"<br>")
uma=uma+1
rs.movenext
wend

%>
