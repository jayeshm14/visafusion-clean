<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
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
          <td><img src="images/threei.gif" width="760" height="26" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="329,2,436,24" href="#"><area shape="rect" coords="461,1,597,24" href="#"><area shape="rect" coords="619,2,720,24" href="#"></map></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="48%"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td width="1%" height="104"><img src="images/pixel.gif" width="33" height="13"></td>
                      <td width="99%" height="104"> 
                        <form method="post" action="getqueries.asp" name="queries">
                          <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tr> 
                              <td colspan="2"><span class="WSRightBold"> VISA 
                                REQUIREMENTS FOR INDIAN NATIONALS : </span></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td><span class="WSRightBold">COUNTRY : </span></td>
                              <td><span class="WSRightBold"> 
                                <select size=1 name="countrylist">
                Embassy
                                  <option value=110 selected>AFGHANISTAN</option>
                                  <option value=111>ALBANIA</option>
                                  <option value=19>ALGERIA</option>
                                  <option value=112>ANGOLA</option>
                                  <option value=20>ARGENTINA</option>
                                  <option value=113>ARMENIA</option>
                                  <option value=202>ATTESTATION</option>
                                  <option value=21>AUSTRALIA</option>
                                  <option value=13>AUSTRIA</option>
                                  <option value=196>BAHAMAS</option>
                                  <option value=22>BANGLADESH</option>
                                  <option value=23>BELARUS</option>
                                  <option value=24>BELGIUM</option>
                                  <option value=180>BELIZE</option>
                                  <option value=114>BENIN</option>
                                  <option value=115>BHUTAN</option>
                                  <option value=116>BOLIVIA</option>
                                  <option value=117>BOSNIA & HERZEGOVINA</option>
                                  <option value=25>BRAZIL</option>
                                  <option value=26>BRUNEI DARUSSALAM</option>
                                  <option value=27>BULGARIA</option>
                                  <option value=28>BURKINA FASO</option>
                                  <option value=29>CAMBODIA</option>
                                  <option value=2>CANADA</option>
                                  <option value=7>CHILE</option>
                                  <option value=30>CHINA</option>
                                  <option value=6>COLOMBIA</option>
                                  <option value=181>COMOROS</option>
                                  <option value=31>CONGO</option>
                                  <option value=32>COSTA RICA</option>
                                  <option value=33>CROATIA</option>
                                  <option value=34>CUBA</option>
                                  <option value=35>CYPRUS</option>
                                  <option value=36>CZECH</option>
                                  <option value=37>DENMARK</option>
                                  <option value=182>DJIBOUTI</option>
                                  <option value=183>DOMINICA</option>
                                  <option value=198>ECNR-ONLY</option>
                                  <option value=119>ECUADOR</option>
                                  <option value=38>EGYPT</option>
                                  <option value=120>ERITREA</option>
                                  <option value=39>ESTONIA</option>
                                  <option value=40>ETHIOPIA</option>
                                  <option value=41>FINLAND</option>
                                  <option value=42>FRANCE</option>
                                  <option value=121>GABON</option>
                                  <option value=184>GAMBIA</option>
                                  <option value=185>GEORGIA</option>
                                  <option value=4>GERMANY</option>
                                  <option value=43>GHANA</option>
                                  <option value=5>GREECE</option>
                                  <option value=122>GRENADA</option>
                                  <option value=123>GUINEA</option>
                                  <option value=124>HOLY SEE</option>
                                  <option value=204>HONG KONG</option>
                                  <option value=44>HUNGARY</option>
                                  <option value=45>ICELAND</option>
                                  <option value=47>INDONESIA</option>
                                  <option value=48>IRAN</option>
                                  <option value=49>IRAQ</option>
                                  <option value=50>IRELAND</option>
                                  <option value=51>ISRAEL</option>
                                  <option value=52>ITALY</option>
                                  <option value=46>IVORY COAST</option>
                                  <option value=125>JAMAICA</option>
                                  <option value=3>JAPAN</option>
                                  <option value=53>JORDAN</option>
                                  <option value=54>KAZAKHSTAN</option>
                                  <option value=55>KENYA</option>
                                  <option value=9>KOREA-DPR</option>
                                  <option value=126>KOREA-REP-OF</option>
                                  <option value=107>KUWAIT</option>
                                  <option value=57>KYRGHYZSTAN</option>
                                  <option value=58>LAOS</option>
                                  <option value=186>LATVIA</option>
                                  <option value=59>LEBANON</option>
                                  <option value=127>LESOTHO</option>
                                  <option value=60>LIBYA</option>
                                  <option value=187>LITHUANIA</option>
                                  <option value=188>LUXEMBOURG</option>
                                  <option value=176>M.E.-ATTEST.</option>
                                  <option value=199>M.E.A.-ATTEST.</option>
                                  <option value=128>MADAGASCAR</option>
                                  <option value=189>MALAWI</option>
                                  <option value=61>MALAYSIA</option>
                                  <option value=129>MALDIVES</option>
                                  <option value=130>MALI</option>
                                  <option value=62>MALTA</option>
                                  <option value=65>MANGOLIA</option>
                                  <option value=63>MAURITIUS</option>
                                  <option value=205>MEET & ASSIST</option>
                                  <option value=64>MEXICO</option>
                                  <option value=131>MICRONESIA</option>
                                  <option value=190>MONACO</option>
                                  <option value=16>MONGOLIA</option>
                                  <option value=66>MOROCCO</option>
                                  <option value=222>MOZAMBIQUE</option>
                                  <option value=67>MYANMAR</option>
                                  <option value=68>NAMIBIA</option>
                                  <option value=191>NAURU</option>
                                  <option value=132>NEPAL</option>
                                  <option value=69>NETHERLAND</option>
                                  <option value=72>NEWZEALAND</option>
                                  <option value=192>NICARAGUA</option>
                                  <option value=133>NIGER</option>
                                  <option value=70>NIGERIA</option>
                                  <option value=71>NORWAY</option>
                                  <option value=206>NOT APPLICABLE</option>
                                  <option value=201>NOTARY</option>
                                  <option value=10>OMAN</option>
                                  <option value=12>PAKISTAN</option>
                                  <option value=134>PALESTINE</option>
                                  <option value=135>PANAMA</option>
                                  <option value=136>PAPUA NEW GUINEA</option>
                                  <option value=73>PERU</option>
                                  <option value=74>PHILIPPINES</option>
                                  <option value=197>POE-ONLY</option>
                                  <option value=75>POLAND</option>
                                  <option value=76>PORTUGAL</option>
                                  <option value=17>PPT SERVICE</option>
                                  <option value=137>QATAR</option>
                                  <option value=77>ROMANIA</option>
                                  <option value=15>ROME</option>
                                  <option value=78>RUSSIA</option>
                                  <option value=138>RWANDA</option>
                                  <option value=193>SAN MARINO</option>
                                  <option value=80>SAUDI ARABIA</option>
                                  <option value=81>SENEGAL</option>
                                  <option value=139>SEYCHELLES</option>
                                  <option value=82>SINGAPORE</option>
                                  <option value=83>SLOVAKIA</option>
                                  <option value=140>SOMALIA</option>
                                  <option value=79>SOUTH AFRICA</option>
                                  <option value=56>SOUTH KOREA</option>
                                  <option value=84>SPAIN</option>
                                  <option value=85>SRILANKA</option>
                                  <option value=86>SUDAN</option>
                                  <option value=141>SURINAM</option>
                                  <option value=142>SWAZILAND</option>
                                  <option value=87>SWEDEN</option>
                                  <option value=88>SWITZERLAND</option>
                                  <option value=89>SYRIA</option>
                                  <option value=90>TAIWAN</option>
                                  <option value=194>TAJIKISTAN</option>
                                  <option value=91>TANZANIA</option>
                                  <option value=92>THAILAND</option>
                                  <option value=195>TOGO</option>
                                  <option value=200>TRANSLATION</option>
                                  <option value=93>TRINIDAD&TOBAGO</option>
                                  <option value=143>TUNISIA</option>
                                  <option value=94>TURKEY</option>
                                  <option value=144>TURKMENISTAN</option>
                                  <option value=223>U.A.E.</option>
                                  <option value=145>U.A.E.-ATTEST</option>
                                  <option value=1>U.S.A.</option>
                                  <option value=95>UGANDA</option>
                                  <option value=106>UKRAINE</option>
                                  <option value=96>UNITED KINGDOM</option>
                                  <option value=98>URUGUAY</option>
                                  <option value=100>UZBEKISTAN</option>
                                  <option value=108>VATICAN</option>
                                  <option value=101>VENEZUELA</option>
                                  <option value=102>VIETNAM</option>
                                  <option value=103>YEMEN</option>
                                  <option value=104>YUGOSLAVIA</option>
                                  <option value=14>ZAMBIA</option>
                                  <option value=105>ZIMBABWE</option>
                                </select>
                                </span></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td><span class="WSRightBold">CATEGORY :</span></td>
                              <td><span class="WSRightBold"> 
                                <select name="category" size="1">
                Category<option value=10>ATTESTATION</option><option value=5>BUSINESS ME</option><option value=4 Selected>BUSINESS SE</option><option value=12>DEP WORK</option><option value=6>DEPENDENT</option><option value=18>JOININGVESSEL</option><option value=7>MIGRATION</option><option value=14>NON-IMMIGRANT</option><option value=2>OFFICIAL</option><option value=1>PPT RENEWAL</option><option value=16>RECOMMENDATION</option><option value=20>REFUND</option><option value=3>RELIGIOUS</option><option value=23>S.T. WORK</option><option value=19>S.T.R</option><option value=22>SEAMAN</option><option value=8>SOCIAL</option><option value=9>STUDENT</option><option value=21>SUPERNUMERARY</option><option value=11>TOURIST</option><option value=17>TRANSIT</option><option value=15>VISIT</option><option value=13>WORK</option> 
              </select>
                                </span></td>
                            </tr>
                            <tr>
                              <td align="center" colspan=2>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="center" colspan=2> 
                                <input type="submit" name="submit" value="Get Information" class="ud">
                              </td>
                            </tr>
                            <tr> 
                              <td align="center" colspan=2>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td align="center" colspan=2><span class="WSRightBold"> 
                                </span> 
                                <p align="left"><span class="WSRightBold"><font color="#FF0000">FOR 
                                  SPECIFIC VISA CASE / DOCUMENTATION QUERIES </font><a href="contactus.asp">ClLICK 
                                  HERE</a></span></p>
                                <p align="left"><span class="WSRightBold">FOR 
                                  VISA APPLICATION FORMS CONTACT <font color="#3333FF"><b>&quot; 
                                  UDAAN &quot;</b></font></span></p>
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
                <td width="52%"> 
                  <div align="center"><img src="images/world.jpg"></div>
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
