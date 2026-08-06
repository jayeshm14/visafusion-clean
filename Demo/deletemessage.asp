<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% response.buffer=true %>
<html>
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td><table BORDER=2 vALIGN=right BGCOLOR=YELLOW width=80%>
<tr>
<td align="center">

<%

stmt="delete from scheduler where messageid="&cint(request("id"))
con.execute stmt
response.clear
response.redirect "employee.asp?msgid=1&uname="&session("uname")
%>
</td></tr>
<tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table></body>
</html>