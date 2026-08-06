<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td>
                <%
      agentID=request("jn")
       %> 
                
<% if session("priv")="adm" then %> 
              
<!-- #include file="topadmin.asp" -->           
      <%
elseif session("priv")="emp" then
%>
<!-- #include file="top.asp" --> 
<% 
elseif session("priv")="agt" then
%>
<!-- #include file="topAgent.asp" -->
<% end if %>


<%
              
              if request("flag")="1" then
              response.write " <P align=center><span class='WSRightBold'>PASSWORD CHANGED SUCCESSFULLY.</span> </P>"
              elseif request("flag")="2" then
              response.write "<P align=center><span class='WSRightBold'> PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD.</span> </P> "
              elseif request("flag")="3" then
              response.write " <P align=center><span class='WSRightBold'>PLEASE CHECK USERNAME OR PASSWORD.</span> </P> "
              end if
              %>
<br><br><br>
</td>
              </tr>
              <tr>
                <td></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
   <tr>
                <td><!-- #include file="homeBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
