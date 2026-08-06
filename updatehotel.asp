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
            <table width="98%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="2%">&nbsp; </td>
                <td colspan="3" bgcolor="#FFFFE5"> 
                  <div align="center"> 
                    <table width="98%" border="0">
                      <tr> 
                        <td height="2" width="32%"> 
                          <div align="right"><b><font face="Arial Black" color="#000080" size="6"><i><img src="updateimg/hotel4.jpg" width="60" height="89"></i></font></b></div>
                        </td>
                        <td height="2" width="39%"> 
                          <div align="center"><b><font face="Arial Black" color="#000080" size="6"></font><font face="Arial Black" color="#000080" size="6"><i><u>UPDATE</u></i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4"><br>
                            'UDAAN' - STAY WITH US</font></i><font face="Arial Black" color="#000080" size="6"></font></b></div>
                        </td>
                        <td height="2" width="29%"><b><font face="Arial Black" color="#000080" size="6"><i><img src="updateimg/hotel4.jpg" width="60" height="89"></i></font></b></td>
                      </tr>
                    </table>
                    
                  </div>
                </td>
              </tr>
              <tr> 
                <td width="2%" height="807">&nbsp;</td>
                <td colspan="3" height="807"> 
                  <table width="100%" height="704" bgcolor="#FFFFE5">
                    <tr> 
                      <td valign="top" align="left" colspan="3" height="22"> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" colspan="3" height="2"> 
                        <p><b><font face="Arial, Helvetica, sans-serif" size="2"> 
                          DEAR TRADE FRIENDS,<br>
                          <br>
                          </font></b> 
                        <font face="Arial, Helvetica, sans-serif" size="2"><b> 
                        <div align="justify">VISA HAS ALWAYS BEEN THE KEY OPERATIONS 
                          AREA FOR 'UDAAN', NEVERTHELESS AT TIMES WE ARE REQUESTED 
                          BY OUR AGENTS/CLIENTS TO MAKE STAY ARRANGMENTS IN DELHI 
                          FOR THEIR ESTEEMED CLIENTS.</div>
                        <br>
                        </b></font><font face="Arial, Helvetica, sans-serif" size="2"><b> 
                        </b></font> 
                        <p></p>
                        <font face="Arial, Helvetica, sans-serif" size="2"><b> 
                        <div align="justify">USUALLY THESE STAY RESERVATIONS FOLLOW, 
                          WHEN A CLIENT IS PLANNING A TRIP TO THE NORTHEN INDIA 
                          AND WANTS TO USE THE CAPITAL AS THE START OFF POINT 
                          OR AT TIMES WHEN AN APPLICANT IS REQUIRED TO COME TO 
                          DELHI FOR THE PURPOSE OF GETTING THEIR VISAS EFFACTUATED.<br>
                          <br>
                          WE BRING TO YOU THE CONVENIENCE OF BOOKING THE ACCOMODATION 
                          THROUGH US AND ASSURE YOU OF THE BEST TARIFFS AND AMENITIES 
                          POSSIBLE IN THE HOTELS. WE HAVE THE FOLLOWING CATEGORIES. 
                        </div>
                        </b></font></td>
                    </tr>
                    <tbody> 
                    <tr> 
                      <td valign="top" colspan="3" height="432"> 
                        <table width="99%" border="0" height="131">
                          <tr> 
                            <td colspan="7" bgcolor="#CCCCFF"><b><font face="Arial, Helvetica, sans-serif"><i><u>REVISED 
                              TARIFF SHEET - HOTEL BOOKING</u></i></font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="23"><font size="2"><b><font face="Arial, Helvetica, sans-serif"> 
                              <div align="justify">HOTEL PRICES ARE SLASHED DOWN. 
                                SOME HOTELS ALSO ARRANGE FREE PICKUP FROM AIRPORT 
                                UPON PRIOR INTIMATION. ALL ARE THREE STAR PROPERTY 
                                LOCATED NEAR EMBASSY AREA AND ABOUT 8 KMS FROM 
                                AIRPORTS.</div>
                              </font></b></font></td>
                            <td rowspan="64" width="45%" valign="top"> 
                              <div align="right"><img src="updateimg/hotel1.jpg" width="300" height="221"> 
                              </div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="23"><b><font face="Arial, Helvetica, sans-serif"><i><font color="#3333FF"><u>TARIFF 
                              1 </u> :</font></i></font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="23"><b> ANAND NIKETAN, NEW 
                              DELHI.</b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">SUPER 
                              DELUX </font></b></td>
                            <td width="15%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              1890/-</font></b></td>
                            <td width="12%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">+ 
                              20 % TAX</font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">MAHARAJA 
                              CLASSIC </font></b></td>
                            <td width="15%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              2390/-</font></b></td>
                            <td width="12%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">+ 
                              20 % TAX</font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"><b><font face="Arial, Helvetica, sans-serif"><i><font color="#3333FF"><u>TARIFF 
                              2</u> :</font></i></font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"><b> SOUTH EXTN - PART 1, 
                              NEW DELHI.</b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"><b><font size="2" face="Arial, Helvetica, sans-serif">SGL</font></b></td>
                            <td width="15%" height="2"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              &nbsp;995/-</font></b></td>
                            <td width="12%" height="2"><b><font size="2" face="Arial, Helvetica, sans-serif">+ 
                              20 % TAX</font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2" rowspan="19"><b><font size="2" face="Arial, Helvetica, sans-serif">DBL</font></b></td>
                            <td width="15%" height="2" rowspan="19"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              1495/-</font></b></td>
                            <td width="12%" height="2" rowspan="19"><b><font size="2" face="Arial, Helvetica, sans-serif">+ 
                              20 % TAX</font></b></td>
                          </tr>
                        </table>
                        <table width="100%" border="0" height="147">
                          <tr> 
                            <td rowspan="7" height="44" width="45%" valign="top"><img src="updateimg/hotel2.jpg" width="300" height="218"> 
                            </td>
                            <td height="2" colspan="3"><b><font face="Arial, Helvetica, sans-serif"><i><font color="#3333FF">TARIFF 
                              3 :</font></i></font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"><b> SRI AUROBINDO MARG, 
                              NEW DELHI.</b></td>
                          </tr>
                          <tr> 
                            <td height="20" width="28%"><b><font size="2" face="Arial, Helvetica, sans-serif">SGL</font></b></td>
                            <td height="20" width="22%"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              1600/-</font></b></td>
                            <td height="20" width="5%"><b><font size="2" face="Arial, Helvetica, sans-serif"></font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" width="28%"><b><font size="2" face="Arial, Helvetica, sans-serif">DLX 
                              DBL</font></b></td>
                            <td height="2" width="22%"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              2500/-</font></b></td>
                            <td height="2" width="5%"><b><font size="2" face="Arial, Helvetica, sans-serif"></font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" width="28%"><b><font size="2" face="Arial, Helvetica, sans-serif">DLX 
                              SUITE</font></b></td>
                            <td height="2" width="22%"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              3400/-</font></b></td>
                            <td height="2" width="5%"><b><font size="2" face="Arial, Helvetica, sans-serif"></font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" width="28%"><b><font size="2" face="Arial, Helvetica, sans-serif">EXTRA 
                              BED</font></b></td>
                            <td height="2" width="22%"><b><font size="2" face="Arial, Helvetica, sans-serif">RS. 
                              &nbsp;500/-</font></b></td>
                            <td height="2" width="5%"><b><font size="2" face="Arial, Helvetica, sans-serif"></font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="2"><font size="2" face="Arial, Helvetica, sans-serif">WITHIN 
                              THE HOTEL PREMISES ONE CAN HAVE A CHOICE OF THREE 
                              CUISINES I.E. THAI, CHINESE &amp; INDIAN.<br>
                              </font><font size="2"><b><font face="Arial, Helvetica, sans-serif"><br>
                              NOTE : FREE PICKUP FROM AIRPORT UPON PRIOR INTIMATION.</font></b></font><font size="2" face="Arial, Helvetica, sans-serif"> 
                              </font></td>
                            <td height="2" width="5%"><b><font size="2" face="Arial, Helvetica, sans-serif"></font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"> 
                              <div align="justify"> 
                                <p> 
                                <font face="Arial, Helvetica, sans-serif" size="2"><b> 
                                <div align="justify">PLEASE NOTE THAT THE TARIFFS 
                                  STATED ARE NON-COMMISSIONABLE AND CAN BE OVERQUOTED 
                                  AT YOUR END. KINDLY WRITE TO US FOR FURTHER 
                                  INFORMATION.</div>
                                <br>
                                CAB BOOKING CAN ALSO BE CONFIRMED IF REQUIRED.</b></font><b><font size="2" face="Arial, Helvetica, sans-serif">WE 
                                lOOK FORWORD TO AN OPPORTUNITY TO OFFER EXCELLENT 
                                SERVICES TO MAKE THE CLIENTS STAY MEMORABLE ONE.</font></b></div>
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
                <td width="2%">&nbsp;</td>
                <td colspan="2"><b><font face="Arial, Helvetica, sans-serif"><a href="updatecar.asp"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="36%"> 
                  <div align="right"><a href="update070302.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
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
              <tr> 
                <td width="2%">&nbsp;</td>
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
