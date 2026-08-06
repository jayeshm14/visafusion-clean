<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
<%

country=request("country")
category=request("category")
%>
<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css">
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
-->
</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="MM_preloadImages('images/logonn2.gif','images/homen2.gif','images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif')">
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
                <td width="11%"><a href="Default.asp"><img src="images/homen1.gif" width="99" height="20" border="0" name="Image7" onMouseOver="MM_swapImage('Image7','','images/homen2.gif',1)"></a></td>
                <td width="12%"><a href="profile.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)"><img src="images/profilen1.gif" width="102" height="20" name="Image1" border="0"></a></td>
                <td width="12%"><a href="update.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)"><img src="images/updaten1.gif" width="102" height="20" name="Image2" border="0"></a></td>
                <td width="12%"><a href="registration.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" border="0"></a></td>
                <td width="12%"><a href="contactus.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)"><img src="images/contactn1.gif" width="102" height="20" name="Image4" border="0"></a></td>
                <td width="12%"><a href="queries.asp"><img src="images/queriean3.gif" width="101" height="20" name="Image5" border="0"></a></td>
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
                <td width="49%"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td width="1%" height="104"><img src="images/pixel.gif" width="33" height="13"></td>
                      <td width="99%" height="104"> 
                        <form method="post" action="getqueries.asp" name="queries">
                          <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tr> 
                              <td colspan="2" height="26"><span class="WSRightBold"> 
                                <font face="Verdana" size="2"><b><font color="#0000FF">VISA 
                                REQUIREMENTS FOR INDIAN NATIONALS:</font></b> 
                                </font></span></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td><span class="WSRightBold"><font face="Verdana" size="2"><b><font color="#FF0033">COUNTRY 
                                : </font></b></font></span></td>
                              <td><span class="WSRightBold"> 
                                <select size="1" name="countrylist">
                                  <%
                                             Call LoadListBox("Embassy",0)
                                             %> 
                                </select>
                                </span></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td><span class="WSRightBold"><font face="Verdana" size="2"><b><font color="#FF0033">CATEGORY 
                                :</font></b></font></span></td>
                              <td><span class="WSRightBold"> 
								<input type="hidden" name="countryFor" value="1">
                                <select name="category" size="1">
                                  <%
                                             Call LoadListBox("Category",4)
                                             %> 
                                </select>
                                </span></td>
                            </tr>
                            <tr>
                              <td align="center" colspan="2">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="center" colspan="2"> 
                                <input type="submit" name="submit" value="Get Information" class="ud">
                              </td>
                            </tr>
                            <tr> 
                              <td align="center" colspan="2">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="center" colspan="2"><span class="WSRightBold"> 
                                </span> 
                                <p align="center"><span class="WSRightBold"><font color="#FF0000" face="Verdana" size="2"><b>FOR 
                                  SPECIFIC VISA CASE / DOCUMENTATION QUERIES </b></font><b><font face="Verdana" size="2"><a href="contactus.asp"><font color="#0000FF">CLICK 
                                  HERE</font></a></font></b></span></p>
                                <p align="center"><span class="WSRightBold"><font face="Verdana" size="2"><b><font color="#FF0000">FOR 
                                  VISA APPLICATION FORMS CONTACT</font><br>
                                  <font color="#0000FF">&quot; <a href="contactus.asp">UDAAN</a> 
                                  &quot;</font></b></font></span></p>
                              </td>
                            </tr>
                          </table>
                        </form>
                      </td>
                    </tr>
                    <tr> 
                      <td width="1%" height="2"><img src="images/pixel.gif" width="33" height="14"></td>
                      <td width="99%" height="2"> 
                        <div align="center"><map name="Map2"><area shape="poly" coords="35,30,48,8,62,30" href="k"><area shape="poly" coords="77,54,64,79,93,81" href="r"><area shape="poly" coords="17,57,31,80,3,83" href="m"></map></div>
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="51%"> 
                  <div align="center"><img src="images/world.jpg" WIDTH="339" HEIGHT="219"></div>
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
