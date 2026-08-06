
<% 
today=date()
set rs5=server.createobject("adodb.recordset")
query1="select * from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)&" and closingtime is null"
response.write "hjh"&query1
rs5.open query1,con,2,3
if not rs5.eof then
rs5("closingtime")=time()
rs5("closedby")=session("uname")
rs5.update
response.write "Closed for the day."
response.write time()
Else
response.write "<P ALIGN=CENTER>THE APPLICATION IS  NOT OPEN.</P>"
End if
%>