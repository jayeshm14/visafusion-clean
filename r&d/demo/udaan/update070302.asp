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
<table width="765" border="0" cellspacing="0" cellpadding="0" align="left">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
            <table width="98%" border="0" cellspacing="0" cellpadding="0" height="1206">
              <tr> 
                <td width="2%">&nbsp; </td>
                <td colspan="3"> 
                  <div align="center"><font face="Times New Roman, Times, serif" 
            size=6><b>&nbsp;&nbsp;&nbsp;&nbsp;</b></font><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>7th March 2002 </font></i></b> </div>
                </td>
              </tr>
              <tr> 
                <td width="2%" height="950">&nbsp;</td>
                <td colspan="3" height="950"> 
                  <table height=1214 width="100%">
                    <tr> 
                      <td valign=top align=left colspan="5" height=2> 
                        <div align="left"><b></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left colspan="5" height=2> 
                        <hr>
                      </td>
                    </tr>
                    <tbody> 
                    <tr> 
                      <td valign=top align=right width="5%" height=69> <font face="Arial, Helvetica, sans-serif" size="1" color="#0000FF">New</font>&nbsp;</td>
                      <td valign=top align=left height=69 colspan="4"> 
                        <p align="left"><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial><font color="#800080" size="4"><u>MALAYSIA 
                          </u></font><font color="#800080"><br>
                          <br>
                          </font>WITH IMMEDIATE EFFECT THE VISA FEES FOR MALAYSIA 
                          HAS BEEN REVISED AS <font color="#3333CC">RS. 650/- 
                          FOR SINGLE ENTRY &amp; RS. 1,300/- FOR MULTIPLE ENTRY.</font><font color="#3366CC"> 
                          </font>THE FEES HAS TO BE PAID BY DEMAND DRAFT DRAWN 
                          IN FAVOUR OF &quot;MALAYSIAN HIGH COMMISSION&quot; - 
                          NEW DELHI.</font></span></font></b></p>
                        <p><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face="Arial" color="#990099"><b><font size="4">U.A.E</font> 
                          </b> </font></span></font></p>
                        <p><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial>KINDLY 
                          NOTE THAT THE U.A.E EMBASSY HAS TEMPORARILY SUSPENDED 
                          THE TRAVEL AGENTS TO PROCESS THE DOCUMENTS FOR U.A.E 
                          AUTHENTICATION, THE APPLICANT WILL HAVE TO COME IN PERSON 
                          FOR THE SAME. HOWEVER, THE BUSINESS DOCUMENTS' AUTHENTICATION 
                          CAN BE FACILITATED THROUGH THE TRAVEL AGENTS. <br>
                          </font></span></font></b></p>
                        <p><font face="Arial" size="4" color="#990099"><b>FOR 
                          THE IMMEDIATE REFERENCE WE BRING TO YOU THE VISA FEES 
                          STRUCTURE PAYABLE BY DEMAND DRAFT : </b></font></p>
                      </td>
                    </tr>
                    <tr> 
                      <td valign=top align=right width="5%" height=20>&nbsp;</td>
                      <td valign=top align=left height=20 colspan="4"><font size="2" face="Arial"><b><font color="#990099">AUSTRALIA</font></b> 
                        FEE DRAFT FAVOURING <b>'AUSTRALIAN HIGH COMMISSION'</b> 
                        - NEW DELHI. <b><br>
                        BUSINESS (SUBCLASS 456) VISITOR (SHORT STAY)</b>:RS.1600/- 
                        D/D CHGS.: RS.75/- <br>
                        <b>TEMPORARY BUSINESS CLASS 1066 (MORE THAN 3 MONTHS)</b> 
                        : RS.4100/- D/D CHGS. : RS.75/- <br>
                        <b>STUDENT VISA APPLICATION SUBCLASS 157 W</b> : RS.7900/- 
                        D/D CHGS. : RS.100/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">NEWZEALAND</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        FEE DRAFT FAVOURING <b>'NEWZEALAND IMMIGRATION SERVICE'</b> 
                        - NEW DELHI<br>
                        <b>VISIT</b> : RS.2000/- D/D CHGS. RS.75/- <b>(BUSINESS/TOURIST) 
                        </b><br>
                        <b>WORK</b> : RS.4550/- D/D CHGS. RS.75/- <br>
                        <b>STUDENT /-TRANSIT</b> : RS.3150/- D/D CHGS. RS.75/- 
                        </font> </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">TAIWAN</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        FEE DRAFT FAVOURING <b>'TAIPEI ECONOMIC AND CULTURAL CENTER'</b> 
                        - NEW DElHI <br>
                        <b> VISITOR</b> : RS.1700/- D/D CHAGS. RS.75/- <b>(TOURIST 
                        / BUSINESS)</b> <br>
                        <b> MULTIPLE ENTRY</b> : RS.3400/- DRAFT CHAGS. RS.75/- 
                        <b>(TOURIST / BUSINESS)</b> <br>
                        <b> URGENT FEE (SINGLE ENTRY)</b>: RS.850/- D/D CHGS.: 
                        RS.75/- AND <b>MULTIPLE ENTRY</b> RS.1700/- D/D CHGS. 
                        RS.75/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">UGANDA</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        FEE DRAFT FAVOURING <b>'UGANDA HIGH COMMISSION'</b> - 
                        NEW DELHI <br>
                        <b>VISITOR (SINGLE ENTRY)</b> - RS.2500/- D/D CHGS RS.75/- 
                        <br>
                        <b> MULTIPLE ENTRY</b> - RS.5000/- D/D CHGS RS.150/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"> 
                        <p><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">CANADA</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                          FEE DRAFT FAVOURING <b>'CANADIAN HIGH COMMISSION'</b> 
                          - NEW DELHI <br>
                          <b> SINGLE ENTRY</b> - RS.2250/- D/D CHGS RS.75/-<br>
                          <b> MULTIPLE ENTRY</b> - RS.4500/- D/D CHGS RS.75/- 
                          <br>
                          <b> EMPLOYMENT AUTORISATION</b> - RS.4500/- D/D CHGS 
                          RS.75/- <br>
                          <b> STUDENT AUTHORISATION</b> - RS.3750/- D/D CHGS : 
                          RS.75/- </font></p>
                      </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">BRAZIL</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        FEE DRAFT FAVOURING <b>'EMBASSY OF BRAZIL'</b> - NEW DELHI 
                        <br>
                        <b> BUSINESS VISA FEE</b> - RS.3500/- D/D. CHGS RS.75/- 
                        <br>
                        <b> TOURIST VISA FEE</b> - RS.1500/- D/D. CHGS RS.75/- 
                        </font> </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">IRELAND</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        FEE DRAFT FAVOURING <b>'EMBASSY OF IRELAND'</b> - NEW 
                        DELHI <br>
                        <b> SINGLE ENTRY VISA FEE</b> - RS.1300/- D/D. CHARGES 
                        RS.75/- <br>
                        <b> MULTIPLE ENTRY VISA FEE</b> - RS.2600/- D/D. CHARGES 
                        RS.75/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">U.K. 
                        </font></b><font size="2" face="Arial, Helvetica, sans-serif">FEE 
                        DRAFT FAVOURING <b>'BRITISH HIGH COMMISSION'</b> - NEW 
                        DELHI <br>
                        <b> 6 MONTH SINGLE ENTRY/MULTIPLE ENTRY VISA FEE</b> - 
                        RS.2300/- D/D CHGS RS.75/- <br>
                        <b> 1 YEAR MULTIPLE ENTRY VISA FEE</b> - RS.3850/- D/D 
                        CHGS RS.75/- <br>
                        <b> 2 YEAR MULTIPLE ENTRY VISA FEE</b> - RS.4550/- D/D 
                        CHGS RS.75/- <br>
                        <b> 5 YEAR MULTIPLE ENTRY VISA FEE</b> - RS.5600/- D/D 
                        CHGS RS.75/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">NETHERLAND</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        VISA FEE DRAFT FAVOURING <b>'ROYAL NETHERLANDS EMBASSY'</b> 
                        - NEW DELHI <br>
                        <b> 1 MONTH SINGLE / MULTIPLE ENTRY VISA FEE</b> - RS.1050/- 
                        D/D CHGS RS.75/- <br>
                        <b> 3 MONTHS SINGLE ENTRY</b> - RS.1250/- D/D CHGS RS.75/- 
                        <br>
                        <b> 3 MONTHS MULTIPLE ENETRY</b> - RS.1460/- D/D CHGS 
                        RS.75/- <br>
                        <b> 1 YEAR MULTIPLE ENTRY</b> - RS.2090/- D/D CHGS RS.75/- 
                        </font> </td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" face="Arial, Helvetica, sans-serif" size="2">PHILIPPINES</font></b><font face="Arial, Helvetica, sans-serif" size="2"> 
                        VISA FEE DRAFT FAVOURING <b>'THE EMBASSY OF PHILIPPINES'</b> 
                        - NEW DELHI<br>
                        <b> SINGLE ENTRY VISA FEE</b> - RS.1380/- D/D CHGS : RS.75/- 
                        <br>
                        <b> 6 MONTHS MULTIPLE ENTRY VISA FEE</b> - RS.2760/- D/D 
                        CHGS : RS.75/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" face="Arial, Helvetica, sans-serif" size="2">U.S.A.</font></b><font face="Arial, Helvetica, sans-serif" size="2"> 
                        FEE DRAFT FAVOURING <b>'AMERICAN EMBASSY'</b> - NEW DELHI 
                        <br>
                        <b> PROCESSING FEE</b> - RS.2205/- D/D CHGS: RS.75/- <br>
                        <b> VISA FEE</b> - RS.3675/- D/D CHGS : RS.75/- </font></td>
                    </tr>
                    <tr> 
                      <td valign=top align=left width="5%" height=2>&nbsp;</td>
                      <td valign=top align=left height=2 colspan="4"><b><font color="#990099" size="2" face="Arial, Helvetica, sans-serif">ETHIOPIA</font></b><font size="2" face="Arial, Helvetica, sans-serif"> 
                        VISA FEE FAVOURING <b>'ETHIOPIAN EMBASSY'</b> - NEW DELHI 
                        <br>
                        <b> TOURIST VISA FEE</b> - RS.1974/- D/D CHGS RS.75/- 
                        <br>
                        <b> BUSINESS VISA FEE</b> - RS.2068/- D/D CHGS RS.75/- 
                        <br>
                        <b> TRANSIT VISA FEE</b> - RS.1927/- D/D CHGS RS.75/-</font> 
                      </td>
                    </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td colspan="2"><b><font face="Arial, Helvetica, sans-serif"><a href="updatehotel.asp"><img src="updateimg/previous.jpg" border="0"></a></font></b></td>
                <td width="36%"> 
                  <div align="right"><a href="update090302.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
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
                        <td width="26%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          </b></td>
                        <td width="24%"> 
                          <input type="button" name="Submit2" value="REGISTER NOW" onClick="return reg()">
                        </td>
                      </tr>
                    </table>
                  </form>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td> <!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
