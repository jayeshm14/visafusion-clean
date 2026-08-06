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
                <td width="21" height="211">&nbsp;</td>
                <td colspan="3" height="211"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="192"> 
                        <table width="536" align="center" height="345" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="2" colspan="2"> 
                              <table width="77%" border="1" height="242">
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF"> 
                                  <td width="62%" height="346" bordercolor="#000000"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Monotype Corsiva" size="7" color="#993366"><img src="updateimg/new%20visa-come-get-it.gif" width="468" height="76"> 
                                              </font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <p align="center"><b>= = = = = = = = = = = = = = = = 
                                          = = = = = = = = = = = = = = = = = = 
                                          = = <br>
                                          <i>
                                        <font face="Arial" color="#3300CC" size="5">ATTENTION 
                                            ALL TRAVELLERS TO CHINA</font></i></b></p>
                                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber6">
                                          <tr>
                                            <td width="100%">As you are well 
                                            aware of the fact that all Visas to 
                                            China are being processed by the 
                                            Chinese Visa Application Centre of 
                                            VFS since 1st August 2008. The 
                                            Chinese Embassy has laid down guide 
                                            lines for submission of visa to be 
                                            followed strictly.<br>
                                            The guide lines laid down are given 
                                            in the succeeding paragraphs:<br>
&nbsp;</td>
                                          </tr>
                                        </table>
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
                                          <tr>
                                            <td width="100%">
                                            <b>
                                            <font face="Verdana, Arial, Helvetica, sans-serif" color="#3300CC">REQUIREMENTS 
                                            FOR TOURIST VISA ( l VISA </font>
                                            <font color="#3300CC">)</font></b></td>
                                          </tr>
                                          <tr>
                                            <td width="100%">
                                            1. Passport with validity of more 
                                            than six months and with min. 2 
                                            blank pages. <br>
                                            2. 1 Visa application form duly 
                                            filled in and signed by the 
                                            Applicant himself. <br>
                                            3. 1 recent passport size colour 
                                            photograph <br>
                                            4. Original covering letter from the 
                                            applicant duly signed &amp; typed on 
                                            company letter head addressed to the 
                                            visa counselor, Embassy of the 
                                            People’s Republic of China. <br>
                                            5. Round trip confirmed Air Ticket
                                            <br>
                                            6. Confirmed Hotel Reservation. <br>
                                            7. Updated Bank statement of 
                                            preceding 3 months with a minimum 
                                            balance of Rs.1.20 lakh per person 
                                            e.g. : If a family of 3 are to 
                                            travel they need to have a min 
                                            balance of 3.60 lakh , if there is 
                                            one account. <br>
                                            8. Incase if you are going to visit 
                                            a relative, then proof of a genuine 
                                            ongoing relationship with the person 
                                            inviting you in China and the copy 
                                            of valid resident permit should be 
                                            given. <br>
                                            9. Note: whenever, an incentive tour 
                                            is organized the bank statement of 
                                            the company must have the balance of 
                                            1.20 lakhs x the number of passenger 
                                            .i.e. if 10 pax are going , it 
                                            should 10 x 1.20 lakhs. .</td>
                                          </tr>
                                        </table>
                                        <p>&nbsp;</p>
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="31">
                                          <tr>
                                            <td width="100%" height="18">
                                            <b>
                                            <font face="Verdana, Arial, Helvetica, sans-serif" color="#3300CC">REQUIREMENTS 
                                            FOR BUSINESS VISA ( F VISA )</font></b></td>
                                          </tr>
                                          <tr>
                                            <td width="100%" height="12">
                                            <font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                                            1. Passport with validity of more 
                                            than six months and 2 blank pages.
                                            <br>
                                            2. 1 Visa application form duly 
                                            filled in and signed by the 
                                            applicant himself <br>
                                            3. 1 Recent passport size colour 
                                            photograph. <br>
                                            4. Original covering letter from the 
                                            applicant on Company’s Letter head 
                                            with the company’s round seal. It 
                                            should give the purpose and the fact 
                                            that the company will bear all 
                                            expenses. <br>
                                            5. Round trip confirmed Air Ticket
                                            <br>
                                            6. Original Visa NOTIFICATION LETTER 
                                            from the relevant authorities in 
                                            china and round stamp.
                                            <a href="http://www.udaanindia.com/forms/CHINA-SAMPLE%20NOTIFICATION%20LETTER.pdf" target=_blank">
                                            CLICK HERE FOR THE SAMPLE 
                                            NOTIFICATION LATTER. </a><br>
                                            7. Hotel Confirmation from China ”
                                            </font></td>
                                          </tr>
                                        </table>
                                        <p>&nbsp;</p>
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber3" height="74">
                                          <tr>
                                            <td width="100%" height="18">
                                            <b>
                                            <font face="Verdana, Arial, Helvetica, sans-serif" color="#3300CC">REQUIREMENTS 
                                            FOR WORK ( EMPLOYEMENT ) VISA ( Z 
                                            VISA )</font></b></td>
                                          </tr>
                                          <tr>
                                            <td width="100%" height="55">1. 
                                            Passport with validity of more than 
                                            six months. <br>
                                            2. 1 Visa application form duly 
                                            filled in and signed- Photocopy can 
                                            be used <br>
                                            3. 1 Recent passport size colour 
                                            photograph. <br>
                                            4. Covering letter from the 
                                            applicant's company stating his 
                                            name, designation, purpose and 
                                            duration of visit.<br>
                                            5. Alien Employment License issued 
                                            from the Ministry of Labour &amp; 
                                            Security - Government of China or 
                                            the Foreign Specialist License from 
                                            the Foreign Specialist Bureau - 
                                            Government of China in original <br>
                                            6. Visa Notification letter issued 
                                            by the Local Authority - The Foreign 
                                            affairs office of China<br>
                                            7. Physical Examination Record for 
                                            foreigner issued by doctor from an 
                                            Indian State Hospital. The photo on 
                                            the Physical Examination Record 
                                            should be stamped by the hospital 
                                            (valid for 6 months from the date of 
                                            issue). <br>
                                            8. To download the Medical form 
                                            please
                                            <a href="http://www.udaanindia.com/forms/China%20Medical%20form.pdf" target="_blank">
                                            CLICK HERE</a>.
                                            <br>
&nbsp;</td>
                                          </tr>
                                        </table>
                                        <p>&nbsp;</p>
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber4">
                                          <tr>
                                            <td width="100%">
                                            <b> 
                                            <font face="Verdana, Arial, Helvetica, sans-serif" color="#3300CC">IMPORTANT:</font></b></td>
                                          </tr>
                                          <tr>
                                            <td width="100%">In covering letter 
                                            pattern given below should be used:
                                            <br>
                                            To <br>
                                            The Visa Officer <br>
                                            Embassy of the People's Republic of 
                                            China <br>
                                            New Delhi 110021 <br>
&nbsp;</td>
                                          </tr>
                                        </table>
                                        <p><br>
                                          <font size="2" face="Verdana">***********************************************************************<br>
                                          </font></p>
                                      </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="12"> 
                                            <div align="center">
                                              <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                                and support us, to serve you better&quot; 
                                                </font> </div>
                                              <div align="left"> 
                                                <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><a href="http://www.udaanindia.com" target="_blank"><font color="#FF0000"><font color="#FF0033" size="2" face="Verdana"><b><font color="#333333">For 
                                                  more Information plz. log on 
                                                  to http://www.udaanindia.com</font></b></font></font></a> 
                                                  </font></marquee></div>
                                              </div>
                                            </div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <b> </b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="645" height="6"></div>
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
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
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
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
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
          <td><!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>