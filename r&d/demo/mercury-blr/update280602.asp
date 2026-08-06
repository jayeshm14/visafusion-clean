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
            <table width="787" border="0" cellspacing="0" cellpadding="0" height="469">
              <tr> 
                <td width="21">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" width="810"> 
                  <div align="center"><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">28th June 2002</font></i></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" width="810"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                           <td> 
                        <table border="0" width="100%">
                          <tr>
                            <td width="70%" colspan="2">
                              <p align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">MYANMAR</font></u></font></b></td>
                            <td width="30%" rowspan="4">
                              <p align="right"><img border="0" src="updateimg/myanmar.jpg" WIDTH="157" HEIGHT="157"></p>
                            </td>
                          </tr>
                          <tr>
                            <td width="70%" colspan="2">                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">AS 
                          PER RECENT NOTIFICATION FROM '<span class="WSRightBold">EMBASSY
                          OF THE UNION OF MYANMAR</span>' - NEW DELHI, WITH IMMEDIATE
                          EFFECT THE VISA 
                          FEE HAS BEEN CHANGED, THE VISA FEE WILL BE AS 
                          FOLLOWS.</font></b></div>
</td>
                          </tr>
                          <tr>
                            <td width="50%"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;BUSINESS VISA FEE</font></font></b></td>
                            <td width="20%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                        1510.00</font></b></font></td>
                          </tr>
                          <tr>
                            <td width="50%">&nbsp;<b><font color="#3333FF" face="Arial, Helvetica, sans-serif" size="2">&nbsp;* 
                        &nbsp;TOURIST VISA FEE</font></b></td>
                            <td width="20%"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                        1010.00</font></b></font></td>
                          </tr>
                        </table>

                      </td>
                    </tr>

                    <tr> 
                      <td> 
                        <table border="0" width="100%" height="89">
                          <tr>
                            <td width="70%" colspan="2" height="27">
                            </td>
                            <td width="30%" rowspan="4" height="85">
                              <p align="right"><img border="0" src="updateimg/senegal.jpg" WIDTH="157" HEIGHT="157"></p>
                            </td>
                          </tr>
                          <tr>
                            <td width="70%" colspan="2" height="31">                   
<p align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">SENEGAL</font></u></font></b>                   
</td>
                          </tr>
                          <tr>
                            <td width="70%" colspan="2" height="1"> <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">AS 
                          PER RECENT NOTIFICATION FROM '<span class="WSRightBold">EMBASSY
                                OF THE REPUBLIC OF SENEGAL</span>' - NEW DELHI, WITH IMMEDIATE
                          EFFECT THE VISA 
                          FEE HAS BEEN CHANGED, THE VISA FEE WILL BE AS 
                          FOLLOWS.</font></b></div></td>
                          </tr>
                          <tr>
                            <td width="50%" height="26">&nbsp;<b><font color="#3333FF" face="Arial, Helvetica, sans-serif" size="2">&nbsp;&nbsp;* 
                        &nbsp;VISA FEE (TOURIST / BUSINESS)</font></b></td>
                            <td width="20%" height="26">&nbsp;<font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              500.00</font></b></font></td>
                          </tr>
                        </table>

                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <table border="0" width="100%" height="1">
                          <tr>
                            <td width="23%" rowspan="14" height="1" valign="top" align="left"><br>
                              <br>
                              <img border="0" src="updateimg/australia1.jpg" WIDTH="157" HEIGHT="157"></td>
                            <td width="77%" colspan="2" height="31">
                              <p align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4" face="Arial, Helvetica, sans-serif" color="#840084">AUSTRALIA</font></u></font></b>
                            </td>
                          </tr>
                          <tr>
                                                        <td width="77%" colspan="2" height="63"><div align="JUSTIFY">
                                  <b><font size="2"><font face="Arial">AS
                                  PER RECENT NOTIFICATION FROM '<span class="WSRightBold">HIGH
                                  COMMISSION FOR AUSTRALIA</span> ' - NEW DELHI, WITH EFFECT FROM
                                  1st JULY 2002 THE REVISED VISA FEE WILL BE AS
                                  FOLLOWS.</font></font></b>
                                </div></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;VISITOR VISA SHORT STAY &lt; 3 MONTHS (FORM 48R)</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              2000.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;VISITOR VISA LONG STAY &gt; 3 MONTHS (FORM 48R)</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              2000.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;STUDENT VISA APPLICATION</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              9300.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;TBE VISA SHORT STAY - UP TO 3 MONTHS (456)</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              2000.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;TBE VISA LONG VALIDITY - ETA</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              2000.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;TBE VISA LONG STAY - 3 MONTHS TO 4 YEARS (1066)</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              4800.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;APPLICATION FOR TEMPORARY RESIDENCE (147)</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              4800.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;APPLICATION FOR RESIDENT RETURN VISA</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              3600.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;APPLICATION FOR RE-EVIDENCE OF RESI. RETURN</font></font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              2100.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><b><font color="#3333FF">&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;MIGRATION APPLICATION</font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2" color="#3333FF">
                              PACKAGE</font></b></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.&nbsp;
                              300.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><font color="#3333FF"><b>&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;APPLICATION FOR MIGRATION&nbsp;<br>
                              </font></b><font face="Arial, Helvetica, sans-serif" size="2">
                              (SPOUSE, PROSPECTIVE MARRIAGE, CHILD, PARENT,
                              REMAINING/AGED DEPENDENT RELATIVE, ENS, RSMS,
                              LABOUR AGREEMENT &amp; DISTINGUISHED TALENT)</font></font></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              34700.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="54%" height="1"><font color="#3333FF"><b>&nbsp;&nbsp;<font face="Arial, Helvetica, sans-serif" size="2">* 
                        &nbsp;APPLICATION FOR MIGRATION&nbsp;<br>
                              </font></b><font face="Arial, Helvetica, sans-serif" size="2">
                              (SKILLED-INDEPENDENT &amp; SKILLED-AUSTRALIAN
                              SPONSORED)</font></font></td>
                            <td width="23%" height="1"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#3333FF">Rs.
                              51500.00</font></b></font></td>
                          </tr>
                         
                          <tr>
                            <td width="100%" height="1" valign="top" align="left" colspan="3"><b><font face="Arial, Helvetica, sans-serif" size="2">NOTE
                              : THE ONLY ACCEPTABLE METHOD OF PAYMENT IS BY BANK
                              DRAFT IN INDIAN RUPEES ONLY FAVOURING 'AUSTRALIAN
                              HIGH&nbsp; COMMISSION, NEW DELHI.</font></b></td>
                          </tr>
                        </table>

                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <p align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">KUWAIT</font></u></font></b>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
<div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">
MEDICAL SLIP FROM THE EMBASSY IS NO LONGER REQUIRED FOR THE KUWAIT EMPLOYMENT VISA STAMPING. NOW THE MEDICALS CAN BE DONE
  FROM ANY GOVT. AUTHORISED DOCTORS AND THEN SEND FOR VISA STAMPING IN DELHI REST OF THE DOCUMENTS REMAINS THE SAME. ie. ONE PHOTO, AIR TKT., ORIGINAL VISA COPY AND PCC.</font></b></div> 
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                      <p align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u><font size="4">CHILE</font></u></font></b> 
                      </td>
                    </tr>
                    <tr> 
                      <td> 
<b><font face="Arial, Helvetica, sans-serif" size="2">THE
                      AUTHORITY LETTER FOR THE CHILE VISA STAMPING HAS TO BE DONE NOW 
                      ON RS. 50/- STAMP PAPER INSTEAD OF RS. 20/- STAMP PAPER.</font></b> 
 
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2" width="69"><b><font face="Arial, Helvetica, sans-serif"><a href="update140602.ASP"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="739" height="2"> 
                  <div align="right"><a href="update010702.asp"><img border="0" src="updateimg/next.jpg" WIDTH="70" HEIGHT="37"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2" width="810"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3" height="2"> 
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
