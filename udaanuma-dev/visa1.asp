<%@ Language=VBScript %>
<%
if session("priv") = "" then
	response.redirect "default.asp?rsn=usb"
end if
%>
<!-- #include file="connection.asp" -->
<!-- #include file="topagent.asp" -->           
<form method="post" action="getqueries.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>" name="queries"> 
<table width="69%" border="0" height="82">
	<tr>
  <td height="86"> 
        <div align="center"></div>
    </td>
  </tr>
</table>
<table width="90%" align="center">
<%
country=request("country")
category=request("category")

   if country<>"" and category<> "" then
            	response.write " <span class='WSRightBold'>INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write " AND CATEGORY "
                call writeIDDescription("category",category)
                 response.write " UPDATED SUCCESSFULLY1.</span>"
    end if
        %>
     
  <tr> 
    <td colspan=2 >&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 ><div align="center"><FONT color=blue face="verdana" size="2"><b> 
	  <input type="radio" name="countryFor" value="1" checked> FOR INDIAN NATIONALS &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="radio" name="countryFor" value="2"> FOR SRI LANKAN NATIONALS<br>&nbsp;
	</b></font></div></td>
  </tr>
  <tr> 
    <td  align="center" valign="top" colspan="2"> 
      <table width="115%" border="0" cellspacing="1" cellpadding="1">
         
          <tr> 
            <td width="43%" valign="top" align="center"><FONT color=red face="verdana" size="2">COUNTRY:</font> 
              <select size=1 name="countrylist">
                <%
                                             Call LoadListBox("Embassy",0)
                                             %> 
              </select>
              </td>
            <td width="57%" valign="top"><FONT color=red face="verdana" size="2">CATEGORY:</font> 
              <select name="category" size="1">
<% if session("priv")="adm" then %>
<option value="100" >ALL</option>
<% END IF %>

                <%
                                             Call LoadListBox("Category",4)
                                             %> 
              </select>
              </td>
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