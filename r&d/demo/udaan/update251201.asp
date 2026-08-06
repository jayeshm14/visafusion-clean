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
          <td><img src="images/threei.gif" width="760" height="26" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="328,2,435,24"><area shape="rect" coords="461,1,597,24"><area shape="rect" coords="619,2,720,24"></map></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="3%">&nbsp; </td>
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td width="3%">&nbsp; </td>
                <td colspan="2"><font face="Times New Roman, Times, serif" 
            size=6><b></b></font><b><u><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><font 
            face=Arial color=#000080 size=6> </font><font face=Arial 
            color=#000080 size=4>25st December 2001</font></u></b></td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td colspan="2"> 
                  <table height=1 cellspacing=0 cellpadding=0 width="99%" 
              border=0 bgcolor="#CCCCCC">
                    <tbody> 
                    <tr> 
                      <td width="67%" height=435> 
                        <table height=393 width="100%">
                          <tbody> 
                          <tr> 
                            <td valign=top align=left width="6%" height=53>&nbsp;<img border="0" src="updateimg/top_bullet.gif" width="11" height="13"></td>
                            <td valign=top align=left width="94%" height=53><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial><font color="#800080">COUNTRY 
                              JAMAICA : CAPITAL KINGSTON. :</font> JAMAICA OPEN 
                              ITS REPRESENTATION IN INDIA AT DELHI AT : <br>
                              FOUR SQUARE HOUSE, # 49 COMMUNITY CENTRE, NEW FRIEND'S 
                              COLONY, NEW DELHI 110 065. PH.: 011 - 683 2155. 
                              <span 
                        style="COLOR: red; mso-bidi-font-size: 10.0pt"><o:p> </o:p></span></font></span><font 
                        face="Arial, Helvetica, sans-serif" 
                        size=2><br>
                              &nbsp;</font> </font></b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=96>&nbsp;<img border="0" src="updateimg/top_bullet.gif" width="11" height="13"></td>
                            <td valign=top align=left width="94%" height=96><b><font size="2"><span 
                        style="mso-bidi-font-size: 10.0pt"><font face=Arial><font color="#800080">THE 
                              DOCUMENTS REQUIRED TO PROCESS THE VISA ARE :</font><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt"> VALID 
                              PASSPORT, 1 VISA APPLICATION FORM, 2 PHOTOGRAPHS, 
                              COVERING LETTER (ON THE BUSINESS LETTER HEAD) FROM 
                              THE APPLICANT STATING PURPOSE AND DURATION OF VISIT, 
                              INVITATION FROM KINGSTON / STAY CONFIRMATION, FOREIGN 
                              EXCHANGE DULY ENDORSED (MANDATORY), CONFIRMED RETURN 
                              AIR TICKET. </span></font></span></font></b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2>&nbsp;<img border="0" src="updateimg/top_bullet.gif" width="11" height="13"></td>
                            <td valign=top align=left width="94%" height=2><b><span style="mso-bidi-font-size: 10.0pt"><font size="2"><font 
                        face=Arial><font color="#800080">TIME TAKEN :</font><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt"> </span></font><font face="Arial"><span 
                        style="COLOR: black; mso-bidi-font-size: 10.0pt">48 - 
                              72 HRS. FEE : EQUIVALENT TO USD 20. </span></font></font></span></b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2>&nbsp;</td>
                            <td valign=top align=left width="94%" height=2>&nbsp;</td>
                          </tr>
                          <tr bgcolor="#000000"> 
                            <td valign=top align=left colspan="2" height=2><b><i><font 
            face="Times New Roman, Times, serif"><font 
            face="Verdana, Arial, Helvetica, sans-serif"><font face="Courier New, Courier, mono" color="#FFFFFF" size="3"><img border="0" src="updateimg/ast015.gif" width="30" height="28"></font></font></font></i><u></u></b><b><i><font 
            face="Times New Roman, Times, serif"><font 
            face="Verdana, Arial, Helvetica, sans-serif"></font></font></i><u><font face="Arial" color="#FFFFFF" size="4">HOLIDAYS 
                              LIST FOR DECEMBER 2001.</font></u><i><font 
            face="Times New Roman, Times, serif"><font 
            face="Verdana, Arial, Helvetica, sans-serif"></font></font></i><i><font 
            face="Times New Roman, Times, serif"><font 
            face="Verdana, Arial, Helvetica, sans-serif"><font face="Courier New, Courier, mono" color="#FFFFFF" size="3"><img border="0" src="updateimg/ast015.gif" width="30" height="28"></font></font></font></i><u></u></b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><u><b><font 
                        face=Courier color=#800080 size=3>DATE</font></b></u></td>
                            <td valign=top align=left width="94%" height=2><b><u><font face=Courier 
                        color=#800080 size=3>COUNTRY</font></u></b></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=15><span 
                        style="COLOR: black"><b><font face="Arial" size="2">26<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=15><span 
                        style="COLOR: black"><b><font face="Arial" size="2">TURKEY, 
                              NEW ZEALAND, CZECH, SWITZERLAND, GREECE, UNITED 
                              KINGDOM, GERMANY, DENMARK, AUSTRIA, SWEDEN, BULGARIA,</font></b></span></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">27<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NEWZELAND, 
                              TURKEY, DENMARK</b></font></b></span></font></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">28<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NEW 
                              ZEALAND, TURKEY, DENMARK</b></font></b></span></font></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">29<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NEW 
                              ZEALAND, JAPAN, TURKEY, DENMARK</b></font></b></span></font></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">30<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NEW 
                              ZEALAND, TURKEY, DENMARK</b></font></b></span></font></td>
                          </tr>
                          <tr> 
                            <td valign=top align=left width="6%" height=2><span 
                        style="COLOR: black"><b><font face="Arial" size="2">31<span 
                        style="mso-spacerun: yes"> </span>:</font></b></span></td>
                            <td valign=top align=left width="94%" height=2><font face="Arial, Helvetica, sans-serif" size="2"><span 
                        style="COLOR: black"><b><font face="Arial, Helvetica, sans-serif" size="2"><b>NEW 
                              ZEALAND, SPAIN, TURKEY, CHINA, DENMARK, SWEDEN, 
                              GERMANY, AUSTRIA</b></font></b></span></font></td>
                          </tr>
                          </tbody> 
                        </table>
                      </td>
                      <td valign=top width="33%" height=435 bgcolor="#000000"> 
                        <table height=1 width="100%" border=0>
                          <tbody> 
                          <tr> 
                            <td height=1><img border="0" src="updateimg/newyear.jpg" width="300" height="420"></td>
                          </tr>
                          </tbody> 
                        </table>
                        <div align="center"><font color="#000080"><b><font color="#FF0000">MERRY 
                          CHRISTMAS TO <br>
                          <br>
                          ALL OF YOU</font></b></font></div>
                      </td>
                    </tr>
                    <tr> </tr>
                    </tbody> 
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td width="47%"><b><font face="Arial, Helvetica, sans-serif"><a href="update011201.asp"><img src="updateimg/previous.jpg" border="0"></a></font></b></td>
                <td width="50%"> 
                  <div align="right"><a href="update040102.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a></div>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td colspan="2"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC">
                      <tr bgcolor="#FFCCCC"> 
                        <td colspan="3"> 
                          <div align="center"><u><font color="#0000FF" face="Arial, Helvetica, sans-serif"><b>GET 
                            OUR VISA UPDATES</b></font></u></div>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td width="26%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">NAME 
                          : </font> 
                          <input type="text" name="name" size="15" maxlength="70">
                          </b></td>
                        <td width="50%"><b> <font face="Arial, Helvetica, sans-serif" color="#FF0000">E. 
                          MAIL :</font> 
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          </b></td>
                        <td width="24%"> 
                          <input type="button" name="Submit2" value="REGISTER NOW" onClick="return reg()">
                        </td>
                      </tr>
                    </table>
                  </form>
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
