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
                <td width="21" height="641">&nbsp;</td>
                <td colspan="3" height="641"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="289" border="1" align="center" bordercolor="#0000FF" height="524">
                          <tr> 
                            <td height="685"> 
                              <table align="center" height="416" width="66%">
                                <tr> 
                                  <td height="16" colspan="2"> 
                                    <div align="center"><font face="Verdana" size="5"><img src="updateimg/flag.gif" width="68" height="50">Latest 
                                      for Malaysian Visa... </font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="500" height="2"></td>
                                </tr>
                                <tr> 
                                  <td height="4" colspan="2"> 
                                    <div align="center"><img src="http://www.udaanindia.com/updateimg/malaysia.jpg" width="252" height="251"></div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="280" colspan="2"> 
                                    <div align="justify"><font face="Arial" size="3"><font size="2" face="Verdana"><b>With 
                                      the out-bound tourism season round the corner, 
                                      the Malaysian High Commission at New Delhi 
                                      has new good news to offer to all travelers 
                                      to the country. From henceforth, all categories 
                                      of Malaysian visa will be processed within 
                                      next working day. The documents required 
                                      for the purpose are as follows: </b></font><b><font size="2" face="Verdana"><br>
                                      </font></b><font size="2" face="Verdana"><br>
                                      <b>-</b> Valid Passport <b><br>
                                      -</b> Visa Application form duly filled 
                                      in and signed <br>
                                      &nbsp;&nbsp;(photocopy or downloaded forms 
                                      from <a href="http://www.udaanindia.com"><b>www.udaanindia.com</b></a> 
                                      can also be used) <br>
                                      - 2 Recent passport size colour photographs 
                                      <br>
                                      - Covering Letter stating applicant's name, 
                                      designation, purpose and duration of stay. 
                                      <br>
                                      - For business visas, invitation letter 
                                      from the counterpart in Malaysia. <br>
                                      - Foreign Exchange duly endorsed. <br>
                                      - Confirmed return air-ticket. <br>
                                      - Tour itinerary or hotel confirmation (not 
                                      mandatory) <br>
                                      <br>
                                      <b>Health Requirement: Nil </b><br>
                                      <br>
                                      <b>Fee: Rs.650 /- for single entry <br>
                                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rs.1, 
                                      300/- for multiple entries <br>
                                      </b><br>
                                      All fee payable by demand drafts drawn in 
                                      favour of "<b>Malaysian High Commission</b>" 
                                      - <b>New Delhi. </b><br>
                                      <br>
                                      <b><font color="#FF3300">So come and enjoy 
                                      <font color="#0000FF">'<u>Malaysia truly 
                                      Asia</u>'</font> through Udaan… </font></b><br>
                                      <br>
                                      <b>FOR FURTHER INFORMATION, KINDLY VISIT 
                                      US AT <font color="#3333FF"><a href="http://www.udaanindia.com">www.udaanindia.com</a></font> 
                                      <br>
                                      <br>
                                      </b></font></font> 
                                      <table width="100%">
                                        <tr bordercolor="#CCCCCC" bgcolor="#CCCCCC"> 
                                          <td height="29"> 
                                            <div align="center"><font face="Verdana" size="4"><b>CANADA 
                                              APPLICATIONS THROUGH 'VFS'…</b></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"><font face="Arial" size="3"><font size="2" face="Verdana"><b>With 
                                        effect from March 7th 2005, all visa applications 
                                        for Canada has to be submitted and collected 
                                        through 'Visa Facilitation Services' (VFS). 
                                        </b><br>
                                        <br>
                                        The visa fee will be as follows: <br>
                                        <b>Rs.2, 600 /- for single entry </b><br>
                                        <b>Rs.5, 200 /- for multiple entries </b><br>
                                        All fee payable by demand draft drawn 
                                        in favour of <b>"Canadian High Commission" 
                                        - New Delhi.</b><br>
                                        <br>
                                        <b>VFS Service charge of Rs.496 /- payable 
                                        by cash</b><br>
                                        <br>
                                        The submission timings at the VFS center 
                                        are from 08:00 - 12:00 am in the morning 
                                        and 13:00 - 16:00 pm in the afternoon.<br>
                                        <br>
                                        For further information on check lists 
                                        for visa application and also the application 
                                        forms, log on to our website <font color="#9900FF"><b><font color="#3333FF"><a href="http://www.udaanindia.com">www.udaanindia.com</a> 
                                        </font> </b> </font> </font></font> </div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update110305.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right">&nbsp;</div>
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
