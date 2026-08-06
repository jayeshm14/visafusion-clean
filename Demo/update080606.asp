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
                <td width="21" height="286">&nbsp;</td>
                <td colspan="3" height="286"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="550"> 
                        <table width="681" align="center" height="485" border="1" bordercolor="#333333">
                          <tr valign="top" > 
                            <td height="354" colspan="2"> 
                              <table width="87%" border="1" height="293">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="415"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><img src="updateimg/Malaysia%20Heading160306.png" width="305" height="58"></div>
                                          </td>
                                        </tr>
                                        <tr>
                                          <td height="45"> 
                                            <div align="center"><img src="updateimg/date%20080606.png" width="272" height="64"></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <table width="658" border="1">
                                          <tr bordercolor="#000000"> 
                                            <td> 
                                              <div align="center"><font face="Verdana" size="3"><b>New 
                                                Contact Numbers Of Udaan </b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <table width="657" border="0">
                                          <tr> 
                                            <td height="2"> 
                                              <div align="justify"><font face="Verdana" size="2"><br>
                                                With Immediate effect, Due to 
                                                the change of code in <b>TATA 
                                                INDICOM NUMBER</b> henceforth,all 
                                                our <b>communication telephone 
                                                numbers </b>would be<b> </b> changed. 
                                                Kindly dial the following telephone 
                                                numbers to reach us.<b> <br>
                                                </b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <table width="657" border="1">
                                          <tr> 
                                            <td width="312" height="18"> 
                                              <div align="center"><b><font face="Verdana" size="2" color="#FF0066">Old 
                                                Telephone Numbers </font></b></div>
                                            </td>
                                            <td width="329" height="18"> 
                                              <div align="center"><b><font face="Verdana" size="2" color="#FF0066">New 
                                                Telephone Numbers</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55603650 
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-66603650</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55603651 
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-66603651</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55603652 
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-66603652</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55603653 
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-66603653</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55603654	
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-66603654</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="312"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-55653707	
                                                </font></b></div>
                                            </td>
                                            <td width="329"> 
                                              <div align="center"><b><font face="Verdana" size="2">011-65653707 
                                                </font></b></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <br>
                                        <table width="659" border="0">
                                          <tr> 
                                            <td> 
                                              <div align="center"><b><font face="Verdana">For 
                                                all latest visa related information, 
                                                visit our website: - <a href="http://www.udaanindia.com">www.udaanindia.com</a></font></b></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="2"> 
                                          </font><font face="Verdana" size="3"><font size="2">*************************************************************************<br>
                                          </font></font></p>
                                        <table width="659" border="1">
                                          <tr bordercolor="#000000"> 
                                            <td> 
                                              <div align="center"><font face="Verdana" size="3"><b>Singapore 
                                                High Commission - 12 June, 2006</b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="3"><font size="2"> 
                                          Temporarily due to heavy rush in Singapore 
                                          Embassy,the Embassy would be accepting 
                                          visa application forms as per the travel 
                                          date, <b>Air Tickets</b> showing the 
                                          next day travel would be entertained 
                                          on urgent basis and visa would be granted 
                                          the next day, However for others the 
                                          minimum time required would be three 
                                          working days after the receipt of complete 
                                          applications</font></font><font face="Verdana" size="2"> 
                                          </font></p>
                                      </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="2"> 
                                            <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                              and support us, to serve you better</font> 
                                              &quot;</div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><b><img src="updateimg/bird76.gif" width="40" height="40">Udaan 
                                                India Pvt. Ltd.</b></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      
                                    </div>
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
