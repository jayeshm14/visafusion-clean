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
                        <table width="527" align="center" height="396" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="209" colspan="2"> 
                              <div align="left"> 
                                <table width="100%" border="1">
                                  <tr> 
                                    <td width="27%" height="201"><img src="updateimg/thailand2.jpg" width="142" height="161"></td>
                                    <td width="46%" height="201"><img src="updateimg/thailand10.jpg" width="248" height="238"></td>
                                    <td width="27%" height="201"><img src="updateimg/thailand%20beaches.jpg" width="142" height="161"></td>
                                  </tr>
                                </table>
                                
                              </div>
                              <div align="center"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="8" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="555" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="59" colspan="2"> 
                              <div align="center"><img src="updateimg/thai%20heading.png" width="526" height="54"> 
                              </div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="8" colspan="2"> 
                              <table width="100%" border="0" height="74" align="center">
                                <tr> 
                                  <td colspan="3" height="30"> 
                                    <div align="justify"><font size="5" color="#000099"><font face="Verdana" size="2">From 
                                      June 9, 2005, all the applications for Thailand 
                                      Visa would be submitted at their VFS Thailand 
                                      Visa Application Centre in New Delhi. Indian 
                                      residents who wish to apply for Transit 
                                      Visas, Tourist Visas or Non-Immigrant Visas 
                                      can now submit their applications at the 
                                      new application centre. <br>
                                      <br>
                                      <b><font size="3">Requirements:</font></b><br>
                                      <br>
                                      Documentation: (Refer <font color="#0000FF"><a href="http://www.udaanindia.com">www.udaanindia.com</a></font> 
                                      or follow the link)<br>
                                      <br>
                                      1) <a href="http://www.udaanindia.com/forms/Tourist%20Visa.doc">Tourist 
                                      Visa </a><br>
                                      2) <a href="http://www.udaanindia.com/forms/Transit%20Visa.doc">Transit 
                                      Visa</a><br>
                                      3) <a href="http://www.udaanindia.com/forms/Non-Immigrant%20Visa.doc">Non 
                                      Immigrant Visa</a><br>
                                      <br>
                                      <b><font size="3">Photographs:</font></b><br>
                                      a) 2-passport size colour photograph (2" 
                                      x 2') taken against a white or light blue 
                                      background so that your features are clearly 
                                      distinguishable. (Please provide identical 
                                      copies of recent photograph, taken within 
                                      the last 6 months)<br>
                                      b) Applicant's full face should be visible. 
                                      The photograph should be taken without sunglasses 
                                      and without a hat or any other head covering, 
                                      unless you wear such an item because of 
                                      your religious beliefs or ethnic background.<br>
                                      c) The photographs should be clear and of 
                                      good quality, and should be printed on normal 
                                      photographic paper. Please note that we 
                                      will be unable to accept photographs that 
                                      do not meet these specifications.<br>
                                      <br>
                                      <font size="3"><b>Visa Fees & Validity </b></font></font></font></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr bgcolor="#CCCCFF" > 
                            <td height="19" colspan="2"> 
                              <div align="center"><font size="5" color="#000099"><u><font size="4" face="Verdana">In 
                                addition to the Visa Fee, each applicant also 
                                needs to pay VFS service charge of Rs. 390/- in 
                                cash. </font></u></font></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="152" colspan="2"> 
                              <table width="100%" border="1">
                                <tr bgcolor="#CCCCFF" bordercolor="#666666"> 
                                  <td> 
                                    <div align="center"><font color="#000099"><b><font face="Verdana" size="2">Visa 
                                      Category</font></b></font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font color="#000099"><b><font face="Verdana" size="2">Fee</font></b></font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font color="#000099"><b><font face="Verdana" size="2">Validity 
                                      of Visa</font></b></font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font color="#000099"><b><font face="Verdana" size="2">Validity 
                                      of Stay</font></b></font></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#666666"> 
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Transit 
                                      Visa</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">INR 
                                      1000</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">3 
                                      Months</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Permitted 
                                      to stay for a period not exceeding 30 Days</font></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#666666"> 
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Tourist 
                                      Visa</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">INR 
                                      1250</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">3 
                                      Months</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Permitted 
                                      to stay for a period not exceeding 60 Days</font></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#666666"> 
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Non-Immigrant 
                                      Visa(Single Entry)</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">INR 
                                      2500</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">3 
                                      Months</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Permitted 
                                      to stay for a period not exceeding 90 Days 
                                      unless otherwise instructed by the Immigration 
                                      Bureau.</font></div>
                                  </td>
                                </tr>
                                <tr bordercolor="#666666"> 
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Non-Immigrant 
                                      Visa (Multiple Entry)</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">INR 
                                      6250</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">1 
                                      Year</font></div>
                                  </td>
                                  <td> 
                                    <div align="center"><font face="Verdana" size="2" color="#000099">Permitted 
                                      to stay for a period not exceeding 90 Days 
                                      unless otherwise instructed by the Immigration 
                                      Bureau </font></div>
                                  </td>
                                </tr>
                              </table>
                              <font face="Verdana" size="2"><b><font size="3"><br>
                              <font color="#000099">Please Note: </font></font></b><font color="#000099"><br>
                              <b>· </b>All visa fees listed above are per applicant. 
                              <br>
                              <b>· </b>Visa fees must be paid in the form of a 
                              Bank Draft drawn in the name of 'The Royal Thai 
                              Embassy', payable at New Delhi. <br>
                              <b>· </b>In addition to the Visa Fee, each applicant 
                              also needs to pay a service charge of Rs. 390/- 
                              in cash. <br>
                              <b>·</b> All fees and charges are not refundable, 
                              even if the application is refused or withdrawn. 
                              <br>
                              <b>· </b>All Visa Fees are subject to change without 
                              notice. </font></font></td>
                          </tr>
                          <tr bgcolor="#CCCCFF" > 
                            <td height="2" colspan="2"> 
                              <div align="center"><font face="Verdana" size="3"><b><font size="4" color="#000099">Processing 
                                Time</font></b></font></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="2"> 
                              <div align="left"><font face="Verdana" size="2" color="#000099">The 
                                processing time required for Transit Visas, Tourist 
                                Visas and Non-Immigration Visas is as follows: 
                                </font></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="111" colspan="2"> 
                              <table width="100%" border="1">
                                <tr bgcolor="#CCCCFF" bordercolor="#666666"> 
                                  <td width="67%"><font color="#000099"><b><font face="Verdana" size="2">Visa 
                                    Application Submitted On:</font></b></font></td>
                                  <td width="33%"><font color="#000099"><b><font face="Verdana" size="2">Visa 
                                    Collection On:</font></b></font></td>
                                </tr>
                              </table>
                              <table width="100%" border="1">
                                <tr bordercolor="#333333"> 
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Monday 
                                    - Thursday</font></td>
                                  <td width="34%"><font face="Verdana" size="2" color="#000099">8 
                                    am - 11 am</font></td>
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Day 
                                    2 Afternoon</font></td>
                                </tr>
                                <tr bordercolor="#333333"> 
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Monday 
                                    - Thursday</font></td>
                                  <td width="34%"><font face="Verdana" size="2" color="#000099">12 
                                    pm - 4 pm</font></td>
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Day 
                                    3 Afternoon</font></td>
                                </tr>
                                <tr bordercolor="#333333"> 
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Friday</font></td>
                                  <td width="34%"><font face="Verdana" size="2" color="#000099">8 
                                    am - 11 am</font></td>
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Monday 
                                    Afternoon</font></td>
                                </tr>
                                <tr bordercolor="#333333"> 
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Friday</font></td>
                                  <td width="34%"><font face="Verdana" size="2" color="#000099">12 
                                    pm - 4 pm</font></td>
                                  <td width="33%"><font face="Verdana" size="2" color="#000099">Tuesday 
                                    Afternoon</font></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="2"><font face="Verdana" size="2"><b><font color="#000099">The 
                              timings for Passport Collection are Monday to Friday, 
                              12 pm to 4 pm.</font></b><br>
                              <br>
                              <font color="#000099">Please note that while the 
                              time frames indicated above will apply in most cases, 
                              some applications may take longer to process than 
                              others. </font></font> </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="2"> 
                              <div align="justify"><font face="Verdana"><b><font size="2" color="#000099">Health 
                                Requirements:<br>
                                <br>
                                </font></b><font size="2" color="#000099">The 
                                Ministry of Public Health has laid down regulations 
                                that applicants who have travelled from or through 
                                countries that have been declared Yellow Fever 
                                Infected Areas, must provide an International 
                                Health Certificate stating that they have received 
                                a Yellow Fever vaccination.</font><b><font size="2" color="#000099"> 
                                </font></b></font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update080605.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update270605.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
