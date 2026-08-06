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
                <td width="21" height="1278">&nbsp;</td>
                <td colspan="3" height="1278"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="433"> 
                        <table width="669" border="1" align="center" bordercolor="#0000FF" height="8" bgcolor="#F0F7FF">
                          <tr> 
                            <td height="1255"> 
                              <table width="663" align="center" height="8">
                                <tr> 
                                  <td height="67" colspan="2"><img src="updateimg/bird76.gif" width="84" height="91"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="6">Udaan's 
                                    consummate Services</font></b></td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="4">Udaan 
                                    is a one stop shop for all the visa related 
                                    issues, we have expertise in the following 
                                    fields: - </font></td>
                                </tr>
                                <tr> 
                                  <td height="1088" colspan="2"><img src="updateimg/bluearrow.gif" width="24" height="15"><font size="4">Visa 
                                    Consultation and Facilitation </font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="4" color="#3333FF">Attestation 
                                    and Authentication of documents</font> <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="4" color="#3333FF">POE 
                                    & ECNR Services </font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="4" color="#3333FF">Handle 
                                    queries relater to FRRO </font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="4">Travel 
                                    Insurance Services </font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"> 
                                    <font size="4">Hotel Reservations <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Car 
                                    Rentals <br>
                                    <br>
                                    Described below are the services most required 
                                    by the Missions:-<br>
                                    <img src="updateimg/bl_pin.gif" width="21" height="21"> 
                                    1. <font color="#0000FF">Attestation and Authentication 
                                    of documents</font><font size="3" color="#0000FF"> 
                                    <font color="#333333">from various ministries 
                                    and embassies for the following: </font></font><br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="3">Education 
                                    <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Marriage 
                                    <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Business 
                                    <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Other 
                                    Certificates </font><br>
                                    To enable the process we would require the 
                                    following from the applicant:<br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15"><font size="3">Originals 
                                    & the photocopy of the documents <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Covering 
                                    Letter <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">Passport 
                                    copy <br>
                                    <img src="updateimg/bluearrow.gif" width="24" height="15">2 
                                    coloured recent passport sized photographs 
                                    <br>
                                    <b>For any clarification & assistance please 
                                    call up the underline:</b></font><br>
                                    </font>
                                    <table width="100%">
                                      <tr>
                                        <td width="43%"><b>Ms. Pooja Sareen<br>
                                          Tel:- 55603654<br>
                                          E-Mail:- pooja@udaanindia.com</b><br>
                                        </td>
                                        <td valign="top" width="57%"><b>Mr. Vipin 
                                          Mishra<br>
                                          Tel:- 55603652<br>
                                          E-Mail:- accounts.udaan@spectranet.com</b></td>
                                      </tr>
                                    </table>
                                    <font size="4"><img src="updateimg/bl_pin.gif" width="21" height="21">2. 
                                    <font color="#3333FF">POE & ECNR Services 
                                    </font><br>
                                    We facilitate the temporary suspension or 
                                    the <font color="#6600FF">POE</font> services 
                                    along with <font color="#6600FF">ECNR</font> 
                                    services required for out bound travel and 
                                    Employment respectively <br>
                                    <font size="3">To enable the process we would 
                                    require the following documents form the applicant: 
                                    <br>
                                    <b><font color="#3333FF">POE</font></b> <br>
                                    </font><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font size="3">Original 
                                    Passport <br>
                                    </font><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font size="3">Covering 
                                    letter from the company stating the purpose 
                                    and duration of the stay <br>
                                    </font><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font size="3">Business 
                                    card and invitation letter (if traveling for 
                                    the business purpose) <br>
                                    </font><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font><font size="3">Original 
                                    confirmed ticket<br>
                                    </font><font size="4"><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font><font size="3">Foreign 
                                    exchange Endorsement </font><font size="3"><br>
                                    </font><font size="4"></font><b><font size="3" color="#3333FF">ECNR 
                                    </font><font size="3"><br>
                                    </font></b><b><font size="3">Please clarify 
                                    the required documents and charges with the 
                                    given below contact as the requirements fluctuate 
                                    from time to time.<br>
                                    </font></b></font> 
                                    <table width="100%">
                                      <tr>
                                        <td width="2%"><br>
                                        </td>
                                        <td valign="top" width="98%"><b>Mr. Vipin 
                                          Mishra<br>
                                          Tel: - 55603652<br>
                                          E-Mail:- accounts.udaan@spectranet.com</b></td>
                                      </tr>
                                    </table>
                                    <p><font size="4"><b><font size="4"><font size="4"><font size="4" color="#3333FF"><img src="updateimg/bl_pin.gif" width="21" height="21"></font></font></font><font size="3" color="#3333FF">Handle 
                                      queries related to FRRO </font><font size="3"><br>
                                      We can help assist any foreigner traveling 
                                      to India to extend/ change the category 
                                      of his/ her visa. To make a query please 
                                      contact the below mentioned with the following 
                                      from the applicant:<br>
                                      </font><font size="4"><b><font size="4"><font size="4"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font></b></font></b><font size="3">Covering 
                                      Letter stating the applicants requirement 
                                      from FRRO </font><b><font size="3"><br>
                                      <b><img src="updateimg/bluearrow.gif" width="24" height="15"></b></font></b><font size="3">Passport 
                                      copy with Indian visa endorsed</font></font></p>
                                    <p><b>We can intiate further assistance only 
                                      after looking into the above mentioned documents 
                                      and the service charges would also vary 
                                      on the kind of assistance.<font size="4"><font size="3"> 
                                      </font></font></b><font size="4"><b><font size="3"><br>
                                      <br>
                                      The applicant can scan and email/ fax/ courier 
                                      the documents as per his/ her convenience 
                                      to us, to initiate the process. <br>
                                      <br>
                                      For any clarification & assistance please 
                                      call up the underline:<br>
                                      Mr. Rajan Dua (MD)<br>
                                      Tel: - 55653707/ 9810017356<br>
                                      E-Mail:- rajan.udaan@spectranet.com</font></b></font></p>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update030205.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update290305.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
