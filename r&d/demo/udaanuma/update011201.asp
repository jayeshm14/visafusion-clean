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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="473">
              <tr> 
                <td width="3%">&nbsp; </td>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td width="3%">&nbsp; </td>
                <td colspan="2"><font face="Times New Roman, Times, serif" 
            size=6><b></b></font><b><font face="Times New Roman, Times, serif" 
            size=6><b></b></font><b><u><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>1st December 2001</font></u></b></b></td>
              </tr>
              <tr> 
                <td width="3%" height="509">&nbsp;</td>
                <td colspan="2" height="509"> 
                  <table height=48 cellspacing=0 cellpadding=0 width="100%" 
              border=0 bgcolor="#fff0d9">
                    <tbody> 
                    <tr> 
                      <td width="53%" height=1> 
                        <table height=1 width="99%">
                          <tbody> 
                          <tr> 
                            <td valign=top align=left width="8%" height=1>&nbsp;<img border="0" src="updateimg/bullet.gif" width="13" height="12"></td>
                            <td valign=top align=left width="92%" height=1><span 
                        style="mso-bidi-font-size: 10.0pt"><b><font face=Arial 
                        size=2>PHILIPPINES : KINDLY NOTE THAT IF PASSENGER IS 
                              A FIRST TIME TRAVELLER TO PHILIPPINES AND ALSO HOLDING 
                              A FRESH PASSPORT THAN, IT WOULD BE FAVORABLE FOR 
                              THE APPLICANT TO APPLY IN PERSON ALONG WITH ADDITIONAL 
                              SUPPORTING DOCUMENTS LIKE COMPANY PROFILE, TAX PAPERS, 
                              BANK STATEMENTS. NEVERTHELESS, IF PAX IS HOLDING 
                              VALID VISAS VIZ. U.K., U.S.A, CANADA, SCHENGEN, 
                              WE MAY ATTEMPT THE CASE AND ADVICE ACCORDINGLY.<span 
                        style="COLOR: red; mso-bidi-font-size: 10.0pt"><o:p> </o:p></span></font></b></span><b><font 
                        face="Arial, Helvetica, sans-serif" 
                        size=2><br>
                              &nbsp;</font> </b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="8%" height=1>&nbsp;<img border="0" src="updateimg/bullet.gif" width="13" height="12"></td>
                            <td valign=top align=left width="92%" height=1><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial 
                        size=2><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt">MYANMAR 
                              : A FAX INVITATION FROM MYANMAR IS MANDATORY TO 
                              COME TO THE EMBASSY DIRECTLY FOR ALL THE BUSINESS 
                              VISA CASE PROCESSING AT DELHI, AND ALSO A COPY TO 
                              BE SENT ALONG WITH THE CASES.</span><span 
                        style="COLOR: red; mso-bidi-font-size: 10.0pt"><o:p> </o:p></span></font></span><font 
                        face="Arial, Helvetica, sans-serif" 
                        size=2><br>
                              &nbsp;</font> </b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="8%" height=1>&nbsp;<img border="0" src="updateimg/bullet.gif" width="13" height="12"></td>
                            <td valign=top align=left width="92%" height=1><b><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt"><font 
                        face=Arial size=2>EGYPT : W.E.F 01DEC THE VISA FEES FOR 
                              EGYPT - SINGLE ENTRY HAS BEEN REVISED TO BE CHARGED 
                              AS RS. 1,300/-. </font></span><span 
                        style="FONT-SIZE: 18pt; COLOR: red; FONT-FAMILY: 'Arial Narrow'; mso-bidi-font-size: 10.0pt"><o:p></o:p></span></b></td>
                          </tr>
                          </tbody> 
                        </table>
                      </td>
                      <td valign=top width="47%" height=1> 
                        <table height=180 width="100%" border=0>
                          <tbody> 
                          <tr> 
                            <td height=231><img border="0" src="images/world.jpg"></td>
                          </tr>
                          </tbody> 
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan=2 height=122> 
                        <table height=238 width="100%">
                          <tbody> 
                          <tr> 
                            <td width="100%" colspan=2 height=10><b><u><font 
                        face=Arial color=#000080 size=4>HOLIDAYS LIST FOR DECEMBER 
                              2001.</font> </u></b></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=16><u><b><font 
                        face=Courier color=#333300 size=3>DATE</font></b></u></td>
                            <td width="94%" height=16><b><u><font face=Courier 
                        color=#333300 size=3>COUNTRY</font></u></b></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=16><span 
                        style="COLOR: black"><b><font face=Arial size=2>05 :</font></b></span></td>
                            <td width="94%" height=16><span 
                        style="COLOR: black"><b><font face=Arial 
                        size=2>THAI</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=15><span 
                        style="COLOR: black"><b><font face=Arial size=2>06<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td width="94%" height=15><span 
                        style="COLOR: black"><b><font face=Arial 
                        size=2>FINLAND</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=15><span 
                        style="COLOR: black"><b><font face=Arial size=2>12<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td width="94%" height=15><span 
                        style="COLOR: black"><b><font face=Arial 
                        size=2>KENYA&nbsp;</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=15><span 
                        style="COLOR: black"><b><font face=Arial size=2>16<span 
                        style="FONT-WEIGHT: normal; FONT-STYLE: normal; FONT-VARIANT: normal"> 
                              </span>:</font></b></span></td>
                            <td width="94%" height=15><span 
                        style="COLOR: black"><b><font face=Arial 
                        size=2>INDONESIA&nbsp;</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=28><span 
                        style="COLOR: black"><b><font face=Arial size=2>17<span 
                        style="FONT-WEIGHT: normal; FONT-STYLE: normal; FONT-VARIANT: normal"> 
                              </span>:</font></b></span></td>
                            <td width="94%" height=28><span 
                        style="COLOR: black"><b><font face=Arial 
                        size=2>INDONESIA, SING, TAIWAN, PHILIPPINES, KENYA, AUSTRALIA, 
                              BRUNEI, MALAYSIA,<span 
                        style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                              </span>SRILANKA,<span 
                        style="mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp; </span>ARGENTINA, 
                              NIGERIA, KOREA, THAI</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=15><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>18<span 
                        style="FONT-WEIGHT: normal; FONT-STYLE: normal; FONT-VARIANT: normal"> 
                              </span>:</font></b></span></td>
                            <td width="94%" height=15><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>BRUNEI</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=15><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>24<span 
                        style="FONT-WEIGHT: normal; FONT-STYLE: normal; FONT-VARIANT: normal"> 
                              </span>:</font></b></span></td>
                            <td width="94%" height=15><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>U.K, UGANDA</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=41><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>25<span 
                        style="FONT-WEIGHT: normal; FONT-STYLE: normal; FONT-VARIANT: normal"> 
                              </span>:</font></b></span></td>
                            <td width="94%" height=41><span lang=FR 
                        style="COLOR: black; mso-ansi-language: FR"><b><font 
                        face=Arial size=2>BELGIUM, GHANA, INDO, SING, TRINIDAD, 
                              TAIWAN, UGANDA, UK, CANADA, SPAIN, ETHIOPIA, CYPRUS, 
                              PHILIPPINES, KENYA, AUSTRALIA, BRUNEI, MALAYSIA, 
                              BRAZIL, SRILANKA, ARGENTINA, THAI, NIGERIA, KOREA</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top width="6%" height=28><span 
                        style="COLOR: black"><b><font face=Arial size=2>26<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td width="94%" height=28><b><span 
                        style="COLOR: black"><font face=Arial size=2>GHANA, TRINIDAD, 
                              UK, CANADA, ETHIOPIA, CYPRUS, KENYA, AUSTRALIA, 
                              IRELAND <o:p></o:p><br>
                              N.ZEALAND EMB IS CLOSED FROM 25 DEC TILL 31 DEC 
                              </font></span></b></td>
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
                <td width="3%">&nbsp;</td>
                <td width="47%"><b><font face="Arial, Helvetica, sans-serif"></font></b></td>
                <td width="50%"> 
                  <div align="right"><a href="update251201.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td colspan="2"> 
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
