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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="394">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="449">&nbsp;</td>
                <td colspan="3" height="449"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="633" border="1" align="center" bordercolor="#330033" height="901">
                          <tr> 
                            <td height="743"> 
                              <table align="center" width="76%" height="684">
                                <tr> 
                                  <td height="246" colspan="2"> 
                                    <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">24th 
                                      August 2004<br>
                                      </font></i></b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="612" height="6"> 
                                      <table width="612" border="1" cellpadding="0">
                                        <tr bordercolor="1"> 
                                          <td> 
                                            <div align="center"><font face="Comic Sans MS, Garamond" size="5"><b>**BANGLADESH**</b></font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td> 
                                            <div align="JUSTIFY"><font size="4" face="Garamond">AS 
                                              PER NOTIFICATION FROM &quot; THE 
                                              HIGH COMMISSION FOR THE PEOPLE'S 
                                              REPUBLIC OF BANGLADESH &quot; - 
                                              NEW DELHI, ALL WORK PERMIT VISA 
                                              APPLICATIONS FOR BANGLADESH SHOULD 
                                              MANDATORILY BE ACCOMPANIED WITH 
                                              <b>EDUCATIONAL</b> AND <b>PROFESSIONAL</b> 
                                              CERTIFICATES DULY ATTESTED BY<b>:</b></font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td> <b><font face="Garamond" size="4" color="#FF3366">(1)</font><font face="Garamond" size="4"> 
                                            THE MINISTRY OF EDUCATION - INDIA.</font></b></td>
                                        </tr>
                                        <tr> 
                                          <td><font face="Garamond" size="4"><b><font color="#FF3333">(2)</font> 
                                            THE MINISTRY OF EXTERNAL AFFAIRS - 
                                            INDIA.</b></font></td>
                                        </tr>
                                      </table>
                                      <b><i><font face="Arial" color="#000080" size="4"> 
                                      </font></i></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="6" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="612" height="6"></td>
                                </tr>
                                <tr > 
                                  <td height="641" colspan="2"> 
                                    <div align="justify"> 
                                      <table width="616" border="0" cellpadding="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Comic Sans MS, Garamond" size="5"><b>**ITALY**</b></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <font size="2" face="Arial"><b><font size="4" face="Garamond">DEAR 
                                      TRAVEL PARTNERS,</font></b><br>
                                      </font> 
                                      <table width="615" border="0" cellpadding="0">
                                        <tr> 
                                          <td height="81"> 
                                            <div align="JUSTIFY"><br>
                                              <font size="2" face="Arial"><font face="Garamond" size="4">IT 
                                              HAS BEEN ANNOUNCED THAT WITH EFFECT 
                                              FROM <b>16TH AUGUST 2004</b> PASSPORTS 
                                              FOR ITALY WILL HAVE TO BE PROCESSED 
                                              THROUGH THE LOCAL CENTERS OF <b>VISA 
                                              FACILITATION SERVICE (VFS)</b> AT 
                                              <b>NEW DELHI, MUMBAI, CHENNAI, KOLKATA, 
                                              BANGALORE, JALANDHAR AND COCHIN 
                                              </b>AS AUTHORISED BY THE EMBASSY 
                                              OF ITALY.</font></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <font size="2" face="Arial"> </font> 
                                      <table width="607" border="1" cellpadding="0" height="157">
                                        <tr> 
                                          <td width="400" height="172"><font size="2" face="Arial"><b><font face="Garamond" size="3">SUBMISSION 
                                            TIME:- 08:00 AM TO 12:00 PM AND 01:00 
                                            PM TO 04:00 PM</font></b><br>
                                            <br>
                                            <b><font face="Garamond" size="3">PROCESSING 
                                            TIME:- </font></b><font face="Garamond"><b><font size="3">THREE 
                                            WORKING DAYS</font></b></font><br>
                                            <br>
                                            <b><font face="Garamond" size="4">FEE:-</font></b><br>
                                            </font> 
                                            <table width="400" border="1" cellpadding="0">
                                              <tr> 
                                                <td width="269"> 
                                                  <div align="center"><b><font face="Garamond" color="#FF3300">VISA 
                                                    TYPE</font></b></div>
                                                </td>
                                                <td width="69"> 
                                                  <div align="center"><font face="Garamond"><b><font color="#FF3300">EUROS.</font></b></font></div>
                                                </td>
                                                <td width="46"> 
                                                  <div align="center"><font face="Garamond"><b><font color="#FF3300">INR</font></b></font></div>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">B-Transit 
                                                  </font></td>
                                                <td width="69"><font face="Garamond">10,00</font></td>
                                                <td width="46"><font face="Garamond">500</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C-Schengen(up 
                                                  to 30 days) </font></td>
                                                <td width="69"><font face="Garamond">25,00</font></td>
                                                <td width="46"><font face="Garamond">1,250</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269" height="28"><font face="Garamond">C 
                                                  type-Schengen (up to 90 days-single 
                                                  entry) </font></td>
                                                <td width="69" height="28"><font face="Garamond">30,00</font></td>
                                                <td width="46" height="28"><font face="Garamond">1,500</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C 
                                                  type - Schengen (up to 90 days) 
                                                  </font></td>
                                                <td width="69"><font face="Garamond">35,00</font></td>
                                                <td width="46"><font face="Garamond">1,750</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C1 
                                                  type - Schengen (one year) </font></td>
                                                <td width="69"><font face="Garamond">50,00</font></td>
                                                <td width="46"><font face="Garamond">2,500</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C2 
                                                  type - Schengen (two years) 
                                                  </font></td>
                                                <td width="69"><font face="Garamond">80,00</font></td>
                                                <td width="46"><font face="Garamond">4,000</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C2 
                                                  type - Schengen (three years) 
                                                  </font></td>
                                                <td width="69"><font face="Garamond">110,00</font></td>
                                                <td width="46"><font face="Garamond">5,500</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">C2 
                                                  type - Schengen (five years) 
                                                  </font></td>
                                                <td width="69"><font face="Garamond">170,00</font></td>
                                                <td width="46"><font face="Garamond">8,500</font></td>
                                              </tr>
                                              <tr> 
                                                <td width="269"><font face="Garamond">D 
                                                  - Italy only </font></td>
                                                <td width="69"><font face="Garamond">50,00</font></td>
                                                <td width="46"><font face="Garamond">2,500</font></td>
                                              </tr>
                                            </table>
                                            <font size="2" face="Arial"> <br>
                                            <b><font face="Garamond" size="3">VFS 
                                            CHARGES:- SUBMISSION CHARGES RS. 350/-<br>
                                            <br>
                                            </font></b></font></td>
                                          <td width="195" height="172"> 
                                            <p><img src="updateimg/italy.jpeg" width="197" height="193"></p>
                                            <p><img src="updateimg/ITALY2.jpg" width="197" height="193"></p>
                                          </td>
                                        </tr>
                                      </table>
                                      <font size="2" face="Arial"> <font color="#FF3300"><b><font face="Garamond" size="3">ABOVE 
                                      AMOUNT WILL BE IN ADDITION TO OUR HANDLING 
                                      AND COURIER CHARGES. </font></b></font><br>
                                      <br>
                                      </font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update010804.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update250804.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
