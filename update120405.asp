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
                <td width="21" height="875">&nbsp;</td>
                <td colspan="3" height="875"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="500" border="1" align="center" bordercolor="#0000FF" height="806">
                          <tr> 
                            <td height="820"> 
                              <table align="center" width="100%" height="805">
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><b><img src="updateimg/bird76.gif" width="71" height="56"></b><font face="Verdana" size="4"><b>New 
                                      procedures for Visa fee payment…</b></font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="2"></td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="2"></td>
                                </tr>
                                <tr> 
                                  <td height="247" colspan="2"> 
                                    <table width="499" border="0" height="111">
                                      <tr> 
                                        <td width="322" height="8" bordercolor="#000099"> 
                                          <div align="center"><font face="Verdana" size="4" color="#990099"><b>Philippines</b></font></div>
                                        </td>
                                        <td width="167" rowspan="2"> 
                                          <div align="right"><img src="updateimg/phillipines.jpg" width="169" height="191"></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="322" valign="top" height="201"> 
                                          <div align="justify"><font face="Verdana" size="2">With 
                                            effect from April 11th 2005, the <b>'Embassy 
                                            of Philippines' - New Delhi</b> will 
                                            accept the visa application fee through 
                                            demand draft only. <br>
                                            <br>
                                            Please note the demand draft should 
                                            be <b>mandatorily drawn from any National 
                                            or International bank in New Delhi 
                                            only. No out-station draft or any 
                                            other form of payment will be accepted. 
                                            </b><br>
                                            <br>
                                            The draft should be drawn in favor 
                                            of the <b>'Embassy of Philippines' 
                                            payable at New Delhi. </b>Just for 
                                            your information, the visa fee remain 
                                            the same at <b>Rs.2, 000 /- for single 
                                            entry</b> and <b>Rs.4, 000 /- for 
                                            multiple entries. </b></font></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="2"></td>
                                </tr>
                                <tr > 
                                  <td height="79" colspan="2"> 
                                    <table width="499" border="0">
                                      <tr> 
                                        <td width="185" rowspan="2" align="center"> 
                                          <p align="center"><img src="updateimg/Switzerland1.jpg" width="142" height="139"></p>
                                          </td>
                                        <td width="304" height="5"> 
                                          <div align="center"><b><font face="Verdana" size="4" color="#990099">Switzerland</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="304" height="35"> 
                                          <div align="justify"><font face="Verdana" size="2">With 
                                            effect from April 01st 2005, the <b>'Embassy 
                                            of Switzerland' - New Delhi </b>will 
                                            accept the visa application fee through 
                                            demand draft only. Please note the 
                                            draft should be drawn in favour of 
                                            the '<b>Embassy of Switzerland' payable 
                                            at New Delhi.</b> Just for your information, 
                                            the visa fee remain the same at <b>Rs.2, 
                                            100 /-</b> for both business and tourist 
                                            visas.<br>
                                            </font></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="499" height="2"></td>
                                </tr>
                                <tr > 
                                  <td height="136" colspan="2"> 
                                    <table width="99%">
                                      <tr> 
                                        <td width="11%" height="2" valign="top">&nbsp;</td>
                                        <td width="89%" height="2"> 
                                          <div align="center"><font face="Verdana" size="4"><b><font color="#990099">China</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="11%" height="2" valign="top"><font size="2"><b><font face="Arial"> 
                                          &nbsp;<img src="images/alert1.gif" width="40" height="20"></font></b></font></td>
                                        <td width="89%" height="2"> 
                                          <div align="justify"><font size="2"><font face="Verdana">The 
                                            Chinese Embassy, New Delhi has once 
                                            again issued a strict circular mentioning 
                                            that <b>the embassy is not going to 
                                            accept any demand draft drawn from 
                                            any out-station banks,</b> even if 
                                            they are payable at New Delhi. Please 
                                            note that the demand drafts drawn 
                                            towards the payment of the visa application 
                                            fee has to be mandatorily issued from 
                                            a bank in New Delhi. </font><b><font face="Arial"><br>
                                            &nbsp; </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="11%" height="2" valign="top">&nbsp;</td>
                                        <td width="89%" height="2"> 
                                          <div align="center"><font face="Verdana" size="4" color="#990099"><b>Change 
                                            of premises for Ivory Coast…</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="11%" height="2" valign="top"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="40" height="20"></font></b></font></td>
                                        <td width="89%" height="2"> 
                                          <div align="JUSTIFY"><font face="Arial" size="2"> 
                                            <div align="justify"><b><font face="Verdana">Honorary 
                                              Consulate of the Republic of Ivory 
                                              Coast' - New Delhi </font></b><font face="Verdana">has 
                                              reallocated its place of work from 
                                              Connaught Place to</font><b><font face="Verdana"> 
                                              "B - 9/6, Vasant Vihar, New Delhi"</font></b></div>
                                            </font></div>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td width="11%" height="2" valign="top">&nbsp;</td>
                                        <td width="89%" height="2">
                                          <div align="center"><font face="Verdana" size="4"><b><font color="#990099">Estonia 
                                            has stopped issuing visa…</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="11%" height="2" valign="top"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="40" height="20"></font></b></font></td>
                                        <td width="89%" height="2"> 
                                          <div align="justify"><font face="Verdana" size="2">"<b>The 
                                            Honorary Consulate General of the 
                                            Republic of Estonia" - New Delhi </b>has 
                                            stopped issuing visas. From henceforth, 
                                            any passenger traveling to Estonia 
                                            need to obtain a visa from any of 
                                            the countries in the European union 
                                            through which they would be traveling 
                                            or transiting. </font></div>
                                        </td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update060405.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update290405.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
