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
<script language="javascript">
function checkAll()
{
a=document.userform.username.value
ulen=a.length
//alert("value & len:"+a+ulen)
if (ulen==0)
{
alert("USER NAME IS REQUIRED")
return false
}
}
</script>
<script  language="javascript">
function checkpassword()
{

var1=document.agentform.pass1.value
var2=document.agentform.pass2.value
var3=document.agentform.pass3.value
len1=var1.length
len2=var2.length
len3=var3.length
if (len1==0 || len2==0 ||len3==0) 
{
alert("PASSWORD CAN NOT BE ZERO LENTH.")
return false
}
if (var2!=var3)
{
alert("PASSWORD AND CONFIRM PAASWORD MUST BE SAME.")
return false
}

}



</script>
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
      <td align=left valign=top background="images/bigtablebg.gif" height="256"> 
        <table width="650" border="0" align="center" bgcolor="BD402C">
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table width="450" align="center" cellpadding="0" cellspacing="0" bgcolor="#008432">
                <tr> 
                  <td height="21" background="images/yellowbgband.gif" align="center"> 
                    <p class="lbltext"> CHANGE PASSWORD</p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td height="2"> 
              <div align="center"></div>
            </td>
          </tr>
          <tr> 
            <td> 
              <form action="newpasswordforagent.asp"  method=post name="agentform"  onSubmit="return checkpassword()">
                <div align="center"> 
                  <table align=center bgcolor="" 
border=0  cellpadding=1 cellspacing=1 width=450 id=TABLE1>
                    <tr> 
                      <td colspan="2"><%
              
              if request("flag")="1" then
              response.write " <p align='center' class='updatetext'><strong>PASSWORD CHANGED SUCCESSFULLY.</strong> </P>"
              elseif request("flag")="2" then
              response.write "<p align='center' class='updatetext'><strong> PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD.</strong> </P> "
              elseif request("flag")="3" then
              response.write " <p align='center' class='updatetext'><strong>PLEASE CHECK USERNAME OR PASSWORD.</strong> </P> "
              end if
              %></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td> 
                        <p class="updatetext"><strong>USERNAME</strong></p>
                      </td>
                      <td> 
                        <p class="updatetext"><strong><%= UCASE(request("uname"))%> 
                          </strong></p>
                        <input type="hidden" name="username" value="<%= request("uname")%>" onSubmit="return checkAll()">
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <p class="updatetext"><strong>OLDPASSWORD</strong></p>
                      </td>
                      <td> 
                        <input  name=pass1 type=Password class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <p class="updatetext"><strong>NEWPASSWORD</strong></p>
                      </td>
                      <td> 
                        <input  name=pass2 type=Password class=inputbox>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <p class="updatetext"><strong>CONFIRM PASSWORD</strong></p>
                      </td>
                      <td> 
                        <input  name=pass3 type=Password class=inputbox>
                      </td>
                    </tr>
                    <input type="hidden" name="seckey" value="xyz25g78M20422npr054416panftpRhjkslsktlsh456">
                    <input type="hidden" name="logonid" value="o9g67435jdpXZ">
                    <input type="hidden" name="jn" value="<%=agentID%>" >
                    <td align=right height="2"> </td>
                    <td text="red" height="2"> 
                      <input name=submit1 type=submit value=Submit class="ud">
                      <input id=reset1 name=reset1 type=reset value=Reset class="ud">
                    </td>
                    </tr>
                  </table>
                </div>
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
