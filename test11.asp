 <%@ Language=VBScript %>
<!-- #include file="connection.asp" --> 
<%


set rsquote=server.createobject("adodb.recordset")
today=currentdate
'stmt ="select * from quote where day(date)="&day(today)&" and month(date)="&month(today)&" and year(date)="&year(today)
'stmt ="select * from quote "
stmt ="select * from paxhotel where name LIKE '%"&request("keywords")&"%'  order by name"
rsquote.open stmt,con
if not rsquote.eof then
while not rsquote.eof
response.write rsquote("name")&"<br>"
rsquote.movenext
wend
else
response.write "nahimila"
end if
rsquote.close()

%>