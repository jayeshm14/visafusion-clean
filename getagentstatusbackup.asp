<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>

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
                   
                
                <b><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>SELECT AGENT NAME:</font></b>
<form name="searchform" action="todayAgentStatus.asp" method="post"><table width="30%" border="0">
 <table border=1> <tr>
    <td><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'><b>AGENT NAME</font>:</font></b></u></font></td>
    <td><font color="#DC890C">
            
              <select size=1  name="agent" >
                     <%
                                             Call LoadListBox("agents",agentID)
                                             %>
                    </select>
                    
      </font></td>
  </tr>
  <tr>
    <td><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>Today's AWB Number</font>:</font></b></u></font></td>
    
    <td><font color="#DC890C">
            
              <input type="text" name="awb" size=15>
                    
      </font></td>
  </tr>
    <td> <input type="submit" name="submit" value="Daily Status"></td>
    <td align="right"><font color="#DC890C">
     <input type="submit" name="submit" value="Email Status">
    
   
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
