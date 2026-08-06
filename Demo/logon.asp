<%
'if session("priv")="emp" then
'response.clear
'response.redirect "Administrator.asp?uname="&session("uname")
'end if
'if session("priv")="adm" then
'response.clear
'response.redirect "Employee.asp?uname="&session("uname")
'end if
'if session("priv")="agt" then
'response.clear
'response.redirect "Agent.asp?uname="&session("uname")
'end if
session.abandon
%>
<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
<SCRIPT language=Javascript>  
function initArray(n) {

this.length = n; 
for (var i =1; i <= n; i++) 
{ this[i] = ' ' }
 } 
slide = new initArray(2);
 slide[0]="Welcom to Udaan India Private Limited: Visa ! Come Get It:" ;
 slide[1]="www.udaanindia.com:" ;
 var delay1 = 3; 
 var delay2 = 3; 
 var text = slide[0] + " " ;
 var str = " " ;
 var leftmsg = ""; 
 var nextmsg = 0; 
 
 function setMessage() 
 { 
 if (str.length == 1) 
 	{ while (text.substring(0, 1) == " ") 
		{ 
			leftmsg += str; 
			str = text.substring(0, 1); 
			text = text.substring(1, text.length); 
		} 
	 leftmsg += str; 
	 str = text.substring(0, 1) ;
	 text = text.substring(1, text.length) ;
	 for (var x = 0; x < 120; x++) 
	 	{ str = " " + str }; 
	} 
 else 
 	{ 	
		str = str.substring(10, str.length) ;
	} 
	window.status = leftmsg + str; 
if (text == "") 
	{ 
	str = " " ;
	nextmsg++ ;
		if (nextmsg > slide.length) 
			{ 
				nextmsg = 0; 
			} 
	text = slide[nextmsg] + " " ;
	leftmsg = "" ;
	setTimeout('setMessage()',delay2); 
	} 
else 
	{ 
	setTimeout('setMessage()',delay1); 
	} 
} 
setMessage();
</SCRIPT>
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
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
input.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 9pt; font-style: normal; background-color: #FFBC48; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif"  onLoad="document.form1.username.focus();MM_preloadImages('images/homen2.gif','images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif')">
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
                <td width="11%"><a href="Default.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','images/homen2.gif',1)"><img src="images/homen1.gif" width="99" height="20" border="0" name="Image7"></a></td>
                <td width="12%"><a href="profile.asp"><img src="images/profilen1.gif" width="102" height="20" name="Image1" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="update.asp"><img src="images/updaten1.gif" width="102" height="20" name="Image2" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="registration.asp"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="contactus.asp"><img src="images/contactn1.gif" width="102" height="20" name="Image4" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="queries.asp"><img src="images/queriean1.gif" width="101" height="20" name="Image5" onMouseOver="MM_swapImage('Image5','','images/queriean2.gif',1)" border="0"></a></td>
                <td width="11%"><a href="logon.asp"><img src="images/logonn4.gif" width="100" height="20" name="Image6" border="0"></a></td>
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
          <td><img src="images/threei.gif" width="760" height="26" usemap="#MapMap" border="0"><map name="MapMap"><area shape="rect" coords="329,2,436,24"><area shape="rect" coords="461,1,597,24"><area shape="rect" coords="619,2,720,24"></map></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="48%" height="154"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td width="1%" height="46"><img src="images/pixel.gif" width="33" height="13"></td>
                      <td width="99%" height="46"><span class="WSRightBold"> 
                        <div align="justify"><span class="WSRightBold"><marquee scrollamount = 5,scrolldelay= 5><font face="Verdana" size="2">Welcome 
                          to the India's most agile and rapid visa facilitation 
                          service agency.</font></marquee></span> </div>
                        </span></td>
                    </tr>
                    <tr> 
                      <td width="1%"><img src="images/pixel.gif" width="33" height="14"></td>
                      <td width="99%"> 
                        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#8A322E">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFF3CA">
                                <form method="post" action="authenticate.asp" name="form1">
                                  <tr> 
                                    <td width="34%"> 
                                      <div align="right"><b><font face="Verdana" size="2">USER 
                                        ID</font></b></div>
                                    </td>
                                    <td width="1%"><b><font face="Arial, Helvetica, sans-serif" size="2">:</font></b></td>
                                    <td width="65%"> 
                                      <input type="text" name="username">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="34%"> 
                                      <div align="right"><b><font face="Verdana" size="2">PASSWORD</font></b></div>
                                    </td>
                                    <td width="1%"><b><font face="Arial, Helvetica, sans-serif" size="2">:</font></b></td>
                                    <td width="65%"> 
                                      <input type="password" name="pass">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3"> 
                                      <div align="center"> 
                                        <input class="ud" type="submit" name="Submit" value="Logon">
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3"> 
                                      <div align="center"><span class="wsrightbold"><font face="Verdana">For 
                                        new Registration<a href="registration.asp"> 
                                        click here</a></font></span><span class="wsrightbold"><font face="Verdana"> 
                                        </font></span></div>
									
                    
                                    </td>
                                  </tr>
                                </form>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="52%" height="154"> 
                  <div align="center"><img src="updateimg/bluebirdie.gif" width="74" height="52"></div>
                </td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td width="100%" colspan="2"> 
                  <div align="justify"><marquee><font size="2" face="Verdana"></font> 
                    <table width="102%">
                      <tr> 
                        <td width="15%" height="2"><img src="updateimg/udaan%20logo%201.jpg" width="114" height="36" align="texttop"></td>
                        <td width="85%" height="2" valign="middle"> 
                          <div align="left"><font size="2" face="Verdana"><b><br>
                            Hassle free visa facilitation to fly abroad. Contact 
                            Udaan @ 011 - </b></font> <font size="2" face="Verdana"></font><font size="2" face="Verdana"><b>26182402&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></div>
                        </td>
                      </tr>
                    </table>
                    <font size="2" face="Verdana"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></marquee></div>
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
</BODY>
</HTML>
