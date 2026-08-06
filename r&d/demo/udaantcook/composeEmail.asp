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
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>
                            
                <form name=emailmessage action="emailmessage.asp">
                Subject:<input type=text name="subject" size=60> <br>
                Message:<br>
                <textarea rows="10" cols="60" name="message"></textarea>
                <br>
                <input type=submit name="subject" value="SEND EMAIL"> 
                
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
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
