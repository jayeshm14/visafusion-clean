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
                <td width="21" height="760">&nbsp;</td>
                <td colspan="3" height="760"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="100%" align="center" height="917" bgcolor="#CCFFCC">
                          <tr> 
                            <td height="2" colspan="2"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">5th 
                                February 2003</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="2"> 
                              <div align="center"><font face="Arial" size="3"><b><font size="4" color="#660000"><i></i></font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="2"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u> 
                                <img src="http://www.udaanindia.com/updateimg/uk6.gif"> 
                                UK ANNOUNCE EXPANSION OF ITS VISA SERVICES IN 
                                NORTHERN INDIA <img src="http://www.udaanindia.com/updateimg/uk6.gif"></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="376" colspan="2"> 
                              <table width="98%" border="1" cellspacing="1" bordercolor="#000033">
                                <tr> 
                                  <td valign="top" width="52%" height="309"> 
                                    <blockquote> 
                                      <p align='justify'><font face="Arial" size="2"> 
                                        The British High Commission is pleased 
                                        to announce that new improved visa application 
                                        facilities and procedures are to be introduced 
                                        India-wide for applicants for all categories 
                                        of UK visas.<br>
                                        <br>
                                        </font><font face="Arial" size="2">This 
                                        improved service has been developed as 
                                        part of the British High Commission's 
                                        continued commitment to make UK visa services 
                                        more accessible to applicants. The new 
                                        services will make applying for a UK visa 
                                        much easier.<br>
                                        <br>
                                        </font><font face="Arial" size="2">Effective 
                                        <b>Monday, 3 February 2003</b>, applicants 
                                        from Northern India for all categories 
                                        of UK visas should lodge their applications 
                                        at one of the <b>UK Visa Application Centres</b> 
                                        being opened in <b>New Delhi, Jalandhar</b> 
                                        and <b>Chandigarh</b>.<br>
                                        <br>
                                        </font><font face="Arial" size="2">These 
                                        new procedures have been introduced after 
                                        detailed consultation with visa applicants. 
                                        From 3 February many more applicants will 
                                        be able to obtain a UK visa without the 
                                        need to make the long and difficult journey 
                                        to the British High Commission in New 
                                        Delhi. Instead, they will be able to lodge 
                                        their applications at one of the conveniently 
                                        situated Application Centres, much closer 
                                        to their homes. Those who still require 
                                        an interview will be able to fix an appointment 
                                        time which suits them. Queuing for a visa 
                                        outside the High Commission will be a 
                                        thing of the past.</font></p>
                                    </blockquote>
                                  </td>
                                  <td valign="top" width="48%" height="309"> 
                                    <blockquote> 
                                      <p align='justify'><font face="Arial" size="2">UK 
                                        Visa Application Centres in Northern India 
                                        open on 3 February 2003 at:<br>
                                        <br>
                                        </font><font face="Arial" size="2"><b>NEW 
                                        DELHI</b><br>
                                        B-2/3, Safdarjung Enclave <br>
                                        Africa Avenue, Opp. St. Thomas Church 
                                        <br>
                                        Timings: 0800-1200, 1300-1600<br>
                                        <br>
                                        </font><font face="Arial" size="2"><b>JALANDHAR</b><br>
                                        BalbirTower, 3rd Floor <br>
                                        Namdeo Chowk, G. T. Road <br>
                                        Timings: 0800-1200, 1300-1500<br>
                                        <br>
                                        </font><font face="Arial" size="2"><b>CHANDIGARH</b><br>
                                        SCO 61-62-63, Sector 9-D <br>
                                        Above Bank of Punjab, Madhya Marg <br>
                                        Timings: 0800-1200, 1300-1500<br>
                                        <br>
                                        </font><font face="Arial" size="2">For 
                                        information and guidance:- <br>
                                        Call in New Delhi:( 011) 51651510 <br>
                                        Call in Punjab: (0181) 5095600 <br>
                                        E-mail: vfsuk.north@visa-services.com<br>
                                        <br>
                                        </font> <font size="1" face="Arial">The 
                                        UK Visa Application Centres are operated 
                                        by Visa Facilitation Services (VFS). VFS 
                                        will be responsible only for accepting 
                                        applications and providing advice and 
                                        guidance. A service charge of Rs. 300 
                                        will be levied per application. All visa 
                                        applications will continue to be assessed 
                                        by Entry Clearance Officers at the British 
                                        High Commission. </font></p>
                                    </blockquote>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td height="163" colspan="2"> 
                              <table width="98%" border="0">
                                <tr> 
                                  <td width="54%" bgcolor="#FFFFCC"> 
                                    <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">GREECE</span></u></font></b></div>
                                  </td>
                                  <td width="1%"> &nbsp;&nbsp;&nbsp;</td>
                                  <td width="45%" bgcolor="#FFFFCC"> 
                                    <div align="center"><b><font color="#800080" size="4" face="Arial"><u>SPAIN</u></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="54%" height="2" bgcolor="#FFFFCC"> 
                                    <div align="justify"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial">AS 
                                      PER RECENT NOTIFICATION FROM 'EMBASSY OF 
                                      GREECE ' - NEW DELHI, WITH IMMEDIATE EFFECT 
                                      THE VISA FEE WILL BE <font color="#FF0000">NON-REFUNDABLE</font>. 
                                      REVISED VISA FEE WILL BE AS FOLLOWS.</font></span></font></b></div>
                                  </td>
                                  <td width="1%" height="2">&nbsp; </td>
                                  <td width="45%" height="2" bgcolor="#FFFFCC"> 
                                    <div align="justify"><b><font size="2"><font face="Arial">AS 
                                      PER RECENT NOTIFICATION FROM 'EMBASSY OF 
                                      SPAIN ' - NEW DELHI, WITH IMMEDIATE EFFECT 
                                      THE REVISED VISA FEE WILL BE AS FOLLOWS.</font></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="54%" height="40" bgcolor="#FFFFCC"> 
                                    <table width="100%" border="1" bordercolor="1">
                                      <tr bgcolor="#FFCCCC"> 
                                        <td width="48%" height="2"> 
                                          <div align="center"><font size="2" face="Arial"><b><font size="2" face="Arial">VISA 
                                            TYPE</font></b></font></div>
                                        </td>
                                        <td width="28%" height="2"> 
                                          <div align="center"><b><font size="2" face="Arial">APPROVAL 
                                            FEE<br>
                                            (NON-REFUNDABLE)</font></b></div>
                                        </td>
                                        <td width="24%" height="2"> 
                                          <div align="center"><b><font size="2" face="Arial">VISA 
                                            FEE<br>
                                            (PAY WHEN COLLECTION)</font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="48%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                          ENTRY (30 days)</font></font></span></b> 
                                        </td>
                                        <td width="28%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;1282.00 +</font></b></font></td>
                                        <td width="24%" height="2"><font color="#3333FF"><b><font size="2" face="Arial">RS. 
                                          51.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="48%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                          ENTRY (90 days)</font></font></span></b> 
                                        </td>
                                        <td width="28%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;1795.00 +</font></b></font></td>
                                        <td width="24%" height="2"><font color="#3333FF"><b><font size="2" face="Arial">RS. 
                                          51.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="48%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font face="Arial, Helvetica, sans-serif" color="#3333FF">HELLAS 
                                          VISA (Only Greece)</font></font></span></b> 
                                        </td>
                                        <td width="28%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                                          1589.00</font></b></font></td>
                                        <td width="24%" height="2">&nbsp;</td>
                                      </tr>
                                      <tr> 
                                        <td width="48%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">TRANSIT 
                                          / SEAMAN</font></font></span></b> </td>
                                        <td width="28%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;&nbsp; 513.00 +</font></b></font></td>
                                        <td width="24%" height="2"><font color="#3333FF"><b><font size="2" face="Arial">RS. 
                                          51.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="48%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">ATTESTATION 
                                          (Per Page)</font></font></b></font></font></font></span></b> 
                                        </td>
                                        <td width="28%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp; 1025.00</font></b></font></td>
                                        <td width="24%" height="2">&nbsp;</td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td width="1%" height="40">&nbsp;</td>
                                  <td width="45%" height="40" bgcolor="#FFFFCC"> 
                                    <table width="100%" border="1" bordercolor="1">
                                      <tr bgcolor="#FFCCCC"> 
                                        <td width="64%" height="2"> 
                                          <div align="center"><font size="2" face="Arial"><b><font size="2" face="Arial"><br>
                                            VISA TYPE<br>
                                            &nbsp; </font></b></font></div>
                                        </td>
                                        <td width="36%" height="2"> 
                                          <div align="center"><b><font size="2" face="Arial"><br>
                                            VISA FEE<br>
                                            &nbsp; </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="64%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">TRANSIT</font></font></span></b> 
                                        </td>
                                        <td width="36%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;&nbsp;505.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="64%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">UP 
                                          TO 30 DAYS</font></font></span></b> 
                                        </td>
                                        <td width="36%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;1260.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="64%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font face="Arial, Helvetica, sans-serif" color="#3333FF">30 
                                          TO 60 DAYS</font></font></span></b></td>
                                        <td width="36%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                                          1523.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="64%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">60 
                                          TO 90 DAYS</font></font></span></b></td>
                                        <td width="36%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp;&nbsp;1765.00</font></b></font></td>
                                      </tr>
                                      <tr> 
                                        <td width="64%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">RESIDENCE/WORK 
                                          VISA</font></font></b></font></font></font></span></b> 
                                        </td>
                                        <td width="36%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                          &nbsp; 2750.00</font></b></font></td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update230103.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="700"> 
                  <div align="right"><a href="update110203.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
          <td> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
