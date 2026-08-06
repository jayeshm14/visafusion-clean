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
                <td width="21" height="304">&nbsp;</td>
                <td colspan="3" height="304"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="597" align="center" height="851" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="86" colspan="2"> 
                              <div align="center"> 
                                <table width="100%" border="1">
                                  <tr bordercolor="#333333"> 
                                    <td> 
                                      <div align="center"><img src="updateimg/indonesia%20heading%203.png" width="486" height="49"></div>
                                    </td>
                                  </tr>
                                  <tr bordercolor="#333333"> 
                                    <td> 
                                      <div align="center"><img src="updateimg/indonesia%20heading%202.png" width="228" height="42"></div>
                                    </td>
                                  </tr>
                                </table>
                              </div>
                              <div align="center"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="587" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="261" colspan="2"> 
                              <div align="center"> 
                                <table width="100%" border="1" height="66">
                                  <tr bordercolor="#000000"> 
                                    <td width="62%" valign="top"> 
                                      <div align="justify"><font face="Verdana" size="2"><b>This 
                                        is to apprise all that as per the latest 
                                        amendments in the Indonesian visa processing, 
                                        all visa applications, for all the categories(Business/ 
                                        Tourist/ Visit) should be supported with 
                                        the following documents:</b><br>
                                        <b>·</b> An Immigration message from the 
                                        Immigration authorities from Jakarta<br>
                                        <b>·</b> If the Immigration message is 
                                        not available; the application would be 
                                        referred to Jakarta for approval. This 
                                        entire procedure would take minimum 2 
                                        weeks time.<br>
                                        <b>·</b> The Embassy would not entertain 
                                        any urgent processing request without 
                                        the above-mentioned document. </font></div>
                                    </td>
                                    <td width="38%" bgcolor="#99FFFF"> 
                                      <div align="center"><img src="updateimg/indonesia%203.jpg" width="211" height="217"></div>
                                    </td>
                                  </tr>
                                </table>
                              </div>
                              <div align="left"> 
                                <table width="100%" border="0" height="65">
                                  <tr valign="bottom"> 
                                    <td width="36%" height="48"><img src="updateimg/malaysia.png" width="204" height="53" align="top"></td>
                                    <td width="64%" height="48"><img src="updateimg/malaysia%20heading%201.png" width="372" height="41" align="middle"></td>
                                  </tr>
                                </table>
                                <div align="center"><marquee behavior = "alternate"><font face="Verdana" size="2" color="#FF0033"><b>So 
                                  come and enjoy</b></font><b><font face="Verdana" size="2"> 
                                  <font color="#3333FF">'Malaysia Truly Asia'</font>
                                  <font color="#FF0033">through Udaan... </font></font></b></marquee></div>
                              </div>
                            </td>
                          </tr>
                          <tr valign="top" > 
                            <td height="8" colspan="2"> 
                              <table width="100%" border="1" height="464">
                                <tr bordercolor="#000000"> 
                                  <td width="38%" height="378"> 
                                    <table width="99%" border="1">
                                      <tr bordercolor="#333333" bgcolor="#66FFFF"> 
                                        <td> 
                                          <div align="center"><img src="updateimg/malaysia%201.jpg" width="200" height="200"></div>
                                        </td>
                                      </tr>
                                      <tr bordercolor="#333333" bgcolor="#99FFFF"> 
                                        <td> 
                                          <div align="center"><img src="updateimg/indonesia%204.jpg" width="200" height="200"></div>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                  <td width="62%" valign="top" height="378">
                                    <div align="justify">
                                      <p><font face="Verdana" size="2"><b>High 
                                        Commission For Malaysia goes online for 
                                        Visa processing.</b><br>
                                        <br>
                                        Hassle free procedures for Single Entry 
                                        through I-Visa for the first time for 
                                        Malaysian Visa...</font></p>
                                      <p><font face="Verdana" size="2"><b>Experience 
                                        it through Udaan...</b><br>
                                        <br>
                                        <b>I-Visa is applicable only for SINGLE 
                                        ENTRY VISA,</b> however for multiple entry 
                                        visa or long-term visa to Malaysia, the 
                                        applicant would have to follow the regular 
                                        procedure of submitting completely filled 
                                        and duly signed visa application form 
                                        along with all the required documents 
                                        to the embassy only. Kindly refer to <b>www.udaanindia.com</b> 
                                        for documentation requirements. <br>
                                        <b>Documentation for I-Visa: -<br>
                                        a)</b> Valid passport for 6 months <br>
                                        <b>b)</b> Covering letter from the applicant 
                                        stating the purpose, duration of stay 
                                        along with the <b>type of entry.</b><br>
                                        <b>c)</b> Photocopy of the return ticket 
                                        or airline booking printout <br>
                                        <b>d)</b> 2 Passport size colour photographs 
                                        with white background <br>
                                        <b>e)</b> <b>Demand Draft favouring " 
                                        Malaysian High Commission" - New Delhi 
                                        </b><br>
                                        <b>Fee - Single Entry - 650/-</b><br>
                                        <b>Time Taken: - 24 - 48 hrs </b></font></p>
                                    </div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF" bordercolor="#000000" > 
                            <td height="19" colspan="2"> 
                              <div align="left"><font size="5" color="#000099"><img src="updateimg/Singapore%20heading.png" width="239" height="53"></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#FFFFFF" >
                            <td height="149" colspan="2"> 
                              <table width="100%" border="1" height="134">
                                <tr bordercolor="#333333"> 
                                  <td width="62%" valign="top" height="123"> 
                                    <div align="justify"><font face="Verdana" size="2"><br>
                                      As per the notification from <b>The Singapore 
                                      High Commission,</b> hence forth all applicants 
                                      holding <b>Ahmedabad issued passports</b>, 
                                      flying from Ahmedabad will have to apply 
                                      for their visa for <b>Singapore </b>through 
                                      <b>New Delhi. </b><br>
                                      <br>
                                      <b>Processing Time - 3 working days</b></font></div>
                                  </td>
                                  <td width="38%" height="123" bgcolor="#99FFFF"> 
                                    <div align="center"><img src="updateimg/indonesia%202.jpg" width="212" height="164"></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update090605.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update280605.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
