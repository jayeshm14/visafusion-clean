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
                                                        UPDATES</font><font size="3" color="#FF0000"> 
                                                        </font></b></font></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font size="2"><b><font face="Verdana" color="#FF0033"><a href="update.asp">NEW 
                                                      VISA PROCESSING RULES FOR 
                                                      UNITED STATES OF AMERICA 
                                                      THROUGH VFS AND HDFC BANK…</a></font></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (19/10/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font size="2" face="Verdana"><b><a href="update191005.asp">US 
                                                      VISAS TO BE SERVICED BY 
                                                      VFS INDIA PVT. LTD...</a> 
                                                      </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (02/09/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font size="2" face="Verdana"><b><a href="update020905.asp">NEW 
                                                      VISA PROCESSING CENTER FOR 
                                                      THE EGYPT EMBASSY…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (17/08/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font size="2" face="Verdana"><b><a href="update170805.asp">FOR 
                                                      FASTER AND ACCURATE PROCESSING 
                                                      OF VISA APPLICATIONS....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="7"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (09/08/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="7" width="88%"><font face="Verdana" size="2"><b><a href="update090805.asp">INDONESIA 
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
                                                    <td valign="top" height="7" width="88%"><font face="Verdana" size="2"><b><a href="update280705.asp">LATEST 
                                                      ON ATTESTATIONS…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="7"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (05/07/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="7" width="88%"><font face="Verdana" size="2"><b><a href="update050705.asp">DEUTSCHE 
                                                      EMBASSY LAUNCHES NEW CALLl 
                                                      CENTER IN DELHI....</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (28/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="update280605.asp">CHANGE 
                                                      OF VISA PROCESSING CENTER 
                                                      FOR THE NIGERIAN HIGH COMMISSION...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (27/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font face="Verdana" size="2"><b><a href="update270605.asp">EMBASSY 
                                                      OF REPUBLIC INDONESIA...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="2"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (09/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="2" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update090605.asp">THE 
                                                      ROYAL THAI EMBASSY...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (08/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update080605.asp">NEW 
                                                      TIMINGS FOR SUBMISSION AND 
                                                      COLLECTIONS AT THE DANISH 
                                                      EMBASSY.... </a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (04/06/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update040605.asp">MALAYSIA 
                                                      VISA APPLICATION BY INTERNET...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (25/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update190505.asp">UPDATE 
                                                      FRANCE, SINGAPORE AND UNITED 
                                                      KINGDOM...</a> </b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (19/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update190505.asp">LETS 
                                                      JOIN HANDS TO "SAIL SMOOTHLY" 
                                                      THROUGH THE "HEAVY LEISURE 
                                                      SEASON" - II ...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (03/05/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update030505.asp">LETS 
                                                      JOIN HANDS TO "SAIL SMOOTHLY" 
                                                      THROUGH THE "HEAVY LEISURE 
                                                      SEASON" - I ...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (29/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update290405.asp">TO 
                                                      ALL TRAVEL PARTNERS…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (12/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update120405.asp">NEW 
                                                      PROCEDURES FOR VISA FEE 
                                                      PAYMENT…</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (06/04/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font size="2" face="Verdana"><b><a href="http://www.udaanindia.com/update060405.asp">NO 
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
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update290305.asp">LATEST 
                                                      FOR MALAYSIAN VISA...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (11/03/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="2"><b><a href="http://www.udaanindia.com/update110305.asp">UDAAN'S 
                                                      CONSUMMATE SERVICES...</a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="14"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (03/02/2005)</font></b></div>
                                                    </td>
                                                    <td valign="top" height="14" width="88%"><font face="Verdana" size="3"><b><font size="2"><a href="http://www.udaanindia.com/update030205.asp">ALL 
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
                                                    <td valign="top" height="2" width="88%"><font face="Verdana" size="3"><b><a href="http://www.udaanindia.com/update010205.asp"><font size="2">AIR 
                                                      CARGO SERVICES...</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="18"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (21/01/2005)</font> </b></div>
                                                    </td>
                                                    <td valign="top" height="18" width="88%"><font face="Verdana" size="3"><b><a href="http://www.udaanindia.com/update250105.asp"><font size="2">KIND 
                                                      ATTENTION TO ALL SINGAPORE 
                                                      VISA APPLICANTS...</font></a></b></font></td>
                                                  </tr>
                                                  <tr> 
                                                    <td colspan="13" valign="top" height="19"> 
                                                      <div align="center"><b><font face="Verdana" size="2">Date<br>
                                                        (06/01/2005)</font><font face="Verdana"> 
                                                        </font></b></div>
                                                    </td>
                                                    <td valign="top" height="19" width="88%"><font face="Verdana" size="3"><b><a href="http://www.udaanindia.com/update060105.asp"><font size="2">UDAAN 
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
