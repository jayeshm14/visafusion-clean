<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<link rel="stylesheet" href="styles.css" type="text/css">

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
                <td align="center">
                   
                
               <span class="tableCaption">View Agent Status</span>
<form name="searchform" action="todayAgentStatus.asp" method="post"><table width="30%" border="0">
 <table border=1 align="center"> <tr>
    <td align="center"><span class="WSRightBold">AGENT NAME</span></td>
    <td>
            
              <select size=1  name="agent" >
                     <%
                                             Call LoadListBox("agents",request("agent"))
                                             %>
                    </select>
                    
      </td>
  </tr>
  <tr>
    <td><span class="WSRightBold">Today's AWB Number</span></td>
    
    <td><font color="#DC890C">
            
              <input type="text" name="awb" size=15>
              
                    
      </font></td>
  </tr>
      <tr>
    <td><span class="WSRightBold">Special Remark</span></td>
    
    <td><font color="#DC890C">
            
              <textarea name="sremark" rows="3" cols="30"></textarea>
              
                    
      </font></td>
  </tr>
    <td align="center"> <input type="submit" name="submit" class="ud" value="Daily Status"></td>
    <td align="center">
     <input type="submit" name="submit" class="ud" value="Email Status">
    
   
      </td>
    
   
   </td>
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
