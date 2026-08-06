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
<form method="post" action="visaInfoSubmit.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" name="queries"> 
<% if request("agentusb")="yesuma" then %>
<input type="hidden" name="agentusb" value="yesuma">
<% end if %>

<table width="90%" align="center">
<%
country=cint(request("country"))
category=cint(request("category"))
   if country<>"" and category<> "" then
                response.write " <span class='wsrightbold'>INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write " AND CATEGORY "
                call writeIDDescription("category",category)
                 response.write " UPDATED SUCCESSFULLY.</span>"
                 end if
        %>
     
  <tr> 
    <td colspan=2 ><span class="WSRightBold"> VISA REQUIREMENTS 
      FOR INDIAN NATIONALS FOR</span></td>
  </tr>
  <tr> 
    <td  align="center" valign="top" colspan="2"> 
      <table width="99%" border="0" cellspacing="1" cellpadding="1">
         
          <tr> 
            <td width="43%" valign="top" ><span class="WSRightBold">COUNTRY: 
              <select size=1 name="countrylist">
                <%
                                             Call LoadListBox("Embassy",0)
                                             %> 
              </select>
              </span></td>
            <td width="57%" valign="top"><span class="WSRightBold">CATEGORY: 
              <select name="category" size="1">
                <%
                                             Call LoadListBox("Category",4)
                                             %> 
              </select>
              </span></td>
          </tr>
          <tr>
            <td width="43%" valign="bottom">&nbsp;</td>
            <td width="57%" valign="bottom">&nbsp;</td>
          </tr>
          <tr> 
          
            <td width="43%" valign="bottom">
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