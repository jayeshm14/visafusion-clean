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
                <td width="21" height="468">&nbsp;</td>
                <td colspan="3" height="468"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="507" align="center" height="227" bgcolor="#FFFFFF" border="1" bordercolor="#000066">
                          <tr> 
                            <td height="2" colspan="2"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">25th 
                                August 2004</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="500" height="1"></td>
                          </tr>
                          <tr > 
                            <td height="497" colspan="2"> 
                              <table width="100%" height="390">
                                <tr> 
                                  <td valign=top align=left height=2 colspan="3"> 
                                    <div align="center"><img src="updateimg/newzealand1.jpeg" width="280" height="208"></div>
                                  </td>
                                </tr>
                                <tr bgcolor="#000099"> 
                                  <td valign=top align=left height=2 colspan="3"> 
                                    <div align="center"> 
                                      <div align="justify"><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial" size="3" color="#003399"><i><b><font color="#FFFFFF"> 
                                        P.O.E SUSPENSION IS NOT REQUIRED FOR THE 
                                        FOLLOWING COUNTRIES:-</font></b></i></font></span></font></div>
                                    </div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#FFCCCC"><font color="#000000"><b><font size="2" face="Arial"><span 
                        style="mso-bidi-font-size: 10.0pt">ALBANIA</span></font></b></font></td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">GREENLAND</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#FFCCCC"><font color="#000000"><b><font size="2" face="Arial">POLAND</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#E6FFFF"> 
                                    <div align="left"><font color="#000000"><b><font size="2" face="Arial">AUSTRALIA</font></b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">HUNGARY</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">PORTUGAL</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">AUSTRIA 
                                    </font></b></font></td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">IRELAND</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">ROMANIA</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#E6FFFF"> 
                                    <font color="#000000"><b><font face="Arial" size="2">BAHAMAS</font></b></font></td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">ICELAND</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">SAN 
                                    MARINO </font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">BANGLADESH</font></b></font></td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">ITALY</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#FFCCCC"><font color="#000000"><b><font size="2" face="Arial">SLOVAK 
                                    REPUBLIC </font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="173" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">BELGIUM</font></b></font></td>
                                  <td valign=top align=left height=2 width="160" bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">JAPAN</font></b></font></td>
                                  <td valign=top align=left height=2 width="151" bgcolor="#E6FFFF"><font color="#000000"><b><font size="2" face="Arial">SPAIN</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"> 
                                    <div align="justify"><font color="#000000"><b><font face="Arial" size="2">BHUTAN 
                                      </font></b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">LATVIA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">SWEDEN</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">BULGARIA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">LIECHTENSTEIN</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">SWITZERLAND</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">CANADA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">LITHUANIA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">THE 
                                    HOLY SEE</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">CYPRUS</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">LUXEMBOURG</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">TURKEY</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">CZECH 
                                    REPUBLIC</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">MALTA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">U. 
                                    S. A.</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">DENMARK</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">MEXICO</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">UNITED 
                                    KINGDOM</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">ESTONIA</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">MONACO</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">VATICAN 
                                    CITY</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">FINLAND</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">NEPAL</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">YUGOSLAVIA</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">FRANCE</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">NETHERLANDS</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">SINGAPORE 
                                    </font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">GERMANY</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">NEW 
                                    ZEALAND</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">THAILAND</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">GIBRALTAR</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">NORWAY</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC"><font color="#000000"><b><font face="Arial" size="2">KOREA</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">GREECE</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">PAKISTAN</font></b></font></td>
                                  <td valign=top align=left height=2 bgcolor="#E6FFFF"><font color="#000000"><b><font face="Arial" size="2">SOUTH 
                                    AFRICA</font></b></font></td>
                                </tr>
                                <tbody> </tbody> 
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update240804.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><b><font face="Arial, Helvetica, sans-serif"><a href="update030904.asp"><img src="updateimg/next.jpg" border="0" width="70" height="37"></a></font></b>&nbsp;</div>
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
