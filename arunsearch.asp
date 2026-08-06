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

%>


<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>New Page 1</title>
</head>

<body>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
 <form method="POST" action="arunsearch1.asp">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="69">
  <tr>
    <td width="50%" height="37">Select The Status</td>
    <td width="50%" height="37">
        
      <select size="1" name="D1">
      <%
      dim rs1
      set rs1=con.execute("select statusID,Description from status order by statusID")
      while not rs1.eof %>
      <option value="<% response.write(rs1(0)) %>"><% response.write(rs1(1)) %></option>
	<%
	rs1.movenext
      wend
      %>
      </select></p>
  
    </td>
  </tr>
  <tr>
    <td width="100%" height="31" colspan="2">    
      <p align="center">    
      <input type="submit" value="Enter" name="B1"></p>
      </p>
 
    <p align="center">&nbsp;</td>
  </tr>
</table>
</form>
</body>

</html>