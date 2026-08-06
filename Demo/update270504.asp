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
    <td height="1365"> 
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
          <td height="1249"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="1294">
              <tr> 
                <td width="21" height="47">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="47"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1231">&nbsp;</td>
                <td colspan="3" height="1231"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width='649' border='1' align='center' bordercolor='#0000FF' height="2158">
                          <tr> 
                            <td height='2154'> 
                              <table align='center' height='2152' width='100%' bgcolor="#FFFFCC">
                                <tr> 
                                  <td height='39' colspan='2'> 
                                    <div align='center'><b><font 
            face='Arial Black' color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face='Arial' color='#000080' size='4'>27th,MAY 
                                      2004</font></i></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height='2' colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='640' height='9'></td>
                                </tr>
                                <tr > 
                                  <td height='1170' colspan='2'> 
                                    <table width='100%' border='0' align='center' bgcolor='#CCFFFF' height='420'>
                                      <tr> 
                                        <td colspan='2' height="683"> 
                                          <div align="center"> 
                                            <table width="629" border="0" cellpadding="0" height="344">
                                              <tr> 
                                                <td height="334"> 
                                                  <div align="center"> 
                                                    <p><font size="5"><b><font size="6">GREECE</font></b></font></p>
                                                    <p align="left"><b><font face="Garamond">FURTHER 
                                                      TO RECENT NOTIFICATION FROM 
                                                      THE &quot;EMBASSY OF GREECE&quot;-NEW 
                                                      DELHI,</font></b><font face="Garamond">THE 
                                                      VISA SECTION WOULD OPERATE 
                                                      ON THE FOLLOWING ARRANGEMENT 
                                                      WITH THE IMMEDIATE EFFECT.</font><b><font face="Garamond"><br>
                                                      <br>
                                                      SUBMISSION -------------------TUESDAY 
                                                      &amp; THURSDAY------BETWEEN 
                                                      10A.M.--</font></b><font face="Garamond"><b>12P.M.<br>
                                                      COLLECTION------------------FRIDAY 
                                                      ONLY---------------------BETWEEN 
                                                      12P.M.--1:00P.M. <br>
                                                      <br>
                                                      </b>THE EMBASSY WOULD ACCEPT 
                                                      ONLY <b>TWO</b> APPLICATIONS 
                                                      FROM EACH AGENT IN A DAY. 
                                                      HOWEVER, A GROUP OR FAMILY 
                                                      TRAVELLING TOGETHER WOULD 
                                                      BE CONSIDERED AND ACCEPTED 
                                                      AS ONE APPLICATION AND PROCESSED 
                                                      TOGETHER.<br>
                                                      <br>
                                                      APPLICATIONS SUBMITTED ON 
                                                      <b>TUESDAY &amp; THURSDAY 
                                                      </b> WOULD BE READY FOR 
                                                      COLLECTION ON <b>FRIDAY</b>. 
                                                      PRIORITY REQUEST WOULD NOT 
                                                      BE ENTERTAINED IN ANY CIRCUMSTANCE 
                                                      WHATSOEVER.<br>
                                                      <br>
                                                      </font></p>
                                                    <p align="left">&nbsp;</p>
                                                  </div>
                                                </td>
                                              </tr>
                                            </table>
                                            <p align="center"><b><font size="5">SINGAPORE</font></b></p>
                                            <p align="left"><b><font face="Garamond">FURTHER 
                                              TO NOTIFICATION FROM THE &quot;EMBASSY 
                                              OF THE REPUBLIC OF SINGAPORE&quot;-NEW 
                                              DELHI,</font></b><font face="Garamond">COMPLETE 
                                              AN APPLICATION FORM TOGETHER WITH 
                                              A RECENT PASSPORT-SIZE PHOTOGRAPH<b>( 
                                              35 MM WIDE</b> <b>BY 45 MM ) </b>HIGH 
                                              WITHOUT BORDER AND TAKEN WITHIN 
                                              THE LAST 3 MONTHS;TAKEN FULL FACE 
                                              WITHOUT HEADGEAR,UNLESS THE APPLICANT 
                                              HABITUALLY WEARS A HEADGEAR IN ACCORDANCE 
                                              WITH HIS/HER RELIGIOUS OR RACIAL 
                                              CUSTOM BUT THE HEADGEAR MUST NOT 
                                              HIDE THE APPLICANT'S FEATURES.THE 
                                              FACIAL IMAGE MUST BE BETWEEN<b>( 
                                              25 MM AND 35 MM )</b> FROM CHIN 
                                              TO CROWN;TAKEN AGAINST A PLAIN WHITE 
                                              BACKGROUND WITH MATT OR SEMI-MATT 
                                              FINISH.</font></p>
                                            <p><b><font color='#800080' size='4' face='Arial'><u><span style='mso-bidi-font-size: 10.0pt'><font color="#000066">NETHERLANDS 
                                              </font></span></u></font></b></p>
                                          </div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="471"> 
                                          <div align="JUSTIFY"> 
                                            <p><b><font face="Arial" size="2">NOW 
                                              NETHERLANDS EMBASSY WILL ONLY ACCEPT 
                                              VISAS AND MVV APPLICATIONS THROUGH 
                                              AN APPOINTMENT SYSTEM.<br>
                                              <i><br>
                                              </i>HOW TO MAKE YOUR APPOINTMENT:-</font></b><font face="Arial" size="2"><br>
                                              YOU CALL THE NETHERLANDS EMBASSY 
                                              THROUGH A SPECIAL NO. FOR APPOINTMENT 
                                              FOR VISA:-(011)-55687000.<br>
                                              APPOINETMENT CAN BE MADE ON MONDAYS 
                                              THROUGH THURSDAYS BETWEEN 10:00 
                                              - 14:00 HOURS.<br>
                                              <b>WHILE MAKING THE APPOINTMENT 
                                              YOU HAVE TO PROVIDE THE OFFICER 
                                              WITH THE FOLLOWING DETAILS:-</b><br>
                                              1.) DATE OF BIRTH OF APPLICANT.<br>
                                              2.) NAME OF THE APPLICANT.<br>
                                              3.) PASSPORT NO. OF THE APPLICANT.<br>
                                              <br>
                                              <b>FOR THE APPOINTMENT YOU HAVE 
                                              THREE OPTIONS:- </b><br>
                                              1.) BETWEEN 09:00 -10:00 A.M<br>
                                              2.) BETWEEN 10:00 - 11:00 A.M<br>
                                              3.) BETWEEN 11:00 - 12:00 A.M<br>
                                              <br>
                                              IT IS ESSENTIAL THAT YOU COME IN 
                                              TIME ACCORDING TO THE FIXED APPOINTMENT. 
                                              DO NOT COME LATE BECAUSE IF YOU 
                                              DO SO, YOUR APPOINTMENT WILL BE 
                                              CANCELLED AND YOU HAVE TO CALL THE 
                                              EMBASSY AGAIN IN ORDER TO MAKE A 
                                              NEW APPOINTMENT.<br>
                                              <br>
                                              ALL PERSONS WHO COME TO THE VISA 
                                              SECTION WITHOUT A FIXED APPOINTMENT 
                                              WILL NOT GAIN ACCESS TO THE VISA 
                                              SECTION OF THE EMBASSY.APPOINTMENT 
                                              CAN NOT BE ARRANGED AT THE GATE, 
                                              BUT ONLY BY TELEPHONE.</font></p>
                                          </div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height='393' colspan='2'> 
                                    <table width='100%' border='0' align='center' bgcolor='#CCFFFF' height='420'>
                                      <tr> 
                                        <td colspan='2'> 
                                          <div align="center"><b><font color='#800080' size='4' face='Arial'><u><span style='mso-bidi-font-size: 10.0pt'><font color="#000066">POLAND 
                                            </font></span></u></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="2"> 
                                          <div align="JUSTIFY"><b><font face="Arial" size="2">FURTHER 
                                            TO NOTIFICATION FROM THE "EMBASSY 
                                            OF THE REPUBLIC OF POLAND"-NEW DELHI, 
                                            WITH IMMEDIATE EFFECT THE SUBMISSION 
                                            OF APPLICATIONS CAN BE DONE BE ON 
                                            THREE WORKING DAYS I.E. MONDAY WEDNESDAY 
                                            AND FRIDAY. THE COLLECTION OF PASSPORTS 
                                            WILL BE FACILITATED ONLY MONDAY AND 
                                            FRIDAY.</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='561' height='1'></td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2'> 
                                          <div align='center'><b><font color='#800080' size='4' face='Arial'><u><span style='mso-bidi-font-size: 10.0pt'><font color='#000066'>CZECH</font></span></u></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' height="2"> 
                                          <div align="justify"><b><font face='Arial' size='2'>'EMBASSY 
                                            OF THE CZECH REPUBLIC ' NEW DELHI, 
                                            HAS EFFACTUATED STRINGENT REGULATIONS 
                                            FOR VISA APPLICATIONS. WITH IMMEDIATE 
                                            EFFECT THE FOLLOWING REQUIREMENTS 
                                            WILL BE MANDATORY FOR VISA PROCESSING.</font> 
                                            </b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2'> 
                                          <div align="left"><b><font size='2' face='Arial'><font color='#FF6600'>COMMON 
                                            REQUIREMENTS FOR SHORT TERM CZECH 
                                            VISA FOR STAY UPTO 90 DAYS :</font></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'> 
                                          <div align="justify"><b><font size='2' face='Arial'>A) 
                                            </font></b></div>
                                        </td>
                                        <td width='96%'> 
                                          <div align="justify"><b><font size='2' face='Arial'>PASSPORT 
                                            WITH VALIDITY BEYOND 3 MONTHS OF THE 
                                            REQUESTED VISA VALIDITY AND A BLANK 
                                            PAGE. </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <div align="justify"><b><font size='2' face='Arial'>B)</font></b></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><b><font size='2' face='Arial'> 
                                            ONE PASSPORT SIZE PHOTO WITH LIGHT 
                                            BACKGROUND WITH PRESENT APPEARANCE 
                                            TO BE GLUED AT THE APPROPRIATE PLACE 
                                            ON THE VISA APPLICATION. </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign="top" height="2"> 
                                          <div align="left"><font face='Arial' size='2'><b>C) 
                                            </b></font></div>
                                        </td>
                                        <td width='96%' height="2"> 
                                          <div align="justify"><font size='2' face='Arial'><b>VISA 
                                            APPLICATION DULY FILLED AND SIGNED 
                                            BY THE APPLICANT.</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <div align="left"><b><font face='Arial' size='2'>D)</font></b></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <p align='left'><b><font size='2' face='Arial'> 
                                            RETURN CONFIRMED AIR TICKET.</font></b></p>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='33'> 
                                          <div align="left"><b><font face='Arial' size='2'>E)</font></b></div>
                                        </td>
                                        <td width='96%' height='33'> 
                                          <div align="justify"><b><font size='2' face='Arial'> 
                                            COVERING LETTER WRITTEN BY THE APPLICANT 
                                            OR COMPANY EXPLAINING THE PURPOSE 
                                            OF VISIT.</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' height='2' valign='top'> 
                                          <div align="left"><font face='Arial' size='2'><b>F) 
                                            </b></font></div>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face='Arial' size='2'><b><font color="#FF6600">1. 
                                            FOR BUSINESS:</font> CZECH IMMIGRATION 
                                            POLICEVERIFIED INVITATION FROM THE 
                                            INVITING COMPANY OR INSTITUTION OF 
                                            THE CZECH REPUBLIC IN ORIGINAL. (PHOTOCOPY 
                                            OR FAX COPY NOT ALLOWED)PROOF OF FINANCIAL 
                                            SUPPORT .</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height='2'> 
                                          <p align="left"><font face='Arial' size='2'></font></p>
                                        </td>
                                        <td width='96%' height='2'> 
                                          <div align="justify"><font face='Arial' size='2'><b><font color="#FF6600">2. 
                                            FOR PRIVATE VISIT:</font> SPONSORING 
                                            LETTER FROM THE INVITING PERSON FROM 
                                            THE CZECH REPUBLIC VERIFIED BY THE 
                                            CZECH IMMIGRATION POLICE. PROOF OF 
                                            FINANCIAL SUPPORT</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top'> 
                                          <div align="left"><font face='Arial' size='2'></font></div>
                                        </td>
                                        <td width='96%'> 
                                          <div align="justify"><font face='Arial' size='2'><b><font color="#FF6600">3. 
                                            FOR TOURIST:</font> CONFIRMATION OF 
                                            HOTEL RESERVATION VOUCHER IN THE CZECH 
                                            REPUBLIC IN ORIGINAL. PROOF OF FINANCIAL 
                                            SUPPORT.</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height="2"> 
                                          <div align="left"></div>
                                        </td>
                                        <td width='96%' height="2"> 
                                          <div align="justify"><b><font face="Arial" size="2" color="#FF6600">4. 
                                            FOR SPORTS, CULTURAL:</font><font face="Arial" size="2"> 
                                            INVITATION LETTER FROM THE ORGANISERS 
                                            OF THE EVENT IN THE CZECH REPUBLIC 
                                            VERIFIED BY THE CZECH IMMIGRATION 
                                            POLICE. PROOF OF FINANCIAL SUPPORT. 
                                            </font> </b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height="2"> 
                                          <div align="left"><b><font face='Arial' size='2'>G)</font></b></div>
                                        </td>
                                        <td width='96%' height="2"> 
                                          <div align="justify"><b><font face='Arial' size='2'> 
                                            PERSONAL PRESENCE OF THE APPLICANT. 
                                            THE APPLICANT CAN BE INTERVIEWED BY 
                                            THE CONSUL IF NECESSARY.</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width='4%' valign='top' height="2"> 
                                          <div align="justify"><b><font size="2" face="Arial">H) 
                                            </font></b></div>
                                        </td>
                                        <td width='96%' height="2"> 
                                          <div align="left"><b><font size="2" face="Arial"> 
                                            MEDICAL INSURANCE FOR THE PERIOD COVERING 
                                            THE STAY IN THE CZECH REPUBLIC</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan="2" valign='top' height="2"> 
                                          <div align="justify"><b><font size='2' face='Arial'><font color='#FF6600'>PLEASE 
                                            ENCLOSE THE PHOTOCOPIES OF THE PASSPORT 
                                            (PAGE WITH PHOTO, VALIDITY, PRESENT 
                                            ADDRESS AND ALL VALID VISAS OF UK, 
                                            USA, SCHENGEN COUNTRIES), AIR TICKET 
                                            AND INVITATION, BANK STATEMENT/CREDIT 
                                            CARD.</font></font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td colspan='2' valign='top' height='2'> 
                                          <div align="justify"><b><font size="2" face="Arial" color="#000000">SUBMISSION 
                                            OF APPLICATION FROM MONDAY TO THURSDAY 
                                            BETWEEN 9 AND 11 AM. PROCESSING TIME 
                                            IS APPROXIMATELY 5 WORKING DAYS OR 
                                            SUBJECT TO CLEARANCE FROM THE CZECH 
                                            IMMIGRATION POLICE.</font></b></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height='2' colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='561' height='1'></td>
                                </tr>
                                <tr > 
                                  <td height='2' colspan='2'> 
                                    <div align="center"><font color="#000066"><b><font face="Arial" size="4"><u>SPAIN</u></font></b></font></div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height='2' colspan='2'> 
                                    <div align="justify"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial">AS 
                                      PER RECENT NOTIFICATION FROM 'EMBASSY OF 
                                      SPAIN ' NEW DELHI, WITH IMMEDIATE EFFECT 
                                      </font></span></font><font face="Arial" size="2">THE 
                                      VISA FEE WILL BE <font color="#FF0066">NON 
                                      REFUNDABLE</font> IRRESPECTIVE OF THE VISA 
                                      BEING DECLINED / WITHDRAWN.</font><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial"> 
                                      <br>
                                      <br>
                                      VISA FEE IS AS FOLLOWS.</font></span></font></b></div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height='78' colspan='2'> 
                                    <table width="100%" border="1" bordercolor="1">
                                      <tr bgcolor="#FFCCCC"> 
                                        <td width="49%" height="2"> 
                                          <div align="center"><font size="2" face="Arial"><b><font size="2" face="Arial">VISA 
                                            TYPE</font></b></font></div>
                                        </td>
                                        <td width="20%" height="2"> 
                                          <div align="left"><b><font size="2" face="Arial">VISA 
                                            FEE</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="49%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial>&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">UPTO 
                                          30 DAYS</font></font></span></b> </td>
                                        <td width="20%" height="2"><font color="#3333FF"><b><font size="2" face="Arial">RS. 
                                          1740.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="49%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial>&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">30 
                                          TO 90 DAYS</font></font></span></b> 
                                        </td>
                                        <td width="20%" height="2"><font color="#3333FF"><b><font size="2" face="Arial">RS. 
                                          2030.00</font></b></font></td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update110304.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update190704.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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

