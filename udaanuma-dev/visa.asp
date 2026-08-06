<%@ Language=VBScript %>
<%
if session("priv") = "" then
	response.redirect "default.asp?rsn=usb&countryid="&request("countryid")&""
end if
%>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                
          <td>
          <%
      agentID=request("jn")
       %> 
          <% if session("priv")="adm" then %> <!-- include file="topAdmin.asp"--> 
      <%
elseif session("priv")="emp" then
%>
<!-- include file="top.asp"--> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp"--> <% 
elseif session("priv")="guest" then
%> <% end if %> </td> </tr> 
<tr>
                <td> 
  <table width=780 border=0 align=center cellpadding=0 cellspacing=0 height="247">
    <tr> 
        <td align=left valign=top background="images/bigtablebg.gif" height="149"> 
          <table width="650" border="0" align="center" bgcolor="BD402C">
            <tr> 
              <td>&nbsp;</td>
            </tr>
            <tr> 
              <td> 
                <table width="550" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                  <tr> 
                    <td height="21" background="images/yellowbgband.gif" align="center"> 
                      <p class="lbltext"> PASSPORTS AND VISA REQUIREMENTS</p>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td height="2">&nbsp;</td>
            </tr>
            <tr> 
              <td height="2"> 
                <div align="center">&nbsp;</div>
              </td>
            </tr>
            <tr align="center"> 
              <td> 
                <form method="post" action="visa_post.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" name="queries">
                  <table width="550" border="0" cellspacing="1" cellpadding="1">
                    <tr> 
                      <td width="43%" valign="top" align="center"> 
                        <p class="dynamictextagent"> 
                          <input type="radio" name="countryFor" value="1" checked>
                          FOR INDIAN NATIONALS </p>
                      </td>
                      <td width="57%" valign="top"> 
                        <p class="dynamictextagent"> 
                          <input type="radio" name="countryFor" value="2">
                          FOR SRI LANKAN NATIONALS</p>
                      </td>
                    </tr>
                    <tr> 
                      <td width="43%" valign="top" align="center">&nbsp;</td>
                      <td width="57%" valign="top">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width="43%" valign="top" align="center"> 
                        <p class="dynamictextagent">COUNTRY: 
                          <select size=1 name="countrylist" class="dropdown">
                            <%
                                             Call LoadListBox("Embassy",request("countryid"))
                                             %> 
                          </select>
                        </p>
                      </td>
                      <td width="57%" valign="top"> 
                        <p class="dynamictextagent">CATEGORY: 
                          <select name="category" size="1" class="dropdown">
                            <%
                                             Call LoadListBox("Category",4)
                                             %> 
                          </select>
                        </p>
                      </td>
                    </tr>
                    <tr> 
                      <td width="43%" valign="bottom">&nbsp;</td>
                      <td width="57%" valign="bottom">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="2" valign="bottom" align="center"> 
                        <input type="submit" name="submit" value="Get Information" class="ud">
                        <br>
                        &nbsp; </td>
                    </tr>
                  </table>
                </form>
              </td>
            </tr>
          </table>
    </tr>
  </table>

                
                
                
                
</tr>
<tr>
                <td><!-- #include file="HomeBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
