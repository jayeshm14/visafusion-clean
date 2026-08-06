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
                                <tr bordercolor="#000000" valign="top" bgcolor="#FFFFFF"> 
                                  <td width="62%" height="346" bordercolor="#000000"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Monotype Corsiva" size="7" color="#993366">Udaan 
                                              - Update</font></div>
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
                                        <table width="100%" border="1">
                                          <tr bgcolor="#993366"> 
                                            <td height="9"> 
                                              <div align="center"><font face="Monotype Corsiva" size="7" color="#FFFFFF">New 
                                                entrants in Schengen World</font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p><font face="Verdana" size="4"><br>
                                          </font><font face="Verdana" size="2"><font color="#333333" face="Courier New" size="3"><b>Dear 
                                          Travel Partners, <br>
                                          </b><br>
                                          This is just an udpate to apprise you 
                                          on the new developments taking place 
                                          for availing Schengen visa. Although 
                                          there is no circular from respective 
                                          embassies supporting this information 
                                          but we have come across this information 
                                          from various sources.</font></font></p>
                                        <p><font face="Verdana" size="2"><font color="#333333" face="Courier New" size="3"><b>Given 
                                          below is information from website <a href="http://www.schengenspace.com" target="_blank">www.schengenspace.com</a><br>
                                          </b><br>
                                          The European Union's ten new members 
                                          (namely - Estonia, Latvia, Lithuania, 
                                          Poland, Slovakia, Hungary, the Czech 
                                          Republic, Slovenia, Malta and Cyprus) 
                                          will join the borderless Schengen zone 
                                          in 2007, according to the Justice and 
                                          Interior ministers from the European 
                                          Union.<br>
                                          <br>
                                          These members must use Schengen standards 
                                          at customs and border points in order 
                                          to join the other fifteen members (namely 
                                          Austria ,Germany, Belgium, Denmark, 
                                          Finland, France, Greece, Iceland, Italy, 
                                          Luxemburg, Norway, Portugal, Spain, 
                                          Sweden, The Netherlands). Those who 
                                          meet the criteria will be able to integrate 
                                          into Schengen system in 2007. Land borders 
                                          are scheduled to be opened in December 
                                          31, 2007 and sea and air borders checks 
                                          will be lifted by latest March 2008. 
                                          In mid-2007 the European Commission 
                                          will evaluate if their borders are meeting 
                                          the required standards. <b><br>
                                          <br>
                                          </b>Until then, the European Commission 
                                          continues to work on the technical infrastructure 
                                          – Schengen Information System that stores 
                                          information about details and missing 
                                          and wanted persons and stolen cars as 
                                          well as arrest orders and visas throughout 
                                          Europe. </font></font> </p>
                                        <font face="Verdana" size="2"><font color="#333333" face="Courier New" size="3">Then, 
                                        a visitor to Schengen countries will be 
                                        able to visit these ten countries in addition 
                                        of the current members using the same 
                                        unique visa (if necessary). </font><font face="Courier New" size="3"><b><font color="#FF0033"><br>
                                        </font></b><br>
                                        In addition, Switzerland, which is surrounded 
                                        by EU countries but isn't a member, will 
                                        also join Schengen space next year.<br>
                                        <br>
                                        <b>For More Updates, click on <a href="http://www.mfa.gov.hu/kum/en/bal/" target="_blank">http://www.mfa.gov.hu/kum/en/bal/</a></b><a href="%3Cfont%20face=%22Verdana%22%20size=%222%22%3E%3Cfont%20face=%22Courier%20New%22%20size=%223%22%3E%3Cb%3Ehttp://www.mfa.gov.hu/kum/en/bal/%3C/b%3E%3Cbr%3E"><br>
                                        </a><br>
                                        This update is as of now. Granting of 
                                        visas will be at the descretion of respective 
                                        embassies.<br>
                                        <br>
                                        We will keep you updated incase of any 
                                        new developments.<br>
                                        <br>
                                        <b>Team Udaan.</b> </font><br>
                                        </font> <font face="Verdana" size="3"><font size="2"><br>
                                        *********************************************************************** 
                                        <br>
                                        </font><font size="2"><br>
                                        </font></font> </div>
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
