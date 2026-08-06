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
                <td width="21" height="787">&nbsp;</td>
                <td colspan="3" height="787"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="635"> 
                        <table width="669" border="1" align="center" bordercolor="#0000FF" height="561" bgcolor="#F0F7FF">
                          <tr> 
                            <td height="631"> 
                              <table width="511" align="center" height="671">
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">15th 
                                      October, 2004</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="1" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="647" height="1"></td>
                                </tr>
                                <tr> 
                                  <td height="142" colspan="2"> 
                                    <table width="633" border="0" cellpadding="0" height="74">
                                      <tr> 
                                        <td height="120" width="175"><img src="updateimg/singapore3.jpg" width="157" height="119"></td>
                                        <td height="120" width="293"> 
                                          <table width="138" border="0" cellpadding="0">
                                            <tr> 
                                              <td height="11"> 
                                                <table width="306" border="0" cellpadding="0" height="102">
                                                  <tr> 
                                                    <td width="142" height="117"><img src="updateimg/singapore%20flag.jpg" width="157" height="119"></td>
                                                    <td width="150" height="117"><img src="updateimg/switzerland%20flag.jpg" width="157" height="119"></td>
                                                    <td width="6" height="117">&nbsp;</td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                        <td height="120" width="157"><img src="updateimg/switzerland.jpg" width="157" height="119"></td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="647" height="1"></td>
                                </tr>
                                <tr> 
                                  <td height="25" colspan="2"> 
                                    <div align="center"><font face="Arial, Helvetica, sans-serif" size="4"><b><font color="#000099"><u>COLLECTION 
                                      ON THE THIRD WORKING DAY FOR A SINGAPORE 
                                      VISA </u></font></b></font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="43" colspan="2"> 
                                    <div align="justify"> 
                                      <p align="justify"><b><font face="Garamond" size="3" color="#FF0033">&quot;THE 
                                        EMBASSY OF THE REPUBLIC OF SINGAPORE&quot; 
                                        - NEW DELHI</font><font face="Garamond" size="3" color="#FFFF00"> 
                                        </font><font face="Garamond" size="3">HAS 
                                        <font color="#0000FF">NOTIFIED THAT FROM 
                                        OCTOBER 15, 2004, THE PROCESSING TIME 
                                        FOR AN ENTRY VISA IS THREE WORKING DAYS. 
                                        SUBMISSION OF VISA APPLICATIONS CAN BE 
                                        MADE BETWEEN 09:30 A.M. TO 12:30 P.M. 
                                        ON ANY WEEK DAYS EXCEPTS ON WEEKNENDS 
                                        AND PUBLIC HOLIDAYS. COLLECTIONS OF PASSPORTS 
                                        IS ON THE THIRD WORKING DAY BETWEEN 02:00 
                                        P.M. TO 04:00 P.M.</font><br>
                                        <br>
                                        <font color="#333333">NOTE:-</font><font color="#0000FF"> 
                                        <font color="#FF0066"><u>THE EMBASSY IS 
                                        GOING TO ACCEPT ONLY A PARTICULAR QUOTA 
                                        OF APPLICATIONS PER DAY AND NO REQUEST 
                                        FOR A SAME DAY URGENT VISA WILL BE ENTERTAINED 
                                        BY THE AUTHORITIES.</u> </font> </font></font></b></p>
                                      <p align="justify"><font color="#0000FF"><b><font face="Garamond" size="3">AND 
                                        ALSO THE APPLICATION FORM SHOULD BE COMPLETELY 
                                        FILLED AND SIGNED TOGETHER WITH A RECENT 
                                        <font color="#FF0066">PASSPORT-SIZE PHOTOGRAPH( 
                                        35 MM WIDE BY 45 MM )</font> HIGH WITHOUT 
                                        BORDER AND TAKEN WITHIN THE LAST 3 MONTHS;TAKEN 
                                        FULL FACE WITHOUT HEADGEAR,UNLESS THE 
                                        APPLICANT HABITUALLY WEARS A HEADGEAR 
                                        IN ACCORDANCE WITH HIS/HER RELIGIOUS OR 
                                        RACIAL CUSTOM BUT THE HEADGEAR MUST NOT 
                                        HIDE THE APPLICANT'S FEATURES.</font><font face="Garamond" size="3" color="#333333"><font color="#FF0033">THE 
                                        FACIAL IMAGE MUST BE BETWEEN( 25 MM AND 
                                        35 MM ) FROM CHIN TO CROWN;TAKEN AGAINST 
                                        A PLAIN WHITE BACKGROUND WITH MATT OR 
                                        SEMI-MATT FINISH.</font></font></b></font></p>
                                      <p align="justify"><font color="#0000FF"><b><font face="Garamond" size="3">FURTHUR 
                                        TO NOTIFICATION, FAILURE TO ADHERENCE 
                                        TO THE ABOVE SPECIFIED INSTRUCTIONS WILL 
                                        RESULT IN NON-ACCEPTENCE OF THE VISA APPLICATION 
                                        FORM. THIS IS SO BECAUSE THE EMBASSY IS 
                                        COMING UP WITH THE CONCEPT OF PHOTO VISA. 
                                        </font><font face="Garamond" size="3"><br>
                                        </font></b> <b><font face="Garamond" size="3"></font></b></font><b><font face="Garamond" size="3"> 
                                        </font></b></p>
                                    </div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="647" height="1"></td>
                                </tr>
                                <tr> 
                                  <td height="2" colspan="2"> 
                                    <div align="center"><b><font face="Arial" size="4" color="#990099"><u><font color="#000099" face="Arial, Helvetica, sans-serif">SWISS 
                                      VISA FEE FOR CHILDREN WILL BE FULLY CHARGED...</font></u></font></b> 
                                      <table width="645" border="0" cellpadding="0">
                                        <tr>
                                          <td>
                                            <div align="justify"><font face="Garamond" size="3"><b><font color="#0000FF">WITH 
                                              IMMEDIATE EFFECT FROM OCTOBER 15, 
                                              2004, <font color="#FF0033">&quot;THE 
                                              EMBASSY OF SWITZERLAND&quot; - NEW 
                                              DELHI</font> HAS NOTIFIED THAT FROM 
                                              HENCEFORTH THE VISA APPLICATION 
                                              PROCESSING FEE FOR CHILDREN WILL 
                                              BE THE SAME AS THAT OF THE ADULTS. 
                                              <i><font color="#FF0033">I.E. RS. 
                                              2, 000/- PAYABLE IN CASH.</font></i></font></b></font></div>
                                          </td>
                                        </tr>
                                      </table>
                                    </div>
                                  </td>
                                </tr>
                                <tr > 
                                  <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="647" height="1"></td>
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
                <td width="21" height="48">&nbsp;</td>
                <td colspan="2" height="48"><b><font face="Arial, Helvetica, sans-serif"><a href="update041004.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="48" width="650"> 
                  <div align="right"><a href="update011104.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
