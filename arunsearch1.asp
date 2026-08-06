<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
'dim status1
'status1=request.form("D1")
dim rs
set rs=con.execute("select refno,paxname,passportno,b.description as Agent,internalremark,receivedate from mainentry a,agents b where a.agent=b.agentsID and status in(401,402,403,404,405,406,407,408,409,410,411) order by receivedate")
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Reference No</title>
</head>

<body>

<table border="1" width="100%">
<tr>
<%for each x in rs.Fields
    response.write("<th>" & x.name & "</th>")
next%>
</tr>
<%do until rs.EOF%>
    <tr>
    <%for each x in rs.Fields%>
       <td><%Response.Write(x.value)%>&nbsp;</td>
    <%next
    rs.MoveNext%>
    </tr>
<%loop
rs.close
con.close
%>
</table>

</body>

</html>