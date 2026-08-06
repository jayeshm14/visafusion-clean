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
                <td width="21" height="1130">&nbsp;</td>
                <td colspan="3" height="1130"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="433"> 
                        <table width="677" border="1" align="center" bordercolor="#0000FF" height="1223" bgcolor="#F0F7FF">
                          <tr> 
                            <td height="1247"> 
                              <table width="678" align="center" height="1207" bordercolor="#3333FF">
                                <tr> 
                                  <td height="134" colspan="2"> 
                                    <div align="justify">
                                      <table width="100%" height="8">
                                        <tr> 
                                          <td width="6%" height="41"><img src="updateimg/bird76.gif" width="39" height="56"></td>
                                          <td width="94%" height="41"> 
                                            <table width="100%">
                                              <tr>
                                                <td height="32" width="43%"> 
                                                  <div align="center"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="44" height="24"></font></b></font></div>
                                                </td>
                                                <td height="32" width="57%">
                                                  <div align="center"><font size="2"><b><font face="Arial"><img src="images/alert1.gif" width="44" height="24"></font></b></font></div>
                                                </td>
                                              </tr>
                                            </table>
                                            <p><font face="Verdana" size="3"><i><b><font color="#FF3300">Lets 
                                              join hands to &quot;sail smoothly&quot; 
                                              through the &quot;Heavy Leisure 
                                              Season&quot;</font></b></i></font></p>
                                          </td>
                                        </tr>
                                      </table>
                                      <font face="Verdana" size="2"><b><font size="3"><br>
                                      Dear Travel Partners, </font></b><br>
                                      <br>
                                      To ease out the visa processing, we request 
                                      you to kindly make the Demand Drafts favouring 
                                      the respective embassy and send along with 
                                      the duly filled in visa application form<br>
                                      Kindly note that the visa fee is <b>NON 
                                      REFUNDABLE</b> </font></div>
                                  </td>
                                </tr>
                                <tr valign="top"> 
                                  <td height="1020" colspan="2"><font size="4"><b><font size="2" face="Verdana"> 
                                    </font></b></font> 
                                    <table width="100%" height="8" border="1" bordercolor="#666666">
                                      <tr bordercolor="#FF0033" bgcolor="#CCCCFF" border="1"> 
                                        <td height="18" width="16%"> 
                                          <div align="center"><b><font face="Verdana" size="2">Name 
                                            Of The Embassy<br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                        <td height="18" width="29%"> 
                                          <div align="center"><b><font face="Verdana" size="2">D/D 
                                            Favouring <br>
                                            (Payable at New Delhi)<br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                        <td height="18" width="21%"> 
                                          <div align="center"><b><font face="Verdana" size="2">Fee 
                                            <br>
                                            (Single Entry)<br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                        <td height="18" width="14%"> 
                                          <div align="center"><b><font face="Verdana" size="2">Fee 
                                            <br>
                                            (Multiple Entry)<br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                        <td height="18" width="8%"> 
                                          <div align="center"><b><font face="Verdana" size="2">Urgent<br>
                                            <br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                        <td height="18" width="12%"> 
                                          <div align="center"><b><font face="Verdana" size="2">Urgent<br>
                                            <br>
                                            <br>
                                            </font></b></div>
                                        </td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Australia</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Australian 
                                          High Commission</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2500/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Newzealand</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Newzealand 
                                          Immigration Services </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">3600/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Canada</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Canadian 
                                          High Commission</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2600/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Taiwan</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Taipei 
                                          Economic And Cultural Center </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1700/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">3400/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">2550/-(SE)</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">5100/-(ME)</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Indonesia</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Indonesian 
                                          Embassy</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1575/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">3375/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Phillippines</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">The 
                                          Embassy Of Philipines</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2000/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">4000/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">U.S.A</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">American 
                                          Embassy</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">4400/-(Visa 
                                          Fee)<br>
                                          2200/-(Processing Fee)<br>
                                          </font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">United 
                                          Kingdom (U.K) </font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">British 
                                          High Commission </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">3100/-(6 
                                          Month)<br>
                                          5100/-(1 Year)<br>
                                          5950/-(2 Years)<br>
                                          7500/-(5 Years)<br>
                                          12750/-(10 Years)<br>
                                          6400/- (Work Visa)<br>
                                          </font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Netherland</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Royal 
                                          Netherlands Embassy </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2000/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Malaysia</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Malaysian 
                                          High Commission </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">650/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">1300/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Ethopia</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Ethiopian 
                                          Embassy</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1040/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Uganda</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Uganda 
                                          High Commission </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1400/- 
                                          (Visa Fee)<br>
                                          800/-(Processing Fee)<br>
                                          </font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Ireland</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of Ireland </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">4000/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">6400/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Brazil</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of Brazil </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">3500/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">1500/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">5500/-</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">2000/-</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Thailand</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Royal 
                                          Thai Embassy </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1250/-(Single 
                                          Entry)<br>
                                          2000/-(Double Entry)<br>
                                          3000/-(Triple Entry)<br>
                                          2500/-(Non-Immigrant) <br>
                                          </font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">6250/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Dubai</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">DVPC 
                                          A/C ABN Amro 2537893 (Payable at Mumbai)</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1582/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">3082/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Argentina</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of Argentine Republic</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2400/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Italy</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">VFS 
                                          A/C Italy Visa </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2100/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Norway</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Royal 
                                          Norwegian Embassy </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2000/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Sudan</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of Sudan </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2977/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Belgium</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of Belgium </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">600/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">2100/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">3000/-</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Nigeria</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Nigerian 
                                          High Commission </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">4860/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">5500/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">8500/-</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Ghana</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Ghana 
                                          High Commission </font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">1920/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">3840/-</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Switzerland</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">Embassy 
                                          of The Switzerland</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">2100/-</font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                      <tr bgcolor="#CCCCCC"> 
                                        <td height="2" width="16%"><font face="Verdana" size="2">Congo</font></td>
                                        <td height="2" width="29%"><font face="Verdana" size="2">The 
                                          Embassy Of The Democratic Republic Of 
                                          Congo</font></td>
                                        <td height="2" width="21%"><font face="Verdana" size="2">4500/-(3 
                                          Months)<br>
                                          9000/-(6 Months)<br>
                                          11500/-(6 Months)-First Time Traveller<br>
                                          18000/-(12 Months)<br>
                                          </font></td>
                                        <td height="2" width="14%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="8%"><font face="Verdana" size="2">&nbsp;</font></td>
                                        <td height="2" width="12%"><font face="Verdana" size="2">&nbsp;</font></td>
                                      </tr>
                                    </table>
                                    <font size="4"><br>
                                    </font> <font size="2" face="Verdana"><br>
                                    </font> 
                                    <div align="justify">
                                      <table width="100%" bordercolor="#6666FF" bgcolor="#E0E0E0" border="1">
                                        <tr>
                                          <td height="30">
                                            <div align="center"><font face="Verdana" color="#FF0000">FOR 
                                              FURTHER INFORMATION, KINDLY VISIT 
                                              US AT </font><font face="Verdana"><font color="#6666FF"><b><a href="http://www.udaanindia.com">(www.udaanindia.com)</a></b></font></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <font size="4"><font size="3"><br>
                                      </font></font> </div>
                                    <div align="justify"><font size="4"><br>
                                      </font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update030505.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update250505.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
            <!-- #include file="HomeBottom.asp" --></td>
        </tr>
        <tr> 
          <td>&nbsp; </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
