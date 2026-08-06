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
<table width="760" border="0" cellspacing="0" cellpadding="0" align="left">
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
            <table width="96%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="681">&nbsp;</td>
                <td colspan="3" height="681"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="96%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="450" align="center" height="609" bgcolor="#CCFFCC">
                          <tr> 
                            <td height="7" bgcolor="#CCFFCC"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>6th December 2002 </font></i></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="7" bgcolor="#CCFFCC"> 
                              <div align="center"><font face="Arial" size="3"><b><font size="4" color="#660000"><i></i></font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" bgcolor="#CCFFCC"> 
                              <div align="center"><b><font size="5"><i><font color="#660000" face="Arial, Helvetica, sans-serif" size="6">FRANCE 
                                </font><font color="#660000" face="Arial, Helvetica, sans-serif"> 
                                </font></i></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="1"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="27" bgcolor="#CCFFCC"> 
                              <div align="JUSTIFY"><b><font face="Arial"><font size="4"><font size="2">"THE 
                                EMBASSY OF FRANCE" - NEW DELHI, AFTER A BRIEF 
                                MEETING WITH ALL THE RECOGNISED TRAVEL AGENTS 
                                ON THE 6TH OF DECEMBER 2002 HAS ANNOUNCED A FEW 
                                GUIDELINES TO BE FOLLOWED BY AGENTS FOR THE FRENCH 
                                SCHENGEN VISA </font></font></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" bgcolor="#CCFFCC"><b><font face="Arial"><font size="4" color="#660000">WITH 
                              EFFECT FROM 01 JANUARY 2003</font></font></b></td>
                          </tr>
                          <tr> 
                            <td height="33" bgcolor="#CCFFCC"> 
                              <table width="99%" border="0">
                                <tr> 
                                  <td width="6%" valign="top"> 
                                    <div align="left"><b><font face="Arial" size="2">1.</font></b></div>
                                  </td>
                                  <td width="94%"> 
                                    <div align="JUSTIFY"><b><font face="Arial" size="2">THE 
                                      VISA FEE WILL BE NON REFUNDABLE IRRESPECTIVE 
                                      OF THE VISA BEING DECLINED / WITHDRAWN.</font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"> 
                                    <div align="left"><b><font face="Arial" size="2">2.</font></b></div>
                                  </td>
                                  <td width="94%"> 
                                    <div align="JUSTIFY"><b><font face="Arial" size="2">THE 
                                      FEE DIFFERENCE WILL BE NON REFUNDABLE INCASE 
                                      OF FEE BEING SUBMITTED FOR A LONGTERM VISA 
                                      AND VISA IS APPROVED FOR A SHORTTERM (AS 
                                      PER VISA CONSUL'S DISCRETION)BY THE EMBASSY. 
                                      </font></b></div>
                                  </td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" bgcolor="#CCFFCC"><b><font face="Arial" size="2"><font size="4" color="#660000">WITH 
                              IMMEDIATE EFFECT</font></font></b></td>
                          </tr>
                          <tr > 
                            <td height="57" bgcolor="#CCFFCC"> 
                              <div align="justify"><b><font face="Arial" size="2">THE 
                                FOLLOWING ARE MANDATORY TO BE ENCLOSED ALONGWITH 
                                THE RELEVANT DOCUMENTS (OCCUPATION FINANCIAL, 
                                TAX AND BANK DOCUMENTS) FOR VISA SUBMISSION.</font><font face="Arial"><br>
                                <br>
                                <font size="4" color="#660000">FOR TOURIST VISAS 
                                : </font></font></b></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="64" bgcolor="#CCFFCC"> 
                              <table width="99%" border="0">
                                <tr> 
                                  <td width="6%" valign="top" height="2"><b><font face="Arial" size="2">1.</font></b></td>
                                  <td width="94%" height="2"><b><font face="Arial" size="2">RETURN 
                                    CONFIRMED AIR TICKET</font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">2.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2">HOTEL 
                                    CONFIRMATION </font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">3.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2"> 
                                    PROOF OF FOREIGN EXCHANGE ENDORSEMENT</font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">4.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2">OVERSEAS 
                                    HEALTH INSURANCE COVER FOR THE DURATION OF 
                                    STAY.</font></b></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" bgcolor="#CCFFCC"><b><font face="Arial" size="4" color="#660000">FOR 
                              BUSINESS VISAS :</font></b></td>
                          </tr>
                          <tr > 
                            <td height="15" bgcolor="#CCFFCC"> 
                              <table width="99%" border="0">
                                <tr> 
                                  <td width="6%" valign="top" height="2"><b><font face="Arial" size="2">1.</font></b></td>
                                  <td width="94%" height="2"> 
                                    <div align="justify"><b><font face="Arial" size="2">INVITATION 
                                      LETTER FROM THE COUNTERPART / ASSOCIATE 
                                      IN FRANCE EXPLAINING IN DETAIL THE PURPOSE 
                                      AND DURATION OF VISIT. (INVITATIONS WITHOUT 
                                      DETAILED INFORMATION WILL NOT BE ACCEPTED 
                                      BY THE MISSION).</font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">2.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2">DETAILED 
                                    COVERING LETTERS FROM THE COMPANY IN INDIA.</font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">3.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2"> 
                                    EVIDENCE OF STAY CONFIRMATION.</font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">4.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2"> 
                                    RETURN CONFIRMED AIR TICKET</font></b></td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">5.</font></b></td>
                                  <td width="94%"> 
                                    <div align="justify"><b><font face="Arial" size="2">OVERSEAS 
                                      HEALTH INSURANCE COVER FOR THE DURATION 
                                      OF STAY</font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td width="6%" valign="top"><b><font face="Arial" size="2">6.</font></b></td>
                                  <td width="94%"><b><font face="Arial" size="2">PROOF 
                                    OF FOREIGN EXCHANGE .</font></b></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" bgcolor="#CCFFCC"><b><font face="Arial" size="4" color="#660000">SPECIAL 
                              INSTRUCTIONS:-</font></b></td>
                          </tr>
                          <tr > 
                            <td height="2" bgcolor="#CCFFCC"> 
                              <div align="justify"><b><font face="Arial" size="2">THE 
                                EMBASSY OF FRANCE HAS ALSO IN PRINCIPLE INSTRUCTED 
                                THAT THE PASSENGERS HOLDING A FRENCH SCHENGEN 
                                VISA OR ANY OTHER SCHENGEN VISA WOULD NOT BE ALLOWED 
                                ENTRY BY THE NETHERLANDS IMMIGRATION.THEREFORE 
                                THE PAX SHOULD BE ADVISED NOT TO MAKE NETHERLANDS 
                                THE FIRST POINT OF ENTRY FROM THE COUNTRY OF ORIGIN 
                                UNLESS HOLDING A SCHENGEN VISA ISSUED BY THE NETHERLANDS 
                                EMBASSY / CONSULATE. </font></b></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update041202.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="600"> 
                  <div align="right"><a href="update101202.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
          <td> <!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
