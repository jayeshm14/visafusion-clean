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
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
        <%
                type1=request("type1")
                if type1="agent" then
                Con.execute("delete from agents where agentname='"&lcase(request("agent"))&"'")
                Response.write "THE AGENT <B>"&Ucase(request("agent"))&"</B> HAS BEEN DELETED SUCCESSFULLY"
                End if
                if type1="user" then
                Con.execute("delete from udaan_users where username='"&lcase(request("username"))&"'")
                Response.write "THE USER <B>"&Ucase(request("username"))&"</B>  HAS BEEN DELETED SUCCESSFULLY"
                End if
                if type1="embassy" then
                Con.execute("delete from embassy where countryname ='"&lcase(request("country"))&"'")
                Response.write "THE COUNTRY <B>"&Ucase(request("country"))&"</B>  HAS BEEN DELETED SUCCESSFULLY"
                End if
                
                
                %>
               
               
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
