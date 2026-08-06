<%@ Language=VBScript %>
<%
response.buffer= true

if session("priv")="" or session("priv")= "guest" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="302">&nbsp;</td>
                <td colspan="3" height="302"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="550"> 
                        <table width="617" align="center" height="107" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="662" height="8"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="125" colspan="2"> 
                              <table width="100%" border="1" height="357">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="110"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><font face="Courier New" size="7"><b>Udaan-Update</b></font><br>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <table width="652" border="1" bgcolor="#00FFFF">
                                          <tr bordercolor="#000000" bgcolor="#333333"> 
                                            <td> 
                                              <div align="center">
                                                <table width="100%">
                                                  <tr>
                                                    <td><font face="Courier New" size="6"><b><font color="#00FFFF" size="4">The 
                                                      Place for Innovation</font></b></font></td>
                                                  </tr>
                                                </table>
                                                <font face="Courier New" size="6"><b><font color="#00FFFF" size="7"> 
                                                <font size="6">ITMA'07</font><br>
                                                <font size="4"><a href="http://www.itma.com" target="_blank"><font color="#33FFFF">www.itma.com</font></a></font><br>
                                                <font size="4">MUNICH 13-20 Sept</font></font></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p><font face="Courier New" size="4"><b>Greeting's 
                                          from D and D Travel Services (P) Ltd. 
                                          !!!!!!!!!</b><br>
                                          <br>
                                          <b>Highlights:-</b><br>
                                          <br>
                                          <font size="3">> Special Packages for 
                                          Exhibitors : Tour Code A<br>
                                          &gt; Airline: Lufthansa-DIRECT DELHI 
                                          MUNICH FLIGHT (NOT EVEN VIA FRANKFURT)<br>
                                          > Perfect Timings: Depart Delhi @ 0915 
                                          hrs & Arrive Munich @ 1405 Hrs // Depart 
                                          Munich @ 2025 hrs & Arrive Delhi @ 0720 
                                          hrs<br>
                                          > Accommodations: Hotel Park Inn -a 
                                          4 Star branded hotel (just 06 Kms from 
                                          Fair Ground with Excellent Train Connectivity) 
                                          </font><br>
                                          <br>
                                          </font></p>
                                        <table width="100%">
                                          <tr>
                                            <td> 
                                              <div align="center"><font face="Courier New"><b><font size="4">:: 
                                                ITMA Special Packages ::</font></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <br>
                                        <table width="100%" border="1">
                                          <tr bgcolor="#99CCFF"> 
                                            <td> 
                                              <div align="center"><font face="Courier New" size="4"><b>TOUR 
                                                PROGRAM</b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <table width="100%" border="1">
                                          <tr> 
                                            <td width="16%"> 
                                              <div align="center"><b><font size="2" face="Courier New">Date 
                                                / Day</font></b></div>
                                            </td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><b><font size="2" face="Courier New">Tour 
                                                Code - A 09N/10D </font></b><font size="2" face="Courier New">Exhibitor's 
                                                Special </font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><b><font size="2" face="Courier New">Tour 
                                                Code-B 04N/05D </font></b></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><b><font size="2" face="Courier New">Tour 
                                                Code - C 05N/06D </font></b></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><b><font size="2" face="Courier New">Tour 
                                                Code - D 04N/05D </font></b></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><b><font size="2" face="Courier New">Tour 
                                                Code - E 03N/04D </font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">12Sep/Wed</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Arrive 
                                                Munich</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Arrive 
                                                Munich</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Arrive 
                                                Munich</font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">13Sep/Thu</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">14Sep/Fri</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">15Sep/Sat</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">16Sep/Sun</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA Depart for INDIA </font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New">Arrive 
                                                Munich</font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">17Sep/Mon</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA Depart for INDIA </font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New">Arrive 
                                                Munich</font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">18Sep/Tue</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">19Sep/Wed</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%">
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">20Sep/Thu</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA Depart for INDIA </font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New">Visit 
                                                ITMA Depart for INDIA </font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"><font size="2" face="Courier New">21Sep/Fri</font></td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><font size="2" face="Courier New">Depart 
                                                for INDIA</font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font size="2" face="Courier New"></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <table width="100%" border="1">
                                          <tr bgcolor="#99CCFF"> 
                                            <td height="20"> 
                                              <div align="center"><font face="Courier New"><b><font color="#FF3300">TOUR 
                                                PACKAGE PRICE</font></b>(per person 
                                                in INR)</font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <table width="100%" border="1">
                                          <tr> 
                                            <td width="16%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">Twin 
                                                Sharing</font></b></font></div>
                                            </td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><b><font face="Courier New" size="2">133500/-</font></b></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">85400/-</font></b></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">94400/-</font></b></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">85400/-</font></b></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">76400/-</font></b></font></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="16%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">Single 
                                                Room Supplement </font></b></font></div>
                                            </td>
                                            <td width="19%" bgcolor="#CCCCCC"> 
                                              <div align="center"><b><font face="Courier New" size="2">36400/-</font></b></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">18500/-</font></b></font></div>
                                            </td>
                                            <td width="14%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">21900/-</font></b></font></div>
                                            </td>
                                            <td width="19%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">18500/-</font></b></font></div>
                                            </td>
                                            <td width="18%"> 
                                              <div align="center"><font color="#FF3300"><b><font face="Courier New" size="2">15100/-</font></b></font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <br>
                                        <br>
                                        <table width="100%" height="61" border="1">
                                          <tr> 
                                            <td bgcolor="#99CCFF" width="49%"> 
                                              <div align="center"><b><font face="Courier New" size="3">TOUR 
                                                PRICE INCLUDES</font></b></div>
                                            </td>
                                            <td bgcolor="#99CCFF" width="51%"> 
                                              <div align="center"><b><font face="Courier New" size="3">TOUR 
                                                PRICE DOES NOT INCLUDES</font></b></div>
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="49%" height="166"><font size="2" face="Courier New">&gt; 
                                              Return Economy Class Airfare on 
                                              LUFTHANSA.<br>
                                              &gt; Accommodation in Hotel PARK 
                                              INN (4 star).<br>
                                              &gt; Daily Buffet Breakfast.<br>
                                              &gt; Daily Indian Packed Lunch.<br>
                                              &gt; Daily Indian Dinner (preset 
                                              menu)<br>
                                              &gt; Airport-Hotel-Airport Transfers.<br>
                                              &gt; Daily Fairground Transfers.<br>
                                              &gt; Complimentary SIM Card (INCOMING 
                                              FREE)<br>
                                              &gt; Visa Fee & Handling Charges.<br>
                                              &gt; All Hotel Applicable Taxes<br>
                                              &gt; Airport Taxes. <br>
                                              &gt; Overseas Mediclaim.<br>
                                              &gt; Services of Tour Guide/Escort.<br>
                                              &gt; Attractive Travel Bag/Kit. 
                                              </font><br>
                                            </td>
                                            <td width="51%" height="166"> 
                                              <p><font size="2" face="Courier New">&gt; 
                                                Entrances Tickets.<br>
                                                &gt; Tips (04 EURO per day/per 
                                                person)<br>
                                                &gt; Personals Expenses like Mineral 
                                                Water, Telephone Calls, Laundry 
                                                and Wines etc.<br>
                                                &gt; Any increase in the rate 
                                                of Exchange leading to increase 
                                                in the land arrangements, which 
                                                may come into effect prior to 
                                                the departure. (Presently 01EURO 
                                                = 56 INR)<br>
                                                &gt; Anything not specifically 
                                                mention in "TOUR PRICE INCLUDES" 
                                                box.<br>
                                                <br>
                                                <br>
                                                </font></p>
                                              <p>&nbsp;</p>
                                              <p>&nbsp; </p>
                                            </td>
                                          </tr>
                                        </table>
                                        <br>
                                        <table width="100%">
                                          <tr>
                                            <td>
                                              <div align="center"><font face="Courier New" size="2"><b>For 
                                                any Further Detail Please feel 
                                                free to contact us.......<br>
                                                </b><br>
                                                <b>:: For Bookings & Further Details 
                                                ::</b><br>
                                                <br>
                                                CONTACT US<br>
                                                <br>
                                                <b>Delhi Office :- <br>
                                                09971697969(Nitin Kansal) <br>
                                                09971697968(Sumit Trivedi) <br>
                                                <br>
                                                D & D Travel Services Pvt. Ltd. 
                                                <br>
                                                # 358, Aggarwal City Mall <br>
                                                Near Mahindera Park, Pitampura, 
                                                <br>
                                                New Delhi - 110034 </b><br>
                                                <br>
                                                E-mail : <a href="mailto:del@discoveries4u.com">del@discoveries4u.com</a> 
                                                <br>
                                                ITMA Details: <a href="http://www.discoveries4u.com/itma.php">www.discoveries4u.com/itma.php</a> 
                                                </font> </div>
                                            </td>
                                          </tr>
                                        </table>
                                        <p><font face="Courier New" size="4"> 
                                          </font><font face="Verdana" size="3"><font size="2">************************************************************************</font></font><font face="Verdana" size="2"> 
                                          </font></p>
                                        </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="2"> 
                                            <div align="center"><font face="Courier New" size="4"><b>&quot;Co-operate 
                                              and support us, to serve you better</b></font> 
                                              <b><font face="Courier New">&quot;</font></b></div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><a href="http://www.udaanindia.com" target="_blank"><font color="#FF0000"><font color="#FF0033" size="2" face="Verdana"><b><font color="#333333" face="Courier New">For 
                                                more Information plz. log on to 
                                                http://www.udaanindia.com</font></b></font></font></a><b> 
                                                </b></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <b> </b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="652" height="8"></div>
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
                    <table width="98%" border="0" bgcolor="#CCCCCC" height="8">
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
          <td><!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
