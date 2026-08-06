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
<table width="760" border="0" cellspacing="0" cellpadding="0" align="left">
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
            <table width="99%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" width="783" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="163">&nbsp;</td>
                <td colspan="3" height="163" width="783"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="99%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="435"> 
                        <table width="99%" height="639">
                          <tr> 
                            <td valign="top" align="left" colspan="4" height="2">
                              <div align="center"><b><font face="Times New Roman, Times, serif" size="6"><b>&nbsp;</b></font><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">1st 
                                August. 2002</font></i></b></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="left" colspan="4" height="2"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="left" colspan="4" height="2"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">ONLINE 
                                STATUS CHECK</font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="left" colspan="4" height="2"><b><font face="Arial, Helvetica, sans-serif"><b><font size="2"> 
                              <div align="justify">NOW YOU CAN CHECK YOUR VISA 
                                CASES&#146; STATUS AND DOCUMENTATION PROCEDURES FOR 
                                VARIOUS COUNTRIES &amp; CATEGORIES ONLINE AT WWW.UDAANINDIA.COM. 
                              </div>
                              </font></b></font></b></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="left" colspan="4" height="2"> 
                              <div align="justify"><font face="Arial" size="2">CONTACT 
                                US FOR YOUR USER I/D AND PASSWORD, IF THE SAME 
                                HAS NOT BEEN FORWARDED TO YOU UNTILL NOW.</font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="3" height="12" rowspan="4"> 
                              <div align="center"><img src="updateimg/uk6.gif" width="23" height="19">&nbsp;&nbsp;<font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">UNITED 
                                KINGDOM</span></u></font>&nbsp;&nbsp;<img src="updateimg/uk6.gif" width="23" height="19"></div>
                            </td>
                            <td valign="top" align="left" height="1" rowspan="23" width="277"> 
                              <div align="right"> <img src="updateimg/ukmake.jpg" width="250" height="250"> 
                              </div>
                            </td>
                          </tr>
                          <tr> </tr>
                          <tr> </tr>
                          <tr> </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" colspan="2"> 
                              <div align="justify"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial">AS 
                                PER RECENT NOTIFICATION FROM 'BRITISH HIGH COMMISSION' 
                                - NEW DELHI, WITH IMMEDIATE EFFECT THE REVISED 
                                VISA FEE WILL BE AS FOLLOWS.</font></span></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="3" height="2"> 
                              <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="updateimg/bl_pin.gif" width="21" height="21"> 
                                Visitor, Student, Passengers in transit, Returning 
                                Residents :</font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" width="261"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="updateimg/bluearrow.gif" width="24" height="15">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">STANDARD 
                              VISA :</font></font></span></b> </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              &nbsp;2900.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" width="261"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font></b></font></font></font></span><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                              ENTRY (1 YEAR)</font></font></span></b> </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              &nbsp;4800.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" width="261"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                              ENTRY (2 YEARS)</font></font></span></b> </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                              5600.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" width="261"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                              ENTRY (5 YEARS)</font></font></span></b> </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              &nbsp;7000.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" width="1" height="2">&nbsp;</td>
                            <td valign="top" align="left" height="2" width="261"><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face="Arial"><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                              ENTRY (10 YEARS)</font></font></span></b> </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                              12000.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="2" height="2"> 
                              <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                Settlement and Marriage :</b></font></div>
                            </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs.&nbsp; 
                              20800.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="2" height="2"> 
                              <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                Certificate of Entitlement :</b></font></div>
                            </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              &nbsp;&nbsp;8800.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="2" height="2"> 
                              <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                All other long term entry :</b></font></div>
                            </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              &nbsp;&nbsp;6000.00</font></b></font></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="right" colspan="2" height="2"> 
                              <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                Direct airside transit :</b></font></div>
                            </td>
                            <td valign="top" align="left" height="2" width="197"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              &nbsp;&nbsp;2150.00</font></b></font></td>
                          </tr>
                          <tr> </tr>
                          <tr> </tr>
                          <tbody> 
                          <tr> 
                            <td colspan="4" height="2"> 
                              <table width="99%" border="0" align="center" height="147">
                                <tr> 
                                  <td valign="top" align="left" colspan="6" height="2" bgcolor="#070692" width="738"><b><u><font face="Arial" color="#FFFFFF" size="4">HOLIDAYS 
                                    LIST FOR &nbsp;AUGUST 2002.</font></u></b></td>
                                </tr>
                                <tr> 
                                  <td valign="top" align="left" width="41" height="2" bgcolor="#FFCCCC"><u><b><font face="Courier" color="#800080" size="3">DATE</font></b></u></td>
                                  <td valign="top" align="left" width="291" height="2" bgcolor="#FFCCCC"><b><u><font face="Courier" color="#800080" size="3">COUNTRY</font></u></b></td>
                                  <td valign="top" align="left" width="42" height="2" bgcolor="#FFCCCC"><u><b><font face="Courier" color="#800080" size="3">DATE</font></b></u></td>
                                  <td valign="top" align="left" height="2" bgcolor="#FFCCCC" colspan="2" width="348"><b><u><font face="Courier" color="#800080" size="3">COUNTRY</font></u></b></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="COLOR: black">1<span style="mso-spacerun: yes"> &nbsp;</span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="291"><font face="Arial"><b><font size="2"><span style="COLOR: black">SWITZERLAND, BENIN</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="42"><font face="Arial"><b><font size="2"><span style="COLOR: black"><span style="color: black"> 17 </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" colspan="2" width="348"><font face="Arial"><b><font size="2">INDONESIA</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="COLOR: black">5&nbsp;<span style="mso-spacerun: yes"> </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="291"><font face="Arial"><b><font size="2"><span style="COLOR: black">BURKINA FASO</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="42"><font face="Arial"><b><font size="2"><span style="COLOR: black">19<span style="color: black"> </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" colspan="2" width="348"><font face="Arial"><b><font size="2">AFGHANISTAN, 
                                    ARGENTINA</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="color: black">6</span><span style="COLOR: black"><span style="mso-spacerun: yes">&nbsp; </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="291"><font face="Arial"><b><font size="2"><span style="COLOR: black">BOLIVIA, JAMAICA</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="42"><font face="Arial"><b><font size="2"><span style="COLOR: black">20<span style="color: black"> </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" colspan="2" width="348"><font face="Arial"><b><font size="2"><span style="COLOR: black">HUNGARY</span></font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="COLOR: black">7<span style="color: black">&nbsp;</span><span style="mso-spacerun: yes"> </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="4" width="291"><font face="Arial"><b><font size="2"><span style="COLOR: black">IRELAND</span></font></b></font></td>
                                  <td valign="top" align="left" height="4" width="42"><font face="Arial"><b><font size="2">24 
                                    :</font></b></font></td>
                                  <td valign="top" align="left" height="4" colspan="2" width="348"><font face="Arial"><b><font size="2">UKRAINE</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="COLOR: black"><span style="color: black"> 9 </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="4" width="291"><font face="Arial"><b><font size="2"><span style="COLOR: black">SINGAPORE</span></font></b></font></td>
                                  <td valign="top" align="left" height="4" width="42"><font face="Arial"><b><font size="2">25 
                                    :</font></b></font></td>
                                  <td valign="top" align="left" height="4" colspan="2" width="348"><font face="Arial"><b><font size="2">URUGUAY</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2"><span style="COLOR: black"><span style="color: black"> 12 </span>:</span></font></b></font></td>
                                  <td valign="top" align="left" height="2" width="291"><font face="Arial"><b><font size="2">THAILAND&nbsp;</font></b></font></td>
                                  <td valign="top" align="left" height="2" width="42"><font face="Arial"><b><font size="2">30 
                                    :</font></b></font></td>
                                  <td valign="top" align="left" height="2" colspan="2" width="348"><font face="Arial"><b><font size="2">ETHIOPIA, 
                                    BHUTAN, TAIWAN, JAPAN, U.S.A., KOREA - REP. 
                                    OF (S/KOREA), THAILAND., M.E.A.-ATTEST., ARGENTINA</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign="top" align="left" width="41" height="2"><font face="Arial"><b><font size="2">15 
                                    :</font></b></font></td>
                                  <td valign="top" align="left" height="2" width="291"><font face="Arial"><b><font size="2">ALL 
                                    OPERATIONS ARE CLOSED</font></b></font></td>
                                  <td valign="top" align="left" height="2" width="42"><font face="Arial"><b><font size="2">31 
                                    :</font></b></font></td>
                                  <td valign="top" align="left" height="2" colspan="2" width="348"><font face="Arial"><b><font size="2">KYRGYZSTAN, 
                                    MALAYSIA, TRINIDAD &amp; TOBAGO</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> </tr>
                                <tr bgcolor="#FEF7ED"> </tr>
                              </table>
                            </td>
                          </tr>
                          </tbody> 
                        </table>
                      </td>
                    </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2" width="69"><b><font face="Arial, Helvetica, sans-serif"><a href="update290702.asp"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="712" height="2"> 
                  <div align="right"><a href="update100802.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2" width="783"> 
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
          <td> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
