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
h1
	{margin-bottom:.0001pt;
	text-align:center;
	page-break-after:avoid;
	font-size:12.0pt;
	font-family:"Times New Roman";
	text-decoration:underline;
	text-underline:single; margin-left:0in; margin-right:0in; margin-top:0in}
.style32 {
	font-size: 16pt;
	font-weight: bold;
}
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
                                      <div align="justify" style="width: 645; height: 372"> 
                                        <p><b>= = = = = = = = = = = = = = = = 
                                          = = = = = = = = = = = = = = = = = = 
                                          = = </b><br>
                                        </p>
                                        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="185">
                                          <tr>
                                            <td width="100%" height="185">
                                            <p><em><b>
                                              <font size="4" face="Courier New" color="#000080">
                                                <br>
                                                </font></b></em></p>
                                                <P align=justify class='style2'><strong>Dear Friend,</strong></P>
                                                <P align=justify class='style2'><strong>We would like to introduce ourselves as       'Udaan-India's Leading Visa Facilitation Firm' </strong></P>
                                                <P align=justify class='style2'><strong>Established in 1992,&nbsp;we have come a long way since       ,and we are today one of the Pioneer's in VISA FACILITATION in India and       across the Globe. Recognized by all leading agents, corporates &amp;       embassies /missions in New Delhi, Udaan has truly scaled many heights in       last eighteen years.Our VISA Services are developed and designed to meet       the various requirements of the Travel Agents and Corporate Clients in       India &amp; Abroad. Our professionalism, co-ordination and operations       pertaining to work speaks for itself. At Udaan, we are a team of dedicated       professionals, each contributing to their optimum expertise to deliver and      ensure complete satisfaction of our clients. </strong></P>      <P align=justify class='style2'><strong>In 2000 we achieved another first, by creating our       website (<A href='http://www.udaanindia.com/'       target=_blank>http://www.udaanindia.com/</A>), exclusively for our clients       that has all relevant information related to visa processing and information&nbsp;pertaining to embassies. The website is       fully equipped with visa information of more than 230 countries across the       globe. We keep our agents updated with Visa &amp; Embassy information by sending them emails regularly in the form of UPDATES</strong></P>      
<P align=justify class='style2'><strong>Our motto of liberating clients from all hassles       associated with visa generation has won us their unfailing confidence and       respect. Thinking ahead we now have a network of branches &amp; associates       throughout the country, and have privileged tie-ups with high       commissions/embassies as an outsourcing agency. Today we are proud to       announce that we have been outsourced by The honorable <A       href='http://udaanindia.com/updatenew030909.html' target=_blank>Embassy of       Azerbaijan</A> to handle there visa department and is our first step into       a new era of such tie ups. Udaan has also been recognized by various missions across India as preferred partner for VISA facilitation services ie EMBASSY OF THE REPUBLIC OF BRAZIL,HIGH COMMISSION OF MALAYSIA,EMBASSY OF ITALY, EMBASSY OF REPUBLIC OF ALGERIA, EMBASSY OF MEXICO, HIGH COMMISSION FOR THE ISLAMIC REPUBLIC OF PAKISTAN etc .Please <A       href='http://udaanindia.com/updatenew030909.html' target=_blank>click       here</A> for more details </strong></P>      <P align=justify class='style2'><strong>We also Expertise in <A       href='http://udaanindia.com/update090909.html' target=_blank>LEGALIZATION       &amp; ATTESTATION</A> of documents.&nbsp;Whether it is Educational       documents or Marriage Certificates we can get them attested at an       affordable prices. For&nbsp;more&nbsp;information please <A       href='http://udaanindia.com/update090909.html' target=_blank>click       here</A>.</strong></P>      <P align=justify class='style2'><strong>Udaan has also ventured into FRRO services by providing expats of corporates with VISA EXTENSION (work/dependent). We provide this assistance irrespective of there jurisdiction. For more information please click here.</strong></P>      <P align=justify class='style2'><strong>Besides&nbsp;VISAS we have also diversified into Hospitality       Sector by launching our <A       href='http://udaanindia.com/serviceApp071109.html' target=_blank>SERVICE       APARTMENTS</A> in New Delhi &amp; NCR . Through these apartments we cater       to a niche&nbsp;segment of society by providing&nbsp;WORLD CLASS       ACCOMMODATION at an unbelievable and affordable price. To view the       pictures of the our apartments please <A       href='http://udaanindia.com/serviceApp071109.html'       target=_blank>click&nbsp;here</A>&nbsp;</strong></P>      <P align=justify class='style2'><strong>From VISAS to HOSPITALITY SECTOR to LEGALIZATION&nbsp;,       today we are a prominent organisation in travel trade with impeccable business ethics       and a sustained commitment to service </strong></P>      <P align=justify class='style2'><strong>It would be our privilege to get associated with your         esteemed organisation and will be honor to service you. Please get in touch with us         at the numbers given below or fill in the&nbsp;registration&nbsp;form and         we will get in touch with you. Click here for <A       href='mailto:deepak@udaanindia.com?subject=Registration request&body=Please provide your Name and contact information and send it.&cc=rajan@udaanindia.com' target=_blank>Registration request</A>.</strong></P>
<P align=justify class='style2'><strong><br>        
  Mr Rajan Dua - Managing Director <BR>        
  <U>Email </U>-&nbsp; <A       href='mailto:rajan@udaanindia.com' target=_blank>rajan@udaanindia.com</A>         <BR>
  Mob -&nbsp;&nbsp;&nbsp;&nbsp; 91-9810017356 </strong></P>      <P align=justify class='style2'><strong>Mr Nirupam Kathuriya (Head-Operations)<BR>        
      <U>Email</U> -&nbsp; <A       href='mailto:nirupam@udaanindia.com'       target=_blank>nirupam@udaanindia.com</A> <BR>
      Mob -&nbsp;&nbsp;&nbsp;       91-9871667666/9910063345</strong></P>      <P align=justify class='style2'><strong>Mr Harpreet Singh&nbsp; (Manager-Operations)<BR>          
          <U>Emaill</U>- <A       href='mailto:harpreet@udaanindia.com'       target=_blank>harpreet@udaanindia.com</A> <BR>
          Mob-&nbsp;&nbsp;&nbsp;       91-9818201852</strong></P>      <P align=justify class='style2'><strong>Mr Deepak Khera (Manager-Business Dev)<BR>        
              <U>Email</U>-&nbsp; <A       href='mailto:deepak@udaanindia.com'       target=_blank>deepak@udaanindia.com</A> <BR>
              Mob-&nbsp;&nbsp;&nbsp;       91-9818128817</strong></P>      <P align=justify class='style2'>&nbsp;</P>      
                                            <p><span class="style32">Regards<br>
       Udaan India</span></td>
                                          </tr>
                                        </table>
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