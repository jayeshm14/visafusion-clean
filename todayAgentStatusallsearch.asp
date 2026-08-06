<!-- #include file="connection.asp" -->
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF">
<table width="452" border="1">
  <tr> 
    <td>
      <form method="post" action="todayagentstatusalltemp.asp">
        <div align="center"><b>Take Agents List (Put first charector in Textbox)</b><br>
          <br>
          <input type="text" name="start" size="8">
          - TO - 
          <input type="text" name="end" size="8">
          <input type="submit" name="Submit" value="GO">
        </div>
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p><table width="452" border="1">
  <tr> 
    <td>
      <form method="post" action="todayagentstatusSentPost.asp">
        <div align="center"><b>Send mail to all agents from sent mail table</b><br>
          <br>
          <select name="date">
            <option value="<%=systousrdate(date())%>" selected><%=systousrdate(date())%></option>
            <% for i=1 to 10 %> 
            <option value="<%=systousrdate(Cdate(date())-i)%>"><%=systousrdate(cdate(date())-i)%></option>
            <% next %> 
          </select>
          <input type="submit" name="Submit" value="GO">
        </div>
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="452" border="1">
  <tr> 
    <td> 
      <form method="post" action="DailySentVisasPost.asp">
        <div align="center"><b>Sent Visas Date wise</b><br>
          <br>
          <select name="date">
            <option value="<%=systousrdate(date())%>" selected><%=systousrdate(date())%></option>
            <% for i=1 to 10 %> 
            <option value="<%=systousrdate(Cdate(date())-i)%>"><%=systousrdate(cdate(date())-i)%></option>
            <% next %> 
          </select>
          <input type="submit" name="Submit" value="GO">
        </div>
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
