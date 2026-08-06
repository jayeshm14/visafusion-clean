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
                <td width="21" height="211">&nbsp;</td>
                <td colspan="3" height="211"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="192"> 
                        <table width="663" align="center" height="345" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="2" colspan="2"> 
                              <table width="100%" border="1" height="242">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="346" bordercolor="#000000"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Courier New, Courier, mono" size="7"><font face="Verdana">UDAAN-UPDATE</font></font></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td> 
                                            <div align="center"></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"><font face="Verdana" size="3"> 
                                        </font> 
                                        <table width="96%" border="1">
                                          <tr bgcolor="#000000"> 
                                            <td height="10"><font color="#FFFFFF" face="Verdana"><font size="4">Greece 
                                              Visa to be serviced by IVS instead 
                                              of BLS….</font></font></td>
                                          </tr>
                                        </table>
                                        <font face="Verdana" size="4"><br>
                                        </font><font face="Verdana" size="2">IVS 
                                        will serve, as the authorized outsourcing 
                                        center for all visa applications required 
                                        for applying for a visa to Greece. All 
                                        visa applications have to be applied through 
                                        the Embassy authorized submission center 
                                        mentioned below:<br>
                                        <br>
                                        <b><font size="3">IVS Visa Application 
                                        Center For Greece:</font></b><br>
                                        <font color="#FF0000"><b>Capital Trust 
                                        House 47, <br>
                                        Community Center, <br>
                                        New Friends Colony, <br>
                                        New Delhi-110025 <br>
                                        Tel: 0091-11-46518112 <br>
                                        Fax:0091-11-46518115 <br>
                                        E-Mail: info@ivs-greecevisa.com <br>
                                        Website: www.ivs-greecevisa.com<br>
                                        <br>
                                        <font color="#333333">Apart from necessary 
                                        documents IVS would also require the following 
                                        :- </font></b></font><br>
                                        <br>
                                        <b>1.)</b> Visa Fee-<b>A D.D of Rs. 3, 
                                        486/-</b> in favor of <b>Embassy of Greece, 
                                        New Delhi.</b><br>
                                        <b>2.)</b> IVS Service Charge-<b>A D.D 
                                        of Rs. 600/-</b> in favor of <b>IVS Visa 
                                        Application Center.</b><br>
                                        <b>3.)</b> Courier Charge- <b>A D.D of 
                                        Rs. 170/-</b> in favor of <b>IVS Visa 
                                        Application Center</b> (per application)<br>
                                        <br>
                                        The <b>IVS working hours</b> are from 
                                        <b>Monday to Friday during 10:00 hours 
                                        to 14:00 hours </b>for submission and 
                                        the collection would come through the 
                                        courier to the respected Applicants.<br>
                                        <br>
                                        <b><font color="#FF0033">To download the 
                                        Visa Application form <a href="http://www.udaanindia.com/forms/Greece.pdf" target="_blank">click 
                                        here</a> <br>
                                        <br>
                                        <br>
                                        </font></b></font> 
                                        <table width="41%" border="1">
                                          <tr bgcolor="#000000"> 
                                            <td><font color="#FFFFFF" face="Verdana" size="3"><b>EMBASSY 
                                              OF AUSTRIA...</b></font></td>
                                          </tr>
                                        </table>
                                        <font face="Verdana" size="2"><b><font color="#FF0033"> 
                                        <br>
                                        </font></b><font color="#333333"><b><font color="#FF0033">1.)</font> 
                                        All Applicant will now have to submit 
                                        an authorization letter, authorizing <font color="#FF0033">Udaan 
                                        India Pvt. Ltd.</font> to submit & collect 
                                        documents</b></font><b><font color="#333333">.</font><font color="#FF0033"><br>
                                        <br>
                                        2.)</font></b><font color="#FF0033"><font color="#333333"> 
                                        Two recent passport sized colour photograph 
                                        with white back ground (with matt or semi 
                                        matt finish) <b>(35mm wide by 45mm high)</b> 
                                        without border and taken within the last 
                                        3 months; taken full face without headgear, 
                                        unless the applicant habitually wears 
                                        a headgear in accordance with his / her 
                                        religious or racial custom but the headgear 
                                        must not hide the applicant's feature. 
                                        The facial image must be between 25mm 
                                        to 35mm from chin to crown.</font></font><b><font color="#FF0033"><br>
                                        <br>
                                        3.) </font></b><font color="#333333">Orginal 
                                        <b>Medical Insurance</b> for the stay 
                                        duration is <b>Mandatory</b> </font><b><font color="#FF0033"><br>
                                        <br>
                                        </font></b></font>
                                        <table width="49%" border="1">
                                          <tr bgcolor="#000000"> 
                                            <td><font color="#FFFFFF" face="Verdana" size="3"><b>World 
                                              Cup Fever Continues…….</b></font></td>
                                          </tr>
                                        </table>
                                        <p><font face="Verdana" size="2">As you 
                                          are well aware the world cup started 
                                          on <b>11th March 2007 and is progressing 
                                          in a big way with quite a few upsets 
                                          Soon it will enter the Semi Final & 
                                          Final Stage.</b> This stage is going 
                                          to be very exciting & is worth watching 
                                          in location. <b><font color="#FF0033"><br>
                                          <br>
                                          </font></b><font color="#FF0033"><font color="#333333">The<b> 
                                          " Embassy of Trinidad & Tobago " -New 
                                          Delhi</b> is still issuing special visa 
                                          for the World Cup 2007. These would 
                                          be issued by the <b>Caribbean community 
                                          <font color="#FF0033">(CARICOM)</font></b> 
                                          and shall be valid upto 15th May 2007. 
                                          Any visitor traveling on this visa would 
                                          be able to move freely in the below 
                                          mentioned countries during his/her stay. 
                                          </font></font><b><font color="#FF0033"><font color="#333333"><br>
                                          <br>
                                          </font></font></b></font></p>
                                        <table width="50%" align="center" border="1">
                                          <tr bordercolor="#000000"> 
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Antigua 
                                              & Barbuda</font></b></font></td>
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Barbados</font></b></font></td>
                                          </tr>
                                          <tr bordercolor="#000000"> 
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Dominica</font></b></font></td>
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Grenada</font></b></font></td>
                                          </tr>
                                          <tr bordercolor="#000000"> 
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Guyana</font></b></font></td>
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Jamaica</font></b></font></td>
                                          </tr>
                                          <tr bordercolor="#000000"> 
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">St. 
                                              Kitts & Nevis</font></b></font></td>
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Saint 
                                              Lucia</font></b></font></td>
                                          </tr>
                                          <tr bordercolor="#000000"> 
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">St. 
                                              Vincent & The Grenadines </font></b></font></td>
                                            <td><font color="#6600FF" size="2"><b><font face="Verdana">Trinidad 
                                              & Tobago </font></b></font></td>
                                          </tr>
                                        </table>
                                        <p><font face="Verdana" size="2"><b><font color="#FF0033"><font color="#333333"> 
                                          </font></font>Apart from the Indian 
                                          travelers, Tourist traveling from <b>Bangladesh, 
                                          Pakistan and Srilanka</b> will have 
                                          to take the <b>CARICOM</b> special visa 
                                          from <b>&quot; Embassy of Trinidad & 
                                          Tobago &quot;-New Delhi</b>, India</b></font></p>
                                        <table width="84%" align="center" bordercolor="#00FFFF" bgcolor="#00FFFF">
                                          <tr bgcolor="#000000" bordercolor="#00FFFF"> 
                                            <td> 
                                              <div align="center"><font face="Monotype Corsiva" size="5" color="#00FFFF">Contact 
                                                us immediately to be a part of 
                                                this World cup fever</font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p><font face="Verdana" size="2"><b><font face="Verdana" size="3"><b><font size="2">1.) 
                                          To download the visa form <font color="#0000FF"><a href="http://www.udaanindia.com/Application%20Form.pdf" target="_blank">click 
                                          here</a></font></font></b><font size="2"><br>
                                          <br>
                                          <b>2.) To view the world cup schedule 
                                          <font color="#0000FF"><a href="http://www.udaanindia.com/Match%20Schedule.doc" target="_blank">click 
                                          here</a></font></b><br>
                                          <br>
                                          <b>3.) To know the visa fee and the 
                                          requirement <font color="#0000FF"><a href="http://www.udaanindia.com/Visa%20Requirements.doc" target="_blank">click 
                                          here</a></font></b> <br>
                                          <br>
                                          <b>4.) For more information logon to 
                                          <font color="#0000FF"><a href="http://www.caricomimpacs.org" target="_blank">www.caricomimpacs.org</a></font></b></font></font><font color="#FF0033"><br>
                                          </font></b></font><font face="Verdana" size="3"><font size="2"><br>
                                          </font></font> </p>
                                      </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="12"> 
                                            <div align="center">
                                              <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                                and support us, to serve you better&quot; 
                                                </font> </div>
                                              <div align="left"> 
                                                <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><a href="http://www.udaanindia.com" target="_blank"><font color="#FF0000"><font color="#FF0033" size="2" face="Verdana"><b><font color="#333333">For 
                                                  more Information plz. log on 
                                                  to http://www.udaanindia.com</font></b></font></font></a> 
                                                  </font></marquee></div>
                                              </div>
                                            </div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <b> </b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="645" height="6"></div>
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
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
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
          <td><!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
