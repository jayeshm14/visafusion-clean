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
                <td width="21" height="1133">&nbsp;</td>
                <td colspan="3" height="1133"> 
                  <table height="1" cellspacing="1" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="524" border="1" align="center" bordercolor="#FFFFFF" height="1240" bgcolor="#000033">
                          <tr> 
                            <td height="1267"> 
                              <table align="center" width="100%" height="1207">
                                <tr> 
                                  <td height="361" colspan="2"> 
                                    <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i><font color="#FFFFFF">UPDATE</font></i></font><font color="#FFFFFF"><i><font 
            face=Arial size=6> </font><font face="Arial" size="4">3rd SEPTEMBER 
                                      2004<br>
                                      <br>
                                      </font></i></font></b> 
                                      <table width="600" border="1" cellpadding="0" height="8">
                                        <tr bgcolor="#333333"> 
                                          <td height="30"> 
                                            <div align="center"><font color="#FFFFFF" face="Comic Sans MS, Garamond" size="5"><b>*UNITED 
                                              KINGDOM*<br>
                                              --------------------------------------- 
                                              </b></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <table width="600" border="0" cellpadding="0">
                                        <tr>
                                          <td height="76"> 
                                            <div align="JUSTIFY"><font color="#FFFFFF" face="Garamond" size="3"><b>AS 
                                              PER LATEST NOTIFICATION FROM THE 
                                              <font color="#FF3333">"HIGH COMMISSION 
                                              OF BRITAIN"</font> - NEW DELHI, 
                                              FROM <font color="#FF3333">1ST SEPTEMBER</font> 
                                              APPLICANT SHOULD COMPLETE AN APPLICATION 
                                              FORM TOGETHER WITH 2 RECENT PASSPORT 
                                              SIZE PHOTOGRAPHS<font color="#FF3333">( 
                                              45 MM WIDE BY 35 MM )</font>, RECENT 
                                              AND TRUE LIKENESS, SHOWING FULL 
                                              FACE, WITH NO HAT, HELMET OR SUNGLASSES, 
                                              ALTHOUGH APPLICANT CAN WEAR EVERYDAY 
                                              GLASSES, <font color="#FF3333">TAKEN 
                                              AGAINST A WHITE BACKGROUND</font>. 
                                              THE PHOTOGRAPHS SHOULD BE GLUED 
                                              TO THE FORM, NOT STAPLED. <font color="#FF3333">(AS 
                                              NOW THE PHOTOGRAPH WILL BE SCANNED 
                                              UPON THE VISA ITSELF)</font></b></font> 
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="left">
                                        <table width="600" border="0" cellpadding="0">
                                          <tr>
                                            <td height="18"><font color="#FFFFFF">--------------------------------------------------------------------------------------------------</font></td>
                                          </tr>
                                        </table>
                                        <b><font color="#FFFFFF"><i><font face="Arial" size="4">VFS 
                                        SERVICE CHARGE <font color="#FF3333">RS. 
                                        441/- <br>
                                        </font></font></i></font></b></div>
                                    </div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><font color="#FFFFFF">----------------------------------------------------------------------------------------------------</font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><b><font face="Arial" size="4" color="#990099"><u><font color="#FFFFFF" face="Comic Sans MS, Garamond" size="5">**BELGIUM**</font></u></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><img src="updateimg/hungary.jpg" width="422" height="234"></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="JUSTIFY"><font face="AriaL" size="2"><b><font color="#FFFFFF" face="Garamond" size="3">AS 
                                      PER LATEST NOTIFICATION FROM "THE EMBASSY 
                                      OF BELGIUM "- NEW DELHI, ALL THE VISA FEES 
                                      SHOULD BE PAID ONLY BY DEMAND DRAFT DRAWN 
                                      ON A NATIONAL OR INTERNATIONAL BANK. THEY 
                                      SHOULD BE MADE FOR THE EXACT AMOUNT IN FAVOUR 
                                      OF THE <font color="#FF3333">"EMBASSY OF 
                                      BELGIUM"</font> - PAYABLE AT NEW DELHI WITH 
                                      EFFECT FROM <font color="#FF3333">1ST SEPTEMBER, 
                                      2004. </font></font></b></font></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#FFFFFF"> 
                                  <td height="419" colspan="2"> 
                                    <table width="99%">
                                      <tr bordercolor="#FFFFFF"> 
                                        <td height="2" valign="top" width="57%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font color="#FF3333">VISA 
                                            TYPE </font></b></font></div>
                                        </td>
                                        <td height="2" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font color="#FF3333">VISA 
                                            FEES </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font size="2">VISA 
                                            'A' AND 'B' ( TRANSIT VISA )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            560/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="48" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></font></font></font></span><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C' ( VISA VALID DURING MAXIMUM 30 
                                            DAYS WITH ONE ENTRY IN TO THE SCHENGEN 
                                            ZONE )</font></b></font></div>
                                        </td>
                                        <td height="48" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            1400/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C' ( VALID 30 DAYS WITH MULTIPLE 
                                            ENTRY INTO THE SCHENGEN ZONE )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            1400/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C' ( VISA VALID DURING MAXIMUM 90 
                                            DAYS WITH ONE ENTRY INTO THE SCHENGEN 
                                            ZONE )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            1680/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C+' ( VISA VALID DURING MAXIMUM 90 
                                            DAYS WITH MULTIPLE ENTRIES IN TO THE 
                                            SCHENGEN ZONE TO BE TO BE USED IN 
                                            A PERIOD OF SIX MONTHS )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            1960/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C+' ( VISA VALID DURING MAXIMUM 90 
                                            DAYS WITH MULTIPLE ENTRIES INTO THE 
                                            SCHENGEN ZONE )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            2800/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"> 
                                          <div align="left"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                            'C+' (TWO YEARS )</font></b></font></div>
                                        </td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF"><b><font face="Garamond">RS. 
                                            4480/- </font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                          'C+' (THREE YEARS )</font></b></font></td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font color="#FFFFFF" face="Garamond"><b>RS. 
                                            6160/- </b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                          'C+' (FOUR YEARS )</font></b></font></td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><b><font face="Garamond" color="#FFFFFF">RS. 
                                            7840/- </font></b></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="19" valign="top" width="57%"><font color="#FFFFFF"><b><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font size="2">VISA 
                                          'C+' (FIVE YEARS )</font></b></font></td>
                                        <td height="19" valign="top" width="43%"> 
                                          <div align="center"><font face="Garamond" color="#FFFFFF"><b>RS. 
                                            9520/- </b></font></div>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td height="19" valign="top" width="57%"><font color="#FFFFFF"><b><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font></b></font><font color="#FFFFFF" size="2"><b>VISA 
                                          'D' STUDENT, FAMILY REUNION, ON BASIS 
                                          OF WORK PERMIT</b></font></td>
                                        <td height="19" valign="top" width="43%">
                                          <div align="center"><font face="Garamond" color="#FFFFFF"><b>RS. 
                                            2800/- </b></font></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><font color="#FFFFFF">----------------------------------------------------------------------------------------------------</font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update250804.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update230904.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
