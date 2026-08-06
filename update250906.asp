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
                <td width="21" height="265">&nbsp;</td>
                <td colspan="3" height="265"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="550"> 
                        <table width="682" align="center" height="443" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="688" height="8"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="231" colspan="2"> 
                              <table width="99%" border="1" height="357">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="187"> 
                                    <div align="justify"> 
                                      <table width="100%">
                                        <tr>
                                          <td><img src="orange%20villa.png" width="354" height="68"><img src="orange%20villa%201.png" width="312" height="69"></td>
                                          <td>&nbsp;</td>
                                        </tr>
                                      </table>
                                      <div align="justify">
                                        <table width="678" border="1">
                                          <tr bordercolor="#000000"> 
                                            <td> 
                                              <div align="center"><font face="Verdana" size="3"><b><i><font color="#FF9900">ORANGE 
                                                VILLA - &quot; HOME AWAY FROM 
                                                HOME &quot;</font></i></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <font face="Verdana" size="2"><b><i>Orange 
                                        Villa depict the concept of <font color="#FF9900">"HOME 
                                        AWAY FROM HOME "</font> for executives 
                                        or business groups. Our combination of 
                                        traditional Indian hospitality and a genuine 
                                        desire to provide comfort and an efficient 
                                        service package makes our properties an 
                                        ideal choice for you!</i></b></font><br>
                                        <table width="100%">
                                          <tr>
                                            <td width="51%"> 
                                              <div align="center"><img src="updateimg/Broucherfront2.jpg" width="283" height="347"></div>
                                            </td>
                                            <td width="49%"> 
                                              <div align="center"><img src="updateimg/Broucherback1.jpg" width="283" height="347"></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="2"><b><i>It 
                                          is ideally located in South Delhi close 
                                          proximity to Domestic as well as International 
                                          Airport and Millennium city Gurgaon. 
                                          We have total 3 well furnished rooms 
                                          with contemporary décor in both Double 
                                          and Twin bedded category.<br>
                                          <br>
                                          It offers tastefully furnished rooms, 
                                          fully equipped and professionally managed 
                                          staff and economical and feasible alternatives 
                                          to hotels/guest houses. Moreover Orange 
                                          Villa provides the flexibility of stay 
                                          from one day to one month to a year 
                                          as required. </i></b></font><i><b><font face="Verdana" size="3"><br>
                                          </font></b><font face="Verdana" size="3"></font></i><font face="Verdana" size="3"><br>
                                          <b><i>Facilities:-</i></b></font></p>
                                        <table width="100%" border=1>
                                          <tr bordercolor="#FF9933" bgcolor="#FFFFFF"> 
                                            <td width="68%"><font size="2" face="Verdana"><b><font color="#000000">1.) 
                                              </font><font color="#FF6600">The 
                                              state-of-the-art design and elegantly 
                                              furnished exclusive living cum dining 
                                              room</font></b></font></td>
                                            <td width="32%"><font size="2" face="Verdana"><b><font color="#000000">5.)</font><font color="#FF6600"> 
                                              Hot & cold water facilities<br>
                                              </font> </b> </font></td>
                                          </tr>
                                          <tr bordercolor="#FF9933" bgcolor="#FFFFFF"> 
                                            <td width="68%"><font size="2" face="Verdana" color="#FF6600"><b><font color="#000000">2.)</font> 
                                              Television in each room</b></font></td>
                                            <td width="32%"><font size="2" face="Verdana"> 
                                              <font color="#FF6600"><b><font color="#000000">6.)</font> 
                                              Wi-Fi</b></font></font></td>
                                          </tr>
                                          <tr bordercolor="#FF9933" bgcolor="#FFFFFF"> 
                                            <td width="68%"><font size="2" face="Verdana"> 
                                              <font color="#FF6600"><b><font color="#000000">3.)</font> 
                                              24 hours room service</b></font></font></td>
                                            <td width="32%"><font size="2" face="Verdana"> 
                                              <font color="#FF6600"><b><font color="#000000">7.)</font> 
                                              Direct dialing ISD/ STD facilities</b></font></font></td>
                                          </tr>
                                          <tr bordercolor="#FF9933" bgcolor="#FFFFFF"> 
                                            <td width="68%"><font size="2" face="Verdana"><b><font color="#000000">4.) 
                                              </font><font color="#FF6600">Laundry 
                                              & cook services</font></b></font></td>
                                            <td width="32%">&nbsp;</td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="3"><b><i>Payment 
                                          accepted through all major credit cards</i></b><font size="2">:-<br>
                                          <b>Tariff : </b>-<br>
                                          <br>
                                          Single / Double room : Rs 3,000 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Extra 
                                          bed : Rs 500 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Whole 
                                          Apartment per day : Rs 7,500 <br>
                                          One week per room : Rs 19,500&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;one 
                                          week (whole apartment) : Rs 49,000 <br>
                                          <br>
                                          <b>The above special rate is inclusive 
                                          of: </b><br>
                                          <b>1.)</b> Accommodation per room per 
                                          night <br>
                                          <b>2.)</b> Buffet Breakfast<br>
                                          <br>
                                          <i><b><font size="3">Special Rate :<br>
                                          <font size="2">Single / Double room 
                                          : Rs 2,700/- </font></font></b></i><br>
                                          The above special rate is inclusive 
                                          of:<br>
                                          <br>
                                          <b>1.)</b> Accommodation per room per 
                                          night<br>
                                          <b>2.)</b> Buffet Breakfast <br>
                                          <b>3.)</b> Currently applicable taxes<br>
                                          <br>
                                          </font></font></p>
                                        <table width="100%">
                                          <tr>
                                            <td>
                                              <div align="center"><font face="Verdana" size="3"><font size="2"><b><font size="3">1.22% 
                                                Service tax Levied Extra.</font></b></font></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="3"><font size="2"><b>Airport 
                                          transfer can arrange on request with 
                                          extra cost.<br>
                                          <br>
                                          </b>The above rates can be changed without 
                                          prior notice.<br>
                                          <br>
                                          <b><font size="3">ORANGE VILLA<br>
                                          # 3167 Sector - A, Pocket - B & C <br>
                                          Vasant kunj, New Delhi - 110 070 <br>
                                          Tel: +91 11 4606 5100 (3 lines) <br>
                                          Fax: + 91 11 4178 5493<br>
                                          Email: orangevilla@orangecabs.net </font></b><br>
                                          <br>
                                          </font></font></p>
                                        <table width="100%">
                                          <tr>
                                            <td><font face="Verdana"><i><b><font size="3">For 
                                              Booking contact :</font></b></i></font></td>
                                          </tr>
                                        </table>
                                        <br>
                                        <table width="100%">
                                          <tr> 
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Kamal 
                                                Vacations Pvt. Ltd.</font></b></font></div>
                                            </td>
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">#26, 
                                                Bina Mangala Block, Stage - 2, 
                                                MIG,</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td height="19"> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">C-5, 
                                                Shanti Kunj, Church Road , Opp. 
                                                D-3,</font></b></font></div>
                                            </td>
                                            <td height="19"> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">CMH 
                                                Road, Indira Nagar,</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Vasant 
                                                Kunj, New Delhi - 110 070 </font></b></font></div>
                                            </td>
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Bangalore 
                                                - 560 008</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Tel 
                                                : + 91 11 41785050 / 5151</font></b></font></div>
                                            </td>
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Tel 
                                                : + 91 80 4115 2886 , 3293 9126</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Fax 
                                                : + 91 11 41785493</font></b></font></div>
                                            </td>
                                            <td> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Fax: 
                                                + 91 80 4115 2884</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td height="2"> 
                                              <div align="center"><font color="#FF6600"><b><font size="2" face="Verdana">Email: 
                                                query@vacationsindiaonline.com<br>
                                                booking@orangecabs.net <br>
                                                </font></b></font></div>
                                            </td>
                                            <td height="2"> 
                                              <div align="left"><font color="#FF6600"><b><font size="2" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email 
                                                : info@atlashoppers.com <br>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;orangecabs@atlashoppers.com<br>
                                                </font></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p align="justify"><font face="Verdana" size="3"><font size="2"><br>
                                          ***************************************************************************</font></font></p>
                                        </div>
                                      <b> </b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="680" height="5"></div>
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
