<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
</td>
              </tr>
              <tr>
                <td>
                <P align=center><STRONG><FONT color=mediumblue face=Arial size=4>CHANGE PASSWORD</FONT></STRONG></P>
<FORM action="newpasswordforagent.asp"  method=post name="agentform"  onsubmit="return checkpassword()">
<TABLE align=center bgColor="" 
border=1  cellPadding=1 cellSpacing=1 width=75% id=TABLE1>
 
    <TR>
        <TD><span class="WSRightBold">USERNAME</span></TD>
        <TD><span class="WSRightBold"><%= request("uname")%>
            <INPUT type="hidden" name="username" value="<%= request("uname")%>" onsubmit="return checkAll()"></FONT></TD></TR>
    <TR>
        <TD><span class="WSRightBold">OLDPASSWORD</span></TD>
        <TD>
            <INPUT  name=pass1 type=Password ></TD></TR>
     <TR>
        <TD><span class="WSRightBold">NEWPASSWORD</span></TD>
        <TD>
            <INPUT  name=pass2 type=Password ></TD></TR>
       <TR>
        <TD><span class="WSRightBold">CONFIRM PASSWORD</span></TD>
        <TD>
            <INPUT  name=pass3 type=Password ></TD></TR>
            
         <input type="hidden" name="seckey" value="xyz25g78M20422npr054416panftpRhjkslsktlsh456">
                              <input type="hidden" name="logonid" value="o9g67435jdpXZ">
                              <input type="hidden" name="jn" value="<%=agentID%>" >
            
            
    
            
        <TD ALIGN=right><INPUT name=submit1 type=submit value=Submit class="ud"></td>
        <td text="red"><INPUT id=reset1 name=reset1 type=reset value=Reset class="ud">
            </TD></TR>
            </TABLE>
            </form>


                
                </td>
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
