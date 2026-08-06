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
                <td width="21" height="706">&nbsp;</td>
                <td colspan="3" height="706"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="500" align="center" height="760">
                          <tr> 
                            <td height="694"> 
                              <table align="center" height="730" width="100%">
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">26th 
                                      March 2003</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="1" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="1"></td>
                                </tr>
                                <tr> 
                                  <td height="4" rowspan="4" width="252"> <img src="updateimg/malaysia.jpg" width="223" height="251"> 
                                  </td>
                                  <td height="2" width="243"> 
                                    <div align="center"><b><font face="Arial" size="4" color="#990099"><u></u></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" width="243"> 
                                    <div align="justify"><font face="Arial" size="2"><b>AS 
                                      PER RECENT NOTIFICATION FROM 'MALAYSIAN 
                                      HIGH COMMISSION ' NEW DELHI, WITH IMMEDIATE 
                                      EFFECT THE APPLICATION FORM HAS BEEN CHANGED. 
                                      &nbsp; </b></font></div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" width="243"> 
                                    <div align="justify"><font face="Arial" size="1">PLEASE 
                                      DOWNLOAD NEW FORMS BY CLICK ON BELOW LINKS, 
                                      YOU CAN SAVE IN YOUR COMPUTER AND OPEN IT 
                                      IN CURRENT LOCATION. THE FILES ARE IN .PDF 
                                      FORMAT (OPEN WITH ACROBAT READER), IT WILL 
                                      TAKE SOME TIME TO DOWNLOAD. PLEASE VISIT 
                                      WWW.UDAANINDIA.COM FOR MORE UPDATES. </font></div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" width="243"> 
                                    <table width="99%">
                                      <tr> 
                                        <td width="33%" height="2"><font size="2" face="Arial"><b><img src="http://www.ttsvisas.com/images/wwwgdl.gif"> 
                                          <a href="http://www.udaanindia.com/forms/malaysia.pdf" target="_blank"> 
                                          FORM</a> </b></font></td>
                                        <td width="14%" height="2"><a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank"><img src="http://images.google.com/images?q=tbn:EhR6JEY24CoC:www.websense.com/images/getacro.gif" border="0"></a></td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="1"></td>
                                </tr>
                                <tr > 
                                  <td height="370" colspan="2"> 
                                    <table width="100%" border="0" align="center" bgcolor="#CCFFFF">
                                      <tr> 
                                        <td colspan="2"> 
                                          <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt"><font color="#000066">SWITZERLAND</font></span></u></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2"> 
                                          <div align="justify"><b><font face="Arial" size="2">AS 
                                            PER RECENT NOTIFICATION FROM 'EMBASSY 
                                            OF SWITZERLAND' NEW DELHI, WITH IMMEDIATE 
                                            EFFECT VISA REQUIREMENT ARE AS FOLLOWS.</font> 
                                            </b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2"><b><font size="2" face="Arial"><font color="#FF6600">BASIC 
                                          VISA REQUIREMENTS : </font></font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"> 
                                          <div align="justify"><b><font size="2" face="Arial">Passport 
                                            which has to be valid at least for 
                                            three months beyond the stay in Switzerland 
                                            </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"> 
                                          <div align="justify"><b><font size="2" face="Arial">Copy 
                                            of the passport (pages: 1,2 and the 
                                            last page) </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="4%"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Visa 
                                          application form duly completed and 
                                          signed by the applicant </font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"> 
                                          <p><b><font size="2" face="Arial"> 1 
                                            passport size photograph of the applicant 
                                            </font></b></p>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"> 
                                          <div align="justify"><b><font size="2" face="Arial"> 
                                            Return air ticket to India </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign="top" height="2"> 
                                          <div align="justify"><b><font size="2" face="Arial"><font color="#FF6600">TOURIST 
                                            : </font></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign="top"> 
                                          <div align="justify"><b><font size="2" face="Arial" color="#FF0066">A 
                                            person travelling for the first time 
                                            to Switzerland has to come personally 
                                            to submit the application </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"><b><font face="Arial" size="2">Letter 
                                          of employment / self employment</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"> 
                                          <div align="justify"><b><font face="Arial" size="2">For 
                                            students: confirmation of University</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Financial 
                                          documents (memorandum, partnership deed, 
                                          income tax return form of the last 3 
                                          years, bank print out of the previous 
                                          6 months, foreign exchange endorsed 
                                          in the passport or a copy of the international 
                                          Credit Card)</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Persons 
                                          above 60 years of age should have an 
                                          international medical plan.</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Hotel 
                                          confirmation / bookings of the entire 
                                          stay</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Visa 
                                          for the country to be visited after 
                                          Switzerland.</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign="top"><b><font size="2" face="Arial" color="#FF6600">BUSINESS 
                                          :</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%"><b><font size="2" face="Arial">Invitation 
                                          by the Swiss firm with/without financial 
                                          responsibilities has to be sent to the 
                                          Embassy directly.</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="4%" valign="top" height="2"><b><font size="2" face="Arial">*</font></b></td>
                                        <td width="96%" height="2"> 
                                          <div align="justify"><b><font face="Arial" size="2">Proof 
                                            of business: correspondence, shipping 
                                            papers, invoices etc.</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2"><b><font size="2" face="Arial"> 
                                          <font color="#FF6600">FEE :</font> UP 
                                          TO 1 YEAR RS. 1400/- (ADULT), RS. 700/- 
                                          (CHILDREN) </font></b></td>
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
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update210303.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update030403.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
            <!-- #include file="HomeBottom.asp" --></td>
        </tr>
        <tr> 
          <td>&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
