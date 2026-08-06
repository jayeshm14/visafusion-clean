<%
response.buffer= true

if session("priv")="" or session("agentid") = "" then
response.clear
response.redirect "default.asp?rsn=usb"
end if
Chatid=session("uname")
if Chatid<>"" then
Chatid=replace(Chatid,"&","*")
Chatid=ucase(Chatid)
End if 

%>
<script language="javascript" src="includes/javascript.js" type="text/javascript">
</script>
<script language="javascript" src="includes/mm_menu.js">
</script>
<script language="javascript" src="includes/menus_def.js">
</script>
<script language="javascript" src="includes/winopen.js">
</script>
</HEAD>
<LINK href="includes/stylesheet.css" type=text/css rel=stylesheet>
<BODY background="" onLoad="MM_preloadImages('images/toplink_aboutus_over.gif','images/toplink_services_over.gif','images/toplink_visa_over.gif','images/toplink_updates_over.gif','images/toplink_faqs_over.gif','images/toplink_contact_over.gif')">
<SCRIPT language=JavaScript1.1>mmLoadMenus("");</SCRIPT>
<table width=780 border=0 align=center cellpadding=0 cellspacing=0>
  <tbody> 
	 <tr>
    <td height="23"><img src="images/trans.gif" width="1" height="23"></td>
  </tr>
  <tr> 
    <td valign=top align=center width=780 height=133><embed src="swf/banner.swf" width="746" height="133" quality="high"  bgcolor="#A21D0E">
      </embed></td>
  </tr>
  <tr> 
    <td valign=bottom align=center width=780 height=32> 
      <table width="774" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="75" align="right"><img src="images/toplink_left.gif" width="66" height="32"></td>
		  <td width="56" background="images/toplink_bg.gif"><a href="default.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','images/toplink_home_over.gif',1)"><img src="images/toplink_home.gif" alt="Home" name="Image19" width="56" height="32" border="0"></a></td>
          <td width="20" align="center" background="images/toplink_bg.gif"><img src="images/toplink_dots.gif" width="15" height="32"></td>
          <td width="84" background="images/toplink_bg.gif"><a href="#" onMouseOut="MM_swapImgRestore(); MM_startTimeout(); this.style.background = ''" onMouseOver="MM_swapImage('Image12','','images/toplink_aboutus_over.gif',1); MM_showMenu(window.mm_menu_service,0,40,null,'bt3');" name=bt3><img src="images/toplink_aboutus.gif" name="Image12" width="84" height="32" border="0"></a></td>
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
          <td width="68"><img src="images/toplink_right.gif" width="68" height="32"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td valign=bottom align=left width=780 height=6><img height=5 
      src="images/bar_red.gif" width=746></td>
  </tr>
  <tr> <% 
if request("jn") <> "" then
	agentID = request("jn")
else
agentID = session("agentid")
end if
 %>
    <td height=26 align=center background="images/top_navigation_band_.gif"> 
      <p class="toplinkadmin"><a href="Agent.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn=<%=agentID%>&ses=k3456l7dj9javyemsn&company=udaan" class="toplinkadmin"> 
        Visa Tracking </a> | <a href="holidaylist.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" class="toplinkadmin">Holidays </a> 
|<a href="visa.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>" class="toplinkadmin"> 
              Visa Information </a> &nbsp;
| <a href="forms.asp?agentusb=yesuma&amp;logon=Y&amp;anp=34&amp;cd=2345&amp;seckey=xyz25g78md20422npr054416panftphjkslsktls&amp;ses=k3456l7dj9javyemsn&amp;company=udaan&amp;jn=<%=agentID%>" class="toplinkadmin"> 
              Visa Forms</a> 
 | <a href="changepasswordforagent.asp?uname=<%=session("uname")%>&&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" class="toplinkadmin">Change 
              Password</a>&nbsp;
| <a href="editbyagent.asp?uname=<%=session("uname")%>&&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" class="toplinkadmin">Edit 
        Info </a> | <a href="javascript:;" onClick="window.print()" class="toplinkadmin">Print</a> 
        | <a href="agent_letter_format.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" class="toplinkadmin">Letter Formats</a> 
		| <a href="logout.asp?logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" class="toplinkadmin">Logout</a> 
       </p>
    </td>
  </tr>
  </tbody> 
</table>
</body>
</html>