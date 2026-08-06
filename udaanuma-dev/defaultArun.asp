<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>Udaan India:: Visa! Come Get It</TITLE>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="Udaan India Pvt Ltd." name=title>
<META content="Copyright 2006 - Udaan India Pvt Ltd." 
name=copyright>
<script Language="JavaScript">
    message     = "Welcome to Udaan India Private Limited : Visa! Come Get It^" +
                "http://www.udaanindia.com^" + 
                 "^"
  scrollSpeed = 25
  lineDelay   = 1500
  txt         = ""

  function scrollText(pos) {
    if (message.charAt(pos) != '^') {
      txt    = txt + message.charAt(pos)
      status = txt
      pauze  = scrollSpeed
    }
    else {
      pauze = lineDelay
      txt   = ""
      if (pos == message.length-1) pos = -1
    }
    pos++
    setTimeout("scrollText('"+pos+"')",pauze)
  }
scrollText(0)
  </SCRIPT> 
<script language="javascript" src="includes/winopen.js" type="text/javascript">
</script>
<script language="javascript">
<!--

function validateform()
{
	user = document.userform.username.value
	pass = document.userform.pass.value
	if (user.length == 0)
	{
		alert("Please enter user name.")
		document.userform.username.focus();
		return false;
	}
	if (pass.length == 0)
	{
		alert("Please enter password.")
		document.userform.pass.focus();
		return false;
	}
}

function cele1()
{
if (!document.country.countrylist[0].selected)
{
parent.window.location.href="visa.asp?anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&developer=usbhardwaj&countryid="+document.country.countrylist.value;
}
}
//-->
</script>
<script language="javascript" src="includes/javascript.js" type="text/javascript">
</script>
<script language="javascript" src="includes/mm_menu.js">
</script>
<script language="javascript" src="includes/menus_def.js">
</script>
</HEAD>
<LINK href="includes/stylesheet.css" type=text/css rel=stylesheet>
<BODY background="" onLoad="MM_preloadImages('images/toplink_services_over.gif','images/toplink_visa_over.gif','images/toplink_updates_over.gif','images/toplink_faqs_over.gif','images/toplink_contact_over.gif')<% if request("rsn") <> "" then %>,ErrMsg('ErrMsg.asp?rsn=<%=request("rsn")%>')<% end if %><% if request("Refno") <> "" then %>,refcheck('refcheck.asp?refno=<%=request("Refno")%>')<% end if %>">
<SCRIPT language=JavaScript1.1>mmLoadMenus("");</SCRIPT> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="23">&nbsp;</td>
  </tr>
  <tr>
    <td height="644" align="center"> 
      <TABLE width=772 border=0 align=center cellPadding=0 cellSpacing=0>
        <TBODY> 
        <TR>
          <TD vAlign=top align=center width=772 height=136><embed src="swf/backup%20banners/banner.swf" width="746" height="133" quality="high"  bgcolor="#A21D0E" align="middle">
            </embed></TD>
        </TR>
        <TR>
          <TD vAlign=bottom align=center width=772 height=2> 
            <table width="774" height="32" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="75" align="right"><img src="images/toplink_left.gif" width="66" height="32"></td>
                <td width="56" background="images/toplink_bg.gif"><img src="images/toplink_home_over.gif" width="56" height="32"></td>
                <td width="20" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
                <td width="84" background="images/toplink_bg.gif"><a href="#" onMouseOut="MM_swapImgRestore(); MM_startTimeout(); this.style.background = '';" onMouseOver="MM_swapImage('Image12','','images/toplink_aboutus_over.gif',1); MM_showMenu(window.mm_menu_service,0,40,null,'bt3');" name=bt3><img src="images/toplink_aboutus.gif" name="Image12" width="84" height="32" border="0"></a></td>
                <td width="18" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
              <td width="73" background="images/toplink_bg.gif"><a href="services.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','images/toplink_services_over.gif',1)"><img src="images/toplink_services.gif" name="Image13" width="73" height="32" border="0"></a></td>
              <td width="21" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
              <td width="78" background="images/toplink_bg.gif"><a href="visa_default.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','images/toplink_visa_over.gif',1)"><img src="images/toplink_visa.gif" name="Image14" width="78" height="32" border="0"></a></td>
              <td width="20" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
              <td width="69" background="images/toplink_bg.gif"><a href="updates.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','images/toplink_updates_over.gif',1)"><img src="images/toplink_updates.gif" name="Image15" width="69" height="32" border="0"></a></td>
              <td width="20" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
              <td width="49" background="images/toplink_bg.gif"><a href="faqs.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','images/toplink_faqs_over.gif',1)"><img src="images/toplink_faqs.gif" name="Image16" width="49" height="32" border="0"></a></td>
              <td width="21" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
              <td width="96" background="images/toplink_bg.gif"><a href="contactus.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image17','','images/toplink_contact_over.gif',1)"><img src="images/toplink_contact.gif" name="Image17" width="96" height="32" border="0"></a></td>
                <td width="68"><img src="images/toplink_right.gif" width="66" height="32"></td>
              </tr>
          </table></TD>
        </TR>
        <TR>
          <TD vAlign=bottom align=left width=772 height=6><IMG height=5 
      src="images/bar_red.gif" width=772></TD>
        </TR>
        <TR>
          <TD height=26 align=left vAlign=bottom background="images/top_navigation_band_.gif" width="772">&nbsp;</TD>
        </TR>
        <TR>
          <TD align=left vAlign=top background="images/bigtablebg.gif" height="218" width="772"> 
            <table width="743" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="2" height="2" align="center"><%
					  holidaylist= MonthlyHolidayList(date())
                      session("uname")=""
                      msgid=REQUEST("rsn") 
                      message= ""
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
                      %> <br>
                  <p class="heading1" align="left"> <% if message = "" then %> 
                    <marquee width=100%>Holiday List for next 30 days: <%=holidaylist%></marquee> 
                    <% else %> <%= message %> <% end if %> <br>
                  </p>
                </td>
              </tr>
              <tr> 
                <td width="553" height="267" align="right" valign="top"> 
                  <table width="542" border="0" cellpadding="0" cellspacing="0" class="tdborder" align="right">
                    <tr> 
                      <td height="21" background="images/yellowbgband.gif"> 
                        <p class="lbltext">Mouseover on World Map to view Visa 
                          Info </p>
                      </td>
                    </tr>
                    <tr> 
                      <td height="337" valign="top" bgcolor="BD402C"><embed src="swf/index.swf" width="540" height="339">
                        </embed></td>
                    </tr>
                  </table>
                  <p><br>
                    <!-- <script type="text/javascript" language="JavaScript1.2" src="../updateimg/stm31.js"></script> --></p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p align="center">&nbsp;</p>
                </td>
                <td width="190" valign="top" height="267"> 
                  <table width="49" border="0" align="right" cellpadding="0" cellspacing="0" class="tdborder">
                    <tr> 
                      <td height="21" align="center" background="images/yellowbgband.gif"> 
                        <p class="rbctext">User Login </p>
                      </td>
                    </tr>
                    <tr> 
                      <td height="80" align="left" valign="top" bgcolor="BD402C" class="trail"> 
                        <TABLE width="90%" 
border=0 align="center" cellPadding=4 cellSpacing=0>
                          <TBODY> 
                          <TR> 
                            <FORM action="authenticate.asp" name="userform" onsubmit="return validateform();">
                              <TD class=trail vAlign=top 
                              align=left>Username:<BR>
                                <INPUT class=inputbox 
                              size=10 name=username>
                                <BR>
                                Password:<BR>
                                <INPUT 
                              class=inputbox type=password size=10 
                              name=pass>
                                <input type="hidden" name="countryID" value="<%=request("countryid")%>">
                                <BR>
                                <TABLE cellSpacing=0 cellPadding=0 align=center 
                              border=0>
                                  <TBODY> 
                                  <TR> 
                                    <TD vAlign=center align=middle width=49 
                                height=25> 
                                      <INPUT type=image height=18 
                                alt="Log In" width=47 
                                src="images/button_login.gif" 
                                value=submit name=submit>
                                    </TD>
                                  </TR>
                                  </TBODY> 
                                </TABLE>
                              </TD>
                            </FORM>
                          </TR>
                          </TBODY> 
                        </TABLE>
                      </td>
                    </tr>
                    <tr> 
                      <td height="21" align="center" background="images/yellowbgband.gif"> 
                        <p class="rbctext">Status Check by Ref. No.</p>
                      </td>
                    </tr>
                    <tr> 
                      <td height="100" align="center" valign="middle" bgcolor="BD402C"> 
                        <font face="Verdana" size="1" color="#FFFFCC">Please enter 
                        your ref. no to check the status.</font> 
                        <FORM action="" name="userform" onsubmit="return validateform();">
                          <font face="Verdana" size="1" color="#FFFFCC">Ref No.:</font>
<INPUT class=inputbox size=7 name=Refno>
                          <INPUT type=image height=18 
                                alt="Search  By Ref No." width=48 
                                src="images/bt_search.gif" 
                                value=submit name=submit>
                                   
                                  </FORM>

<!--<embed src="swf/Final%20Composition2.swf" width="180" height="100" wmode="transparent">
                        </embed>--></td>
                    </tr>
                    <tr> 
                      <td height="22" background="images/yellowbgband_middle.gif">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td height="100" bgcolor="BD402C"><embed src="swf/Udaan_holidays.swf" width="180" height="100" wmode="transparent">
                        </embed></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </TD>
        </TR>
        <TR>
          <TD width="772" height="2" align=center vAlign=top background="images/bigtablebg.gif"><img src="images/bar_red.gif" width="744" height="5"></TD>
        </TR>
        <TR>
          <TD align=left vAlign=top background="images/bigtablebg.gif" width="772"> 
            <table width="744" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="477" height="50" align="left" valign="middle" background="images/bottom_bg.gif"> 
                  <p class="imgmargin"><img src="images/partner_logo.gif" width="147" height="39">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="mailto:deepak@udaanindia.com"><font size="2" color="#FFFF00"><b>Register</b></font></a><font color="#FFCC00"><a href="mailto:deepak@udaanindia.com"><font size="2"><b><font color="#FFFF00"> 
                    With Us</font></b></font></a></font></p>
                </td>
                <td width="267" height="50" align="right" background="images/bottom_bg.gif" bordercolor="#993300"> 
                  <form name="country">
                    <table width="230" height="30" border="0" cellpadding="0" cellspacing="0">
                <tr><td height="35" valign="bottom"><p class="trail">&nbsp;</p></td>
                  <td height="35" valign="bottom">
	         <select size=1 name="countrylist" class="dropdown" onChange="cele1()">
				<option>Select a Country</option>
                <%
                     Call LoadListBox("Embassy",0)
                 %> 
              </select>
				</td>
                </tr></table></form></td></tr><tr>
                <td height="27" colspan="2" align="center" background="images/bottom_end.gif"> 
                  <p class="copyright" align="left">Rights Reserved @ Udaan India 
                    Private LTD 2001-2006&nbsp;!!&nbsp; <a href="Disclaimer.asp"><font color="#FFCC33"> 
                    Disclaimer</font></a><a href="mailto:deepak@udaanindia.com"><font color="#FFCC33"> 
                    </font></a></p>
                </td>
            </tr>
          </table></TD></TR></TBODY></TABLE></td></tr>
</table>
</BODY></HTML>