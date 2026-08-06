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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="228">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="189">&nbsp;</td>
                <td colspan="3" height="189"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="457" align="center" height="354" border="0" bgcolor="#E8FFE8">
                          <tr> 
                            <td height="2" colspan="3"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">10th 
                                November 2003</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="8" colspan="3"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">THAILAND</span></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="198" colspan="2" valign="top"> 
                              <div align="justify"> 
                                <p><font face="Arial" size="2">AS PER RECENT NOTIFICATION 
                                  FROM THE '<b>ROYAL THAI EMBASSY</b>' - NEW DELHI, 
                                  WITH IMMEDIATE EFFECT THE <font color="#FF0033"><b>APPLICANT 
                                  SHOULD HAVE US$ ENDORSED IN THE PASSPORT OR 
                                  COPY OF INTERNATIONAL CREDIT CARD</b></font> 
                                  AT THE TIME OF APPLYING FOR BUSINESS / TOURIST 
                                  VISA TO THAILAND.<br>
                                  <br>
                                  <b>NEW REQUIREMENTS ARE AS FOLLOWS:-</b></font></p>
                              </div>
                              <ul>
                                <li> 
                                  <div align="justify"><font face="Arial" size="2">RETURN 
                                    AIR TICKET.</font></div>
                                </li>
                                <li> 
                                  <div align="justify"><font face="Arial" size="2">PASSPORT 
                                    VALID FOR SIX MONTHS.</font></div>
                                </li>
                                <li> 
                                  <div align="justify"><font face="Arial" size="2">TWO 
                                    RECENT PHOTOGRAPHS.</font></div>
                                </li>
                                <li> 
                                  <div align="justify"><font face="Arial" size="2"><b>US$ 
                                    MUST BE ENDORSED IN THE PASSPORT / CREDIT 
                                    CARD COPY.</b></font></div>
                                </li>
                              </ul>
                            </td>
                            <td height="6" rowspan="2" width="183" valign="top"> 
                              <div align="right"><br>
                                <img src="updateimg/argentina.jpg" width="180" height="220"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" width="173">&nbsp;</td>
                            <td height="2" width="93">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">AUSTRALIA</span></u></font></b></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"> 
                              <div align="JUSTIFY"><font face="Arial" size="2"><b>AS 
                                PER RECENT NOTIFICATION FROM 'AUSTRALIAN HIGH 
                                COMMISSION' NEW DELHI, WITH IMMEDIATE EFFECT THE 
                                APPLICATION FORM HAS BEEN CHANGED.</b></font></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"><font face="Arial" size="2"><b><font size="2" face="Arial"><img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/forms/48r.pdf" target="_blank">Tourist(48R)</a></font></b><b><font size="2" face="Arial"> 
                              &nbsp;&nbsp;<img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/forms/456.pdf" target="_blank">Business(456)</a></font></b><b><font size="2" face="Arial">&nbsp;&nbsp;&nbsp;<img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/forms/m67.pdf" target="_blank">Detail 
                              of Relatives(M67)</a></font></b></font></td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"> 
                              <div align="justify"><font face="Arial" size="2"><b>Forms 
                                can also be downloaded from <a href="http://www.immi.gov.au/" target="_blank">http://www.immi.gov.au</a></b></font> 
                                <br>
                                &nbsp; </div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update071103.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update031203.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
