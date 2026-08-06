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
.style19 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 18px;
}
.style75 {
	color: #333333;
	font-size: 18pt;
}
.style16 {
	font-size: 24pt;
	font-family: "Times New Roman", Times, serif;
	font-weight: bold;
	color: #0000CC;
}
.style4 {
	font-size: 16pt;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
.style23 {
	color: #0000CC;
	font-size: 24pt;
	font-weight: bold;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
.style79 {
	font-size: 16pt;
	font-weight: bold;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
.style84 {font-weight: bold; font-size: 24px;}
.style85 {font-size: 16pt}
.style87 {font-size: 24pt; font-weight: bold; color: #0000CC;}
.style88 {font-family: Verdana, Arial, Helvetica, sans-serif}
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
                              <table width="99%" border="0" height="753">
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
                                  <td height="46" bordercolor="#000000"><div align="center"><span class="style16">ESTABLISHMENT OF NEW EMBASSIES IN NEW DELHI </span></div></td>
                                  </tr>
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF">
                                  <td height="186" bordercolor="#000000"><span class="style88"><span class="style84">Dear Travel Partners;</span><br>
                                      <span class="style85"><br>
                                      </span></span>
                                    <P align="justify" class=style19><span class="style85">It has been our constant endeavor to upgrade our services for the benefit of our esteemed clients .Keeping this in view we are bringing to your notice the details of <u>Albania</u> and <u>Lithuania</u> Embassies.</span></P>
                                    <p class="style23"><u>Lithuania</u></p>
                                    <p class="style79">Short-stay Visa (C) (documents required to submit)</p>
                                    <ul class="li style4">
                                      <li>Passport with validity of more than 
                                        six months. </li>
                                      <li>1 Visa application form duly filled 
                                        in and signed- Photocopy can be used. </li>
                                      <li>1 Recent passport size colour photographs 
                                        in the size of 3.5 cms x 4.5 cms with a white / light background. </li>
                                      <li>A copy of invitation letter, approved by the Migration department of the Republic of Lithuania. </li>
                                      <li>Air ticket Reservation. </li>
                                      <li>Hotel Reservation. </li>
                                      <li>Documents sustaining the available means for traveling and return to the state of origin (bank statements, salary slips etc).</li>
                                      </ul>
                                    <p class="style79">In case the applicant is going for the purpose of Business the following additional documents need to be submitted:</p>
                                    <ul class="li style4 ">
                                      <li>Covering letter from the applicant, explaining the exact purpose and duration of your stay in Lithuania. </li>
                                      <li>Official letter from Lithuania business partner stating purpose of travel and intended time of stay. </li>
                                      <li>Official letter from the employer stating exact purpose of Travel, applicant's designation and applicant's monthly income. </li>
                                      <li>Bank statements of the company covering the last 3 months. </li>
                                      <li>Proof of employment for the last 12 months. </li>
                                      <li>Salary slips for the last 6 months. </li>
                                    </ul>
                                    <p class="style4">Tuesday 2pm - 5pm<br />
Thursday 10am - 1pm<br />
<br />
<strong>Consular fee - </strong>4,000 INR</p>
                                    <p class="style4"><strong>Personal appearance is mandatory.</strong> Visa processing time approximately 7-10 working days. </p>
                                    <p class="style4">Embassy of the Republic of Lithuania<br />
                                      D-129, Anand Niketan<br />
                                      New Delhi - 110021<br />
                                      Tel : +91-11-43132200<br />
                                      Fax: +91-11-43132222<br />
                                      E-mail: amb.in@urm.lt</p>
                                    <p class="style4"><span class="style87"><u>Albania</u></span><br />
                                        <br />
                                    </p>
                                    <ul class="li style4">
                                      <strong>Albania Business Visa Requirements </strong>
                                      <li>Valid passport with validity of more 
                                        than three months. <br />
                                      </li>
                                      <li>1 Visa application form duly filled 
                                        in and signed. <br />
                                      </li>
                                      <li>2 Recent passport size colour photographs. 
                                        (45 mm wide by 35 mm, White background), without any staple marks.<br />
                                      </li>
                                      <li>Invitation by the company in Albania stating the reason of invitation and duration of stay. </li>
                                      <li>Letter head from the company including name and surname of the applicant, passport number, duties fulfilled by the applicant at the company, date of employment and monthly salary. </li>
                                      <li>Copy of the tax statement of the company and copy of document stating the legal status of the company.<br />
                                      </li>
                                      <li>Confirmed Air ticket.<br />
                                          <br />
                                          <p><strong><u>Working hours of the Visa section:</u></strong></p>
                                        <p>Monday to Friday<br />
                                          10:00 AM To 3:30 PM<br />
                                          <br />
                                          <br />
                                          <strong>Consular fee - </strong>15 Euro i.e. Rs. 1045</p>
                                      </li>
                                    </ul>
                                    <p><span class="style4">Embassy of the Republic of Albania<br />
                                      16, Sadhna Enclave, II - nd Floor, <br />
                                      Panch Sheel Park<br />
                                      New Delhi - 110017,<br />
                                      Telephone: +91 11 4052 9396<br />
                                      Fax: + 91 11 4052 9396 </span></p></td>
                                  </tr>
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF"> 
                                  <td height="346" bordercolor="#000000" class="style19"> 
                                    <div align="justify">
                                      <div align="left"><br>
                                       </div>
                                       <p align="left"><strong><span class="style75">Regards<br>
                                         Udaan Team</span><br>
                                           
                                          ******************************************************************                                                     </strong></p>
                                       <table width="94%" border="1" height="74">
                                        <tr> 
                                          <td height="12"> 
                                            <div align="center">
                                              <div align="center">&quot;Co-operate 
                                                and support us, to serve you better&quot;                                                 </div>
                                              <div align="left"> 
                                                <div align="center"><marquee behavior = "alternate">
                                                  <font color="#0000FF"><a href="http://www.udaanindia.com" target="_blank"><font color="#FF0000"><font color="#FF0033"><b><font color="#333333">For 
                                                  more Information plz. log on 
                                                  to http://www.udaanindia.com</font></b></font></font></a> </font>
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
                <td width="21" height="2" class="style19">&nbsp;</td>
                <td height="2" colspan="2" class="style19">&nbsp;</td>
                <td width="650" height="2" class="style19"> 
                  <div align="right">&nbsp;</div>                </td>
              </tr>
              <tr> 
                <td width="21" class="style19">&nbsp;</td>
                <td colspan="3" rowspan="2" class="style19"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3"> 
                          <div align="center"><u><font color="#0000FF"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="26%" height="2"><b> <font color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%" height="2"><b> <font color="#FF0000">E. 
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
                <td width="21" class="style19">&nbsp;</td>
              </tr>
            </table>          </td>
        </tr>
        <tr> 
          <td class="style19"><!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>    </td>
  </tr>
</table>
</body>
</html>
