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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="2%">&nbsp; </td>
                <td colspan="3"> 
                  <div align="center"><b><u><font face="Times New Roman, Times, serif" size="6"><b><img src="updateimg/mazdarx8a.jpg" width="110" height="51"></b></font><b><font face="Arial Black" color="#000080" size="6"><i>&nbsp;&nbsp;&nbsp;UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">'UDAAN' CAR RENTALS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="updateimg/uma_cars.gif" width="100" height="75"></font></i></b></u></b></div>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td colspan="3"> 
                  <table height="801" width="100%">
                    <tr> 
                      <td valign="top" align="left" colspan="3" height="2"> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                      <td valign="top" colspan="3" height="116"> 
                        <p><b><font face="Arial, Helvetica, sans-serif" size="2"> 
                          Dear Sir,<br>
                          <br>
                          </font></b><font face="Arial, Helvetica, sans-serif" size="2"><b>At 
                          the outset, We thank you for your wholehearted support 
                          and patronisation to us. We assure you thet we would 
                          always render our most agile services to you.<br>
                          </b></font><font face="Arial, Helvetica, sans-serif" size="2"><b> 
                          </b></font></p>
                        <font face="Arial, Helvetica, sans-serif" size="2"><b> 
                        <div align="justify">Further, We herewith furnish the 
                          details as are required by your office for the ``MEET 
                          &amp; GREET`` service. We understand that your office 
                          is presently dealing with many leading indian corporate 
                          companies and multinationals. Keeping the same in view, 
                          we inform you about the fleet of vehicles which can 
                          be made available for your esteemed client. The charges 
                          given herebelow are most competetive in delhi.</div>
                        </b></font> </td>
                    </tr>
                    <tbody> 
                    <tr> 
                      <td valign="top" colspan="3" height="579"> 
                        <table width="100%" border="0">
                          <tr> 
                            <td colspan="6" height="23"><b><font face="Arial, Helvetica, sans-serif"><i><u>REVISED 
                              TARIFF SHEET - CAR HIRE</u></i></font></b></td>
                            <td rowspan="54" width="33%" valign="middle"><br>
                              <br>
                              <br>
                              <br>
                              <br>
                              <img src="updateimg/comf-car.jpg" width="240" height="107"></td>
                          </tr>
                          <tr bgcolor="#CCCCFF"> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">ASSIGNMENT</font></b></td>
                            <td width="9%" height="2"><font face="Arial, Helvetica, sans-serif"><b><font size="2">LOCAL 
                              8HRS-80KMS.</font></b></font></td>
                            <td width="6%" height="2"><font size="2" face="Arial, Helvetica, sans-serif"><b>EXT. 
                              P.K.M.</b></font></td>
                            <td width="11%" height="2"><b><font size="2" face="Arial, Helvetica, sans-serif">DETENTION 
                              PER HRS.</font></b></td>
                            <td width="11%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">OUT 
                              STATION 200 Km/Day</font></b></td>
                            <td width="13%" height="2"><font face="Arial, Helvetica, sans-serif" size="2"><b>OUT 
                              STATION 0/NIGHT CHG.</b></font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">INDICA 
                              NON A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">600.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">6.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">30.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">6.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">INDICA 
                              A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">800.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">8.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">35.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">8.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">QUALIS 
                              N A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">850.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">8.50</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">30.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">8.50</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">QUALIS 
                              A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">950.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">9.50</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">35.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">9.50</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">DLX 
                              TWIN QUALIS A/C</font></b></td>
                            <td height="2" width="9%"><font size="2" face="Arial, Helvetica, sans-serif">1200.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">12.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">40.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">12.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">ESTEEM/SIENNA</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1200.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">12.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">45.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">12.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">CIELO 
                              / ICON</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1600.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">16.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">50.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">16.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">HONDA 
                              CITY</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1800.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">18.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">60.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">18.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="15"><b><font face="Arial, Helvetica, sans-serif" size="2">LANCER</font></b></td>
                            <td height="15" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">2000.00</font></td>
                            <td height="15" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">20.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">70.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">20.00</font></td>
                            <td height="15" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="15"><b><font face="Arial, Helvetica, sans-serif" size="2">OPEL 
                              ASTRA </font></b></td>
                            <td height="15" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">2100.00</font></td>
                            <td height="15" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">21.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">70.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">21.00</font></td>
                            <td height="15" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="15"><b><font face="Arial, Helvetica, sans-serif" size="2">TATA 
                              SAFARI</font></b></td>
                            <td height="15" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1700.00</font></td>
                            <td height="15" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">17.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">50.00</font></td>
                            <td height="15" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">17.00</font></td>
                            <td height="15" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">SUMO 
                              NON A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">700.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">7.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">30.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">7.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2">SUMO 
                              A/C</font></b></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">850.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">8.50</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">30.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">8.50</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">100.00</font></td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"><font face="Arial, Helvetica, sans-serif" size="2"><b>TEMPO 
                              TRAVELLER</b></font><b><font face="Arial, Helvetica, sans-serif" size="2"> 
                              (Mini Coach / 9-12 Seater)</font></b><font face="Arial, Helvetica, sans-serif" size="2"></font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><font face="Arial, Helvetica, sans-serif" size="2">NON 
                              A/C</font></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1300.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">13.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">50.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">13.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">150.00</font></td>
                          </tr>
                          <tr> 
                            <td width="17%" height="2"><font face="Arial, Helvetica, sans-serif" size="2">A/C</font></td>
                            <td height="2" width="9%"><font face="Arial, Helvetica, sans-serif" size="2">1500.00</font></td>
                            <td height="2" width="6%"><font face="Arial, Helvetica, sans-serif" size="2">15.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">60.00</font></td>
                            <td height="2" width="11%"><font face="Arial, Helvetica, sans-serif" size="2">15.00</font></td>
                            <td height="2" width="13%"><font face="Arial, Helvetica, sans-serif" size="2">150.00</font></td>
                          </tr>
                        </table>
                        <table width="100%" border="0" height="326">
                          <tr bgcolor="FF9999" align="center"> 
                            <td colspan="3" height="2"><b><font size="5" color="#0000FF" face="Arial Black"><i>SPECIAL 
                              OFFERS</i></font></b> </td>
                          </tr>
                          <tr> 
                            <td rowspan="5" height="44" width="37%"> <img src="updateimg/indica-img.gif" width="284" height="145"></td>
                            <td height="2" width="49%"><b><font face="Arial, Helvetica, sans-serif" size="2">1. 
                              DELHI / AGRA / DELHI (Same day) </font></b></td>
                            <td height="2" width="14%"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              2700.00</font></b></td>
                          </tr>
                          <tr> 
                            <td height="18" width="49%"><b><font face="Arial, Helvetica, sans-serif" size="2">2. 
                              DELHI / AGRA / F. SIKRI / DELHI (Same day)</font></b></td>
                            <td height="18" width="14%"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              3200.00</font></b></td>
                          </tr>
                          <tr> 
                            <td height="20" width="49%"><b><font face="Arial, Helvetica, sans-serif" size="2">3. 
                              DELHI / AGRA / F. SIKRI / DELHI (2 days)</font></b></td>
                            <td height="20" width="14%"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              3500.00</font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" width="49%"><b><font face="Arial, Helvetica, sans-serif" size="2">4. 
                              DELHI / AGRA / F. SIKRI / JAIPUR / DELHI (3 days)</font></b></td>
                            <td height="2" width="14%"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              5200.00</font></b></td>
                          </tr>
                          <tr> 
                            <td height="2" width="49%"><b><font face="Arial, Helvetica, sans-serif" size="2">5. 
                              DELHI / AGRA / F. SIKRI / JAIPUR / DELHI (4 days)</font></b></td>
                            <td height="2" width="14%"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                              5500.00</font></b></td>
                          </tr>
                          <tr> 
                            <td width="37%" height="2"><font size="2" face="Arial, Helvetica, sans-serif"><b>TRANSPORTATION 
                              BY NON A/C INDICA.</b></font></td>
                            <td height="2" width="49%">&nbsp;</td>
                            <td height="2" width="14%">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="3" height="2"> 
                              <div align="center"><font face="Arial, Helvetica, sans-serif"><b><font color="#0000FF"> 
                                ******************** ENGLISH SPEAKING GUIDE AT 
                                AGRA - COMPLIMENTARY *******************</font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td width="37%" height="2">&nbsp;</td>
                            <td height="2" width="49%"><font face="Arial, Helvetica, sans-serif" size="2">(* 
                              Govt. service tax levied inclusive)</font> </td>
                            <td height="2" width="14%">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td width="37%" height="2">&nbsp;</td>
                            <td height="2" width="49%">&nbsp;</td>
                            <td height="2" width="14%">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="3" height="2"> 
                              <div align="justify"> <b><font size="2" face="Arial, Helvetica, sans-serif">NOTE 
                                : Mileage and time would be calculated from garage 
                                to garage. All applicable tool taxes would be 
                                charged as actuals. Above rates are subject to 
                                change without prior notice, in case of fuel hike. 
                                <u><font color="#FF6666">Outstation run of 200 
                                kms per day minimum would be charged</font> service 
                                tax of Rs. 5% will be included in the car tariff 
                                itself.</u></font></b> 
                                <p><font face="Arial, Helvetica, sans-serif" size="2"><b>Please 
                                  let us know if any specific outstation itineraries 
                                  are required by your client, So we may provide 
                                  you with the relevant details. Hotel reservation 
                                  can also be confirmed if required for stay outstation.</b></font></p>
                              </div>
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
                <td width="2%">&nbsp;</td>
                <td colspan="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update310102.asp"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="36%"> 
                  <div align="right"><a href="updatehotel.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="2%">&nbsp;</td>
                <td colspan="3"> 
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
