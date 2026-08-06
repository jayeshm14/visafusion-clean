<!-- #include file="connection.asp" -->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="white">
<table width="452" border="1" align="center" bordercolor="#0000FF">
  <tr> 
    <td> 
      <form method="post">
        <div align="center"> 
          <input type="text" name="email">
          <input type="submit" name="Submit" value="Khojo">
        </div>
      </form>
    </td>
  </tr>
  <%
if request("email")<>"" then
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where  emailid like '%"&request("email")&"%'" 
rs.open stmt,con
if not rs.eof then
while not rs.eof
response.write"<tr><td><FONT COLOR='RED'>"&RS("description")&"</FONT>--->>"&RS("EMAILID")&"</td></tr>"
rs.movenext
wend
else
response.write("<tr><td>NAHI HAI YAAR</td></tr>")
end if
rs.close
end if
%> 
</table>
</body>
</html>
