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
<table border="0" cellspacing="0" cellpadding="0" align="left" height="652" width="100%">
  <tr> 
    <td height="652"> 
      <table width="99%" border="0" cellspacing="0" cellpadding="0" height="548">
        <tr> 
          <td height="73"><img src="images/topn1.jpg" width="760" height="71"></td>
        </tr>
        <tr> 
          <td height="24"> 
            <table width="91%" border="0" cellspacing="0" cellpadding="0">
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
          <td height="14"><img src="images/linecolor.gif" width="760" height="12"></td>
        </tr>
        <tr> 
          <td height="7"><img src="images/pixelb.gif" width="33" height="5"></td>
        </tr>
        <tr> 
          <td height="28"><img src="images/threei.gif" width="760" height="26" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="329,2,436,24"><area shape="rect" coords="461,1,597,24"><area shape="rect" coords="619,2,720,24"></map></td>
        </tr>
        <tr> 
          <td height="476"> 
            <table width="99%" border="0" cellspacing="0" cellpadding="0" height="469">
              <tr> 
                <td width="21">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" width="802"> 
                  <div align="center"><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">8th 
                    July 2002</font></i></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="357">&nbsp;</td>
                <td colspan="3" width="802" height="357"> 
                  <table width="95%" border="0" height="196">
                    <tr> 
                      <td height="21" colspan="4" width="757"></td>
                    </tr>
                    <tr> 
                      <td height="21" colspain="4" colspan="4" width="757"> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" colspan="4" height="2" width="757"> 
                        <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">ONLINE 
                          STATUS CHECK</font></u></font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" colspan="4" height="2" width="757"><b><font face="Arial, Helvetica, sans-serif"><b><font size="2"> 
                        <div align="justify">NOW YOU CAN CHECK YOUR VISA CASES&#146; 
                          STATUS AND DOCUMENTATION PROCEDURES FOR VARIOUS COUNTRIES 
                          &amp; CATEGORIES ONLINE AT WWW.UDAANINDIA.COM. </div>
                        </font></b></font></b></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" colspan="4" height="2" width="757"> 
                        <div align="justify">CONTACT US FOR YOUR USER I/D AND 
                          PASSWORD, IF THE SAME HAS NOT BEEN FORWARDED TO YOU 
                          UNTILL NOW.</div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" colspan="3" height="12" width="535"> 
                        <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u></u></font></b></div>
                        <div align="justify"><b><font face="Arial, Helvetica, sans-serif"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font color="#800080"> 
                          </font></span></font></b></font></b><font face="Arial, Helvetica, sans-serif"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font color="#800080"> 
                          </font></span></font></b></font></div>
                        <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">GREECE</span></u></font></b></div>
                      </td>
                      <td valign="top" align="left" height="1" rowspan="21" width="216"> 
                        <div align="right"> <img src="updateimg/greece3.jpg" WIDTH="210" HEIGHT="238"> 
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="2">&nbsp;</td>
                      <td valign="top" align="left" height="2" colspan="2" width="513"> 
                        <div align="justify"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial">AS 
                          PER RECENT NOTIFICATION FROM 'EMBASSY OF GREECE ' - 
                          NEW DELHI, WITH IMMEDIATE EFFECT THE REVISED VISA FEE 
                          WILL BE AS FOLLOWS.</font></span></font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="23">&nbsp;</td>
                      <td valign="top" align="left" height="23" width="333"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial">&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                        ENTRY (30 days)</font></font></span></b> </td>
                      <td valign="top" align="left" height="23" width="174"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        &nbsp;1244.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="2">&nbsp;</td>
                      <td valign="top" align="left" height="2" width="333"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial">&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                        ENTRY (90 days)</font></font></span></b> </td>
                      <td valign="top" align="left" height="2" width="174"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        &nbsp;1723.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="2">&nbsp;</td>
                      <td valign="top" align="left" height="2" width="333"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial">&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">HELLAS 
                        VISA (Only Greece) (90 days)</font></font></span></b> 
                      </td>
                      <td valign="top" align="left" height="2" width="174"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                        1483.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="2">&nbsp;</td>
                      <td valign="top" align="left" height="2" width="333"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial">&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">TRANSIT 
                        / SEAMAN</font></font></span></b> </td>
                      <td valign="top" align="left" height="2" width="174"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        &nbsp; 526.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="right" width="16" height="2">&nbsp;</td>
                      <td valign="top" align="left" height="2" width="333"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial">&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;ATTESTATION 
                        (Per Page)</font></font></b></font></font></font></span></b> 
                      </td>
                      <td valign="top" align="left" height="2" width="174"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        &nbsp; 957.00</font></b></font></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2" width="69"><b><font face="Arial, Helvetica, sans-serif"><a href="update030702.ASP"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="731" height="2"> 
                  <div align="right"><a href="updatecontactinfo.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2" width="802"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="760" border="0" bgcolor="#CCCCCC">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3" height="2" width="752"> 
                          <div align="center"><u><font color="#0000FF" face="Arial, Helvetica, sans-serif"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="191" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="325" height="2"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          </b></td>
                        <td width="224" height="2"> 
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
          <td height="1"> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
