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
            <table width="96%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="551">&nbsp;</td>
                <td colspan="3" height="551"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="96%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="100%" border="0">
                          <tr> 
                            <td colspan="4">
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>2nd December 2002 </font></i></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">THAILAND 
                                </font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="4"> 
                              <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">AS 
                                PER RECENT NOTIFICATION FROM THE ROYAL THAI EMBASSY 
                                –NEW DELHI ,WITH IMMEDIATE EFFECT THE VISA FEES 
                                FOR THAILAND WILL BE <font color="#FF0000">ACCEPTED 
                                IN THE FORM OF DEMAND DRAFT</font> DRAWN IN FAVOUR 
                                OF "ROYAL THAI EMBASSY" - NEW DELHI. KINDLY NOTE 
                                THE FEE FOR THE VARIOUS CATEGORIES IS AS FOLLOWS:- 
                                .</font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4">&nbsp;</td>
                          </tr>
                          <tr bgcolor="#CCCCFF"> 
                            <td colspan="2" height="20"><b><font size="2" face="Arial">SINGLE 
                              ENTRY </font></b></td>
                            <td colspan="2" width="66%" height="20"><b><font size="2" face="Arial">RS. 
                              400.00 </font></b></td>
                          </tr>
                          <tr bgcolor="#FFCCFF"> 
                            <td colspan="2" height="18"><b><font size="2" face="Arial">DOUBLE 
                              ENTRY </font></b></td>
                            <td colspan="2" width="66%" height="18"><b><font size="2" face="Arial">RS. 
                              600.00 </font></b></td>
                          </tr>
                          <tr bgcolor="#CCCCFF"> 
                            <td colspan="2" height="17"><b><font size="2" face="Arial">TRIPLE 
                              ENTRY</font></b></td>
                            <td colspan="2" width="66%" height="17"><b><font size="2" face="Arial">RS. 
                              900.00 </font></b></td>
                          </tr>
                          <tr bgcolor="#FFCCFF"> 
                            <td colspan="2" height="18"><b><font size="2" face="Arial">NON-IMMIGRANT 
                              </font></b></td>
                            <td colspan="2" width="66%" height="18"><b><font size="2" face="Arial">RS. 
                              650.00</font></b></td>
                          </tr>
                          <tr bgcolor="#CCCCFF"> 
                            <td colspan="4" height="18"><b><font size="2" face="Arial">ALSO 
                              THE COST FOR THE VISA FORM IS RS. 10/- AND IS PAYABLE 
                              BY CASH. </font></b></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="18"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="18"> 
                              <div align="center"><font size="4" face="Arial"><b><font color="#990099"><u>SOUTH 
                                AFRICA</u></font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"><font size="2" face="Arial"><b>AS 
                              PER RECENT NOTIFICATION FROM 'SOUTH AFRICA HIGH 
                              COMMISSION ' NEW DELHI, WITH IMMEDIATE EFFECT THE 
                              APPLICATION FORM HAS BEEN CHANGED. <br>
                              <br>
                              PLEASE DOWNLOAD NEW FORMS BY CLICK ON BELOW LINKS, 
                              YOU CAN SAVE IN YOUR COMPUTER AND OPEN IT IN CURRENT 
                              LOCATION. THE FILES ARE IN .PDF FORMAT (OPEN WITH 
                              ACROBAT READER), IT WILL TAKE SOME TIME TO DOWNLOAD. 
                              PLEASE VISIT WWW.UDAANINDIA.COM FOR MORE UPDATES. 
                              <br>
                              <br>
                              </b></font> 
                              <table width="99%" border="0">
                                <tr> 
                                  <td width="30%" height="2"><font size="2" face="Arial"><b><img src="http://www.ttsvisas.com/images/wwwgdl.gif"> 
                                    <a href="http://www.udaanindia.com/updateimg/safrica1.pdf" target="_blank">FORM 
                                    (SIDE 1) </a></b></font></td>
                                  <td width="30%" height="2"><img src="http://www.ttsvisas.com/images/wwwgdl.gif"> 
                                    <b><font size="2" face="Arial"><a href="http://www.udaanindia.com/updateimg/safrica2.pdf" target="_blank">FORM 
                                    (SIDE 2)</a></font></b></td>
                                  <td width="26%" height="2"><font face="Arial" size="2"><b><font size="1">FOR 
                                    DOWNLOAD ACROBAT READER </font></b></font></td>
                                  <td width="14%" height="2"><a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank"><img src="http://images.google.com/images?q=tbn:EhR6JEY24CoC:www.websense.com/images/getacro.gif" border="0"></a></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="18"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="2"> 
                              <div align="center"><font size="4" face="Arial"><b><font color="#990099"><u>JORDAN</u></font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="18"><font size="2" face="Arial"><b>AS 
                              PER RECENT NOTIFICATION FROM ' EMBASSY OF THE HASHEMITE 
                              KINGDOM OF JORDON ' NEW DELHI, WITH IMMEDIATE EFFECT 
                              THE ALL APPLICATIONS WILL BE REFERRED TO JORDAN 
                              FOR APPROVAL, AND TIME TAKEN WILL BE 3 - 4 WORKING 
                              DAYS. </b></font></td>
                          </tr>
                          <tr> 
                            <td colspan="4" height="130"> 
                              <table width="100%" border="0" align="center" height="147">
                                <tr> 
                                  <td valign=top align=left colspan="6" height=2 bgcolor="#070692"><b><u><font color="#FFFFFF">HOLIDAY 
                                    LIST FOR DECEMBER 2002</font></u></b></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left width="6%" height=2 bgcolor="#FFCCCC"><u><b><font 
                        face=Courier color=#800080 size=3>DATE</font></b></u></td>
                                  <td valign=top align=left width="48%" height=2 bgcolor="#FFCCCC"><b><u><font face=Courier 
                        color=#800080 size=3>COUNTRY</font></u></b></td>
                                  <td valign=top align=left width="5%" height=2 bgcolor="#FFCCCC"><u><b><font 
                        face=Courier color=#800080 size=3>DATE</font></b></u></td>
                                  <td valign=top align=left height=2 bgcolor="#FFCCCC" colspan="2" width="41%"><b><u><font face=Courier 
                        color=#800080 size=3>COUNTRY</font></u></b></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=11><font face="Arial" size="1">1.</font></td>
                                  <td valign=top align=left height=11 width="48%"><font face="Arial" size="1">ICELAND, 
                                    ROMANIA</font></td>
                                  <td valign=top align=left height=11 width="5%"><font face="Arial" size="1">11.</font></td>
                                  <td valign=top align=left height=11 colspan="2" width="41%"><font face="Arial" size="1">BHUTAN, 
                                    BURKINA FASO</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">2.</font></td>
                                  <td valign=top align=left height=2 width="48%"><font face="Arial" size="1">U.A.E., 
                                    SAUDI ARABIA, LAOS</font></td>
                                  <td valign=top align=left height=2 width="5%"><font face="Arial" size="1">12.</font></td>
                                  <td valign=top align=left height=2 colspan="2" width="41%"><font face="Arial" size="1">KENYA</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">3.</font></td>
                                  <td valign=top align=left height=2 width="48%"><font face="Arial" size="1">U.A.E., 
                                    SAUDI ARABIA, BANGLADESH, KUWAIT</font></td>
                                  <td valign=top align=left height=2 width="5%"><font face="Arial" size="1">17.</font></td>
                                  <td valign=top align=left height=2 colspan="2" width="41%"><font face="Arial" size="1">BHUTAN</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">4.</font></td>
                                  <td valign=top align=left height=4 width="48%"><font face="Arial" size="1">U.A.E., 
                                    SAUDI ARABIA, KUWAIT</font></td>
                                  <td valign=top align=left height=4 width="5%"><font face="Arial" size="1">18.</font></td>
                                  <td valign=top align=left height=4 colspan="2" width="41%"><font face="Arial" size="1">NIGER</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=4 rowspan="2"><font face="Arial" size="1">5.</font></td>
                                  <td valign=top align=left height=8 width="48%" rowspan="2"><font face="Arial" size="1">INDONESIA, 
                                    JORDAN, EGYPT, THAILAND., KUWAIT, U.A.E., 
                                    SAUDI ARABIA, AFGHANISTAN</font></td>
                                  <td valign=top align=left height=4 width="5%"><font face="Arial" size="1">23.</font></td>
                                  <td valign=top align=left height=8 colspan="2" width="41%"><font face="Arial" size="1">JAPAN</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left height=4 width="5%"><font face="Arial" size="1">24.</font></td>
                                  <td valign=top align=left height=8 colspan="2" width="41%"><font face="Arial" size="1">FINLAND</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=26 rowspan="2"><font face="Arial" size="1">6.</font></td>
                                  <td valign=top align=left height=26 width="48%" rowspan="2"><font face="Arial" size="1">INDIA, 
                                    ETHIOPIA, TAIWAN, JAPAN, U.A.E., SAUDI ARABIA, 
                                    AFGHANISTAN, IRAQ, QATAR, PALESTINE, FINLAND, 
                                    U.S.A., MALAYSIA, KOREA - REP. OF (S/KOREA), 
                                    UNITED KINGDOM, THAILAND., SPAIN, M.E.A.-ATTEST., 
                                    KUWAIT, INDONESIA, BANGLADESH, JORDAN, IRAN, 
                                    KYRGYZSTAN, EGYPT, SINGAPOORE</font></td>
                                  <td valign=top align=left height=83 rowspan="2"><font face="Arial" size="1">25.</font></td>
                                  <td valign=top align=left height=96 colspan="2" rowspan="2"><font face="Arial" size="1">FINLAND, 
                                    PANAMA, ETHIOPIA, BHUTAN, TAIWAN, JAPAN, THAILAND., 
                                    SPAIN, AUSTRIA, U.S.A., MALAYSIA, KOREA - 
                                    REP. OF (S/KOREA), NEWZEALAND, INDIA, M.E.A.-ATTEST., 
                                    KUWAIT, ARGENTINA, UNITED KINGDOM</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">7.</font></td>
                                  <td valign=top align=left height=2 width="48%"><font face="Arial" size="1">INDONESIA, 
                                    KUWAIT, MALAYSIA, U.A.E., SAUDI ARABIA</font></td>
                                  <td valign=top align=left height=2 width="5%"><font face="Arial" size="1">26.</font></td>
                                  <td valign=top align=left height=2 colspan="2" width="41%"><font face="Arial" size="1">AUSTRALIA, 
                                    NEWZEALAND, AUSTRIA, UNITED KINGDOM, FINLAND 
                                    </font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">8.</font></td>
                                  <td valign=top align=left height=2 width="48%"><font face="Arial" size="1">U.A.E., 
                                    SAUDI ARABIA, PANAMA, KUWAIT, ARGENTINA, INDONESIA</font></td>
                                  <td valign=top align=left height=4 width="5%"><font face="Arial" size="1">27.</font></td>
                                  <td valign=top align=left height=4 colspan="2" width="41%"><font face="Arial" size="1">NEWZEALAND, 
                                    AUSTRALIA, UNITED KINGDOM</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=12 rowspan="2"><font face="Arial" size="1">9.</font></td>
                                  <td valign=top align=left height=12 width="48%" rowspan="2"><font face="Arial" size="1">INDONESIA, 
                                    JORDAN, U.A.E., SAUDI ARABIA, KUWAIT</font></td>
                                  <td valign=top align=left height=6 width="5%"><font face="Arial" size="1">29.</font></td>
                                  <td valign=top align=left height=12 colspan="2" width="41%"><font face="Arial" size="1">NEPAL</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left height=6 width="5%"><font face="Arial" size="1">30.</font></td>
                                  <td valign=top align=left height=12 colspan="2" width="41%"><font face="Arial" size="1">NEWZEALAND, 
                                    JAPAN</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left width="6%" height=2><font face="Arial" size="1">10.</font></td>
                                  <td valign=top align=left height=2 width="48%"><font face="Arial" size="1">THAILAND., 
                                    KUWAIT, INDONESIA</font></td>
                                  <td valign=top align=left height=2 width="5%"><font face="Arial" size="1">31.</font></td>
                                  <td valign=top align=left height=2 colspan="2" width="41%"><font face="Arial" size="1">NEWZEALAND, 
                                    THAILAND., JAPAN</font></td>
                                </tr>
                                <tr bgcolor="#FEF7ED"> 
                                  <td valign=top align=left colspan="5" height=2><font face="Arial" size="1"></font><font face="Arial" size="1"></font><font face="Arial" size="1"></font><font face="Arial" size="1"></font></td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update251102.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="600"> 
                  <div align="right">&nbsp;<a href="update041202.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
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
          <td> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
