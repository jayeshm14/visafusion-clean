<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Udaan India</title>
<link href="includes/stylesheet.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css">
<!--
body {
	BACKGROUND:  url(contact/contbg.gif) #8d2222 repeat-x; MARGIN-top:0; margin-left:0; margin-bottom:0;
}
-->
</style>

<body background="contact/contbg.jpg" scroll="no">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr  height="100%">
    <td height="20" valign="top" background="images/contbg.jpg">&nbsp;</td>
  </tr>
  <tr  height="100%">
    <td height="100%" valign="top" background="images/contbg.jpg">
      <table width="380" border="0" align="center" cellpadding="0" cellspacing="0" class="tdborder">
        <tr> 
          <td height="22" colspan="2" background="images/yellowbgband_middle.gif">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2" height="30" bgcolor="B21E0D"> 
<%
                      session("uname")=""
                      msgid=REQUEST("rsn") 
                      message=""
                      if msgid="B" then
                      message="Username or Password is not correct. Please try Again"
                      elseif msgid="O" then
                      message="The application is not yet opened by the administrator. Please contact administrator."
                      elseif msgid="C" then
                      message="The application is closed for day. Please contact administrator."
                      elseif msgid="S" then
                      message="Your session is expired. Please Login again."
                       elseif msgid="V" then
                      message="Please relogin Again."
                       elseif msgid="usb" then
                      message="Kindly contact Udaan for your official User Id and Password."
                      
                      End if
                      %><br><br>
                  <p class="heading1"><%= message %></p><br><br>
          </td>
        </tr>
        <tr> 
          <td height="25" colspan="2" align="center" bgcolor="BD402C"><a href="javascript:window.close()" class="toplinkadmin">Close 
            (X) </a></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr  height="100%" background="images/contbg.jpg">
    <td height="40" valign="top">&nbsp;</td>
  </tr>
</table>
</body>
</html>
