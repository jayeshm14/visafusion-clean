<html>
<body>
<%
set con=server.CreateObject("adodb.connection") 
con.open "filedsn=pan.dsn"
set rs=server.CreateObject("adodb.recordset") 
stmt="select * from agent where agentname="& request("name")
rs.Open stmt,con,2,3
while not rs.EOF   

Response.Write(rs("agentname")&"<br>")
Response.Write(rs("city")&"<br>")
Response.Write(rs(0)&"<br>")
Response.Write(rs("address")&"<br>")
rs.MoveNext 

wend
%>