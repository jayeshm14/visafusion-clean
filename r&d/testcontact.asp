
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

function mail()
{
if (document.form1.email.value!="")
	{ 
		var email,ln;
		email=document.form1.email.value;
		ln=email.indexOf('@',1);
		if ( ln > 0)
		{	
			if (email.indexOf(".",ln+1) <3 )
			{
				alert ("Please enter valid Email.");
		document.form1.email.focus()
		document.form1.email.select()
				return false;	
			}
		}
		else
		{
			alert ("You have entered wrong Email Id, please enter the correct Email Id.");
		document.form1.email.focus()
		document.form1.email.select()
			return false;
		}
	}
	else
		{alert("Enter the Email Id.");
		document.form1.email.focus()
		document.form1.email.select()
		return false;}
}	

function check()
{
if(document.form1.msgtxt.value==""){
alert("Please enter your Any Question ?  Remarks ?  Suggestions ?  Queries ?")
document.form1.msgtxt.focus()
return false
}
if(document.form1.name.value==""){
alert("Please enter your Name!.")
document.form1.name.focus()
return false
}
if(document.form1.phone.value==""){
alert("Please Enter your Phone No.")
document.form1.phone.focus()
return false
}
if(document.form1.email.value==""){
alert("Please enter your Email address.")
document.form1.email.focus()
return false
}
if(document.form1.city.value==""){
alert("Please enter the name of the City in which you are residing.")
document.form1.city.focus()
return false
}
}
//-->
</script>


</head>

<body bgcolor="#FFFFFF">
<form method="post" action="contactsendpre.asp" name="form1"  onSubmit="return check()">
  <table width="100%" border="0">
    <tr> 
      <td colspan="3"> 
        <div align="center"><span class="wsrightbold"><font size="3">Any Question 
          ? &nbsp;Remarks ? &nbsp;Suggestions ? &nbsp;Queries ?</font></span></div>
      </td>
    </tr>
    <tr> 
      <td height="2" colspan="3"> 
        <div align="center"> 
          <textarea name="msgtxt" rows="6" cols="40"></textarea>
        </div>
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">Name</font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="name">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">Company 
        Name</font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="cname">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">Phone 
        </font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="phone" onBlur="return numvalid(this)">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">Fax</font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="fax" onBlur="return numvalid(this)">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">Email</font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="email" onChange="return mail()">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"><b><font size="2" face="Arial, Helvetica, sans-serif">City</font></b></td>
      <td height="2" width="51%"> 
        <input type="text" name="city">
      </td>
    </tr>
    <tr> 
      <td height="2" width="29%">&nbsp;</td>
      <td height="2" width="20%"> 
        <div align="right"> 
          <input type="submit" name="Submit" value="Submit">
        </div>
      </td>
      <td height="2" width="51%"> 
        <input type="reset" name="Submit2" value="Reset">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
