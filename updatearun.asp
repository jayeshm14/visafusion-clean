<%@ Language=VBScript %>
<%
response.buffer= true

if session("priv")="" or session("priv")= "guest" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
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
                      <td height="44"> 
                        <table width="75%" align="center" cellpadding="0" cellspacing="0">
                          <tr bgcolor="#FFFFFF"> 
                            <td height="68"> 
                              <div align="center"><b><img src="updateimg/update%202.jpg" width="252" height="81"></b></div>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="2"> 
                        <table width="75%" border="0" cellspacing="0" cellpadding="0" height="43">
                          <tr> 
                            <td><img src="images/linetopgreen1.gif" width="660" height="0"></td>
                          </tr>
                          <tr bgcolor="#009933"> 
                            <td height="7"> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td align="left" width="1" height="58"><img src="images/pixelsline.gif" width="1" height="7"></td>
                                  <td bgcolor="#FFFFFF" height="58"> 
                                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                      <tr> 
                                        <td> 
                                          <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" height="8" >
                                            <tr> 
                                              <td height="2"> 
                                                <table width="100%" border="1" height="8" bordercolor="#003333">
                                                  <tr>
                                                    <td colspan="13" valign="top" height="2">
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="3" color="#0000FF">LATEST 
                                                        UPDATES</font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"> 
                                                      <a href="update100708.asp"><b>Region 
                                                      wise jurisdiction for applying 
                                                      Singapore Visa</b></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (25/06/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update250608.asp">Greece 
                                                      Embassy - Update...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (06/06/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update060608.asp">Udaan 
                                                      - Update ( Singapore High 
                                                      Commission )...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22/05/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update220508.asp">Udaan 
                                                      - Update ( Demand Draft 
                                                      Requested )...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13/05/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update130508.asp">Udaan 
                                                      Update ( Switzerland, Turkey 
                                                      and VFS Charges )...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="5"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22/04/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="5" width="85%"><font size="2" face="Verdana"><b><a href="update220408.asp">Udaan 
                                                      Update ( Spain, Portugal 
                                                      and Hungary )...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="11"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (14/04/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="11" width="85%"><font size="2" face="Verdana"><b><a href="update140408.asp">CHINA 
                                                      EMBASSY IMPOSES STRINGENT 
                                                      VISA REGULATIONS</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="11"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10/04/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="11" width="85%"><font size="2" face="Verdana"><b><a href="update100408.asp">SPECIAL 
                                                      ROOM RATES FOR SATTE DELEGATION 
                                                      </a> </b> </font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="13"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (09/04/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="13" width="85%"><font face="Verdana" size="2"><b><a href="update090408.asp">Udaan 
                                                      Launches Gulf Visa Services...</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="10"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (08/04/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="10" width="85%"><font face="Verdana" size="2"><a href="update080408.asp"><b>Udaan 
                                                      - Update ( Nigeria, Singapore, 
                                                      Malta and Botswana )...</b></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (27/03/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update270308.asp">Udaan 
                                                      - Update ( Demand Draft 
                                                      Requested )...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (20/03/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update200308.asp">Udaan 
                                                      - Update ( Singapore, Switzerland 
                                                      and Embassy Holiday List 
                                                      )</a></b></font> </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (18/03/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><font size="2" face="Verdana"><a href="update180308.asp">Udaan 
                                                      - Update ( Singapore, Thailand 
                                                      and Czech Republic )</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (06/03/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><font size="2" face="Verdana"><a href="update060308.asp">Udaan 
                                                      - Update ( Accounts - 06/03/2008 
                                                      )</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05/03/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update050308.asp">Communication 
                                                      Branch of Udaan....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (26/02/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update260208.asp">Udaan 
                                                      update ( 26/02/2008 )....Nigeria 
                                                      and Spain</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (21/02/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update210208.asp">Udaan 
                                                      Update ( 21/02/2008 )....Switzerland 
                                                      and Philippines</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (29/01/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update290108.asp">Service 
                                                      Apartment Rooms @ Rs 3500 
                                                      only</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (25/01/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update250108.asp">Udaan 
                                                      Update ( 25/01/2008 )....Switzerland,Spain 
                                                      and China</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10/01/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><a href="update100108.asp">Udaan 
                                                      Update (10/01/2008)...</a></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (07/01/2008)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update070108.asp">Udaan 
                                                      Update ( Enclosure Sheet 
                                                      )...</a></b></font> </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (19/12/2007)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update191207.asp">Update 
                                                      from Hungary Embassy...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (18/12/2007)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update181207.asp">UPDATED 
                                                      HOLIDAY LIST....</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (14/12/2007)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update141207.asp">New 
                                                      entrants in Schengen World...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13/12/2007)</font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><font size="2" face="Verdana"><a href="update131207.asp">BIOMETRIC 
                                                      REQUIRED FOR ALL UK VISA 
                                                      APPLICANTS:-</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16/11/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update161107.asp">CANADIAN 
                                                      HIGH COMMISSION...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13/11/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update131107.asp">3 
                                                      & 4 Star Service Apartments 
                                                      in Delhi & NCR....Attention 
                                                      Travelers to France:-</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05/11/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update051107.asp">Attention 
                                                      Travelers to United Kingdom...</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (17 /10/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update171007.asp">World 
                                                      Class Service Apartment--Rooms 
                                                      available @ Rs 3500 per 
                                                      day(Tax Included) Special 
                                                      Rate For Travel Agents </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (09 /10/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update091007.asp">3 
                                                      Star Service Apartment Rooms 
                                                      available on Rent on Daily 
                                                      / Monthly Basis...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (29 /09/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update290907.asp">Attention 
                                                      all applicants Traveling 
                                                      to Argentina....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (27 /09/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update270907.asp">Changes 
                                                      in Taiwan visa fee...NO 
                                                      SAME DAY VISA'S</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (07 /09/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update070907.asp">Emigration 
                                                      check eased...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (21 /08/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update210807.asp">Udaan 
                                                      - update....The Place for 
                                                      Innovation...ITMA'07</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (03 /08/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update030807.asp">Inclusion 
                                                      Of Service Tax In The Bill 
                                                      / Invoice...</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (06 /07/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><font face="Verdana" size="2"><a href="update060707.asp">Singapore 
                                                      High Commission ...</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (29 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update290607.asp">Home 
                                                      Away From Home---Come Stay 
                                                      with us in Comfort</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update220607.asp">Attention 
                                                      All Applicants Traveling 
                                                      To Tunisia & Venezuela...High 
                                                      Commission of the Federal 
                                                      Republic of India... </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (15 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update150607.asp">Greece 
                                                      Visa to be serviced by VFS 
                                                      instead of IVS….</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (07 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update070607.asp">Home 
                                                      Away From Home---Come Stay 
                                                      with us in Comfort</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update050607.asp">New 
                                                      specification for Spain 
                                                      visa Applications...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (02 /06/2007)</font></b></font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><a href="update020607.asp"><b>UK 
                                                      visa fees with effect form 
                                                      01st April 2007</b></a></font><a href="update020607.asp">.....<b><font face="Verdana" size="2">Good 
                                                      News For Travelers To Colombia 
                                                      </font></b></a> </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (24 /05/2007)</font></b></font></b></font></b></font></b></font><font size="3" color="#0000FF"><blink></blink></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update240507.asp">EMMIGRATION 
                                                      OFFICE / POE IN DELHI...</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22 /05/2007)</font></b></font></b></font></b></font></b></font><font size="3" color="#0000FF"><blink></blink></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update220507.asp">EMBASSY 
                                                      OF SPAIN...EMBASSY OF SLOVAK 
                                                      REPUBLIC...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (03 /05/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update030507.asp">HIGH 
                                                      COMMISSION OF THE FEDERAL 
                                                      REPUBLIC OF NIGERIA... PAPUA 
                                                      NEW GUINEA HIGH COMMISSION 
                                                      ... </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (25 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2" color="#000000"><b><a href="update250407.asp">HIGH 
                                                      COMMISSION OF THE FEDERAL 
                                                      REPUBLIC OF NIGERIA....</a></b></font><a href="update250407.asp"><b><font face="Verdana" size="4"><font size="2">EMBASSY 
                                                      OF REPUBLIC OF HUNGARY ...</font></font></b></a> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><a href="update160407.asp"><b>Singapore 
                                                      High Commission Closed ...Embassy 
                                                      Of The People’s Republic 
                                                      Of China... </b></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Monotype Corsiva" size="5" color="#000000"><b><font face="Verdana" size="2"><a href="update100407.asp">Attention 
                                                      Travelers to Hungary & Czech...</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (09 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update090407.asp">Embassy 
                                                      of Spain.....POE Stamping...</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update050407.asp">Attention 
                                                      All Applicants traveling 
                                                      to Canada...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (04 /04/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update040407.asp">Embassy 
                                                      of Spain...European Consulates 
                                                      Closed...Australian & New 
                                                      Zealand High Commission...Honorary 
                                                      Consulate General Of The 
                                                      Republic Of Estonia...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (30 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update300307.asp">Attention 
                                                      All Applicants for Australian 
                                                      Visa</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (28 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><a href="update280307.asp"><b>UK 
                                                      visa fees with effect form 
                                                      01st April 2007</b></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (26 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update260307.asp">Travel 
                                                      & Stay with Udaan in comfort 
                                                      </a> </b> </font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update220307.asp">Greece 
                                                      Visa to be serviced by IVS 
                                                      instead of BLS….</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update050307.asp">Request 
                                                      for clearance of outstanding 
                                                      dues</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (01 /03/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update010307.asp">----Udaan 
                                                      wishes you & your family 
                                                      a very HAPPY HOLI !----</a></b></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (24 /02/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update240207.asp">GREECE/ 
                                                      SOUTH KOREA/ BRAZIL and 
                                                      CANADA update </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10 /02/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update100207.asp">swiss 
                                                      update </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (31 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><a href="update310107.asp"><b>Netherlands 
                                                      Visa to be serviced by VFS 
                                                      India Pvt. Ltd...</b></a></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (19 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update190107.asp">All 
                                                      your visa submission under 
                                                      one roof with UDAAN-BANGALORE</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (18 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"> 
                                                      <a href="update180107.asp"><b><font face="Verdana" size="2">Three 
                                                      Star Service Apartment Rooms 
                                                      available on Rent on Daily 
                                                      Basis</font></b></a></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (17 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update170107.asp">Australian 
                                                      and New Zealand - New visa 
                                                      form...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update160107.asp">Singapore 
                                                      High Commission-Changes 
                                                      in Visa Processing Fee Mode 
                                                      </a> </b> </font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update050107.asp">Udaan 
                                                      - Update</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (02 /01/2007)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font color="#000000" face="Verdana"><b><font size="2"><a href="update020107.asp">Spain 
                                                      visa to be serviced by IVS.....Embassy 
                                                      of Greece</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (29 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update291206.asp">REVISION 
                                                      OF VISA FEES....PROTECTOR 
                                                      OF EMIGRANTS...EMBASSY OF 
                                                      RUSSIAN FEDERATION</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (21 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update211206.asp">Embassy 
                                                      of Sweden...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (18 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update181206.asp">Nigeria, 
                                                      Belgium, Philippines and 
                                                      British High Commission 
                                                      Update </a></b></font> </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update161206.asp">Special 
                                                      Visa For Cricket World Cup-2007 
                                                      (CARICOM)</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (15 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update151206.asp">Embassy 
                                                      of Philippines...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (02 /12/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update021206.asp">High 
                                                      Commission For The People's 
                                                      Republic of Bangladesh...</a></b> 
                                                      </font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (30 /11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update301106.asp">Embassy 
                                                      of Finland...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (25/11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update251106.asp">Embassy 
                                                      of Greece...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (21/11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><a href="update211106.asp"><font size="2">Kind 
                                                      Attention To All Singapore 
                                                      Visa Applicants..</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10/11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update101106.asp">Important 
                                                      Notice for All Travel Agents...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (08/11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update081106.asp">Embassy 
                                                      Of The Slovak Republic...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (01/11/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update011106.asp">Embassy 
                                                      of Vietnam-----For Tourist 
                                                      Visa</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (30 /10/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update301006.asp">For 
                                                      an Employment Work Visa 
                                                      Renewal ( X - Category )</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (24 /10/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update241006.asp">Embassy 
                                                      of Switzerland....Embassy 
                                                      of Greece...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (19 /10/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><a href="update191006.asp"><font size="2">KIND 
                                                      ATTENTION TO ALL SINGAPORE 
                                                      VISA APPLICANTS..</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16 /10/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update161006.asp">Embassy 
                                                      of Hungary...</a> </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13 /10/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update131006.asp">Important 
                                                      Notice...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (29 /09/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update290906.asp">Greece 
                                                      Embassy launches new Call 
                                                      Center in Delhi…</a></b></font><a href="update290906.asp"><b><font face="Verdana" size="3"><font size="2">Austria 
                                                      Visa to be serviced by VFS 
                                                      India Pvt. Ltd...</font><font face="Verdana" size="3"><font face="Verdana" size="3"><font face="Verdana" size="3"><font face="Verdana" size="3"><font size="2">Embassy 
                                                      of Argentina...</font></font></font></font></font></font></b></a></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (22 /09/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><a href="update220906.asp"><font size="2">KIND 
                                                      ATTENTION TO ALL SINGAPORE 
                                                      VISA APPLICANTS..</font></a> 
                                                      </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (18 /09/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update180906.asp">Enhancement 
                                                      of Charges - 18/09/2006...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (15 /09/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update150906.asp">Visa 
                                                      Advisory...</a> </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (23 /08/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><a href="update230806.asp"><b>Advertise 
                                                      on www.udaanindia.com</b></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16 /08/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update160806.asp">Philippines 
                                                      visa fees with effect form 
                                                      01st September 2006...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (08 /08/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><font color="#0000CC" size="2"><a href="update080806.asp">Embassy 
                                                      of Taiwan - Photo Specifications</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (05 /08/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update050806.asp">Embassy 
                                                      of Hungary…with effect from 
                                                      07/08/06</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (27/07/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><a href="update270706.asp"><font face="Verdana" size="2">Embassy 
                                                      of Costa Rica...</font></a></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13/07/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><a href="update130706.asp"><font face="Verdana" size="2">Embassy 
                                                      of Dominican Republic...</font></a></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (24/06/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update240606.asp">UK 
                                                      visa fees with effect form 
                                                      26th June 2006...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (08/06/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update080606.asp">New 
                                                      Contact Numbers Of Udaan...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (03/06/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update030606.asp">Embassy 
                                                      of Austria - Photo Specifications...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (01/06/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><a href="update010606.asp"><b>Malaysian 
                                                      High Commision....</b></a></font> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (24/05/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update240506.asp">Canada 
                                                      Immigration Cost Recovery 
                                                      Fees - 29th May 2006...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (08/05/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update080506.asp">See 
                                                      your own Udaan with a new 
                                                      face from 8th May 2006...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (04/05/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"> 
                                                      <p><a href="update040406.asp"><b><font face="Verdana" size="2">Embassy 
                                                        of Poland......Embassy 
                                                        of China...</font></b></a> 
                                                      </p>
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (30/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update300306.asp">South 
                                                      Africa High Commission...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (28/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><a href="update280306.asp"><font face="Verdana" size="2">Embassy 
                                                      of Paraguay...</font></a></b> 
                                                    </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (25/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update250306.asp">Embassy 
                                                      Of Sweden... </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (20/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update200306.asp">Embassy 
                                                      of Italy...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update160306.asp">Welcome 
                                                      To Malaysia Truly Asia...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update100306.asp">Royal 
                                                      Thai Embassy....traveling 
                                                      to Thailand would require 
                                                      POE clearance </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (03/03/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><font size="2"><a href="update030306.asp">High 
                                                      Commission For Malaysia...Processing 
                                                      Time</a></font></b><a href="update030306.asp"><font size="2"><b>...</b></font></a></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16/02/2006)</font></b></font></b></font></b></font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><b><font face="Verdana" size="2"><a href="update160206.asp">NEW 
                                                      VISA FEE FOR U.K AND CONGO....</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="17"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (21/01/2006)</font></b></font><font size="3" color="#FF0000"></font></b></font><font size="3" color="#FF0000"> 
                                                        </font></b></font><font size="3" color="#FF0000"> 
                                                        </font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="17" width="85%"><font face="Verdana"><b><font size="3"><a href="update210106.asp">Accounts 
                                                      Update...</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="17"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (10/01/2006)</font></b></font><font size="3" color="#FF0000"></font></b></font><font size="3" color="#FF0000"> 
                                                        </font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="17" width="85%"><font face="Verdana" size="2" color="#CC3399"><b><font color="#0000CC"><a href="update100106.asp">Udaan 
                                                      India Pvt. Ltd. can obtain 
                                                      a Pakistan visa for all 
                                                      you cricket fans out there….</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="32"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (16/12/2006)</font></b></font><font size="3" color="#FF0000"> 
                                                        </font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="32" width="85%"><b><font face="Verdana" size="2"><a href="update161205.asp">NEW 
                                                      VISA FEE FOR U.K AND HOLIDAY 
                                                      FOR PHILIPPINES...</a></font></b></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="16"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (13/12/2005)</font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="16" width="85%"><font face="Verdana" size="2"><b><a href="update131205.asp">MALAYSIAN 
                                                      HIGH COMMISSION CLOSED @ 
                                                      CHENNAI…!??! RESOLVE YOUR 
                                                      PROBLEM BY SENDING YOUR 
                                                      MALAYSIAN VISA APPLICATION 
                                                      TO UDAAN…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (03/12/2005)</font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update031205.asp">PORTUGAL 
                                                      EMBASSY LAUNCHES NEW CALL 
                                                      CENTER IN DELHI…<br>
                                                      EASY ANSWER TO MALAYSIAN 
                                                      I- visa…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><font size="2" face="Verdana"><b><font face="Verdana" size="2">Date<br>
                                                        (02/12/2005)</font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2"><b><font face="Verdana" color="#FF0033"><a href="update021205.asp">Change 
                                                      of Fee and payment procedure 
                                                      of Spain and German Embassy...</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (14/11/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2"><b><font face="Verdana" color="#FF0033"><a href="update141105.asp">NEW 
                                                      VISA PROCESSING RULES FOR 
                                                      UNITED STATES OF AMERICA 
                                                      THROUGH VFS AND HDFC BANK…</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (19/10/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update191005.asp">US 
                                                      VISAS TO BE SERVICED BY 
                                                      VFS INDIA PVT. LTD...</a> 
                                                      </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (02/09/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update020905.asp">NEW 
                                                      VISA PROCESSING CENTER FOR 
                                                      THE EGYPT EMBASSY…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (17/08/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font size="2" face="Verdana"><b><a href="update170805.asp">FOR 
                                                      FASTER AND ACCURATE PROCESSING 
                                                      OF VISA APPLICATIONS....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="7"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (09/08/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="7" width="85%"><font face="Verdana" size="2"><b><a href="update090805.asp">INDONESIA 
                                                      VISA ON ARRIVAL… READ ON 
                                                      FURTHER TO KNOW MORE ON 
                                                      THE VISA PROCEDURES OF THE 
                                                      UPCOMING TOURIST DESTINATIONS…</a> 
                                                      </b> </font> </td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="7"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (28/07/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="7" width="85%"><font face="Verdana" size="2"><b><a href="update280705.asp">LATEST 
                                                      ON ATTESTATIONS…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="7"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (05/07/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="7" width="85%"><font face="Verdana" size="2"><b><a href="update050705.asp">DEUTSCHE 
                                                      EMBASSY LAUNCHES NEW CALLl 
                                                      CENTER IN DELHI....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (28/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="update280605.asp">CHANGE 
                                                      OF VISA PROCESSING CENTER 
                                                      FOR THE NIGERIAN HIGH COMMISSION...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (27/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="update270605.asp">EMBASSY 
                                                      OF REPUBLIC INDONESIA...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (09/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update090605.asp">THE 
                                                      ROYAL THAI EMBASSY...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (08/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update080605.asp">NEW 
                                                      TIMINGS FOR SUBMISSION AND 
                                                      COLLECTIONS AT THE DANISH 
                                                      EMBASSY.... </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (04/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update040605.asp">MALAYSIA 
                                                      VISA APPLICATION BY INTERNET...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (25/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update190505.asp">UPDATE 
                                                      FRANCE, SINGAPORE AND UNITED 
                                                      KINGDOM...</a> </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (19/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update190505.asp">LETS 
                                                      JOIN HANDS TO "SAIL SMOOTHLY" 
                                                      THROUGH THE "HEAVY LEISURE 
                                                      SEASON" - II ...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (03/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update030505.asp">LETS 
                                                      JOIN HANDS TO "SAIL SMOOTHLY" 
                                                      THROUGH THE "HEAVY LEISURE 
                                                      SEASON" - I ...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (29/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update290405.asp">TO 
                                                      ALL TRAVEL PARTNERS…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (12/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update120405.asp">NEW 
                                                      PROCEDURES FOR VISA FEE 
                                                      PAYMENT…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (06/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font size="2" face="Verdana"><b><a href="http://www.udaanindia.com/update060405.asp">NO 
                                                      MORE LONG QUEUES, NO MORE 
                                                      HASSLES! ATTESTATIONS ARE 
                                                      DONE AT THE QUICKEST SPEED 
                                                      THROUGH UDAAN… </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (29/03/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update290305.asp">LATEST 
                                                      FOR MALAYSIAN VISA...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (11/03/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update110305.asp">UDAAN'S 
                                                      CONSUMMATE SERVICES...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (03/02/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="85%"><font face="Verdana" size="3"><b><font size="2"><a href="http://www.udaanindia.com/update030205.asp">ALL 
                                                      APPLICANTS FOR AUSTRALIAN 
                                                      VISA FROM ALL OVER THE COUNTRY 
                                                      CAN APPLY AT THE HIGH COMMISSON 
                                                      IN NEW DELHI VIA T. T. SERVICES, 
                                                      NEW DELHI… </a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (01/02/2005) </font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="85%"><font face="Verdana" size="3"><b><a href="http://www.udaanindia.com/update010205.asp"><font size="2">AIR 
                                                      CARGO SERVICES...</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="18"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (21/01/2005)</font> </b></div>
                                                    </td>
                                                    <td valign="top" height="18" width="85%"><font face="Verdana" size="3"><b><a href="update250105.asp"><font size="2">KIND 
                                                      ATTENTION TO ALL SINGAPORE 
                                                      VISA APPLICANTS...</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="19"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (06/01/2005)</font><font face="Verdana"> 
                                                        </font></b></div>
                                                    </td>
                                                    <td valign="top" height="19" width="85%"><font face="Verdana" size="3"><b><a href="http://www.udaanindia.com/update060105.asp"><font size="2">UDAAN 
                                                      WELCOMES 2005 BY GOING ONLINE 
                                                      WITH GALILEO INDIA AND SINGAPORE 
                                                      HIGH COMMISSION...</font></a></b></font></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td align="right" width="1" height="58"><img src="images/pixelsline.gif" width="1" height="7"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2"><img src="images/linetopgreen2.gif" width="664" height="1"></td>
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
