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
                <td width="3%">&nbsp; </td>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td width="3%">&nbsp; </td>
                <td colspan="2"><font face="Times New Roman, Times, serif" 
            size=6><b></b></font><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>4th January 2002 </font></i><u></u></b></td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td colspan="2"> 
                  <table height=393 width="100%">
                    <tr> 
                      <td valign=top align=left colspan="3" height=2> 
                        <div align="right"></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left colspan="3" height=2> 
                        <hr>
                      </td>
                    </tr>
                    <tbody> 
                    <tr> 
                      <td valign=top align=right width="6%" height=317> &nbsp;<img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=317 colspan="2"><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial><font color="#800080" size="4"><u>COUNTRY 
                        MOZAMBIQUE : CAPITAL MAPUTO</u></font><font color="#800080"><br>
                        <br>
                        </font><u>MOZAMBIQUE OPENS ITS REPRESENTATION IN INDIA 
                        AT DELHI :</u> HIGH COMMISSION OF THE REPUBLIC OF MOZAMBIQUE 
                        - B 3/24, VASANT VIHAR, NEW DELHI 110 057. PH.: 0 98 106 
                        42885.<br>
                        <u>THE DOCUMENTS REQUIRED TO PROCESS VISA ARE :</u> VALID 
                        PASSPORT, 1 VISA APPLICATION FORM DULY FILLED IN, TWO 
                        PHOTOS, COVERING LETTER FROM THE APPLICANT ADDRESSED TO 
                        THE EMBASSY STATING PUROSE AND DURATION OF VISIT (THE 
                        DATE OF ENTRY AND EXIT TO BE SPECIFICALLY STATED )<br>
                        <u> TIME TAKEN :</u> 10 DAYS (NORMAL) ; 3 DAYS (URGENT) 
                        ; SAME DAY (VERY URGENT) ; VISAS ALSO ISSUED ON WEEKENDS 
                        / HOLIDAYS.<br>
                        <u> FEE :</u> ENTRY TYPE TRANSIT (VALID FOR STAY UPTO 
                        01 TO 07 DAYS) - RS. 213/- NORMAL, RS. 319/- URGENT, RS. 
                        372/- VERY URGENT.<br>
                        ENTRY TYPE SINGLE (VALID FOR STAY UPTO 01 TO 30 DAYS) 
                        - RS. 425/- NORMAL, RS. 638/- URGENT, RS. 744/- VERY URGENT.<br>
                        ENTRY TYPE SINGLE (VALID FOR STAY UPTO 30 TO 60 DAYS) 
                        - RS. 851/- NORMAL, RS. 1,276/- URGENT, RS. 1,498/- VERY 
                        URGENT.<br>
                        ENTRY TYPE SINGLE (VALID FOR STAY UPTO 60 TO 90 DAYS) 
                        - RS. 1,276/- NORMAL, RS. 1,914/- URGENT, 2,2,33/- VERY 
                        URGENT.<br>
                        ENTRY TYPE MULTIPLE (VALID UNTILL 3 MONTHS) - RS. 1,418/- 
                        NORMAL, RS. 2,127/- URGENT, RS. 2,482/- VERY URGENT.<br>
                        ENTRY TYPE MULTIPLE (VALID UNTILL 6 MONTHS) - RS. 2,836/- 
                        NORMAL, RS. 4,254/- URGENT, RS. 4,963/- VERY URGENT.<br>
                        ENTRY TYPE MUTIPLE (VALID UNTILL 12 MONTHS) - RS. 4,254/- 
                        NORMAL, RS. 6,381/- URGENT, RS. 7,445/- VERY URGENT. </font></span></font></b></td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="6%" height=42>&nbsp;<img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=42 colspan="2"><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial><font color="#800080" size="4" face="Arial, Helvetica, sans-serif"><u>COUNTRY 
                        CONGO : CAPITAL KINSHASA</u></font><font color="#800080"><br>
                        <br>
                        </font><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt"><u>EMBASSY 
                        OF CONGO SHIFTS PREMISES TO :</u> D 6, ANAND NIKETAN, 
                        NEW DELHI 110 021. <br>
                        </span></font></span></font></b></td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="6%" height=2>&nbsp;<img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=2 colspan="2"><b><span style="mso-bidi-font-size: 10.0pt"><font size="4" face="Arial, Helvetica, sans-serif" color="#800080">COUNTRY 
                        CROATIA : CAPITAL ZAGREB</font><font size="4" face="Arial, Helvetica, sans-serif"><br>
                        <br>
                        <font size="2"><u>EMBASSY OF CROATIA SHIFTS PREMISES TO 
                        :</u> A - 15 WEST END COLONY, VASANT VIHAR, NEW DELHI 
                        110 057. PH.: 011 - 687 6871 / 687 6872. FAX : 011 - 687 
                        6873. <br>
                        </font></font></span></b></td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="6%" height=2><img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=2 colspan="2"><b><span style="mso-bidi-font-size: 10.0pt"><font size="4" face="Arial, Helvetica, sans-serif" color="#800080">COUNTRY 
                        SWITZERLAND : CAPITAL BERNE</font><font size="4" face="Arial, Helvetica, sans-serif"><br>
                        <br>
                        <font size="2"><u>EMBASSY OF SWITZERLAND</u> HAS NOW INTRODUCED 
                        THE SAME DAY VISA PROCESSING UPON PAYMENT OF ADDITIONAL 
                        FEE OF RS. 600/-, BESIDE THE REGULAR VISA FEES. THE VISAS 
                        SUBMITTED ON FRIDAY WILL BE NOW GIVEN ON MONDAY AS THE 
                        REGULAR COLLECTION AND NOT SAME DAY, AS WAS EARLIER. <br>
                        </font></font></span></b></td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="6%" height=2><img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=2 colspan="2"><font face="Arial, Helvetica, sans-serif" size="4"><b><font color="#800080"><u>COUNTRY 
                        HUNGARY : CAPITAL BUDAPEST</u></font><br>
                        <br>
                        <font size="2"><u>VISA FEES REVISED W.E.F. JAN 2002 :</u> 
                        VISA TYPE ENTRY- RS. 1,920/- (SGL.) ; RS. 3,600/- (DBL.) 
                        ; RS. 8,640/- (MULTPL).<br>
                        VISA TYPE TRANSIT - RS. 1,824/- (SGL.) ; RS. 3,120/- (DBL.) 
                        ; RS. 7,200/- (MULTPL).<br>
                        <u> VISA AUTHORISATION FEE :</u> RS. 960/- (APPLICABLE 
                        IF CASE REFERRED)<br>
                        NOTE : FOR ALL URGENT VISA PROCESSING AN ADDITIONAL AMOUNT 
                        OF RS. 720/- HAS TO BE PAID BESIDES THE REQUIRED FEES 
                        AS PER VISA TYPE.<br>
                        </font> </b></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="6%" height=24><img border="0" src="updateimg/NEWGREEN.gif" width="18" height="8"></td>
                      <td valign=top align=left height=24 colspan="2"><font face="Arial, Helvetica, sans-serif" size="4"><b><font color="#800080"><u>COUNTRY 
                        JAMAICA : CAPITAL KINGSTON.</u></font><br>
                        <br>
                        <font size="2"><u>JAMAICA OPEN ITS REPRESENTATION IN INDIA 
                        AT DELHI :</u> FOUR SQUARE HOUSE, # 49 COMMUNITY CENTRE, 
                        NEW FRIEND'S COLONY, NEW DELHI 110 065. PH.: 011 - 683 
                        2155.<br>
                        <u> THE DOCUMENTS REQUIRED TO PROCESS THE VISA ARE :</u> 
                        VALID PASSPORT, 1 VISA APPLICATION FORM, 2 PHOTOGRAPHS, 
                        COVERING LETTER (ON THE BUSINESS LETTER HEAD) FROM THE 
                        APPLICANT STATING PURPOSE AND DURATION OF VISIT, INVITATION 
                        FROM KINGSTON / STAY CONFIRMATION, FOREIGN EXCHANGE DULY 
                        ENDORSED (MANDATORY), CONFIRMED RETURN AIR TICKET. <br>
                        <u> TIME TAKEN :</u> 48 - 72 HRS.<br>
                        <u> FEE :</u> EQUIVALENT TO USD 20. </font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="2">&nbsp;</td>
                    </tr>
                    <tr bgcolor="#000000"> 
                      <td valign=top align=left colspan="3" height=4><b><u><font face="Arial" color="#FFFFFF" size="4">HOLIDAYS 
                        LIST FOR JANUARY 2002.</font></u></b></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><u><b><font 
                        face=Courier color=#800080 size=3>DATE</font></b></u></td>
                      <td valign=top align=left width="68%" height=2><b><u><font face=Courier 
                        color=#800080 size=3>COUNTRY</font></u></b></td>
                      <td valign=top align=left rowspan="7" height=14 width="26%"><img src="updateimg/orbit.gif" width="184" height="125"></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">1<span 
                        style="mso-spacerun: yes"> &nbsp;</span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">CUBA, 
                        PALESTINE, SUDAN, TURKEY, DENMARK, SWITZERLAND</font></b></span></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">2&nbsp;<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>SWITZERLAND, 
                        TURKEY</b></font></b></span></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">4<span 
                        style="mso-spacerun: yes">&nbsp; </span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>MYANMAR</b></font></b></span></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">24<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>TOGO</b></font></b></span></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">26<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>ALL 
                        MISSIONS ARE CLOSED</b></font></b></span></font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">31<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                      <td valign=top align=left width="68%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NAURU</b></font></b></span></font></td>
                    </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td width="47%"><b><font face="Arial, Helvetica, sans-serif"><a href="update251201.asp"><img src="updateimg/previous.jpg" border="0"></a></font></b></td>
                <td width="50%"> 
                  <div align="right"><a href="updatecontactinfo.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td colspan="2">
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3"> 
                          <div align="center"><u><font color="#0000FF" face="Arial, Helvetica, sans-serif"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="26%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          </b></td>
                        <td width="24%"> 
                          <input type="button" name="Submit2" value="REGISTER NOW" onClick="return reg()">
                        </td>
                      </tr>
                    </table>
                  </form>
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
