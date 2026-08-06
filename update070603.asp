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
                <td width="21" height="635">&nbsp;</td>
                <td colspan="3" height="635"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table height=483 cellspacing=0 cellpadding=0 width="667" 
border=1 hspace="0" vspace="0" align="center">
                          <tr valign="top"> 
                            <td height=666> 
                              <table cellspacing=0 cellpadding=0 width="100%" border=0 height="444">
                                <tr> 
                                  <td width=0% height="288" bgcolor="#000099" rowspan="2">&nbsp;</td>
                                  <td colspan=5 height="2"> 
                                    <div align="center"><font size="6"><b><font 
            face="Arial Black" color=#000080 size=6><i><font color="#000000">UPDATE</font></i></font><font color="#000000"><i><font 
            face=Arial size=6> </font><font face="Arial" size="5">7th June 2003</font></i></font></b></font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td colspan=5 height="361" bgcolor="#000000"> 
                                    <table width="95%" border="0" vspace="0" hspace="0">
                                      <tr> 
                                        <td width="13%" height="324" bgcolor="#000000" valign="top"><img src="updateimg/aus1.jpg" width="100" height="200" align="top"></td>
                                        <td width="69%" height="324" bgcolor="#FFFFFF"> 
                                          <table width="98%" border="0" bgcolor="#FFFFFF" height="409" align="center">
                                            <tr> 
                                              <td colspan="3"> 
                                                <div align="center"><b><font size="5" color="#000099"><u>AUSTRALIA</u></font></b></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="5" colspan="3"> 
                                                <div align="justify"><font face="Arial"><b><font size="2">APPRECIATE 
                                                  IF YOU COULD FORWARD </font><font face="Arial"><b><font size="2">AUSTRALIAN 
                                                  VISA FORMS DULY</font></b></font><font size="2"> 
                                                  FILLED AND SIGNED <font color="#CC0033">STRICTLY 
                                                  BY APPLICANTS ONLY</font>. ALSO 
                                                  KINDLY ENCLOSE RELEVANT DEMAND 
                                                  DRAFTS WITH APPLICATIONS TO 
                                                  ENSURE SPEEDY PROCESSING. </font></b></font></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="33" colspan="3"> 
                                                <div align="JUSTIFY"><font size="2" face="Arial"><b>DEMAND 
                                                  DRAFT FAVOURING '<font color="#CC0033">AUSTRALIAN 
                                                  HIGH COMMISSION</font>' - NEW 
                                                  DELHI. BUSINESS (SUBCLASS 456) 
                                                  AND VISITOR (SHORT STAY 48R) 
                                                  : RS. 1900/- </b> </font></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"><font face="Arial"><b><font size="2">TO 
                                                DOWNLOAD THESE FORMS PLEASE CLICK 
                                                ON BELOW LINKS. </font></b></font></td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"><b><font size="2" face="Arial"><img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/updateimg/48r.pdf" target="_blank">TOURIST 
                                                (48 R)</a></font></b><b><font size="2" face="Arial"> 
                                                / <a href="http://www.udaanindia.com/updateimg/456.pdf" target="_blank">BUSINESS 
                                                (456)</a></font></b><b><font size="2" face="Arial">&nbsp;/ 
                                                <a href="http://www.udaanindia.com/updateimg/australia.m-67form.gif" target="_blank">DETAILS 
                                                OF RELATIVES (M67)</a></font></b></td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"><font face="Arial" size="2"><b>FORMS 
                                                CAN ALSO BE DOWNLOADED FROM <a href="http://www.ausgovindia.com" target="_blank">http://www.ausgovindia.com</a></b></font></td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="center"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="center"><b><font size="5" color="#000099"><u>NEWZEALAND</u></font></b></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="JUSTIFY"><font size="2" face="Arial"><b>DEMAND 
                                                  DRAFT FAVOURING '<font color="#CC0033">NEWZEALAND 
                                                  IMMIGRATION SERVICE</font>' 
                                                  - NEW DELHI VISIT : RS. 2600/- 
                                                  (BUSINESS/TOURIST)</b></font></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"><b><font size="2" face="Arial"><img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/updateimg/nzis1017.pdf" target="_blank">VISIT 
                                                / BUSINESS</a></font></b><b><font size="2" face="Arial">&nbsp;&nbsp;<img src="http://www.ttsvisas.com/images/wwwgdl.gif"><a href="http://www.udaanindia.com/updateimg/newzealand.familysheet.gif" target="_blank">FAMILY 
                                                INFORMATION SHEET</a></font></b></td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"><font face="Arial" size="2"><b>FORMS 
                                                CAN ALSO BE DOWNLOADED FROM <a href="http://www.immigration.govt.nz" target="_blank">http://www.immigration.govt.nz</a></b></font></td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="center"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="center"><b><font size="5" color="#000099"><u>GERMANY</u></font></b></div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <div align="justify"><font face="Arial" size="2"><b>AS 
                                                  PER RECENT NOTIFICATION FROM 
                                                  'EMBASSY OF FEDERAL REPUBLIC 
                                                  OF GERMANY' - NEW DELHI, WITH 
                                                  IMMEDIATE EFFECT THE REVISED 
                                                  VISA FEE WILL BE AS FOLLOWS.</b></font> 
                                                </div>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td height="2" colspan="3"> 
                                                <table width="99%" align="center">
                                                  <tr bgcolor="#FFFFE6"> 
                                                    <td width="35%" height="2"><b><font size="2" face="Arial"> 
                                                      &nbsp;* 30 DAYS</font></b></td>
                                                    <td width="24%" height="2"><b><font face="Arial" size="2">RS. 
                                                      1390/-</font></b></td>
                                                  </tr>
                                                  <tr bgcolor="#F0F0FF"> 
                                                    <td width="35%" height="2"><b><font face="Arial" size="2">&nbsp;* 
                                                      90 DAYS</font></b></td>
                                                    <td width="24%" height="2"><b><font face="Arial" size="2">RS. 
                                                      1950/-</font></b></td>
                                                  </tr>
                                                  <tr bgcolor="#FFFFE6"> 
                                                    <td width="35%" height="2"><b><font face="Arial" size="2">&nbsp;* 
                                                      1 YEAR</font></b></td>
                                                    <td width="24%" height="2"><b><font face="Arial" size="2">RS. 
                                                      2760/-</font></b></td>
                                                  </tr>
                                                  <tr bgcolor="#F0F0FF"> 
                                                    <td width="35%" height="2"><b><font face="Arial" size="2">&nbsp;* 
                                                      2 YEARS</font></b></td>
                                                    <td width="24%" height="2"><b><font face="Arial" size="2">RS. 
                                                      4480/-</font></b></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                        <td width="18%" height="324" bgcolor="#000000" valign="top"><img src="updateimg/aus2.jpg" width="100" height="200"></td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width=0% height=2 bgcolor="#000099">&nbsp;</td>
                                  <td colspan=5 height=2 bgcolor="#000099"><img height=37 
            src="updateimg/burung.jpg" width=670></td>
                                </tr>
                                <tr> 
                                  <td width=0% height=1 bgcolor="#000099">&nbsp;</td>
                                  <td colspan=5 height=1 bgcolor="#000000"><marquee direction="LEFT"><img src="updateimg/uma-kang.gif" width="60" height="60"></marquee></td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update030603.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update140603.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
