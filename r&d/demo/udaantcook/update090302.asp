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
            <table width="98%" border="0" cellspacing="0" cellpadding="0" height="686">
              <tr> 
                <td width="2%">&nbsp; </td>
                <td colspan="3"> 
                  <div align="center"><font face="Times New Roman, Times, serif" size="6"><b>&nbsp;&nbsp;&nbsp;&nbsp;</b></font><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">9th March 2002 </font></i></b> </div>
                </td>
              </tr>
              <tr> 
                <td width="2%" height="507">&nbsp;</td>
                <td colspan="3" height="507"> 
                  <table width="100%">
                    <tr> 
                      <td valign="top" align="left" colspan="6" height="2"> 
                        <div align="left"><b></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" colspan="6" height="2"> 
                        <hr>
                      </td>
                    </tr>
                    <tbody> 
                    <tr> 
                      <td valign="top" align="right" width="4%" height="2">&nbsp; </td>
                      <td valign="top" align="left" height="2" colspan="3"> 
                        <p align="center"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial"><font color="#800080" size="4"><u>INDONESIA</u></font><font color="#800080"> 
                          </font></font></span></font></b></p>
                      </td>
                      <td valign="top" align="left" height="10" colspan="2" rowspan="7" width="46%"> 
                        <div align="right"><img src="updateimg/INDO1.jpg" width="335" height="235"></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="2" colspan="3"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">AS 
                          PER RECENT NOTIFICATION FROM 'EMBASSY OF THE REPUBLIC 
                          OF INDONESIA' - NEW DELHI, WITH EFFECT FROM 15TH MARCH 
                          2002 THE REVISED VISA FEE WILL BE AS FOLLOWS.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="2" colspan="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;*&nbsp;SINGLE 
                        ENTRY</font></b></font></td>
                      <td valign="top" align="left" height="2" width="14%"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        1500.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="2" colspan="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;*&nbsp;1 
                        YEAR STAY (SINGLE ENTRY)</font></b></font></td>
                      <td valign="top" align="left" height="2" width="14%"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        2550.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="2" colspan="2"><font color="#3333FF"><b><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;&nbsp;*&nbsp;1 
                        YEAR STAY (MULTIPLE ENTRY) </font></b></font></td>
                      <td valign="top" align="left" height="2" width="14%"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        3200.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="2" colspan="2"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;*&nbsp;TRANSIT</font></b></font></td>
                      <td valign="top" align="left" height="2" width="14%"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                        &nbsp;650.00</font></b></font></td>
                    </tr>
                    <tr> 
                      <td valign="top" align="left" width="4%" height="6"><b><font face="Arial, Helvetica, sans-serif" size="2"></font></b></td>
                      <td valign="top" align="left" height="6" colspan="3"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">FEE 
                          WILL BE ACCEPTED BY DEMAND DRAFT IN FAVOUR OF 'INDONESIAN 
                          EMBASSY' PAYABLE AT NEW DELHI </font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="6" height="188"> 
                        <table width="100%" border="0" align="center">
                          <tr> 
                            <td valign="top" align="left" colspan="6" height="2" bgcolor="#070692"><b><u><font face="Arial" color="#FFFFFF" size="4">HOLIDAYS 
                              LIST FOR MARCH 2002.</font></u></b></td>
                          </tr>
                          <tr> 
                            <td valign="top" align="left" width="5%" height="2" bgcolor="#FFCCCC"><u><b><font face="Courier" color="#800080" size="3">DATE</font></b></u></td>
                            <td valign="top" align="left" width="36%" height="2" bgcolor="#FFCCCC"><b><u><font face="Courier" color="#800080" size="3">COUNTRY</font></u></b></td>
                            <td valign="top" align="left" width="4%" height="2" bgcolor="#FFCCCC"><u><b><font face="Courier" color="#800080" size="3">DATE</font></b></u></td>
                            <td valign="top" align="left" height="2" bgcolor="#FFCCCC" colspan="2" width="55%"><b><u><font face="Courier" color="#800080" size="3">COUNTRY</font></u></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">1<span style="mso-spacerun: yes"> &nbsp;</span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">KOREA-REP-OF</span></font></b></td>
                            <td valign="top" align="left" height="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">20<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">TUNISIA</font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">2&nbsp;<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">ETHIOPIA</span></font></b></td>
                            <td valign="top" align="left" height="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">21<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">NAMIBIA</font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">3<span style="mso-spacerun: yes">&nbsp; </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">BULGARIA</span></font></b></td>
                            <td valign="top" align="left" height="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">23<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">PAKISTAN</span></font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">5, 6<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">GHANA</span></font></b></td>
                            <td valign="top" align="left" height="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2">25 
                              :</font></b></td>
                            <td valign="top" align="left" height="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">SINGAPORE, 
                              GREECE, INDIA, ETHIOPIA, TAIWAN, JAPAN, U.S.A., 
                              KOREA-REP-OF, THAILAND, PHILIPPINES, M.E.A.-ATTEST.</font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="13"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">12<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="13" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">PHILIPPINES, MAURITIUS, ETHIOPIA, 
                              TAIWAN, JAPAN, KOREA-REP-OF, INDIA, M.E.A.-ATTEST., 
                              ARGENTINA, S. AFRICA</span></font></b></td>
                            <td valign="top" align="left" height="13" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2">26 
                              :</font></b></td>
                            <td valign="top" align="left" height="13" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">BANGLADESH</font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">15<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2">ITALY, 
                              MALAYSIA</font></b></td>
                            <td valign="top" align="left" height="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2">28 
                              :</font></b></td>
                            <td valign="top" align="left" height="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">PHILIPPINES, 
                              SINGAPORE, ARGENTINA</font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">16<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2">KUWAIT</font></b></td>
                            <td valign="top" align="left" height="4" rowspan="2" width="4%"><b><font face="Arial, Helvetica, sans-serif" size="2">29 
                              :</font></b></td>
                            <td valign="top" align="left" height="4" rowspan="2" colspan="2" width="55%"><b><font face="Arial, Helvetica, sans-serif" size="2">ETHIOPIA, 
                              BHUTAN, TAIWAN, JAPAN, THAILAND, SPAIN, NEWZEALAND, 
                              AUSTRIA, FINLAND, U.S.A., SINGAPORE, MALAYSIA, KOREA-REP-OF, 
                              INDIA, M.E.A.-ATTEST., AUSTRALIA, PHILIPPINES, ARGENTINA,<span style="COLOR: black"> S. AFRICA</span>. </font></b></td>
                          </tr>
                          <tr bgcolor="#FEF7ED"> 
                            <td valign="top" align="left" width="5%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><span style="COLOR: black">17<span style="mso-spacerun: yes"> </span>:</span></font></b></td>
                            <td valign="top" align="left" height="2" width="36%"><b><font face="Arial, Helvetica, sans-serif" size="2">IRELAND</font></b></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="2%" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update070302.asp"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="36%" height="2"> 
                  <div align="right"><a href="update120302.ASP"><img src="updateimg/Next.jpg" width="70" height="37" border="0"></a></div>
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
