<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "default.asp?rsn=usb"
end if
%>
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
    <table width=780 border=0 align=center cellpadding=0 cellspacing=0 height="23">
      <tr> 
        <td align="center" valign=top background="images/bigtablebg.gif" height="2"> 
          <table width="700" border="0" cellpadding="0" cellspacing="0" class="tdborder">
            <tr bgcolor="BD402"> 
              <td height="21" colspan="2">&nbsp;</td>
            </tr>
            <tr> 
              <td height="21" colspan="2" background="images/yellowbgband.gif"> 
                <p class="lbltext">Letter Format </p>
              </td>
            </tr>
            <tr> 
              <td height="20" bgcolor="BD402">&nbsp;</td>
              <td bgcolor="BD402">&nbsp;</td>
            </tr>
            <tr> 
              <td width="398" height="20" bgcolor="BD402"> 
                <p class="dynamictextagent">Sample Authority Letter </p>
              </td>
              <td width="300" bgcolor="BD402"><a href="Sample Letter/Sample - Authority Letter.doc" target="_blank" class="dynamictextagent">Click 
                Here to Download </a></td>
            </tr>
            <tr> 
              <td height="20" bgcolor="BD402"> 
                <p class="dynamictextagent">Sample Business Covering Letter </p>
              </td>
              <td bgcolor="BD402"><a href="Sample Letter/Sample Covering Letter - Business.doc" target="_blank" class="dynamictextagent">Click 
                Here to Download </a></td>
            </tr>
            <tr> 
              <td height="20" bgcolor="BD402"> 
                <p class="dynamictextagent">Sample Tourist Covering Letter </p>
              </td>
              <td bgcolor="BD402"><a href="Sample Letter/Sample Covering Letter - Tourist.doc" target="_blank" class="dynamictextagent">Click 
                Here to Download </a></td>
            </tr>
            <tr> 
              <td height="20" bgcolor="BD402"> 
                <p class="dynamictextagent">Enclosure Sheet </p>
              </td>
              <td bgcolor="BD402"><a href="Sample Letter/Enclosure Sheet.doc" target="_blank" class="dynamictextagent">Click 
                Here to Download </a></td>
            </tr>
            <tr> 
              <td height="20" bgcolor="BD402">&nbsp;</td>
              <td bgcolor="BD402">&nbsp;</td>
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
