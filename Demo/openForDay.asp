
<%
today=date()
set rs=server.createobject("adodb.recordset")
if request("new")<>"" then
delquery="delete from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)
set rs1=server.createobject("adodb.recordset")
rs1.open delquery,con,2,3
end if


query1="select * from security where  Day(date1)="&day(today)&" and month(date1)="&month(today)&" and year(date1)="&year(today)
rs.open query1,con,2,3
if rs.eof then
rs.addnew
rs("date1")=date()
rs("openingtime")=time()
rs("openby")=session("uname")
rs.update
'response.write "<P ALIGN=CENTER><span class='WSRightBold'>HAVE A NICE DAY</span></p>"
response.clear
myurl= "securityhome.asp?flag="
response.redirect(myurl)
Else
response.write "<P ALIGN=CENTER><span class='WSRightBold'>THE APPLICATION IS ALREADY OPENED FOR THE DAY  BY "& UCASE(rs("openby")) &". <BR>HAVE A NICE DAY</span></P>"

response.write "<P ALIGN=CENTER><span class='WSRightBold'><a href='open.asp?new=yes'>click here for open any way</a>.</span></p>"
End if
%>