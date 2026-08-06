<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >

</form>
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
              <form method="post" action="viewVisaInfo.asp" name="queries">
              <table width="75%" >
              <tr> 
              
                <td colspan=6 ALIGN="center">
                GET VISA INFPRMATION FOR INDIAN NATIONS</TD></TR>
                 <tr> 
              
                <td colspan=4 align="center"> 
                  COUNTRY</td> <td colspan=4 align=="center">CATEGORY
                  
                </td></tr>
                <tr> 
              
                <td colspan=4 align="center"> <select size=1 name="countrylist">
                                              <%
                                             Call LoadListBox("Embassy",0)
                                             %>
                                            </select>
                  </td>
                   <td colspan=4 align=="center"><select name="category" size="1">
                                              <%
                                             Call LoadListBox("Category",4)
                                             %>
                                              </select>
                  
                </td></tr>
                <TR><td colspan=4 align="center"> 
                  &nbsp;</td><td colspan=4 align="center"> 
                  &nbsp;</td></tr>
                  <tr> 
              
                
                  <td colspan=6 ALIGN="center">
 </TD></tr>
                


                
                 
                                <tr> 
              
                <td colspan=4 align="center"> 
                  &nbsp;</td> <td colspan=4 align=="center">
                  <input type="hidden" name="flag" value="first">
                  <input type="submit" value="GET RESULT">
                  </form>
                </td></tr>
                <tr><td colspan=6>
                </td></tr>
                </table>
                
                
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
<p>&nbsp;</p>
</body>
</html>
