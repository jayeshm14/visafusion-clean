<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="Styles.css">
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
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
                <b><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>EDIT AGENT INFORMATION :</font></b>

<form name="searchform" action="agenttestsubmit.asp">

<table width="30%" border="0">
 <table border=0 align="center"> <tr>
    <td><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'><u><b><font size="4"><font size="3">AGENT NAME</font>:</font></b></u></font></td>
    <td><font color="#DC890C">
            
              <select size=1  name="agent" >
                     <%
                                             Call LoadListBox("agents",agentID)
                                             %>
                    </select>
                    
      </font></td>
  </tr>
  <tr >     <td align="right" colspan=2>&nbsp;</td></tr>
   <tr bgcolor="#FFE898"> 
    <td align="right" colspan=2><font color="#DC890C">
      <input type="submit"  class="ud" name="submit" value="Edit" >
      <input type="submit"  class="ud"  name="submit" value="Add" >
      <input type="submit"  class="ud" name="submit" value="View Status">
      <input type="submit"  class="ud" name="submit" value="E-mail Status">
      <input type="submit"  class="ud" name="submit" value="Statement">
      <input type="submit"  class="ud" name="submit" value="Payments">
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
  </tr><tr>
                <td></td>
          
    </tr>
</table>
</body>
</html>
