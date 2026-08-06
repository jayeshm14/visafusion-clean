<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<link rel="stylesheet" href="styles.css" type="text/css">
</head>
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td align="center">
                   <% today=date() %>
                <br>
               <span class="tableCaption">Send Agent's AWB No.</span>
<form name="searchform" action="sendawbgo.asp" method="post"><table width="30%" border="0">
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
    <td><span class="WSRightBold">Sent Date</span></td>
    
    <td><font color="red">
            
    <select name="sdate">
    <% for i=0 to 10 %> 
	<% if systousrdate(Cdate(today)-i)=systousrdate(today-1) then %>
	<option value="<%=systousrdate(Cdate(today)-i)%>" selected><%=systousrdate(Cdate(today)-i)%></option>
	<% else %>
    <option value="<%=systousrdate(Cdate(today)-i)%>"><%=systousrdate(cdate(today)-i)%></option>
	<% end if
	next %> 
    </select>
              
                    
      </font></td>
  </tr>
  <tr>
    <td><span class="WSRightBold">Today's AWB Number</span></td>
    
    <td><font color="#DC890C">
            
              <input type="text" name="awb" size=30>
              
                    
      </font></td>
  </tr>
      <tr>
    <td><span class="WSRightBold">Special Remark (Send by ?)</span></td>
    
    <td><font color="#DC890C">
            
  <select name="sremark">
    <option value="PIGEON COURIER" selected>PIGEON COURIER</option>
	<option value="BLUE DART" selected>BLUE DART</option>
	<option value="IC CARGO">IC CARGO</option>
    <option value="JET CARGO">JET CARGO</option>
    <option value="BLAZE FLASH">BLAZE FLASH</option>
  </select>

              
                    
      </font></td>
  </tr>
    <td align="center"> <input type="submit" name="submit" class="ud" value="View AWB"></td>
    <td align="center">
     <input type="submit" name="submit" class="ud" value="Send AWB">
    
   
      </td>
    
   
   </table></table></form></td>
  </tr>
</table>

                </td>
              </tr>
            </table>
          
        
      
    
  
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>

</body>
</html>
