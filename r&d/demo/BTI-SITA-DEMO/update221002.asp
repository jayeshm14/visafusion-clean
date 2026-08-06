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
                <td width="21" height="123">&nbsp;</td>
                <td colspan="3" height="123"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="96%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="99%" border="0" bgcolor="#CCFFCC">
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>22nd October 2002 </font></i></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><img src="updateimg/usany.jpg" width="645" height="100"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="6" face="Georgia, Times New Roman, Times, serif">U.S.A.</font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="6"> 
                              <div align="justify"> 
                                <p><b><font face="Arial" size="2">EFFECTIVE NOVEMBER 
                                  1, 2002, THE U.S. DEPARTMENT OF STATE IS RAISING 
                                  THE WORLDWIDE NONIMMIGRANT VISA FEE FROM $ 65 
                                  TO $ 100. </font></b></p>
                                <p><b><font face="Arial" size="2">THIS ADJUSTMENT 
                                  WILL BRING THE FEE INTO LINE WITH THE ACTUAL 
                                  COSTS OF ADMINISTERING NONIMMIGRANT VISA SERVICES.</font></b></p>
                                <p><b><font face="Arial" size="2">ADDED SECURITY 
                                  SCREENING PROCEDURE, RESTRICTIONS ON THE ROLE 
                                  OF SUPPORT STAFF, AND FURTHER INCREASES IN MANAGEMENT 
                                  OVERSIGHT HAVE ADDED TO THE COST OF NONIMMIGRANT 
                                  VISA PROCESSING. </font></b><b><font face="Arial" size="2"><br>
                                  &nbsp; </font></b></p>
                              </div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <table width="99%" border="0">
                                <tr bgcolor="#CCFFFF"> 
                                  <td height="2" width="50%"><font size="2"><b><font face="Arial">NON-IMMIGRANT 
                                    VISA APPLICATION FEE </font></b></font></td>
                                  <td height="2" width="17%"><font size="2"><b><font face="Arial">US 
                                    $ 100</font></b></font></td>
                                  <td height="2" width="33%"><font size="2"><b><font face="Arial">RS. 
                                    4900.00</font></b></font></td>
                                </tr>
                                <tr bgcolor="#FFCCFF"> 
                                  <td height="2" width="50%"><font size="2"><b><font face="Arial">NON-IMMIGRANT 
                                    VISA ISSUANCE FEE </font></b></font></td>
                                  <td height="2" width="17%"><font size="2"><b><font face="Arial">US 
                                    $ 75</font></b></font></td>
                                  <td height="2" width="33%"><font size="2"><b><font face="Arial">RS. 
                                    3675.00</font></b></font></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="JUSTIFY"><font face="Arial" size="2"><b><font color="#FF0033">FEES 
                                WILL BE ACCEPTED BY DEMAND DRAFT DRAWN IN FAVOUR 
                                OF ''AMERICAN EMBASSY'' PAYABLE AT NEW DELHI.</font></b></font></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="6" face="Georgia, Times New Roman, Times, serif">JORDAN</font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="justify"><b><font face="Arial" size="2">WITH 
                                IMMEDIATE EFFECT THE VISITORS VISA COLLECTION 
                                WILL BE GIVEN NEXT DAY AND TRANSIT VISA COLLECTION 
                                WILL BE GIVEN THIRD DAY BY THE VISA SECTION OF 
                                'EMBASSY OF THE HASHEMITE KINGDOM OF JORDAN' - 
                                NEW DELHI.</font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="6" face="Georgia, Times New Roman, Times, serif">POE</font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="justify"> 
                                <p><font face="Arial" size="2"><b>AS PER RECENT 
                                  NOTIFICATION FROM THE 'PROTECTORATE OF EMMIGRANTS' 
                                  - WITH EFFECT FROM 28TH NOVEMBER 2002, A PROCESSING 
                                  FEE OF RS. 100/- WILL BE CHARGED FOR THE POE 
                                  SUSPENSION IN PASSPORT.</b></font></p>
                                <p><b><font face="Arial" size="2">ALSO THE REVISED 
                                  FEE FOR THE ECNR FOR EMPLOYMENT WILL BE RS. 
                                  200/- INSTEAD OF RS. 100/- CHARGED EARLIER. 
                                  </font></b></p>
                                <p><b><font face="Arial" size="2">KINDLY BE APPRISED 
                                  THAT THE ABOVE ARE IN ADDITION TO THE CHARGES 
                                  PAID TO OUR AUTHORISED AGENTS FOR POE SUSPENSION. 
                                  </font></b></p>
                              </div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <hr>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="6" face="Georgia, Times New Roman, Times, serif">SAUDI</font></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td colspan="6" height="2"> 
                              <p align="JUSTIFY"><font face="Arial" size="2"><b>AS 
                                PER RECENT NOTIFICATION FROM 'ROYAL EMBASSY OF 
                                SAUDI ARABIA ' - NEW DELHI, THE INVITATION FROM 
                                SAUDI ASSOCIATE SHOULD BE IN FORMAT AS GIVEN HEREBELOW 
                                :</b></font></p>
                              <p align="left"><b><font face="Arial" size="2">TO 
                                DOWNLOAD THE NEW INVITATION FORMAT PLEASE CLICK 
                                ON LINK </font></b></p>
                              <p align="left"><b><font face="Arial" size="2"><img src="http://www.ttsvisas.com/images/wwwgdl.gif"> 
                                <a href="http://www.udaanindia.com/updateimg/saudiinv.pdf" target="_blank">FORMATE 
                                </a></font></b></p>
                              <p>&nbsp;</p>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update121002.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="600"> 
                  <div align="right"><a href="update021102.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
