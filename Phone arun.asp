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
                        <table width="536" align="center" height="345" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="2" colspan="2"> 
                              <table width="77%" border="1" height="242">
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF"> 
                                  <td width="62%" height="346" bordercolor="#000000"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Monotype Corsiva" size="7" color="#993366"><img src="updateimg/new%20visa-come-get-it.gif" width="468" height="76"> 
                                              </font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <p><b>= = = = = = = = = = = = = = = = 
                                          = = = = = = = = = = = = = = = = = = 
                                          = = <br>
                                          &nbsp;</b></p>
                                        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber3">
                                          <tr>
                                            <td width="100%">
                                            <p align="center">
                                            <font size="7" color="#808080">
                                            Welcome To Uddan INDIA</font></td>
                                          </tr>
                                        </table>
                                        <p align="center"><b><u>
                                            <font size="6" color="#0076AE">List 
                                            Of Important Phone Number</font></u></b></p>
                                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
                                          <tr>
                                            <td width="100%">
                                            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2">
                                              <tr>
                                                <td width="33%" align="center">
                                                <font color="#0076AE"><b>Name</b></font></td>
                                                <td width="26%" align="center">
                                                <font color="#0076AE"><b>Section</b></font></td>
                                                <td width="18%" align="center">
                                                <font color="#0076AE"><b>Phone 
                                                Number</b></font></td>
                                                <td width="159%" align="center">
                                                <font color="#0076AE"><b>
                                                Extension</b></font></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Rajan Dua</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Administration</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9810017356</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">101</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Manish Rajput</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Administration</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9810017355</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">222</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Harpreet 
                                                Singh</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Operation</font></b></td>
                                                <td width="18%" align="left">
                                                <font color="#0076AE"><strong>
                                                9818201852</strong></font></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">119</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font face="Arial" color="#0076AE">
                                                Mr.Harish Dua</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                H.R.</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9810335223</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">114</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Ms.Pooja Sarin</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Account Manager</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9810063345</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">109</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Ms.Shamila</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Communication</font></b></td>
                                                <td width="18%" align="left">&nbsp;</td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">124</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Rohit Gulati</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Communication</font></b></td>
                                                <td width="18%" align="left">&nbsp;</td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">112</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Ms Alpana Aswal</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Communication</font></b></td>
                                                <td width="18%" align="left">&nbsp;</td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">111</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Vipin Mishra</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Communication</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9818119166</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">105</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Ms Shalini Bali</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Communication</font></b></td>
                                                <td width="18%" align="left">&nbsp;</td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">115</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Deepak Khera</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Sales</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9818128817</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Ms. Priyanka 
                                                Kamboj</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Sales</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">987339939</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">113</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.H.K. Shah</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Account</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">09818424501</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Sanjay 
                                                Notiyal</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Account</font></b></td>
                                                <td width="18%" align="left">&nbsp;</td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Mr.Basu Dev 
                                                Bhatt</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">Dispatch</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9818720698</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                Mr.Uma Shankar Sharma</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                IT</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9811049020</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                Mr.Arun Saxena</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                IT</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9891497442</font></b></td>
                                                <td width="159%" align="left">
                                                <b><font color="#0076AE">116</font></b></td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font face="Arial" color="#0076AE">
                                                Spectranet</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                Inter Services</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">41610088</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                              <tr>
                                                <td width="33%" align="left"><b>
                                                <font face="Arial" color="#0076AE">
                                                Snowtec</font></b></td>
                                                <td width="26%" align="left"><b>
                                                <font color="#0076AE" face="Arial">
                                                Vendor (Hardware)</font></b></td>
                                                <td width="18%" align="left"><b>
                                                <font color="#0076AE">9212000284</font></b></td>
                                                <td width="159%" align="left">&nbsp;</td>
                                              </tr>
                                            </table>
                                            </td>
                                          </tr>
                                        </table>
                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <p>&nbsp;</p>
                                        <p><br>
                                          <font size="2" face="Verdana">***********************************************************************<br>
                                          </font></p>
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