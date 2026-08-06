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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="1416">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1221">&nbsp;</td>
                <td colspan="3" height="1221"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="602" border="0" height="331" align="center" bgcolor="#EAFFEA">
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>30th &amp; 31st December 2003 </font></i></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><img src="http://www.udaanindia.com/updateimg/canada.jpg" width="450" height="125"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font size="5"><i><font color="#660000" face="Arial, Helvetica, sans-serif" size="6"><u>CANADA</u></font></i></font><font face="Arial, Helvetica, sans-serif" color="#840084"><u></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="justify"> 
                                <p><font face="Arial"><b><font size="2">AS PER 
                                  RECENT NOTIFICATION FROM '</font><font face="Arial"><b><font size="2">CANADIAN 
                                  HIGH COMMISSION</font></b></font><font size="2">' 
                                  - NEW DELHI, W.E.F. 05th JAN. 2004, THE REVISED 
                                  VISA FEE WILL BE AS FOLLOWS.</font></b></font></p>
                              </div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="79"> 
                              <table width="100%" border="0" bgcolor="#FFFF99">
                                <tr valign="top"> 
                                  <td height="2" colspan="2" bgcolor="#FFCCFF"><font face="Arial" size="2"><b>TEMPORARY 
                                    RESIDENT VISAS (Visitors)</b></font></td>
                                </tr>
                                <tr bgcolor="#CCFFFF" valign="top"> 
                                  <td height="2" width="85%"><font face="Arial" size="2">SINGLE 
                                    ENTRY TO CANADA</font></td>
                                  <td height="2" width="15%"><font face="Arial" size="2">RS. 
                                    2,600/-</font></td>
                                </tr>
                                <tr bgcolor="#CCFFFF" valign="top"> 
                                  <td height="2" width="85%"><font face="Arial" size="2">MULTIPLE 
                                    ENTRY</font></td>
                                  <td height="2" width="15%"><font face="Arial" size="2">RS. 
                                    5,200/-</font></td>
                                </tr>
                                <tr bgcolor="#CCFFFF" valign="top"> 
                                  <td height="2" width="85%"><font face="Arial" size="2">FAMILY 
                                    RATE FOR EITHER SINGLE OR MULTIPLE ENTRY (ALL 
                                    FAMILY MEMBERS MUST APPLY AT THE SAME TIME 
                                    AND PLACE)</font></td>
                                  <td height="2" width="15%"><font face="Arial" size="2">RS.13,800/-</font></td>
                                </tr>
                                <tr valign="top"> 
                                  <td height="2" colspan="2" bgcolor="#FFCCFF"><font face="Arial" size="2"><b>WORK 
                                    PERMITS</b></font><font face="Arial" size="2"></font></td>
                                </tr>
                                <tr valign="top"> 
                                  <td height="2" width="85%" bgcolor="#CCFFFF"><font face="Arial" size="2">WORK 
                                    PERMITS</font></td>
                                  <td height="2" width="15%" bgcolor="#CCFFFF"><font face="Arial" size="2">RS. 
                                    5,200/-</font></td>
                                </tr>
                                <tr valign="top"> 
                                  <td height="2" width="85%" bgcolor="#CCFFFF"><font face="Arial" size="2">WORK 
                                    PERMITS - GROUP OF 3 OR MORE PERFORMING ARTISTS 
                                    (THIS FEE IS PER PERSON, BUT THE TOTAL AMOUNT 
                                    WILL NOT EXCEED $450 IN THE CASE OF A GROUP 
                                    OF THREE OR MORE PERFORMING ARTISTS AND THEIR 
                                    STAFF WHO APPLY AT THE SAME TIME AND PLACE.)</font></td>
                                  <td height="2" width="15%" bgcolor="#CCFFFF"><font face="Arial" size="2">RS.15,500/-</font></td>
                                </tr>
                                <tr valign="top"> 
                                  <td height="2" width="85%" bgcolor="#FFCCFF"><b><font face="Arial" size="2">STUDY 
                                    PERMITS</font></b></td>
                                  <td height="2" width="15%" bgcolor="#FFCCFF"><b><font face="Arial" size="2">RS. 
                                    4,300/-</font></b></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="JUSTIFY"><font face="Arial" size="2"><b><font color="#FF0033">FEES 
                                WILL BE ACCEPTED BY DEMAND DRAFT DRAWN IN FAVOUR 
                                OF ''CANADIAN HIGH COMMISSION'' PAYABLE AT NEW 
                                DELHI.</font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <hr noshade>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><font size="6"><i><font color="#660000"><u>NIGERIA</u></font></i></font></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="justify"><b><font face="Arial" size="2">WITH 
                                IMMEDIATE EFFECT THE 'HIGH COMMISSION OF THE FEDERAL 
                                REPUBLIC OF NIGERIA' - NEW DELHI NOW REQUIRES 
                                THE INVITATION LETTER <font color="#FF0033">IN 
                                ORIGINAL (FAX COPY OR PHOTO COPY WILL NOT BE ACCEPTED)</font> 
                                AND CERTIFICATE OF INCORPORATION OF NIGERIAN COMPANY 
                                SHOULD SPECIFICALLY MENTION THE RC NO. OF NIGERIAN 
                                COMPANY.<br>
                                &nbsp; </font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <hr noshade>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4"><span class="WSRightBold"><font color="#660000" size="6"><i>AUSTRALIA</i></font></span></font></u></font></b> 
                              </div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"><b><font size="2"><font face="Arial">AS 
                              PER RECENT NOTIFICATION FROM ''AUSTRALIAN HIGH COMMISSION 
                              ' - NEW DELHI, W.E.F. 1st JAN. 2004, THE REVISED 
                              VISA FEE WILL BE AS FOLLOWS.</font></font></b> </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <table border="1" width="100%" height="1" bgcolor="#FFFFFF" bordercolor="1">
                                <tr> 
                                  <td width="84%" height="1" bgcolor="#FFCCCC"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;VISITOR VISA SHORT STAY &lt; 3 MONTHS 
                                    (FORM 48R)</font></font></b></td>
                                  <td width="16%" height="1" bgcolor="#FFCCCC"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    2,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;VISITOR VISA LONG STAY &gt; 3 MONTHS 
                                    (FORM 48R)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    2,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><b><font color="#3333FF"> 
                                    &nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;VISITOR VISA SPONSORED FAMILY VISITOR 
                                    (FORM 48S)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.&nbsp;2,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;VISITOR VISA MEDICAL TREATMENT &gt; 
                                    3 MONTHS (FORM 48ME)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.&nbsp;1,400.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;STUDENT VISA APPLICATION</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.14,000.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;TBE VISA SHORT STAY - UP TO 3 MONTHS 
                                    (456)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    2,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;TBE VISA LONG VALIDITY - ETA</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.&nbsp;2,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;TBE VISA LONG STAY - 3 MONTHS TO 4 YEARS 
                                    (1066)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    5,800.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;APPLICATION FOR TEMPORARY RESIDENCE 
                                    (147)</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    5,800.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;APPLICATION FOR RESIDENT RETURN VISA</font></font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs. 
                                    4,200.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;MIGRATION APPLICATION</font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2" color="#3333FF"> 
                                    PACKAGE</font></b></td>
                                  <td width="16%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.&nbsp;&nbsp; 
                                    400.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="84%" height="1"><font color="#3333FF"><b>&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;APPLICATION FOR MIGRATION&nbsp;<br>
                                    </font></b><font face="Arial, Helvetica, sans-serif" size="2"> 
                                    (SPOUSE, PROSPECTIVE MARRIAGE, CHILD, PARENT, 
                                    REMAINING/AGED DEPENDENT RELATIVE, ENS, RSMS, 
                                    LABOUR AGREEMENT &amp; DISTINGUISHED TALENT)</font></font></td>
                                  <td width="16%" height="1" valign="top"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.42,300.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="84%" height="1"><font color="#3333FF"><b>&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                                    &nbsp;APPLICATION FOR MIGRATION&nbsp;<br>
                                    </font></b><font face="Arial, Helvetica, sans-serif" size="2"> 
                                    (SKILLED-INDEPENDENT &amp; SKILLED-AUSTRALIAN 
                                    SPONSORED)</font></font></td>
                                  <td width="16%" height="1" valign="top"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.62,700.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td height="1" valign="top" align="left" colspan="2"> 
                                    <div align="justify"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#FF0033">NOTE 
                                      : THE ONLY ACCEPTABLE METHOD OF PAYMENT 
                                      IS BY BANK DRAFT IN INDIAN RUPEES ONLY FAVOURING 
                                      'AUSTRALIAN HIGH&nbsp; COMMISSION, NEW DELHI.</font></b></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <hr noshade>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font size="4" face="Arial, Helvetica, sans-serif" color="#990099"><u><font color="#660000"><i><font size="6">SWITZERLAND</font></i></font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"><font face="Arial" size="2"><b>AS 
                              PER RECENT NOTIFICATION FROM 'EMBASSY OF SWITZERLAND 
                              ' NEW DELHI, <font size="2"><font face="Arial"> 
                              W.E.F. 1st JAN. 2004</font></font>, THE VISA FEE 
                              WILL BE <font color="#FF0033">NON REFUNDABLE</font> 
                              IRRESPECTIVE OF THE VISA BEING DECLINED / WITHDRAWN.<br>
                              <br>
                              VISA FEE WILL BE AS FOLLOWS.</b></font></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <table width="100%" border="1" bordercolor="1" height="110">
                                <tr> 
                                  <td width="49%" height="2" bgcolor="#FFCCCC"> 
                                    <div align="center"><font size="2" face="Arial"><b><font size="2" face="Arial">VISA 
                                      TYPE</font></b></font></div>
                                  </td>
                                  <td width="31%" height="2" bgcolor="#FFCCCC"> 
                                    <div align="center"><b><font size="2" face="Arial">VISA 
                                      FEE </font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="49%" height="2" bgcolor="#CCCCFF"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial>&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">VISA 
                                    FEE</font></font></span></b></td>
                                  <td width="31%" height="2" bgcolor="#CCCCFF"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    &nbsp;1900.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCCC"> 
                                  <td width="49%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial>&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;VISA 
                                    FEE </font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">(TWO 
                                    YEAR)</font></font></span></b></td>
                                  <td width="31%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    &nbsp;3800.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#CCCCFF"> 
                                  <td width="49%" height="2"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial>&nbsp;&nbsp;<b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">*&nbsp;VISA 
                                    FEE </font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">(THREE 
                                    YEAR)</font></font></span></b> </td>
                                  <td width="31%" height="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                                    5700.00</font></b></font></td>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update271203.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update130104.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
