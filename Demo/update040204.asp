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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="1226">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1105">&nbsp;</td>
                <td colspan="3" height="1105"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width='572' border='1' align='center' bordercolor='#0000FF' height="671">
                          <tr> 
                            <td height='1104'> 
                              <table align='center' height='546' width='100%'>
                                <tr> 
                                  <td height='2' colspan='2'> 
                                    <div align='center'><b><font 
            face='Arial Black' color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face='Arial' color='#000080' size='4'>4th 
                                      February 2004</font></i></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height='107' colspan='2'> 
                                    <table width='100%' border='0' align='center' bgcolor='#CCFFFF' height='8'>
                                      <tr> 
                                        <td colspan='2' height="2"> 
                                          <div align='center'><font face="Arial"><b><font color='#800080' size='4'><u><span style='mso-bidi-font-size: 10.0pt'><font color='#000066'>SWITZERLAND</font></span></u></font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="2"> 
                                          <div align="justify"><b><font face="Arial" size="2">'EMBASSY 
                                            OF SWITZERLAND' NEW DELHI, HAS EFFACTUATED 
                                            STRINGENT REGULATIONS FOR VISA APPLICATIONS. 
                                            WITH IMMEDIATE EFFECT THE FOLLOWING 
                                            REQUIREMENTS WILL BE MANDATORY FOR 
                                            VISA PROCESSING.<br>
                                            <br>
                                            <font color="#FF0066">ALSO THEY WILL 
                                            NOT BE ACCEPTING ANY VISA APPLICATION 
                                            ON ALL WEDNESDAYS, ONLY PAX WHO ARE 
                                            CALLED FOR PERSONAL INTERVIEW WILL 
                                            BE ATTENDED ON WEDNESDAY. </font></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="62"> 
                                          <p align="justify"><font face="Arial" size="1">PLEASE 
                                            DOWNLOAD NEW VISA REQUIREMENTS FOR 
                                            DIFFRENT CATEGORIES BY CLICK ON BELOW 
                                            LINKS, YOU CAN SAVE IN YOUR COMPUTER 
                                            AND OPEN IT IN CURRENT LOCATION. THE 
                                            FILES ARE IN .PDF FORMAT (OPEN WITH 
                                            ACROBAT READER), IT WILL TAKE SOME 
                                            TIME TO DOWNLOAD.</font><b><font face="Arial" size="2"><br>
                                            <br>
                                            <a href="http://www.udaanindia.com/updateimg/Switzerland-all-req.pdf">VISA 
                                            REQUIREMENTS FOR VARIUS CATEGORIES</a><br>
                                            <br>
                                            FOR DOWNLOAD ACROBAT READER <a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank"><img src="http://www.adobe.com/images/get_adobe_reader.gif" border="0"></a></font></b></p>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height='2' colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='561' height='1'></td>
                                </tr>
                                <tr > 
                                  <td height='635' colspan='2'> 
                                    <table width='100%' border='0' align='center' bgcolor='#CCFFFF' height='420'>
                                      <tr> 
                                        <td colspan='2'> 
                                          <div align='center'><font face="Arial"><b><font color='#800080' size='4'><u><span style='mso-bidi-font-size: 10.0pt'><font color='#000066'>SLOVAK</font></span></u></font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="63"> 
                                          <div align="center"><font size="4" face="Arial"><u><i>Information 
                                            on visa for the Slovak Republic for 
                                            citizens of Indian</i></u></font><font face="Arial"><br>
                                            &nbsp; <br>
                                            <i><font size="2"><b>Submitting of 
                                            application for visa Tuesday and Thursday 
                                            10.00 -12.00 & 14.00 -16.00 hours 
                                            Collection of passport after 21 days.</b></font></i></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2'> 
                                          <div align="justify"><font face="Arial"><b><font size='2'><font color="#FF6600" size="3"><i><u>General 
                                            Visa Requirements:</u></i></font></font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%'> 
                                          <div align="justify"><font face="Arial">Valid 
                                            passport</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face="Arial">Application 
                                            form duly filled in + 1 photograph 
                                            </font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign="top"> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%'> 
                                          <div align="justify"><font face="Arial">Return 
                                            air-ticket confirmed (not open for 
                                            return flight)</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <p align='justify'><font face="Arial">Original 
                                            of invitation from the business partner 
                                            in Slovak (company, Chamber of Commerce 
                                            etc.) duly verified by the Slovak 
                                            authorities (Foreign Police Department)</font></p>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face="Arial">Bail 
                                            payment has to be deposited with the 
                                            Slovak Embassy in New Delhi.</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' height='2' valign='top'> 
                                          <div align="justify"><font face="Arial"><b>-</b></font></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face="Arial"><b>All 
                                            applicants are required to pay the 
                                            related expenses for the Slovak visa 
                                            label in amount of 100 Slovak crown. 
                                            The new rules are being applied worldwide 
                                            in all countries whose nationals required 
                                            visas to enter the Slovak Republic.</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <p align="justify"><font face="Arial">-</font></p>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face="Arial">Overseas 
                                            Insurance</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'> 
                                          <div align="justify"><font face="Arial">-</font></div>
                                        </td>
                                        <td width='96%'> 
                                          <div align="justify"><font face="Arial">Per 
                                            day 50US$ for expenses.<br>
                                            &nbsp; </font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'><font face="Arial">1.</font></td>
                                        <td width='96%'> 
                                          <div align="justify"><font face="Arial"> 
                                            The applicant for Slovak visa has 
                                            to personally come and submit his 
                                            application as well as for the collection 
                                            of the passport to the Slovak Embassy 
                                            in New Delhi. Applications submitted 
                                            through agents or travel agencies 
                                            will not be accepted.</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'><font face="Arial">2.</font></td>
                                        <td width='96%'> 
                                          <div align="justify"><font face="Arial">As 
                                            every application is considered individually, 
                                            there can be specific requirements 
                                            i.e personal interview with the applicant.</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'><font face="Arial">3.</font></td>
                                        <td width='96%'><font face="Arial">There 
                                          is no visa fee for Indian citizens.</font></td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'><font face="Arial">4.</font></td>
                                        <td width='96%'><font face="Arial">Visa 
                                          can be issued only by the Slovak Embassy 
                                          in New Delhi.</font></td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'><font face="Arial">5.</font></td>
                                        <td width='96%'><font face="Arial">Minimum 
                                          validity of the passport should not 
                                          be less than 6 months.</font></td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'>6<font face="Arial">. 
                                          </font></td>
                                        <td width='96%'><font face="Arial">No 
                                          exception from the above rules will 
                                          be entertained<br>
                                          &nbsp; </font></td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign='top' height="2"> 
                                          <div align="center"><font face="Arial" size="2"><font size="4"><u>IMPORTANT, 
                                            PLEASE NOTICE!</u></font> <br>
                                            &nbsp; </font> </div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign='top' height="2"> 
                                          <div align="left"><font face="Arial"><b><u>Instruction 
                                            for Indian visa applicants :-</u><br>
                                            &nbsp; </b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height="2"><font face="Arial">1. 
                                          </font></td>
                                        <td width='96%' height="2"> 
                                          <div align="justify"><font face="Arial">Time 
                                            of visa processing is approximately 
                                            21 days for the holders of the ordinary 
                                            passport.</font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height="2"> 
                                          <div align="justify"><font face="Arial">2.</font></div>
                                        </td>
                                        <td width='96%' height="2"> 
                                          <div align="justify"><font face="Arial">Time 
                                            of visa processing is approximately 
                                            14 days for holders of the diplomatic 
                                            and service passport. The period less 
                                            than 14 days only in cases of cultural 
                                            exchanges and visits under other bilateral 
                                            exchanges.</font></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height='2' colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='561' height='1'></td>
                                </tr>
                                <tr bgcolor="#CCFFFF" > 
                                  <td height='2' colspan='2'> 
                                    <div align="center"><font face="Arial" size="2"><b><font color="#FF3366"><font size="4" color="#000066"><u>NIGERIA</u> 
                                      </font></font></b></font></div>
                                  </td>
                                </tr>
                                <tr bgcolor="#CCFFFF" > 
                                  <td height='2' colspan='2'> 
                                    <div align="justify"><font face="Arial" size="2"><b>WITH 
                                      IMMEDIATE EFFECT THE 'HIGH COMMISSION OF 
                                      THE FEDERAL REPUBLIC OF NIGERIA' - NEW DELHI 
                                      NOW REQUIRES THE INVITATION LETTER IN ORIGINAL 
                                      (FAX COPY OR PHOTO COPY WILL NOT BE ACCEPTED) 
                                      AND CERTIFICATE OF INCORPORATION OF THE 
                                      NIGERIAN COMPANY SHOULD SPECIFICALLY MENTION 
                                      THE RC NO. OF THE NIGERIAN COMPANY AND ATTESTED 
                                      BY MINISTRY OF FORIEGN AFFAIRS FOR BUSINESS 
                                      VISAS. </b></font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update190104.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update120204.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
