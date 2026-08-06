<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% if request("agentusb")="yesuma" then
%>
<!-- #include file="topagent.asp" -->           
<% else 
if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
end if
%>
<% if request("agentusb")="yesuma" then %>
<form method="post" action="getCountryInfo.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" name="queries"> 
<% else %>
</form><form method="post" action="CountryInfoSubmit.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" name="queries"> 
<% end if %>
<% if request("agentusb")="yesuma" then %>
<input type="hidden" name="agentusb" value="yesuma">
<% end if %>
<div align="center"><table width="69%" border="0" height="82"></div>
	<tr>
  <td height="86"> 
      <div align="center"><FONT color=red face="verdana" size="2"><b>Country Information</b></font></div>
    </td>
  </tr>
</table>
<table width="90%" align="center">
<%
country=request("country")

   if country<>"" then
            	response.write " <span class='WSRightBold'>INFORMATION FOR "
                call writeIDDescription("embassy",country)
                 response.write " UPDATED SUCCESSFULLY1.</span>"
    end if
        %>
     
  <tr> 
    <td colspan=2 >&nbsp;</td>
  </tr>
  <tr> 
    <td  align="center" valign="top" colspan="2"> 
      <table width="115%" border="0" cellspacing="1" cellpadding="1">
         
          <tr> 
            <td width="43%" valign="top" align="center" colspan="2"><FONT color=red face="verdana" size="2"><b>COUNTRY:</font></b> 
              <select size=1 name="countrylist">
                <%
                                             Call LoadListBox("Embassy",0)
                                             %> 
              </select>
              </span></td>
          </tr>
          <tr>
            <td width="43%" valign="bottom">&nbsp;</td>
            <td width="57%" valign="bottom">&nbsp;</td>
          </tr>
          <tr> 
          
            <td width="43%" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <% if session("priv")="adm" then
%> 
              <div align="right"> 
                <input type="submit" name="submit2" value="Add / Edit" class="ud">
                <%
end if
%>
 </div>
            </td>
            <td width="57%" valign="bottom"> 
              <input type="submit" name="submit" value="Get Information" class="ud">
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
    <td  align="center" valign="top"> 
      <div align="right"></div>
    </td>
    <td  align=="center" valign="top">&nbsp; </td>
  </tr>
  
</table>
</form>