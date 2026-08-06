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
<table width="750" border="0" cellspacing="0" cellpadding="0" align="left" height="469">
  <tr> 
    <td height="582"> 
      <table width="99%" border="0" cellspacing="0" cellpadding="0" height="697">
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
          <td height="394"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="0">
              <tr> 
                <td width="21" height="1540">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="1540"> 
                  <div align="center"> <b><font size="5" face="Garamond"></font></b> 
                    <table align='center' height='1615' width='10%' bgcolor="#FFFFCC">
                      <tr bgcolor="#00CCFF"> 
                        <td height='33' colspan='2'> 
                          <div align="center"><b><font size="5" face="Garamond"><i><font color="#CC00CC" face="Lucida Sans Unicode"><marquee behaviour = "alternate"><font face="Monotype Corsiva" size="6">UPDATE 
                            1ST AUGUST, 2004</font></marquee behaviour = "alternate"></font></i></font></b></div>
                        </td>
                      </tr>
                      <tr bgcolor="#FFCCFF"> 
                        <td height='46' colspan='2'> 
                          <div align="center"><b><font face="Comic Sans MS" size="6" color="#CC00FF">***CHINA***</font></b></div>
                        </td>
                      </tr>
                      <tr bgcolor="#66CCFF"> 
                        <td height='1483' colspan='2'> 
                          <div align="justify"> 
                            <p><b><font size="2"><font face="Garamond" size="3" color="#3333CC">AS 
                              PER LATEST NOTIFICATION FROM &quot;THE EMBASSY OF 
                              THE PEOPLE'S REPUBLIC OF CHINA &quot;- NEW DELHI, 
                              ALL THE VISA FEES SHOULD BE PAID ONLY BY DEMAND 
                              DRAFT DRAWN ON A NATIONAL OR INTERNATIONAL BANK. 
                              THEY SHOULD BE MADE FOR THE EXACT AMOUNT IN FAVOUR 
                              OF THE &quot;EMBASSY OF THE PEOPLE'S REPUBLIC OF 
                              CHINA&quot; - PAYABLE AT NEW DELHI OR &quot;CHINESE 
                              EMBASSY, NEW DELHI&quot; WITH EFFECT FROM <i><font color="#FFFF66">1ST 
                              AUGUST, 2004.</font></i><br>
                              <br>
                              <font color="#FFFF00">NOTE</font>:- THE DRAWER'S 
                              FULL NAME, TELEPHONE NUMBER AND PICK UP FORM NUMBER 
                              SHOULD BE WRITTEN ON THE BACK OF DRAFT.</font></font></b><font face="Garamond" size="3" color="#3333CC"><b><i> 
                              <br>
                              </i></b></font></p>
                            <table width="718" border="0" cellpadding="0">
                              <tr bordercolor="#FF6666"> 
                                <td> 
                                  <div align="center"><b><font face="Comic Sans MS" color="#FFFF33">VISA 
                                    FEE FOR INDIAN PASSPORT HOLDERS</font></b></div>
                                </td>
                              </tr>
                            </table>
                            <p><font face="Garamond" size="3" color="#CC00FF"><b><i> 
                              <img border="0" src="updateimg/up0107.jpg" width="717" height="124"><br>
                              </i></b></font> </p>
                            <table width="718" border="0" cellpadding="0" height="108">
                              <tr bgcolor="#FFCCFF" bordercolor="#333333"> 
                                <th width="267" nowrap> 
                                  <div align="center"><b><font face="Garamond" color="#CC00FF">TYPE 
                                    OF VISA</font></b></div>
                                </th>
                                <th width="212" nowrap> 
                                  <div align="center"><font color="#CC00FF"><b><font face="Garamond">NORMAL<br>
                                    (collection in 4 working days)<br>
                                    </font> </b> </font></div>
                                </th>
                                <th width="231" nowrap> 
                                  <div align="center"><font color="#CC00FF"><b><font face="Garamond">URGENT<br>
                                    (collection in 2 or 3 working days)</font></b></font></div>
                                </th>
                              </tr>
                              <tr> 
                                <td width="267" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>SINGLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="212" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    1000/-</b></font></div>
                                </td>
                                <td width="231" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    1900/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="267" height="21" bgcolor="#FFCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>DOUBLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="212" height="21" bgcolor="#FFCCFF"> 
                                  <p align="center"><font color="#CC00FF"><b>RS. 
                                    1500/-</b></font></p>
                                </td>
                                <td width="231" height="21" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2400/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="267" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR HALF YEAR</b></font></div>
                                </td>
                                <td width="212" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2000/-</b></font></div>
                                </td>
                                <td width="231" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2900/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="267" bgcolor="#FFCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR ONE YEAR</b></font></div>
                                </td>
                                <td width="212" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    3000/-</b></font></div>
                                </td>
                                <td width="231" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    3900/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="267" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>GROUP 
                                    VISA / PER PERSON</b></font></div>
                                </td>
                                <td width="212" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    800/-</b></font></div>
                                </td>
                                <td width="231" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    1250/-</b></font></div>
                                </td>
                              </tr>
                            </table>
                            <table width="717" border="0" cellpadding="0" height="34">
                              <tr>
                                <td height="29"> 
                                  <div align="center"><b><font color="#FFFF00" face="Comic Sans MS">VISA 
                                    FEE FOR FOREIGN NATIONALS <i>EXCEPT AMERICAN 
                                    PASSPORT HOLDERS</i></font></b></div>
                                </td>
                              </tr>
                            </table>
                            <table width="718" border="0" cellpadding="0">
                              <tr bgcolor="#FFCCFF"> 
                                <td width="259"> 
                                  <div align="center"><b><font face="Garamond" color="#CC00FF">TYPE 
                                    OF VISA</font></b></div>
                                </td>
                                <td width="206"> 
                                  <div align="center"><font color="#CC00FF"><b><font face="Garamond">NORMAL<br>
                                    (collection in 4 working days)<br>
                                    </font></b></font></div>
                                </td>
                                <td width="245"> 
                                  <div align="center"><font color="#CC00FF"><b><font face="Garamond">URGENT<br>
                                    (collection in 2 or 3 working days)</font></b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="259" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>SINGLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="206" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    1300/-</b></font></div>
                                </td>
                                <td width="245" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2200/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="259" height="21" bgcolor="#FFCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>DOUBLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="206" height="21" bgcolor="#FFCCFF"> 
                                  <p align="center"><font color="#CC00FF"><b>RS. 
                                    2000/-</b></font></p>
                                </td>
                                <td width="245" height="21" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2900/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="259" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR HALF YEAR</b></font></div>
                                </td>
                                <td width="206" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2600/-</b></font></div>
                                </td>
                                <td width="245" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    3500/-</b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="259" bgcolor="#FFCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR ONE YEAR</b></font></div>
                                </td>
                                <td width="206" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    3900/-</b></font></div>
                                </td>
                                <td width="245" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    4800/-</b></font></div>
                                </td>
                              </tr>
                            </table>
                            <table width="719" border="0" cellpadding="0">
                              <tr>
                                <td>
                                  <div align="center"><font face="Comic Sans MS" color="#FFFF00"><b>VISA 
                                    FEE FOR AMERICAN PASSPORT HOLDER</b></font></div>
                                </td>
                              </tr>
                            </table>
                            <table width="720" border="0" cellpadding="0">
                              <tr bgcolor="#FFCCFF"> 
                                <td width="354" height="36">
                                  <div align="center"><b><font face="Garamond" color="#CC00FF">TYPE 
                                    OF VISA</font></b></div>
                                </td>
                                <td width="360" height="36"> 
                                  <div align="center"><font color="#CC00FF"><b><font face="Garamond">NORMAL<br>
                                    (collection in 4 working days)<br>
                                    </font></b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="354" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>SINGLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="360" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    2400/- </b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="354" height="21" bgcolor="#FFCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>DOUBLE 
                                    ENTRY</b></font></div>
                                </td>
                                <td width="360" height="21" bgcolor="#FFCCFF"> 
                                  <p align="center"><font color="#CC00FF"><b>RS. 
                                    3700/- </b></font></p>
                                </td>
                              </tr>
                              <tr> 
                                <td width="354" bgcolor="#CCCCFF"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR HALF YEAR</b></font></div>
                                </td>
                                <td width="360" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    4900/- </b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="354" bgcolor="#FFCCFF" height="17"> 
                                  <div align="center"><font face="Garamond" size="2" color="#CC00FF"><b>MULTIPLE 
                                    ENTRY FOR ONE YEAR</b></font></div>
                                </td>
                                <td width="360" bgcolor="#FFCCFF" height="17"> 
                                  <div align="center"><font color="#CC00FF"><b>RS. 
                                    7300/- </b></font></div>
                                </td>
                              </tr>
                            </table>
                            <table width="721" border="1" cellpadding="0">
                              <tr bgcolor="#66CCFF" bordercolor="#6666FF"> 
                                <td height="51"> 
                                  <div align="center"><b><font size="5" color="#3333CC" face="Comic Sans MS">***HONGKONG***<br>
                                    <font size="3">(VISA FEE WITHOUT DIFFERENCE 
                                    OF NATIONALITY)</font></font></b></div>
                                </td>
                              </tr>
                            </table>
                            <table width="721" border="0" cellpadding="0">
                              <tr> 
                                <td width="348" bgcolor="#FFCCFF"> 
                                  <div align="center"><font color="#CC66FF" face="Garamond"><b><font color="#FF00FF">NORMAL 
                                    (collection in 4 working days)</font></b></font></div>
                                </td>
                                <td width="367" bgcolor="#CCCCFF"> 
                                  <div align="center"><font color="#CC66FF" face="Garamond"><b><font color="#FF00FF">URGENT 
                                    (collection in 2 or 3 working days)</font></b></font></div>
                                </td>
                              </tr>
                              <tr> 
                                <td width="348" bgcolor="#CCCCFF"> 
                                  <div align="center"><b><font color="#FF00FF">RS. 
                                    1200/-</font></b></div>
                                </td>
                                <td width="367" bgcolor="#FFCCFF"> 
                                  <div align="center"><b><font color="#FF00FF">RS. 
                                    2100/-</font></b></div>
                                </td>
                              </tr>
                            </table>
                            <table width="729" border="0" cellpadding="0">
                              <tr bgcolor="#66CCFF"> 
                                <td> 
                                  <div align="center"><font face="Comic Sans MS"><b><font size="5" color="#3333CC">IMPORTANT 
                                    NOTICE : FOR FASTER VISA PROCESSING</font></b></font></div>
                                </td>
                              </tr>
                              <tr bgcolor="#99CCFF"> 
                                <td height="266"><font face="Garamond" size="2"><b><font size="3" color="#009900"><i><font color="#FF00FF">TO 
                                  AVOID DELAY IN THE PROCESSING OF VISA APPLICATIONS, 
                                  KINDLY FILL UP THE NEW APPLICATION FORM OF THE 
                                  COUNTRIES GIVEN BELOW. DOWNLOAD THE FORMS FROM 
                                  THE ADJOINING LINKS.<br>
                                  <br>
                                  </font></i></font></b></font> 
                                  <table width="723" border="1" cellpadding="0" height="8">
                                    <tr>
                                      <td height="43"> 
                                        <div align="center"><font face="Comic Sans MS, Garamond" size="5"><b><font color="#6633CC" size="6">***NORWAY***<br>
                                          </font></b></font></div>
                                      </td>
                                    </tr>
                                  </table>
                                  <table width="725" border="0" cellpadding="0">
                                    <tr bgcolor="#FFCCFF"> 
                                      <td><font color="#FF00FF"><b><font face="Garamond">WITH 
                                        IMMEDIATE EFFECT ALL APPLICANTS HAVE TO 
                                        ATTACH A <i><font color="#6633CC">PERSONAL 
                                        INFORMATION SUPPLEMENTARY</font></i> ALONG 
                                        WITH THE VISA APPLICATION FORM.THE FORMS 
                                        MAY BE DOWNLOADED FROM THE LINK BELOW. 
                                        <br>
                                        <a href="http://www.udaanindia.com/forms/Norway Additional form.pdf" target="_blank"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"></a> 
                                        <font color="#6633CC">PERSONAL INFORMATION 
                                        SUPPLEMENTARY SHEET.</font></font></b></font></td>
                                    </tr>
                                  </table>
                                  <font face="Garamond" size="2"><b><font size="3" color="#009900"><i><font color="#FF00FF"> 
                                  </font></i></font></b></font></td>
                              </tr>
                            </table>
                            <table width="725" border="0" cellpadding="0">
                              <tr bgcolor="#CCFFCC"> 
                                <td height="40" width="347" bgcolor="#FFCCFF"><font color="#669900" face="Comic Sans MS"><b><a href="http://www.udaanindia.com/forms/bangladesh.pdf" target="_blank"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font color="#FF00FF" size="2">BANGLADESH 
                                  VISA FORM</font></a></b></font></td>
                                <td height="40" width="372" bgcolor="#CCCCFF"><font face="Arial, Helvetica, sans-serif" size="2"><b> 
                                  <a href="http://www.udaanindia.com/forms/Egypt.pdf" target="_blank"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font face="Comic Sans MS" color="#FF00FF">EGYPT 
                                  VISA FORM</font></a></b></font></td>
                              </tr>
                              <tr bgcolor="#CCFFCC"> 
                                <td width="347" bgcolor="#CCCCFF"> <a href="http://www.udaanindia.com/forms/GREECE.pdf" target="_blank"> 
                                  <img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><b><font face="Comic Sans MS" color="#FF00FF" size="2">GREECE 
                                  VISA FORM</font></b></a></td>
                                <td width="372" bgcolor="#FFCCFF"> <a href="http://www.udaanindia.com/forms/hungary.pdf" target="_blank"> 
                                  <img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font color="#339900" face="Comic Sans MS" size="2"><b><font color="#FF00FF">HUNGARY 
                                  VISA FORM</font></b></font></a></td>
                              </tr>
                              <tr bgcolor="#CCFFCC"> 
                                <td width="347" bgcolor="#FFCCFF"> <a href="http://www.udaanindia.com/forms/Koria(south).pdf" target="_blank"> 
                                  <img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font color="#669900" face="Comic Sans MS" size="2"><b><font color="#FF00FF">SOUTH 
                                  KOREA VISA FORM</font></b></font></a></td>
                                <td width="372" bgcolor="#CCCCFF"> <a href="http://www.udaanindia.com/forms/Turkey.pdf" target="_blank"> 
                                  <img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="Comic Sans MS" color="#FF00FF">TURKEY 
                                  VISA FORM</font></b></font></a></td>
                              </tr>
                              <tr bgcolor="#CCFFCC">
                                <td width="347" bgcolor="#CCCCFF"><font color="#FF00FF"><b><font face="Garamond"><a href="http://www.udaanindia.com/forms/China Medical form.pdf" target="_blank"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"></a><font face="Comic Sans MS, Garamond" size="2">CHINA 
                                  MEDICAL FORM</font></font></b></font></td>
                                <td width="372" bgcolor="#FFCCFF"><font color="#669900" face="Comic Sans MS"><b><a href="http://www.udaanindia.com/forms/Mexico.pdf" target="_blank"><img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"></a><font size="2" color="#FF00FF">MEXICO 
                                  VISA FORM</font></b></font></td>
                              </tr>
                            </table>
                            <table width="726" border="1" cellpadding="0">
                              <tr bgcolor="#66CCFF"> 
                                <td> 
                                  <div align="center"><font size="5" face="Comic Sans MS"><b><font color="#6633CC">***ESTONIA***</font></b></font></div>
                                </td>
                              </tr>
                            </table>
                            <table width="725" border="0" cellpadding="0">
                              <tr bgcolor="#FFCCFF"> 
                                <td><b><font face="Garamond" color="#FF00FF">FOR 
                                  BUSINESS VISA APPLICATIONS, THE INVITATION LETTER 
                                  SHOULD BE MANDATORILY WRITTEN ON THE PRESCRIBED 
                                  PROFORMA GIVEN BELOW: </font><br>
                                  </b><a href="http://www.udaanindia.com/forms/Estonia-inv.pdf" target="_blank"> 
                                  <img src="http://www.ttsvisas.com/images/wwwgdl.gif" width="32" height="32"><font face="Comic Sans MS" size="2" color="#CC9900"><b><font color="#FF00FF">INVITATION 
                                  LETTER PROFORMA. </font></b></font></a></td>
                              </tr>
                            </table>
                            <b><i><font face='Arial' color='#000080' size='4'> 
                            </font></i></b></div>
                        </td>
                      </tr>
                      <tr> 
                        <td height='2' colspan='2'><img src='http://www.udaanindia.com/updateimg/back-ground.jpg' width='717' height='8'></td>
                      </tr>
                      <tr > 
                        <td height='243' colspan='2'> 
                          <table width='100%' border='0' align='center' bgcolor='#CCFFFF' height='297'>
                            <tr bgcolor="#009999"> 
                              <td colspan='2' height="123"> 
                                <div align="center"> 
                                  <p align="center"><b><font size="5" color="#99FF99" face="Comic Sans MS">***SINGAPORE***</font></b></p>
                                  <p align="justify"><font color="#99FF99"><b><font face="Garamond">FURTHER 
                                    TO NOTIFICATION FROM THE &quot;EMBASSY OF 
                                    THE REPUBLIC OF SINGAPORE&quot;-NEW DELHI,</font></b><font face="Garamond"><b> 
                                    <font color="#FFFF33"><i>FROM 1ST AUGUST</i></font></b><font color="#FFFF33"> 
                                    </font>COMPLETE AN APPLICATION FORM TOGETHER 
                                    WITH A RECENT PASSPORT-SIZE PHOTOGRAPH<b>( 
                                    35 MM WIDE</b> <b>BY 45 MM ) </b>HIGH WITHOUT 
                                    BORDER AND TAKEN WITHIN THE LAST 3 MONTHS;TAKEN 
                                    FULL FACE WITHOUT HEADGEAR,UNLESS THE APPLICANT 
                                    HABITUALLY WEARS A HEADGEAR IN ACCORDANCE 
                                    WITH HIS/HER RELIGIOUS OR RACIAL CUSTOM BUT 
                                    THE HEADGEAR MUST NOT HIDE THE APPLICANT'S 
                                    FEATURES.THE FACIAL IMAGE MUST BE BETWEEN<b>( 
                                    25 MM AND 35 MM )</b> FROM CHIN TO CROWN;TAKEN 
                                    AGAINST A PLAIN WHITE BACKGROUND WITH MATT 
                                    OR SEMI-MATT FINISH.</font></font></p>
                                </div>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <b><font size="5" face="Garamond"></font></b><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="3" height="2">&nbsp; </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="updatecar.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update240804.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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

