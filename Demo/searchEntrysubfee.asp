<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<link rel="stylesheet" href="Styles.css">
</head>
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 
marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" 
align="center" height="310">
  <tr valign="top" align="left"> 
    <td height="21">
<% if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
%></td>
  </tr>
  <tr> 
    <td height="21">&nbsp;</td>
  </tr>
  <tr> 
    <td height="31">
      <table width="75%" align="center" cellpadding="0" 
cellspacing="0">
      
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">SEARCH FEES 
SUBMIT</span></div> 
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="216" ALIGN="CENTER"> 
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/linetopgreen1.gif" width="660" 
height="10"></td>
        </tr>
        <tr bgcolor="#009933"> 
          <td> 
            <table width="100%" border="0" cellspacing="0" 
cellpadding="0">
              <tr> 
                <td align="left" width="1"><img 
src="images/pixelsline.gif" width="1" height="7"></td>
                <td bgcolor="#FFFFFF"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" 
cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr><td>&nbsp;</td></tr>
                   <tr>
                   <td align="center"> 
<form name=country action="searchPaxfee1.asp" method="post">
                    <span class="WSRightBold">Select Country                   
                        <select name="countryID" size="1">
                          <% 
              call loadlistbox("embassy",embassyID)
              %> 
                        </select>
                        <input type="submit" name="Submit" class="ud" 
value="Go">
                    </span>
</form>
                      </td>
                                     
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                         <tr><td>&nbsp;</td></tr>
                    <tr> 
                      <td colspan="3"> 
                        <div align="center"><span class="WebSite"><!-- 
#include file="Adminbottom.asp" --></span> 
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
                <td align="right" width="1"><img 
src="images/pixelsline.gif" width="1" height="7"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="images/linetopgreen2.gif" width="660" 
height="10"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr valign="top" align="left"> 
    <td height="21">&nbsp;</td>
  </tr>
</table>
</body>
</html>