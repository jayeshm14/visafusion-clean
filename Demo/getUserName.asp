<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>
              <font size="3" color="#CC0000">EDIT USER INFORMATION :</font></b>
<form action="edituser.asp" method="post"><table width="30%" border="0">
  <tr>
    <td><u><b><font size="4"><font size="3" color="#CC0000" >USERNAME</font>:</font></b></u></font></td>
    <td><font color="#DC890C">
      <select size=1 name="username" >
                      <%

set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
rs.open "select username from udaan_users order by username",con,2,3
while not rs.eof
response.write("<option value='"&rs("username")&"' >")
response.write ucase(rs("username"))
response.write("</option>")
rs.movenext
wend
rs.close
%> 
                    </select>
      
      
      </font></td>
  </tr>
  <tr>
  
    <td><font color="#DC890C"><b><u><i>&nbsp; </i></u></b></font></td>
    <td align="right"><font color="#DC890C">
      <input type="submit" name="submit" value="GO">
      </font></td>
  </tr>
</table></form>
                
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
