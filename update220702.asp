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
<table width="762" border="0" cellspacing="0" cellpadding="0" align="left">
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
            <table width="99%" border="0" cellspacing="0" cellpadding="0" height="469">
              <tr> 
                <td width="21">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" width="783"> 
                  <div align="center"><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">22nd July 2002</font></i></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="512">&nbsp;</td>
                <td colspan="3" height="512" width="783"> 
                  <table width="98%" border="0" height="439">
                    <tr> 
                      <td colspan="4" height="2"> 
                        <p align="center"><b><font color="#000080"> </font></b>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="21"> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2"><font face="Arial" size="2"><b><marquee>NOW 
                        YOU CAN CHECK YOUR VISA CASES&#146; STATUS AND DOCUMENTATION 
                        PROCEDURES FOR VARIOUS COUNTRIES &amp; CATEGORIES ONLINE AT 
                        WWW.UDAANINDIA.COM. </marquee></b></font></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" bgcolor="#FFCCCC"> 
                        <p align="center"><b><font size="5" color="#0000FF">STRUCTURE 
                          FOR VISA FEE PAYABLE BY DEMAND DRAFT</font></b> 
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="1128"> 
                        <div align="justify"> 
                          <p><font face="Arial" size="2"><font face="Arial" size="2"><font face="Arial" size="2"><font color="#990099"><b>MALAYSIA</b></font></font> 
                            FEE DRAFT FAVOURING '<b>MALAYSIAN HIGH COMMISSION</b>' 
                            - NEW DELHI.<br>
                            <b>SINGLE ENTRY</b> RS. 650 D/D CHGS.: RS.75/- <br>
                            <b>MULTIPLE ENTRY</b> RS. 1,300/- D/D CHGS. : RS.75/- 
                            <br>
                            </font></font></p>
                          <p><font face="Arial" size="2"><font color="#990099"><b>AUSTRALIA</b></font> 
                            FEE DRAFT FAVOURING '<b>AUSTRALIAN HIGH COMMISSION</b>' 
                            - NEW DELHI. BUSINESS (SUBCLASS 456) <b>VISITOR (SHORT 
                            STAY)</b>:RS.2000/- D/D CHGS.: RS.75/- <br>
                            <b>TEMPORARY BUSINESS CLASS 1066 (MORE THAN 3 MONTHS) 
                            </b>: RS.4800/- D/D CHGS. : RS.75/- <br>
                            <b>STUDENT VISA APPLICATION SUBCLASS 157 W </b>: RS.9300/- 
                            D/D CHGS. : RS.100/- </font></p>
                          <p><font face="Arial" size="2"><font color="#990099"><b>NEWZEALAND</b></font> 
                            FEE DRAFT FAVOURING '<b>NEWZEALAND IMMIGRATION SERVICE</b>' 
                            - NEW DELHI <br>
                            <b>VISIT</b> : RS.2200/- D/D CHGS. RS.75/- (BUSINESS/TOURIST) 
                            <br>
                            <b>WORK</b> : RS. 5000/- D/D CHGS. RS.75/- STUDENT 
                            /-<br>
                            <b>TRANSIT</b> : RS.3500/- D/D CHGS. RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">TAIWAN</font></b> 
                            FEE DRAFT FAVOURING '<b>TAIPEI ECONOMIC AND CULTURAL 
                            CENTER</b>' - NEW DElHI <br>
                            <b>VISITOR</b> : RS.1700/- D/D CHAGS. RS.75/- (TOURIST 
                            / BUSINESS) <br>
                            <b>MULTIPLE ENTRY</b> : RS.3400/- DRAFT CHAGS. RS.75/- 
                            (TOURIST / BUSINESS) <br>
                            <b>URGENT FEE (SINGLE ENTRY)</b> : RS.850/- D/D CHGS.: 
                            RS.75/- <br>
                            <b>URGENT FEE (MULTIPLE ENTRY)</b> : RS.1700/- D/D 
                            CHGS. RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">UGANDA</font></b> 
                            FEE DRAFT FAVOURING '<b>UGANDA HIGH COMMISSION</b>' 
                            - NEW DELHI <br>
                            <b>VISITOR (SINGLE ENTRY)</b> - RS.2500/- D/D CHGS 
                            RS.75/- <br>
                            <b>MULTIPLE ENTRY</b> - RS.5000/- D/D CHGS RS.150/- 
                            </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">CANADA</font></b> 
                            FEE DRAFT FAVOURING '<b>CANADIAN HIGH COMMISSION</b>' 
                            - NEW DELHI <br>
                            <b>SINGLE ENTRY</b> - RS.2250/- D/D CHGS RS.75/- <br>
                            <b>MULTIPLE ENTRY</b> - RS.4500/- D/D CHGS RS.75/- 
                            <br>
                            <b>EMPLOYMENT AUTORISATION</b> - RS.4500/- D/D CHGS 
                            RS.75/- <br>
                            <b>STUDENT AUTHORISATION</b> - RS.3750/- D/D CHGS 
                            : RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">BRAZIL</font></b> 
                            FEE DRAFT FAVOURING '<b>EMBASSY OF BRAZIL</b>' - NEW 
                            DELHI <br>
                            <b>BUSINESS VISA FEE</b> - RS.3850/- D/D. CHGS RS.75/- 
                            <br>
                            <b>TOURIST VISA FEE</b> - RS.1650/- D/D. CHGS RS.75/- 
                            <br>
                            <b>ATTESTATION</b> - RS.1100/- D/D. </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">IRELAND</font></b> 
                            FEE DRAFT FAVOURING '<b>EMBASSY OF IRELAND</b>' - 
                            NEW DELHI <br>
                            <b>SINGLE ENTRY VISA FEE</b> - RS.1300/- D/D. CHARGES 
                            RS.75/- <br>
                            <b>MULTIPLE ENTRY VISA FEE</b> - RS.2600/- D/D. CHARGES 
                            RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">U.K.</font></b> 
                            FEE DRAFT FAVOURING '<b>BRITISH HIGH COMMISSION</b>' 
                            - NEW DELHI <br>
                            <b>(A) STANDARD VISA FEE</b> - RS.2700/- D/D CHGS 
                            RS.75/- <br>
                            <b>1 YEAR MULTIPLE ENTRY VISA FEE </b>- RS.4500/- 
                            D/D CHGS RS.75/- <br>
                            <b>2 YEAR MULTIPLE ENTRY VISA FEE</b> - RS.5250/- 
                            D/D CHGS RS.75/- <br>
                            <b>5 YEAR MULTIPLE ENTRY VISA FEE</b> - RS.6600/- 
                            D/D CHGS RS.75/- <br>
                            <b>(B) SETTLEMENT AND MARRIAGE</b> - RS.19500/- D/D 
                            CHGS RS.75/- <br>
                            <b>(C) CERTIFICATE OF ENTITLEMENT</b> - RS.8250/- 
                            D/D CHGS RS.75/- <br>
                            <b>(D) ALL OTHER LONG TERM ENTRY</b> - RS.5650/- D/D 
                            CHGS RS.75/- <br>
                            <b>(E) DIRECT AIRSIDE TRANSIT</b> - RS.2000/- D/D 
                            CHGS RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">NETHERLAND</font></b> 
                            VISA FEE DRAFT FAVOURING '<b>ROYAL NETHERLANDS EMBASSY</b>' 
                            - NEW DELHI <br>
                            <b>1 MONTH SINGLE / MULTIPLE ENTRY VISA FEE</b> - 
                            RS.1170/- D/D CHGS RS.75/- <br>
                            <b>3 MONTHS SINGLE ENTRY</b> - RS.1400/- D/D CHGS 
                            RS.75/- <br>
                            <b>3 MONTHS MULTIPLE ENETRY</b> - RS.1640/- D/D CHGS 
                            RS.75/- <br>
                            <b>1 YEAR MULTIPLE ENTRY</b> - RS.2340/- D/D CHGS 
                            RS.75/- <br>
                            <b>TRANSIT VISA FEE</b> RS. 470/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">PHILIPPINES</font></b> 
                            VISA FEE DRAFT FAVOURING '<b>THE EMBASSY OF PHILIPPINES</b>' 
                            - NEW DELHI <br>
                            <b>SINGLE ENTRY VISA FEE</b> - RS.1380/- D/D CHGS 
                            : RS.75/- <br>
                            <b>6 MONTHS MULTIPLE ENTRY VISA FEE</b> - RS.2760/- 
                            D/D CHGS : RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">U.S.A.</font></b> 
                            FEE DRAFT FAVOURING '<b>AMERICAN EMBASSY</b>' - NEW 
                            DELHI PROCESSING <br>
                            <b>FEE</b> - RS.3185/- D/D CHGS: RS.75/- <br>
                            <b>VISA FEE</b> - RS.3675/- D/D CHGS : RS.75/- </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">ETHIOPIA</font></b> 
                            VISA FEE FAVOURING <b>'ETHIOPIAN EMBASSY</b>' - NEW 
                            DELHI <br>
                            <b>TOURIST VISA FEE</b> - RS.1974/- D/D CHGS RS.75/- 
                            <br>
                            <b>BUSINESS VISA FEE</b> - RS.2068/- D/D CHGS RS.75/- 
                            <br>
                            <b>TRANSIT VISA FEE</b> - RS.1927/- D/D CHGS RS.75/- 
                            </font></p>
                          <p><font face="Arial" size="2"><b><font color="#990099">INDONESIA</font></b> 
                            VISA FEE FAVOURING '<b>INDONESIAN EMBASSY</b>' - NEW 
                            DELHI <br>
                            <b>SINGLE ENTRY</b> - RS. 1500.00 <br>
                            <b>1 YEAR STAY (SINGLE ENTRY) </b>- RS. 2550.00 <br>
                            <b>1 YEAR STAY (MULTIPLE ENTRY)</b> - RS. 3200.00 
                            <br>
                            <b>TRANSIT</b> - RS. 650.00 </font></p>
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2">&nbsp;</td>
                    </tr>
                    <tr bgcolor="#FFCCCC"> 
                      <td colspan="4" height="2"> 
                        <div align="center"><b><font size="5" color="#0000FF">U.S.A.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2"> 
                        <div align="JUSTIFY"><font face="Arial" size="2"><b>AS 
                          PER NEW DROP BOX RULES FROM NOW ON ONLY THE FOLLOWING 
                          WOULD BE ALLOWED TO USE THE DROP BOX FACILITY, REST 
                          ALL CRITERIA FOR VISITOR DROP BOX HAVE BEEN DISCONTINUED 
                          BY THE U.S. EMBASSY. <br>
                          <br>
                          1. PAX SHOULD HAVE TRAVELLED TO THE U.S. AT LEAST ONCE 
                          (MAINTAINING PROPER STATUS) ON A MULTIPLE VISA WHICH 
                          EXPIRED WITHIN THAN TWO YEARS BEFORE THE CURRENT APPLICATION 
                          <br>
                          <br>
                          2. PAX SHOULD BE OVER THE AGE OF 60 YEARS AT THE TIME 
                          OF APPLICATION </b></font></div>
                      </td>
                    </tr>
                    <tr bgcolor="#FFCCCC"> 
                      <td colspan="4" height="2"> 
                        <div align="JUSTIFY"> 
                          <p><font face="Arial, Helvetica, sans-serif"><b><font color="#FF0033" size="5">Kindly 
                            do not use our email id udaan@del3.vsnl.net.in</font><font color="#FF0033">,</font> 
                            For quick response to your queries mail at <font color="#0000FF">udaan@spectranet.com</font>, 
                            <font color="#0000FF">udaan@udaanindia.com</font> 
                            FOR ALL URGENT INFORMATIONS - FACSIMILE : 011 - 616 
                            0606. </b></font></p>
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2" width="69"><b><font face="Arial, Helvetica, sans-serif"><a href="update180702.asp"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="712" height="2"> 
                  <div align="right"><a href="update240702.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2" width="783"> 
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
          <td> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
