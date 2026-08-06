
<%
'	set rshit=server.createobject("adodb.recordset")
'	stmt="select hits from  hits"
'	rshit.open stmt,con,2,3
'dim hits
'if not rshit.eof then
'    hits=cdbl(rshit("hits"))
'	hits=hits+1
'	rshit("hits")=hits
'	rshit.update
'end if
'rshit.close
%>
<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta NAME="Description" CONTENT="Udaan India pvt. Ltd. - Visa Processing in india &amp; Visa facilitation for indians, india travel, tour and travel in india, north and south india tourism, hotel reservations in india, visa services, visa facilitys in india, visa requirements, embassy holidays, udaan india, uma shankar bhardwaj.">
<meta NAME="Keywords" CONTENT="visa processing, visa services, visa requirements, udaan india, embassy holidays, india tours, tours in india, tours and travel in india, package tour of india, india tour packages, tours to india, travel packages in india, india travel packages, indian travel agents, tour operators in india, travelling in india, tourism in india, special interest tours, indian hotel reservation, hotel reservations in india, north india tours, south india tourism, tourist destinations, visit india, visa services from india, visa for india, taylor made tour to india, indian tour operators, package tours in india, adventure tours, cultural tours, safari tours travels, beach holidays in goa, Uma Shankar Bhardwaj">
<meta NAME="robots" CONTENT="index,follow">
<meta NAME="Author" CONTENT="Uma Shankar Bhardwaj, usbhardwaj@udaanindia.com">
<style>.spanstyle {COLOR: red; FONT-FAMILY: Verdana; FONT-SIZE: 10pt; FONT-WEIGHT: bold; POSITION: absolute; TOP: -50px; VISIBILITY: visible}
</style>
<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
<TITLE>JavaScriptBank.com -> JavaScript -> Status-Title Bar -> Typing Text in Status bar</title></head>
<body>
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
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>
</head>
<!--onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logonn2.gif')"-->
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="makesnake();MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logonn2.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td> 
      <table width="765" border="0" cellspacing="0" cellpadding="0" align="left">
        <tr> 
          <td><img src="images/topn1.jpg" width="760" height="71"></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="1%"><img src="images/whitw.gif" width="13" height="20"></td>
                <td width="11%"><a href="Default.asp"><img src="images/homenf1.gif" width="99" height="20" border="0"></a></td>
                <td width="12%"><a href="profile.asp"><img src="images/profilen1.gif" width="102" height="20" name="Image1" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)" border="0"></a></td>
                <td width="12%"><a href="update.asp"><img src="images/updaten1.gif" width="102" height="20" name="Image2" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)" border="0"></a></td>
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
                <td width="48%"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td width="1%" height="184"><img src="images/pixel.gif" width="33" height="13"></td>
                      <td width="99%" height="184"> 
                        <div align="justify">&nbsp;&nbsp;&nbsp;&nbsp;<i><b><font face="Arial, Helvetica, sans-serif" color="#0000FF">Today 
                          </font></b></i><font size="2"><i> is an era wherein 
                          Cyber has already made its presence --- where new technologies 
                          have made all forms of communications inexpensive, individual, 
                          instantaneous and interactive. These technologies have 
                          totally changed the way we work and live, and the speed 
                          of this transformation is ever accelerating. <br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          The future is no more to be an extension of past, and 
                          success lies in developing new methods and strategies. 
                          Over the years, <b>Udaan</b> has built bridges of information, 
                          contacts and opportunities, and these have been invaluable 
                          in developing the competetiveness of Udaan. <br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          In an effort to serve you even better - We now assume 
                          a key role in Visa facilitation, a role that depends 
                          on our agile services and innovation, in terms of bringing 
                          this website to you. Doing business in this century 
                          is about Speed --- reduced processing time, rapid operation 
                          cycles and very importantly immediate access to informations.<br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          Being influenced by these new dynamics, we bring to 
                          you this site which enables you to browse and find the 
                          necessary Visa requirements - for specific categories, 
                          to be update with whats latest in the Visa Vocation. 
                          Above all reach your own home page, wherein you can 
                          check the status of your cases / documents without having 
                          to call us or await our case reports. <br>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                          We are happy to share this with you, as for us It is 
                          the start of a new journey and a new adventure &#133;</i></font></div>
                      </td>
                    </tr>
                    <tr> 
                      <td width="1%"><img src="images/pixel.gif" width="33" height="14"></td>
                      <td width="99%"> 
                        <div align="center"><map name="Map2"><area shape="poly" coords="35,30,48,8,62,30" href="k"><area shape="poly" coords="77,54,64,79,93,81" href="r"><area shape="poly" coords="17,57,31,80,3,83" href="m"></map></div>
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="52%" valign="top" align="left"> 
                  <div align="left"> 
                    <table width="86%" border="0" height="320">
                      <tr> 
                        <td height="83"> 
                          <div align="center"></div>
                        </td>
                      </tr>
                      <tr> 
                        <td height="122"> 
                          <div align="center"><img src="images/world.jpg" width="339" height="219"></div>
                        </td>
                      </tr>
                    </table>
                    <br>
                  </div>
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
