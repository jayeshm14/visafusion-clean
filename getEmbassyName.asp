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
                <b><font color="#DC890C">EDIT EMBASSY INFORMATION :</font></b>
<form action="editembassy.asp" method="post"><table width="30%" border="0">
  <tr>
    <td><font color="#DC890C"><u><b><font size="4"><font size="3">COUNTRY NAME</font>:</font></b></u></font></td>
    <td><font color="#DC890C">
      
      <select size=1  name="country" >
                     <%
                                             Call LoadListBox("Embassy",embassyID)
                                             %>
                    </select>
      </font></td>
  </tr>
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
