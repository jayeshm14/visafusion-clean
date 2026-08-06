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
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1097">&nbsp;</td>
                <td colspan="3" height="1097"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="659" align="center" height="1037" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="877" colspan="2"> 
                              <table width="98%" border="1" height="913">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="806"> 
                                    <div align="justify">
                                      <table width="100%" border="0">
                                        <tr>
                                          <td>
                                            <div align="center"><img src="updateimg/update%20heading.png" width="173" height="67"></div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td>
                                            <div align="center"><img src="updateimg/Date%20Heading.png" width="395" height="67"></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <font face="Verdana" size="3"><b>Change 
                                      of Fee and payment procedure…<br>
                                      </b><br>
                                      <font size="2"><b>Spanish Visa</b> <br>
                                      With effect from December 01st, 2005 the 
                                      Spanish Visa Application fee will be payable 
                                      by demand draft drawn in favour of 'Embassy 
                                      of Spain' - New Delhi. Please note, the 
                                      fee remains the same at Rs.2, 030 /-<br>
                                      <br>
                                      <b>German Visa</b> <br>
                                      The Deutsche Embassy visa fee has changed 
                                      to Rs.2, 000 /- payable in cash<br>
                                      <br>
                                      <b>Latest Fee Structure from the Canada 
                                      High Commission </b><br>
                                      As per the instructions from the Canadian 
                                      High Commission, New Delhi and the Consulate 
                                      General of Canada, Chandigarh, Temporary 
                                      Resident Visa Fee is being revised with 
                                      effect from 18th November 2005.As per the 
                                      instructions from the Canadian High Commission, 
                                      New Delhi and the Consulate General of Canada, 
                                      Chandigarh, Temporary Resident Visa Fee 
                                      is being revised with effect from 18th November 
                                      2005.<br>
                                      The New Fee schedule is given below:<br>
                                      </font></font> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td width="8%"> 
                                            <div align="center"><font size="2" face="Verdana"><b>Sl. 
                                              No.</b></font></div>
                                          </td>
                                          <td width="53%"> 
                                            <div align="center"><font face="Verdana" size="2"><b>Category</b></font></div>
                                          </td>
                                          <td width="18%"> 
                                            <div align="center"><font face="Verdana" size="2"><b>INR</b></font></div>
                                          </td>
                                          <td width="21%"> 
                                            <div align="center"><font face="Verdana" size="2"><b>C$</b></font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="8%" height="17"> 
                                            <div align="center"><b><font size="3">1.</font></b></div>
                                          </td>
                                          <td width="53%" height="17"><font face="Verdana" size="2"><b>Temporary 
                                            Resident Visa/ Visitors</b></font></td>
                                          <td width="18%" height="17">&nbsp;</td>
                                          <td width="21%" height="17">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td width="8%" height="82">&nbsp;</td>
                                          <td width="53%" height="82"><font size="2" face="Verdana"><b>·</b> 
                                            Single Entry<br>
                                            <b>·</b> Multiple Entry<br>
                                            <b>·</b> Family rates for either Single 
                                            or <br>
                                            Multiple Entry (all family members<br>
                                            Must apply at the same time and place) 
                                            </font><br>
                                          </td>
                                          <td width="18%" height="82"> 
                                            <div align="center"><font size="2" face="Verdana">2775<br>
                                              5550<br>
                                              14800</font><br>
                                              <br>
                                            </div>
                                          </td>
                                          <td width="21%" height="82"> 
                                            <div align="center"><font size="2" face="Verdana">$75 
                                              <br>
                                              $150<br>
                                              $400</font><br>
                                              <br>
                                            </div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="8%"> 
                                            <div align="center"><b><font size="3">2.</font></b></div>
                                          </td>
                                          <td width="53%"><font face="Verdana" size="2"><b>Work 
                                            Permits</b></font></td>
                                          <td width="18%">&nbsp;</td>
                                          <td width="21%">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td width="8%">&nbsp;</td>
                                          <td width="53%"> 
                                            <div align="justify">· <font face="Verdana" size="2">Work 
                                              Permit<br>
                                              Work Permit-Group of 3 or more Performing 
                                              Artists (This fee is Applicable 
                                              on per person basis, but the total 
                                              amount will not exceed $ 450 in 
                                              the case of a group of three or 
                                              more performing artists and their 
                                              staffs who applies at the same time 
                                              and place) </font></div>
                                          </td>
                                          <td width="18%" valign="top"> 
                                            <div align="center"><font size="2" face="Verdana">5550 
                                              </font></div>
                                          </td>
                                          <td width="21%" valign="top"> 
                                            <div align="center"><font face="Verdana" size="2">$150</font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="8%"> 
                                            <div align="center"><font face="Verdana"><b><font size="3">3.</font></b></font></div>
                                          </td>
                                          <td width="53%"><font size="2" face="Verdana"><b>Study 
                                            Permits</b></font></td>
                                          <td width="18%"> 
                                            <div align="center"><font size="2" face="Verdana">4625</font></div>
                                          </td>
                                          <td width="21%"> 
                                            <div align="center"><font face="Verdana" size="2">$125</font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="8%"> 
                                            <div align="center"><b><font size="3">4.</font></b></div>
                                          </td>
                                          <td width="53%"><font size="2" face="Verdana"><b>Return 
                                            To Canada (for Permanent Residents)<br>
                                            -Travel Documents </b></font></td>
                                          <td width="18%"> 
                                            <div align="center"><font face="Verdana" size="2">1850</font></div>
                                          </td>
                                          <td width="21%"> 
                                            <div align="center"><font face="Verdana" size="2">$50</font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <font face="Verdana" size="3"><font size="2">Please 
                                      note, any demand draft made as per the current 
                                      schedule will not be accepted with effect 
                                      from 18th November 2005</font><br>
                                      <br>
                                      <b><font size="2">New Zealand : -</font><br>
                                      </b><font size="2">With effect from November 
                                      28th, 2005, the visa application fee for 
                                      New Zealand High Commission has changed 
                                      to Rs.3, 750 /- payable by demand draft 
                                      drawn in favour of 'New Zealand Immigration 
                                      Service' - New Delhi. Please note, a single 
                                      draft would serve for one single family 
                                      except for the below mentioned conditions:<br>
                                      <b>a.)</b> Children above 20 years will 
                                      require individual demand draft <br>
                                      <b>b.)</b> Couples who are engaged but not 
                                      married will require individual demand draft 
                                      </font><br>
                                      </font> 
                                      <p align="justify"><font face="Verdana" size="2"><b><font size="3">Holiday 
                                        Lists : -<br>
                                        </font></b><font size="3"> <font size="2"><b>1.)</b> 
                                        The Austrian Embassy - New Delhi will 
                                        remain closed from December 05th, 2005 
                                        to December 08th, 2005 <br>
                                        <b>2.)</b> The Immigration New Zealand 
                                        and TT Services New Zealand Section will 
                                        remain closed from December 24th, 2005 
                                        to January 01st, 2006 on the occasion 
                                        of Christmas and New Year <br>
                                        <b>3.)</b> The Embassy of the Republic 
                                        of Bulgaria will remain closed from December 
                                        02nd, 2005 to December 06th, 2005 </font></font></font></p>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="2"> 
                                            <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                              and support us, to serve you better</font> 
                                              &quot;</div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><b><img src="updateimg/bird76.gif" width="40" height="40">Udaan 
                                                India Pvt. Ltd.</b></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="645" height="6"></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"></font></b></td>
                <td height="2" width="650"> 
                  <div align="right">&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3"> 
                          <div align="center"><u><font color="#0000FF" face="Arial, Helvetica, sans-serif"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="26%" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          </b></td>
                        <td width="24%" height="2"> 
                          <input type="button" name="Submit2" value="REGISTER NOW" onClick="return reg()">
                        </td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
