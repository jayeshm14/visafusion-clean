<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<html>
<head>
<title>www.udaanindia.com</title>

<script language="JavaScript">
<!--

function numvalid(a)
{
if(isNaN(a.value))
{
alert("Please fill numeric value for" + a.name)
a.focus()
a.select()
}
}

//-->
</script>
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0">
  <tr> 
    <td colspan="3"><!-- #include file="topadmin.asp" --></td>
  </tr>
  <tr> 
    
  <td colspan="3"> 
    <form method="post" action="dailyprint.asp" name="form1">
      <table width="100%" border="0">
        <tr> 
          <td colspan="5"> 
            <div align="center"><b><font size="4">List Of Collections from refno. 
              to refno.<br>
              &nbsp;&nbsp; </font></b></div>
          </td>
        </tr>
        <tr> 
          <td width="32%"> 
            <div align="right"><b>From Ref No.</b></div>
          </td>
          <td width="6%"> 
            <input type="text" name="fromref" maxlength="6" size="6" onBlur="return numvalid(this)">
          </td>
          <td width="15%"> 
            <div align="right"><b>To Ref No.</b></div>
          </td>
          <td width="11%"> 
            <input type="text" name="toref" maxlength="6" size="6" onBlur="return numvalid(this)">
          </td>
          <td width="36%"> 
            <input type="submit" value=" GO " name="submit" class="ud"></td>
        </tr>
      </table>
    </form>
  </td>
</tr>
<tr>
    <td colspan="3"><!-- #include file="empBottom.asp" -->

</td>
  </tr>
</table>
</body>
</html>
