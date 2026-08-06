<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<script language="JavaScript">
<!--

function pass()
{
if ((! document.form1.u_pwd.value=="") && (! document.form1.u_pwd1.value==""))
	{
	var pwd=document.form1.u_pwd.value;
	if (pwd != document.form1.u_pwd1.value)
		{
		alert("Password and Confirm Password must be same.");
		document.form1.u_pwd1.focus()
		document.form1.u_pwd1.select()
		return false;
		}
	}
}

function numvalid(a)
{
if(isNaN(a.value))
{
alert("Please fill numeric value for " + a.name)
a.focus()
a.select()
}
}


function mail()
{
if (document.form1.u_mail.value!="")
	{ 
		var email,ln;
		email=document.form1.u_mail.value;
		ln=email.indexOf('@',1);
		if ( ln > 0)
		{	
			if (email.indexOf(".",ln+1) <3 )
			{
				alert ("Please enter valid Email.");
		document.form1.u_mail.focus()
		document.form1.u_mail.select()
				return false;	
			}
		}
		else
		{
			alert ("You have entered wrong Email Id, please enter the correct Email Id.");
		document.form1.u_mail.focus()
		document.form1.u_mail.select()
			return false;
		}
	}
	else
		{alert("Enter the Email Id.");
		document.form1.u_mail.focus()
		document.form1.u_mail.select()
		return false;}
}	

function check()
{
if(document.form1.date.value==""){
alert("Please enter Date!.")
document.form1.date.focus()
return false
}
if(document.form1.fname.value==""){
alert("Please enter your First Name.")
document.form1.fname.focus()
return false
}	
if(document.form1.lname.value==""){
alert("Please enter your Last Name.")
document.form1.lname.focus()
return false
}
if(document.form1.add.value==""){
alert("Please enter your Address.")
document.form1.add.focus()
return false
}	
if(document.form1.area.value==""){
alert("Please enter your Area.")
document.form1.area.focus()
return false
}	
if(document.form1.city.value==""){
alert("Please enter the name of the City in which you are residing.")
document.form1.city.focus()
return false
}
if(document.form1.pincode.value==""){
alert("Please enter the Pin Code of your area.")
document.form1.pincode.focus()
return false
}
if(document.form1.phoneno.value==""){
alert("Please enter the Phone No.")
document.form1.phoneno.focus()
return false
}
if(document.form1.u_mail.value==""){
alert("Please enter your Email address.")
document.form1.u_mail.focus()
return false
}
if(document.form1.uid.value==""){
alert("Please enter your User ID.")
document.form1.uid.focus()
return false
}
if(document.form1.u_pwd.value==""){
alert("Please enter your Password!")
document.form1.u_pwd.focus()
return false
}
if(document.form1.u_pwd1.value==""){
alert("Please enter your Confirm Password!")
document.form1.u_pwd1.focus()
return false
}
if (!document.form1.termask.checked )
   {
    alert("Please fill out the Check Box of Terms and Conditions!");
    document.form1.termask.focus();
    return (false);
   } 


}
//-->
</script>

<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="MM_preloadImages('images/contactn2.gif','images/queriean2.gif','images/logonn2.gif','images/homen2.gif','images/profilen2.gif','images/updaten2.gif')">
<table width="765" border="0" cellspacing="0" cellpadding="0" align="left">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/topn1.jpg" width="760" height="71"></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="1%"><img src="images/whitw.gif" width="13" height="20"></td>
                <td width="11%"><a href="Default.asp"><img src="images/homen1.gif" width="99" height="20" border="0" name="Image7" onMouseOver="MM_swapImage('Image7','','images/homen2.gif',1)"></a></td>
                <td width="12%"><a href="profile.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)"><img src="images/profilen1.gif" width="102" height="20" name="Image1" border="0"></a></td>
                <td width="12%"><a href="update.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)"><img src="images/updaten1.gif" width="102" height="20" name="Image2" border="0"></a></td>
                <td width="12%"><a href="registration.asp"><img src="images/registrationn3.gif" width="102" height="20" name="Image3" border="0"></a></td>
                <td width="12%"><a href="contactus.asp"><img src="images/contactn1.gif" width="102" height="20" name="Image4" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="queries.asp"><img src="images/queriean1.gif" width="101" height="20" name="Image5" onMouseOver="MM_swapImage('Image5','','images/queriean2.gif',1)" border="0"></a></td>
                <td width="11%"><a href="logon.asp"><img src="images/logonn1.gif" width="100" height="20" name="Image6" onMouseOver="MM_swapImage('Image6','','images/logonn2.gif',1)" border="0"></a></td>
                <td width="17%"><img src="images/pixekn.gif" width="58" height="20"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="images/linecolor.gif" width="760" height="12"></td>
        </tr>
        <tr> 
          <td><img src="images/pixelb.gif" width="33" height="5"></td>
        </tr>
        <tr> 
          <td><img src="images/threei.gif" width="760" height="26" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="329,2,436,24"><area shape="rect" coords="461,1,597,24"><area shape="rect" coords="619,2,720,24"></map></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2"> 
                  <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
                    <tr> 
                      <td> 
                        <table width="75%" align="center" cellpadding="0" cellspacing="0">
                          <tr bgcolor="#FFE898"> 
                            <td height="19"> 
                              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><span class="tableCaption">REGISTER 
                                NOW</span></font></font></b> </div>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="2"> 
                        <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
                          </tr>
                          <tr bgcolor="#009933"> 
                            <td height="968"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                                  <td bgcolor="#FFFFFF"> 
                                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                      <tr> 
                                        <td> 
                                          <form method="post" action="regsubmit.asp" name="form1"  onSubmit="return check()">
                                            <table align=center 
border=0 bordercolor=mediumblue cellpadding=1 cellspacing=1 width=95% id=TABLE1>
                                              <tr> 
                                                <td colspan="3"> 
                                                  <div align="center"><b><font face="Verdana" color="#0000FF" size="3">TO 
                                                    PROCESS YOUR REGISTRATION, 
                                                    KINDLY FILL IN THIS FORM:</font></b></div>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3">
                                                  <div align="center"><font face="Verdana" size="2" color="#006633">YES, 
                                                    WE WOULD LIKE TO REGISTER 
                                                    WITH<b> <font color="#FF0033">&quot;www.udaanindia.com&quot;</font></b></font></div>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font face="Verdana" color="#006633" size="2">AS 
                                                  OF</font> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="text" size="1" maxlength="2" name="date" onBlur="return numvalid(this)">
                                                  OF</font> <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  <select name="month">
                                                    <option value="1" selected>January</option>
                                                    <option value="2">February</option>
                                                    <option value="3">March</option>
                                                    <option value="4">April</option>
                                                    <option value="5">May</option>
                                                    <option value="6">June</option>
                                                    <option value="7">July</option>
                                                    <option value="8">August</option>
                                                    <option value="9">September</option>
                                                    <option value="10">October</option>
                                                    <option value="11">November</option>
                                                    <option value="12">December</option>
                                                  </select>
                                                  <select name="year">
                                                    <option value="2001" selected>2001</option>
                                                    <option value="2002">2002</option>
                                                    <option value="2003">2003</option>
                                                    <option value="2004">2004</option>
                                                  </select>
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"></font></td>
                                                <td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"></font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"><img src="images/natureofbusi.gif" width="175" height="22"></font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="AIRLINE">
                                                  </b>AIRLINE </font></td>
                                                <td width="37%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="EMBASSY / CONSULATE">
                                                  </b>EMBASSY / CONSULATE</font></td>
                                                <td width="34%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="CORPORATE">
                                                  </b>CORPORATE<b> </b></font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="TRAVEL AGENCY" checked>
                                                  </b> TRAVEL AGENCY</font></td>
                                                <td width="37%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="SOFTWARE HOUSE">
                                                  </b>SOFTWARE HOUSE</font></td>
                                                <td width="34%"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="CRSs">
                                                  </b>CRSs </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="TOUR OPERATOR">
                                                  </b>TOUR OPERATOR</font></td>
                                                <td width="37%" height="2"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="PUBLICATION">
                                                  </b>PUBLICATION </font></td>
                                                <td width="34%" height="2"> <font size="2" face="Verdana" color="#006633"><b> 
                                                  <input type="radio" name="busi" value="OTHER">
                                                  </b>OTHER <b> 
                                                  <input type="text" name="othbusi" size="10" maxlength="30">
                                                  </b></font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"><b></b></font></td>
                                                <td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"><b></b></font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"><b><img src="images/contact_details.gif" width="175" height="22"></b></font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"> <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"><b> 
                                                  <input type="radio" name="pre" value="Mr." checked>
                                                  </b><font face="Verdana">Mr. 
                                                  <b> 
                                                  <input type="radio" name="pre" value="Ms.">
                                                  </b>Ms.<b> 
                                                  <input type="radio" name="pre" value="Mrs.">
                                                  </b>Mrs.<b> </b></font></font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font size="2" face="Verdana" color="#006633">FIRST 
                                                  NAME : 
                                                  <input  name="fname" size="15" maxlength="30" >
                                                  &nbsp;&nbsp;&nbsp;LAST NAME 
                                                  : 
                                                  <input  name="lname" size="15" maxlength="30" >
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">DESIGNATION 
                                                  : </font></td>
                                                <td height="2" colspan="2"> 
                                                  <p><font size="2" face="Verdana" color="#006633"> 
                                                    <input type=text size="30" maxlength="70"  name=desig>
                                                    </font></p>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">COMPANY 
                                                  : </font></td>
                                                <td height="2" colspan="2"><font size="2" face="Verdana" color="#006633"> 
                                                  <input  name=company type=text size="30" maxlength="70">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">OFFICE 
                                                  ADDRESS :</font></td>
                                                <td height="2" colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input  name=add type=text size="40" maxlength="100">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">AREA 
                                                  :</font></td>
                                                <td height="2" colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name=area type=text size="30" maxlength="45">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">CITY 
                                                  : </font></td>
                                                <td colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name=city type=text size="25" maxlength="45">
                                                  &nbsp;&nbsp;&nbsp; &nbsp;PIN 
                                                  CODE : 
                                                  <input name="pincode" type=text size="6" maxlength="6" onBlur="return numvalid(this)">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="20"><font size="2" face="Verdana" color="#006633">COUNTRY 
                                                  :</font></td>
                                                <td colspan="2" height="20"> <font size="2" face="Verdana" color="#006633"> 
                                                  <select name="country" size="1" class="tsr">
                                                    <option value="Australia">Australia</option>
                                                    <option value="Canada">Canada</option>
                                                    <option value="China">China</option>
                                                    <option value="Europe">Europe</option>
                                                    <option value="India" selected>India</option>
                                                    <option value="Japan">Japan</option>
                                                    <option value="Netherland">Netherland</option>
                                                    <option value="U.S.A">U.S.A</option>
                                                    <option value="United Kingdom">United 
                                                    Kingdom</option>
                                                  </select>
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">PHONE 
                                                  NO :</font></td>
                                                <td colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name="phoneno" type=text size="15" maxlength="15" onBlur="return numvalid(this)">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">FAX 
                                                  NO :</font></td>
                                                <td colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name="faxno" type=text size="15" maxlength="15" onBlur="return numvalid(this)">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">EMAIL 
                                                  ID :</font></td>
                                                <td colspan="2" height="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name="u_mail" type=text size="30" maxlength="70" onChange="return mail()">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">HOME 
                                                  PAGE :</font></td>
                                                <td colspan="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input name="hpage" type=text value="www." size="30" maxlength="95">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  <div align="justify"><font face="Verdana">PLEASE 
                                                    ADVICE PREFERRED USER ID &amp; 
                                                    PASSWORD. THE USER ID &amp; 
                                                    PASSWORD MUST CONTAIN 8 CHARACTERS 
                                                    WITH ALPHABETICAL, NUMERIC 
                                                    AND / OR SPECIAL CHARACTERS.</font></div>
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3" height="2"> 
                                                  <div align="left"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                    <font color="#FF0000"><b><font face="Verdana">PLEASE 
                                                    NOTE THAT THE USER-CODE MUST 
                                                    HAVE AN ASSOCIATION WITH YOUR 
                                                    COMPANY'S NAME.</font></b></font></font></div>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"></font></td>
                                                <td colspan="2" height="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#006633"></font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">USER 
                                                  ID :</font></td>
                                                <td colspan="2"> <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  <input name="uid" type=text size="20" maxlength="20">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%" height="2"><font size="2" face="Verdana" color="#006633">PASSWORD 
                                                  : </font></td>
                                                <td colspan="2" height="2"> <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  <input name="u_pwd" type=password size="20" maxlength="20">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td width="29%"><font size="2" face="Verdana" color="#006633">CONFIRM 
                                                  PASSWORD :</font></td>
                                                <td colspan="2"> <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  <input name="u_pwd1" type=password size="20" onChange="return pass()">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"><font size="2" face="Verdana" color="#006633">PLEASE 
                                                  TICK THE APPROPRIATE BOX SHOWING 
                                                  HOW YOU FOUND OUT ABOUT <font color="#FF0000"><b>&quot;www.udaanindia.com&quot;</b></font></font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="radio" name="how" value="directmail" checked>
                                                  THROUGH DIRECT MAIL ANNOUNCING 
                                                  &quot;udaanindia.com&quot; </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="radio" name="how" value="metat">
                                                  MET AT THE 
                                                  <input type="text" name="metat1" size="15" maxlength="45">
                                                  CONFERENCE / EXHIBITION IN 
                                                  <input type="text" name="metat2" size="15" maxlength="45">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3" height="2"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="radio" name="how" value="confriend">
                                                  THROUGH CONTACT / FRIEND, NAMELY 
                                                  <input type="text" name="friend" size="20" maxlength="45">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="radio" name="how" value="udaanprom">
                                                  THROUGH &quot;UDAAN&quot; PROMOS 
                                                  <input type="text" name="promos" size="20" maxlength="45">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3"> <font size="2" face="Verdana" color="#006633"> 
                                                  <input type="radio" name="how" value="othmeans">
                                                  THROUGH OTHER MEANS 
                                                  <input type="text" name="othmeans" size="20" maxlength="45">
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3" height="2"> 
                                                  <div align="center"><b><font color="#FF0000" size="6" face="Arial, Helvetica, sans-serif">TERMS 
                                                    FOR USE</font> </b></div>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td colspan="3" height="65"> 
                                                  <table width="100%" border="1">
                                                    <tr> 
                                                      <td> 
                                                        <p> 
                                                        <div align="justify"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633">
                                                          <div align="justify"><font face="Verdana">EVERY 
                                                            EFFORT HAS BEEN MADE 
                                                            TO ENSURE THAT THE 
                                                            INFORMATION PROVIDED 
                                                            BY <b><font color="#0000FF">"UDAAN 
                                                            INDIA PRIVATE LIMITED"</font></b> 
                                                            AND/OR ITS SOURCE 
                                                            IS AS ACCURATE AS 
                                                            POSSIBLE. HOWEVER, 
                                                            NO LIABILITY CAN BE 
                                                            ACCEPTED IN RESPECT 
                                                            OF INACCURACIES OR 
                                                            INCOMPLETE INFORMATION, 
                                                            UNLESS THE INFORMATION 
                                                            PROVIDED IS INTENTIONALLY 
                                                            WRONG AND/OR GROSS 
                                                            NEGLIGENCE IS INVOLVED. 
                                                            </font></div>
                                                          </font></div>
                                                        <p align="left"></p>
                                                        <p align="left"> 
                                                        <div align="left"><font face="Verdana" size="2" color="#006633">THE 
                                                          USER SHALL NOT RAISE 
                                                          ANY CLAIM AGAINST <b><font color="#0000FF">"UDAAN 
                                                          INDIA PRIVATE LIMITED"</font></b> 
                                                          OR ITS SOURCE IN RESPECT 
                                                          OF INACCURACIES OR INCOMPLETE 
                                                          INFORMATION AND THE 
                                                          USER SHALL INDEMNIFY 
                                                          THEM AGAINST ANY CLAIM. 
                                                          </font></div>
                                                        <font face="Arial, Helvetica, sans-serif" size="2" color="#006633"> 
                                                        </font> 
                                                        <p></p>
                                                        <font size="2" face="Verdana" color="#006633"> 
                                                        <input type="checkbox" name="termask" value="checked">
                                                        <font color="#FF0000"><b> 
                                                        I AGREE WITH YOUR TERMS 
                                                        AND CONDITIONS</b></font></font><font color="#FF0000" face="Verdana"><b>.</b> 
                                                        </font> </td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td align=left colspan="3" height="2"> 
                                                  <font size="2" face="Arial, Helvetica, sans-serif" color="#006633"> 
                                                  </font></td>
                                              </tr>
                                              <tr> 
                                                <td align=right width="29%" height="2"><font text=red> 
                                                  <input class="ud" name=submit type=submit value=Submit>
                                                  </font></td>
                                                <td text="red" colspan="2" height="2"> 
                                                  <input class="ud" id=reset1 name=reset type=reset value=Reset>
                                                </td>
                                              </tr>
                                            </table>
                                          </form>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td align="right" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td><img src="images/linetopgreen2.gif" width="660" height="8"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> <!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
