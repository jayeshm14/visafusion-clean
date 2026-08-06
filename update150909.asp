<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
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

function reg()
{
location.href="registration.asp"
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
if(document.form1.name.value==""){
alert("Please enter your Name.")
document.form1.name.focus()
return false
}	
if(document.form1.u_mail.value==""){
alert("Please enter your Email address.")
document.form1.u_mail.focus()
return false
}
}
//-->
</script>
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
.style27 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
}
.style45 {font-family: Verdana, Arial, Helvetica, sans-serif}
.style50 {font-size: 16px; font-family: Arial, Helvetica, sans-serif;}
.style46 {font-size: 24px; color: #333333; font-family: "Times New Roman", Times, serif; }
.style68 {
	font-family: "Times New Roman", Times, serif;
	font-size: 24;
}
.style79 {font-family: Arial, Helvetica, sans-serif; font-size: 36px; color: #0000CC; font-weight: bold; }
.style67 {font-size: 18px}
.style47 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
	color: #0000CC;
	font-weight: bold;
}
.style82 {color: #000000; font-family: Verdana, Arial, Helvetica, sans-serif;}
.style83 {color: #0000FF}
.style84 {font-size: 18px; color: #0000CC; font-family: Arial, Helvetica, sans-serif;}
.style89 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 18px; }
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="MM_preloadImages('images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logonn2.gif','images/homen2.gif','images/profilen2.gif')">
<table width="750" border="0" cellspacing="0" cellpadding="0" align="left">
  <tr> 
    <td> 
      <table width="99%" border="0" cellspacing="0" cellpadding="0">
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
                <td width="12%"><a href="update.asp"><img src="images/updaten3.gif" width="102" height="20" name="Image2" border="0"></a></td>
                <td width="12%"><a href="registration.asp"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="contactus.asp"><img src="images/contactn1.gif" width="102" height="20" name="Image4" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="queries.asp"><img src="images/queriean1.gif" width="101" height="20" name="Image5" onMouseOver="MM_swapImage('Image5','','images/queriean2.gif',1)" border="0"></a></td>
                <td width="11%"><a href="logon.asp"><img src="images/logonn1.gif" width="100" height="20" name="Image6" onMouseOver="MM_swapImage('Image6','','images/logonn2.gif',1)" border="0"></a></td>
                <td width="17%"><img src="images/pixekn.gif" width="58" height="20"></td>
              </tr>
          </table>          </td>
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
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>                </td>
              </tr>
              <tr> 
                <td width="21" height="211">&nbsp;</td>
                <td colspan="3" height="211"> 
                  <img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6">
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="192"> 
                        <table width="751" align="center" height="345" border="1" bordercolor="#333333">
                          <tr> 
                            <td width="741" height="2" colspan="2">&nbsp;</td>
                          </tr>
                          <tr valign="top" > 
                            <td height="2" colspan="2"> 
                              <table width="99%" border="0" height="690">
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF">
                                  <td height="117" bordercolor="#000000"><table width="93%" border="0">
                                    <tr>
                                      <td><div align="center"><font face="Monotype Corsiva" size="7" color="#993366"><img src="updateimg/new%20visa-come-get-it.gif" width="468" height="76"> </font></div></td>
                                    </tr>
                                  </table>
                                    <div align="left"><b>= = = = = = = = 
                                      = = = = = = = = = = = = = = = = = = = 
                                      = = = = = = = = = = = = = = = = = =<br>
                                    </b></div></td>
                                </tr>
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF">
                                  <td height="46" bordercolor="#000000"><div align="center"><span class="style79">UDAAN HDFC ACCOUNT</span></div></td>
                                  </tr>
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF">
                                  <td height="124" bordercolor="#000000"><p class="style89"><strong>Dear Travel Partners;</strong><br>
                                      <br>
                                    For your convenience we have opened a current account with HDFC bank. Find below the account details for your reference. </p>
                                    <p class="style45"><span class="style89"><strong><br>
                                      A/c no:</strong><strong> 06788630000070<br>
                                    </strong><strong>Bank Name:</strong><strong> HDFCBank Ltd.<br>
                                    </strong><strong>Address: UG-10, Bhikaji Cama Place,</strong><strong>New Delhi</strong> <strong><br>
                                    RTGS/NEFT/IFSC: HDFC0000678</strong> </span><span class="style67"></span></p>
                                    <p class="style45"><FONT face=Arial size=2><br>
                                                                                                            </FONT></p></td>
                                  </tr>
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF"> 
                                  <td height="346" bordercolor="#000000"> 
                                    <div align="justify">
                                      <div align="left"><span class="style47"><span class="style82">NOTE:</span> </span><span class="style84"><span class="style82">If you are depositing or transfering any amount to our account please mark mail on:</span></span><span class="style47"><span class="style82"> <span class="style83"><a href="mailto:accounts.udaan@spectranet.com? &cc=hkshah@udaanindia.com" target="_blank">accounts.udaan@spectranet.com</a></span></span> </span><span class="style84"><span class="style82">and  cc:</span></span><span class="style47"><span class="style82"><strong> <a href="mailto: hkshah@udaanindia.com">hkshah@udaanindia.com</a></strong></span></span></div>
                                       <P align="left" class=style50><span class="style45"><br>
                                       </span></P>
                                       <p align="left" class='style27'><span class="style68"><span class="style46">Regards<br>
                                         Udaan Team</span></span><br>
                                          <font face="Verdana"> 
                                          ******************************************************************                                                    </font> </p>
                                       <table width="94%" border="1" height="74">
                                        <tr> 
                                          <td height="12"> 
                                            <div align="center">
                                              <div align="center"><font face="Verdana">&quot;Co-operate 
                                                and support us, to serve you better&quot; 
                                                </font> </div>
                                              <div align="left"> 
                                                <div align="center"><marquee behavior = "alternate">
                                                  <font face="Monotype Corsiva" color="#0000FF"><a href="http://www.udaanindia.com" target="_blank"><font color="#FF0000"><font color="#FF0033" face="Verdana"><b><font color="#333333">For 
                                                  more Information plz. log on 
                                                  to http://www.udaanindia.com</font></b></font></font></a>                                                  </font>
                                                </marquee></div>
                                              </div>
                                            </div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"></marquee></div>
                                            </div>                                          </td>
                                        </tr>
                                      </table>
                                      <img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="645" height="6"></div>                                  </td>
                                </tr>
                              </table>                            </td>
                          </tr>
                        </table>                      </td>
                    </tr>
                    </tbody> 
                </table>                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2">&nbsp;</td>
                <td height="2" width="650"> 
                  <div align="right">&nbsp;</div>                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3"> 
                          <div align="center"><u><font color="#0000FF" face="Arial, Helvetica, sans-serif"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="26%" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          </b></td>
                        <td width="24%" height="2"> 
                          <input type="button" name="Submit2" value="REGISTER NOW" onClick="return reg()">                        </td>
                      </tr>
                    </table>
                  </form>                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
              </tr>
            </table>          </td>
        </tr>
        <tr> 
          <td><!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>    </td>
  </tr>
</table>
</body>
</html>
