<%@ Language=VBScript %>
<%
response.buffer= true

if session("priv")="" or session("priv")= "guest" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
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
                <td width="21" height="1460">&nbsp;</td>
                <td colspan="3" height="1460"> 
                  <table height="1226" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="1185"> 
                        <table width="613" align="center" height="1020" border="1" bordercolor="#333333">
                          <tr valign="top" > 
                            <td height="1037" colspan="2"> 
                              <table width="100%" border="1" height="1033">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="979"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><img src="updateimg/Malaysia%20Heading160306.png" width="305" height="58"></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td height="45"> 
                                            <div align="center"><font face="Monotype Corsiva" size="+7"><b><font color="#CC0033">01/10/2007</font></b></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <p><font face="Verdana" size="3"><b><br>
                                          Dear Agents, </b><br>
                                          <br>
                                          </font><b><font size="3">Kindly note 
                                          that our office will be closed tomorrow 
                                          on the occasion of Gandhi Jayanthi</font> 
                                          <br>
                                          </b></p>
                                        <table width="100%">
                                          <tr> 
                                            <td> 
                                              <div align="center"><b><font color="#FF3333" size="4">Holiday 
                                                List for October </font></b></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p>**************************************************************************</p>
                                        <p><b>* CHINA</b> <font color="#FF3333" size="3"><b> 
                                          Monday, October 01, 2007 </b></font><br>
                                          <b>* PHILIPPINES</b> <b><font color="#FF3333">Monday, 
                                          October 01, 2007</font></b><br>
                                          <b>* AUSTRIA</b> <font color="#FF3333"><b>Tuesday, 
                                          October 02, 2007</b></font><br>
                                          <b>* NETHERLANDS</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b> <br>
                                          <b>* THAILAND</b>. <font color="#FF6666"><b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b></font> <br>
                                          <b>* BRAZIL</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007 </font></b><br>
                                          <b>* CHINA</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007 </font></b><br>
                                          <b>* ISRAEL</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b> <br>
                                          <b>* PHILIPPINES</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b> <br>
                                          <b>* BELGIUM</b> <font color="#FF3333"><b>Tuesday, 
                                          October 02, 2007</b></font> <br>
                                          <b>* GERMANY</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b><br>
                                          <b>* SINGAPORE</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b> <br>
                                          <b>* SWITZERLAND</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007 </font></b><br>
                                          <b>* UNITED KINGDOM</b> <font color="#FF3333"><b>Tuesday, 
                                          October 02, 2007 </b></font><br>
                                          <b>* KENYA</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007 </font></b><br>
                                          <b>* IRELAND</b> <b><font color="#FF3333">Tuesday, 
                                          October 02, 2007</font></b><br>
                                          <b>* PHILIPPINES</b> <b><font color="#FF3333">Wednesday, 
                                          October 03, 2007</font></b><br>
                                          <b>* CHINA</b> <b><font color="#FF3333">Wednesday, 
                                          October 03, 2007</font></b> <br>
                                          <b>* KOREA</b> <b><font color="#FF3333">Wednesday, 
                                          October 03, 2007</font></b> <br>
                                          <b>* KOREA</b> <b><font color="#FF3333">Thursday, 
                                          October 04, 2007 </font></b><br>
                                          <b>* CHINA</b> <font color="#FF3333"><b>Thursday, 
                                          October 04, 2007</b></font><br>
                                          <b>* PHILIPPINES</b> <b><font color="#FF3333">Thursday, 
                                          October 04, 2007</font></b> <br>
                                          <b>* ISRAEL</b> <font color="#FF3333"><b>Thursday, 
                                          October 04, 2007</b></font> <br>
                                          <b>* ISRAEL</b> <b><font color="#FF3333">Friday, 
                                          October 05, 2007</font></b> <br>
                                          <b>* PHILIPPINES</b> <b><font color="#FF3333">Friday, 
                                          October 05, 2007</font></b> <br>
                                          <b>* CHINA</b> <b><font color="#FF3333">Friday, 
                                          October 05, 2007</font></b> <br>
                                          <b>* KENYA</b> <b><font color="#FF3333">Wednesday, 
                                          October 10, 2007</font></b><br>
                                          <b>* MALAYSIA</b> <b><font color="#FF3333">Monday, 
                                          October 15, 2007</font></b><br>
                                          <b>* MALAYSIA</b> <b><font color="#FF3333">Tuesday, 
                                          October 16, 2007</font></b> <br>
                                          <b>* IRELAND</b> <b><font color="#FF3333">Monday, 
                                          October 29, 2007 </font></b></p>
                                      </div>
                                      <table width="100%" border="1" height="84">
                                        <tr> 
                                          <td height="2"> 
                                            <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                              and support us, to serve you better</font> 
                                              &quot;</div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <b> </b></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="3">&nbsp;</td>
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
                    <table width="98%" border="0" bgcolor="#CCCCCC" height="8">
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
          <td><!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
