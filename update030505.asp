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
                <td width="21" height="599">&nbsp;</td>
                <td colspan="3" height="599"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="433"> 
                        <table width="677" border="1" align="center" bordercolor="#0000FF" height="8" bgcolor="#F0F7FF">
                          <tr> 
                            <td height="1605"> 
                              <table width="678" align="center" height="8">
                                <tr> 
                                  <td height="66" colspan="2"> 
                                    <div align="justify"> 
                                      <table width="100%" height="8">
                                        <tr> 
                                          <td width="6%" height="41"><img src="updateimg/bird76.gif" width="39" height="56"></td>
                                          <td width="94%" height="41"> 
                                            <table width="100%">
                                              <tr> 
                                                <td height="32" width="43%"> 
                                                  <div align="center"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="44" height="24"></font></b></font></div>
                                                </td>
                                                <td height="32" width="57%"> 
                                                  <div align="center"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="44" height="24"></font></b></font></div>
                                                </td>
                                              </tr>
                                            </table>
                                            <p><font face="Verdana" size="3"><i><b><font color="#FF3300">Lets 
                                              join hands to &quot;sail smoothly&quot; 
                                              through the &quot;Heavy Leisure 
                                              Season&quot;</font></b></i></font></p>
                                          </td>
                                        </tr>
                                      </table>
                                      <font face="Verdana" size="2"><b><font size="3"><br>
                                      Dear Travel partners, </font></b><br>
                                      <br>
                                      The leisure season is in full swing and 
                                      we all look forward to a wonderful season. 
                                      You all would be happy to learn that the 
                                      outbound tourism has increased by 3 times 
                                      in this season; this has lead to an high 
                                      increase in the visa processing too, the 
                                      Embassies and Consulates are also occupied 
                                      with the visa issuing. To avoid any confusions 
                                      and problems in getting the visa, we request 
                                      you to kindly follow the given instructions 
                                      and help us to provide you an easy, hassle 
                                      free service. </font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="1363" colspan="2"><font size="4"><img src="updateimg/bl_pin.gif" width="21" height="21"></font><font face="Verdana" size="2"><b>Documentation</b></font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font face="Verdana" size="2">Kindly 
                                    attach enclosure letter mentioning clearly 
                                    all the documents that you are sending to 
                                    us with all the cases, this will act as a 
                                    checklist and avoid any kind of confusion. 
                                    <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Kindly 
                                    fill in all the application forms correctly 
                                    to avoid any delay in the submissions. All 
                                    form are available on our website <b>www.udaanindia.com</b>. 
                                    If you can not download it from our website, 
                                    please give us a call or send us a mail to 
                                    the following e-mail address</font>:<br>
                                    <font face="Verdana" size="2"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font face="Verdana" size="2" color="#6633FF"><b>rajan.udaan@spectranet.com<br>
                                    </b></font><font face="Verdana" size="2"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font face="Verdana" size="2" color="#6633FF"><b>neetanjali@udaanindia.com<br>
                                    </b></font><font face="Verdana" size="2"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font face="Verdana" size="2" color="#6633FF"><b>nandini@udaanindia.com 
                                    </b></font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font face="Verdana" size="2">Kindly 
                                    attach D/D wherever applicable.</font><br>
                                    <br>
                                    <b><font face="Verdana" size="2">The list 
                                    of the countries with their visa fee would 
                                    come to you in our next update i.e. on 30th 
                                    April 2005 </font></b><br>
                                    <font size="4"><img src="updateimg/bl_pin.gif" width="21" height="21"><font face="Verdana" size="2"><b>Embassy's 
                                    schedule for issuing visa<br>
                                    </b></font> </font><br>
                                    <font size="4"> <b><font size="2" face="Verdana">Due 
                                    to the Leisure Season, some of the embassies 
                                    would give the collection of the passports 
                                    as per the following schedule: </font></b><br>
                                    <font size="2" face="Verdana"><b><font color="#009933">(Kindly 
                                    book the air tickets of your clients accordingly)</font></b></font><br>
                                    </font> 
                                    <table width="100%">
                                      <tr> 
                                        <td width="33%"> 
                                          <div align="left"><font color="#FF0000" face="Verdana"><b>Country</b></font></div>
                                        </td>
                                        <td width="26%"> 
                                          <div align="left"><font color="#FF0000" face="Verdana"><b>Source</b></font></div>
                                        </td>
                                        <td width="41%"> 
                                          <div align="left"><font color="#FF0000" face="Verdana"><b>Time 
                                            Taken</b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="33%"><font face="Verdana" size="2"><b>Italy<br>
                                          <br>
                                          Spain<br>
                                          </b></font></td>
                                        <td width="26%"><font face="Verdana" size="2"><b>VFS<br>
                                          <br>
                                          Embassy<br>
                                          </b></font></td>
                                        <td width="41%"><font face="Verdana" size="2"><b>10 
                                          Working Days<br>
                                          <br>
                                          15 Working Days</b></font></td>
                                      </tr>
                                    </table>
                                    <font size="2" face="Verdana"><b>Special Note: 
                                    -</b> Spain embassy is accepting limited passports 
                                    from limited agents that too on the basis 
                                    of the token that we need to obtain early 
                                    in the morning. An agent can submit only 5 
                                    - 8 cases in a day<br>
                                    <br>
                                    </font> 
                                    <table width="100%">
                                      <tr> 
                                        <td width="33%" height="17"><b><font face="Verdana" size="2">Germany<br>
                                          <br>
                                          Denmark<br>
                                          </font></b></td>
                                        <td width="26%" height="17"><b><font face="Verdana" size="2">Embassy<br>
                                          <br>
                                          Embassy <br>
                                          </font></b></td>
                                        <td width="41%" height="17"><b><font face="Verdana" size="2">7 
                                          Working Days<br>
                                          <br>
                                          7 Working Days</font></b></td>
                                      </tr>
                                    </table>
                                    <div align="justify"><font size="4"><font size="2" face="Verdana"><b>Special 
                                      Note: -</b> Denmark embassy is accepting 
                                      limited passports from limited agents that 
                                      too on the basis of the token that we need 
                                      to obtain early in the morning. An agent 
                                      can submit only 5 - 8 cases in a day</font><br>
                                      <font size="3"><br>
                                      </font></font> </div>
                                    <table width="100%">
                                      <tr> 
                                        <td width="33%"><b><font face="Verdana" size="2">Norway</font></b></td>
                                        <td width="26%"><b><font face="Verdana" size="2">Embassy</font></b></td>
                                        <td width="41%"><b><font face="Verdana" size="2">7 
                                          Working Days</font></b></td>
                                      </tr>
                                    </table>
                                    <div align="justify"><font size="2" face="Verdana"><b>Special 
                                      Note:-</b> Norway embassy works only on 
                                      Mondays and Wednesdays. The embassy required 
                                      visa application form duly filled in. The 
                                      passenger will have to provide with all 
                                      the required documents to avoid any delays 
                                      in the submissions.</font><font size="4"> 
                                      <font face="Verdana" size="2">Kindly download 
                                      the visa application forms from out website 
                                      <b>www.udaanindia.com </b></font> <br>
                                      <br>
                                      </font> </div>
                                    <table width="100%">
                                      <tr> 
                                        <td width="33%"><b><font face="Verdana" size="2">France<br>
                                          <br>
                                          Austria<br>
                                          <br>
                                          Malaysia<br>
                                          <br>
                                          </font></b></td>
                                        <td width="22%"><b><font face="Verdana" size="2">Embassy<br>
                                          <br>
                                          Embassy<br>
                                          <br>
                                          High Commission<br>
                                          <br>
                                          </font></b></td>
                                        <td width="45%"><b><font face="Verdana" size="2">7 
                                          - 10 Working Days<br>
                                          <br>
                                          7 Working Days<br>
                                          <br>
                                          2 Working Days (Jurisdiction Passports)<br>
                                          3 Working Days (Out of Jurisdiction)</font></b></td>
                                      </tr>
                                    </table>
                                    <div align="justify"><font size="4"><font size="2" face="Verdana"><b>Special 
                                      Note:-</b> Malaysian embassy is issuing 
                                      the local passports (which come in our Jurisdiction) 
                                      in 2 working days. Passports, which are 
                                      not from our jurisdiction, can also be serviced 
                                      in Delhi, but the collection of the same 
                                      would be in 3 working days. Kindly note 
                                      that the collections are given late in the 
                                      evening so we request you to kindly advice 
                                      your passengers accordingly.<br>
                                      </font><b><font size="3"><br>
                                      </font></b></font> </div>
                                    <table width="100%">
                                      <tr> 
                                        <td width="33%"><b><font face="Verdana" size="2">Singapore<br>
                                          <br>
                                          </font></b></td>
                                        <td width="26%"><b><font face="Verdana" size="2">High 
                                          Commission<br>
                                          <br>
                                          </font></b></td>
                                        <td width="41%"><b><font face="Verdana" size="2">2 
                                          Working Days ( Delhi Passports)<br>
                                          3 Working Days (Out of Jurisdiction)</font></b></td>
                                      </tr>
                                    </table>
                                    <font size="4"><font size="2" face="Verdana"><b>Special 
                                    Note:-</b> We require one day to register 
                                    the case on line, so all the local passports 
                                    which are from Delhi would be collected in 
                                    2 working days. Cases coming to us in the 
                                    morning cannot be registered at the same time, 
                                    so all the outstation passports would be collected 
                                    in 3 working days.<br>
                                    <br>
                                    </font><font size="4"><img src="updateimg/bl_pin.gif" width="21" height="21"></font><font size="2" face="Verdana"><b>Courier 
                                    / Cargo</b></font><b><font size="3"><br>
                                    </font></b><font size="3"> <font size="2" face="Verdana">Kindly 
                                    note that due to heavy rush in the leisure 
                                    season and keeping in mind the security reasons, 
                                    we are collecting the Blue Dart load by four 
                                    wheelers, which reaches us only by 10:00am.<br>
                                    <br>
                                    We request you to use <b>Pigeon courier services</b> 
                                    (the southern region) or cargo services for 
                                    urgent delivery of documents to us.<br>
                                    <br>
                                    For any important submission you are requested 
                                    to contact the following executives from Udaan:<br>
                                    </font></font></font> 
                                    <table width="100%">
                                      <tr> 
                                        <td width="60%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">Ms. 
                                            Pooja Sarin</font></b></font></div>
                                        </td>
                                        <td width="40%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">55603654</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">Ms. 
                                            Nandini Som</font></b></font></div>
                                        </td>
                                        <td width="40%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">9313368934</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">Ms. 
                                            Neetanjali</font></b></font></div>
                                        </td>
                                        <td width="40%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">9871375711</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">Mr. 
                                            Anantham</font></b></font></div>
                                        </td>
                                        <td width="40%"> 
                                          <div align="left"><font size="2"><b><font face="Verdana">9818201852</font></b></font></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"><b><font size="2" face="Verdana">Ms. 
                                          Nirlap/ Ms. Monica</font></b></td>
                                        <td width="40%"><b><font size="2" face="Verdana">55603651</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"><b><font size="2" face="Verdana">Ms. 
                                          Saira (For Australia & New Zealand)</font></b></td>
                                        <td width="40%"><b><font size="2" face="Verdana">55603653</font></b></td>
                                      </tr>
                                    </table>
                                    <font size="4"><b><font size="2" face="Verdana"><br>
                                    For any urgent request you can also contact 
                                    the management at the following numbers:-</font><font size="3"><br>
                                    <br>
                                    </font></b></font> 
                                    <table width="100%">
                                      <tr> 
                                        <td width="60%"><b><font face="Verdana" size="3">Mr. 
                                          Rajan Dua ( M.D)</font></b></td>
                                        <td width="40%"><b><font face="Verdana" size="3">9810017356</font></b></td>
                                      </tr>
                                      <tr> 
                                        <td width="60%"><b><font face="Verdana" size="3">Mr. 
                                          Manish Rajput (Director)</font></b></td>
                                        <td width="40%"><b><font face="Verdana" size="3">9810017355</font></b></td>
                                      </tr>
                                    </table>
                                    <font size="4"><b><font size="3"><br>
                                    </font></b></font> 
                                    <p><font size="4"><b><font size="4"><font size="4"></font></font></b></font></p>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update290405.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update190505.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
