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
    <td height="581"> 
      <table width="99%" border="0" cellspacing="0" cellpadding="0" height="638">
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
          <td height="334"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="722">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1432">&nbsp;</td>
                <td colspan="3" height="1432"> 
                  <table width='656' border='1' align='center' bordercolor='#0000FF' height="1413" bgcolor="#33FFFF">
                    <tr> 
                      <td height='1404'> <img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='633' height='1'> 
                        <table align='center' height='8' width='98%' bgcolor="#99FFFF">
                          <tr bgcolor="#6699FF"> 
                            <td height='44' colspan='2'> 
                              <div align="center"><font size="6"><b><font face="Arial Black" color="#000080" size="6"><i><font color="#00FFFF">UPDATE</font></i></font><font color="#00FFFF"><i><font face="Arial" size="6"> 
                                </font><font face="Arial" size="4">19th July, 
                                2004</font></i></font></b></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="center"><font color="#FFFFFF" face="Arial"><b><font size="4">INDONESIA 
                                </font> </b> </font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="justify"><font color="#FFFFFF" face="Arial">The 
                                "Indonesian High commission"-New Delhi,has notified 
                                that the processing time for visa would be 4 to 
                                6 working days in certain cases due to delay in 
                                receiving approval from the department of immigration 
                                - Indonesia. </font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="center"><font color="#FFFFFF" face="Arial" size="4"><b>IRELAND</b></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="justify"><font color="#FFFFFF" face="Arial">Original 
                                fax invitation from Ireland is mandatory for all 
                                cases (Scanned copies are strictly not acceptable) 
                                </font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="center"><font color="#FFFFFF" face="Arial" size="4"><b>MOROCCO</b></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="justify"><font color="#FFFFFF" face="Arial">Chamber 
                                of commerce recommendation letter is mandatory 
                                for Business visa. Original personal bank statements 
                                are mandatory for Tourist visa. </font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='44' colspan='2'> 
                              <div align="center"><font size="5" face="Garamond"><b><font color="#FFCC99">**AUSTRALIA**</font></b></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height='325' colspan='2'> 
                              <div align='center'> 
                                <table width="644" border="0" cellpadding="0">
                                  <tr> 
                                    <td width="140" height="269"> 
                                      <div align="center"><img src="updateimg/aus1.jpg" width="123" height="223" align="top"></div>
                                    </td>
                                    <td height="269" width="12">&nbsp;</td>
                                    <td height="269" width="330" bgcolor="#333333"> 
                                      <div align="justify"><font face="Garamond"><b><font size="4" color="#FFCC99">As 
                                        per notification from the 'Australian 
                                        High Commission'-New Delhi- W.E.F. 01 
                                        July 2004 the revised visa fee for Australia-- 
                                        Tourist(48R) & Business(456) applications 
                                        is Rs. 2200 /-. Demand draft to be drawn 
                                        in favour of 'Australian High Commission' 
                                        payable at New Delhi. 'Australian High 
                                        Commission'-New Delhi with effect from 
                                        5th july 2004 will accept business visa 
                                        applications only with the revised FORM 
                                        456 (design date 07/04). <br>
                                        <br>
                                        </font> </b> </font></div>
                                    </td>
                                    <td width="134" height="269"> 
                                      <div align="right"><img src="updateimg/aus2.jpg" width="123" height="223"></div>
                                    </td>
                                    <td height="269" width="15">&nbsp;</td>
                                  </tr>
                                </table>
                                <div align="left"> 
                                  <table width="647" border="0" cellpadding="0" height="40">
                                    <tr bordercolor="#99FFFF"> 
                                      <td width="289" bordercolor="#66FFFF"><font face="Arial"><b><font size="2" color="#FF3366">TO 
                                        DOWNLOAD THESE FORMS PLEASE CLICK ON LINKS. 
                                        </font></b></font></td>
                                      <td height="2" colspan="3" bgcolor="#333333"><b><font size="2" face="Arial"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="29" height="31"><a href="http://www.udaanindia.com/forms/48R-Tourist.pdf" target="_blank"><font color="#FF9966">TOURIST 
                                        (48 R)</font></a></font></b><font color="#FF9966"><b><font size="2" face="Arial"> 
                                        / <a href="http://www.udaanindia.com/forms/456-small stay business.pdf" target="_blank"><font color="#FF9933">BUSINESS 
                                        (456)</font></a><font color="#FF9933">&nbsp;/ 
                                        <a href="http://www.udaanindia.com/updateimg/australia.m-67form.gif" target="_blank"><font color="#FF9966">DETAILS 
                                        OF RELATIVES (M67)</font></a></font></font></b></font></td>
                                      <td width="12">&nbsp;</td>
                                    </tr>
                                  </table>
                                  <b></b></div>
                              </div>
                            </td>
                          </tr>
                          <tr bgcolor="#333333"> 
                            <td height="76"><marquee direction="LEFT"><img src="updateimg/uma-kang.gif" width="108" height="79"></marquee></td>
                          </tr>
                          <tr bgcolor="#FFCC99"> 
                            <td height='28' colspan='2'> 
                              <div align="center"><font size="5" face="Garamond"><b>**NIGERIA**</b></font></div>
                            </td>
                          </tr>
                          <tr bgcolor="#66FFFF"> 
                            <td height='157' colspan='2'> 
                              <table width="638" border="0" cellpadding="0">
                                <tr> 
                                  <td width="407" bgcolor="#CCFFFF" height="152">
                                    <div align="justify"><b><font face="Garamond" size="3">WITH 
                                      IMMEDIATE EFFECT THE &quot;HIGH COMMISSION 
                                      OF THE FEDERAL REPUBLIC OF NIGERIA&quot; 
                                      - NEW DELHI, REQUIRES FOR ALL BUSINESS VISA 
                                      APPLICATIONS, THE R.C. NUMBER OF THE NIGERIAN 
                                      COMPANY SPECIFICALLY MENTIONED IN THE CERTIFICATE 
                                      OF INCORPORATION AND ATTESTED BY THE MINISTRY 
                                      OF FOREIGN AFFAIRS - NIGERIA. </font> </b></div>
                                  </td>
                                  <td width="222" height="152"> 
                                    <div align="right"><img src="updateimg/nigeria1.jpg" width="222" height="151"></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr bgcolor="#FFCC99"> 
                            <td height='32' colspan='2'> 
                              <div align="center"><font size="5"><b><font face="Garamond">**MYANMAR**</font></b></font> 
                              </div>
                            </td>
                          </tr>
                          <tr bgcolor="#66FFFF"> 
                            <td height='147' colspan='2'> 
                              <table width="643" border="0" cellpadding="0" height="142">
                                <tr> 
                                  <td width="230" height="143"><img src="updateimg/myanmar.jpg" width="231" height="151"></td>
                                  <td width="402" height="143" bgcolor="#CCFFFF"> 
                                    <div align="justify"><b><font size="3">AS PER 
                                      RECENT NOTIFICATION FROM THE "EMBASSY OF 
                                      MYANMAR" - NEW DELHI, THE EMBASSY NOW REQUIRES 
                                      APPLICANT'S PERSONAL TELEPHONE NUMBERS AND 
                                      PROOF OF OCCUPATION WITH DESIGNATION. </font></b></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr bgcolor="#99FF99"> 
                            <td height='245' colspan='2'> 
                              <p align="center"><img src="updateimg/MAURTIUS1.jpg"178" height="153" border="0" width="174"><img src="updateimg/MAURTIUS2.jpg" width="250" height="200"><img src="updateimg/MAURTIUS3.jpg" width="173" height="145"><br>
                              </p>
                              <p align="center"><font size="5"><b>**MAURITIUS**</b></font> 
                              </p>
                            </td>
                          </tr>
                          <tr bgcolor="#99FF99" > 
                            <td height='86' colspan='2'> 
                              <p align="justify"><font face="Garamond"><b>AS PER 
                                NOTIFICATION FROM THE &quot;EMBASSY OF MAURITIUS&quot; 
                                - NEW DELHI WITH IMMEDIATE EFFECT, THE EMBASSY 
                                REQUIRES FOREX ENDORSEMENT WITH ORIGINAL FOREX 
                                RECEIPTS OR COLOURED PHOTOCOPY OF INTERNATIONAL 
                                CREDIT CARD WITH STATEMENTS.<br>
                                </b></font></p>
                            </td>
                          </tr>
                          <tr bgcolor="#66FFFF" > 
                            <td height='2' colspan='2'> 
                              <div align="center"><b><font face="Arial" size="4"><u><font color="#003333">FRANCE 
                                </font></u> </font></b></div>
                            </td>
                          </tr>
                          <tr bgcolor="#FFFF99" > 
                            <td height='88' colspan='2'> 
                              <div align="justify"><b><font face="Arial" size="2">AS 
                                PER RECENT NOTIFICATION FROM THE "EMBASSY OF FRANCE" 
                                - NEW DELHI, WITH EFFECT FROM 01 JUNE 2004, ALL 
                                CATEGORY VISA APPLICATIONS SHOULD BE ACCOMPANIED 
                                BY THE OVERSEAS MEDICAL INSURANCE INCLUDING THE 
                                FOLLOWING CLAUSE: <br>
                                <br>
                                MEDICAL EXPENSES, EVACUATION AND REPATRIATION 
                                -THE COST OF THESE EXPENSES SHOULD BE A MINIMUM 
                                OF EURO 30,000. (KINDLY NOTE - NEW OVERSEAS MEDICAL 
                                POLICY OF "BAJAJ ALLIANZ GENERAL INSURANCE COMPANY 
                                LTD." HAS THIS CLAUSE WITH THE REQUIRED AMOUNT) 
                                </font></b></div>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update270504.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3" height="2"> 
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
                <td width="21" height="2">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td height="2"><!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>

