<%
Set myconn=server.CreateObject ("ADODB.Connection")
myconn.open "driver={SQL server};Server=65.57.230.105;uid=udaanindia;pwd=uda3000;database=udaanindia"
'myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=NETDB"

mydate=date()-300
response.write(mydate&"<br><br>")
set rs = myconn.Execute ("select distinct(refno) from paxstatus where statusid='601' and sentdate<'"&cdate(mydate)&"' order by refno desc")
set rs1=server.createobject("ADODB.RecordSet")

if rs.eof then
response.write("No data")
else

while not rs.eof

refno=rs("refno")
rs1.open "select distinct(paxid) from entrydetails where refno="&refno&"", myconn,2,3

if not rs1.eof then
while not rs1.eof
myconn.execute("delete from statushistory where paxid='"&rs1("paxid")&"'")
rs1.movenext
wend
end if

rs1.close

myconn.execute("delete from mainentry where refno='"&refno&"'")
myconn.execute("delete from entrydetails where refno='"&refno&"'")
myconn.execute("delete from paxstatus where refno='"&refno&"'")

Response.write(rs("refno")&" Deleted<BR>")

rs.movenext
wend

end if

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF">
</body>
</html>
