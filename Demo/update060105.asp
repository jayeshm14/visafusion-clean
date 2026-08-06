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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="394">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="1135">&nbsp;</td>
                <td colspan="3" height="1135"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="1093"> 
                        <table width="569" align="center" height="908" bgcolor="#FFFFFF" border="1" bordercolor="#000066">
                          <tr bgcolor="#333333"> 
                            <td height="6" colspan="2"> 
                              <div align="center"><font color="#99FF33"><img src="updateimg/Bird4.jpg" width="104" height="109"><b><font size="7"><i><font color="#FF6666">UPDATE</font></i></font></b> 
                                <font color="#FF6666"><i><font size="4"><b><font size="5">JANUARY 
                                06, 2005</font></b></font></i></font></font></div>
                              <div align="left"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="1" colspan="2"> <img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="650" height="2"></td>
                          </tr>
                          <tr > 
                            <td height="853" colspan="2"> 
                              <table width="100%" height="745">
                                <tr> 
                                  <td valign=top align=left height=839 colspan="3"> 
                                    <div align="left"> 
                                      <table width="100%" height="62">
                                        <tr bgcolor="#333333"> 
                                          <td height="32" width="65%"> 
                                            <div align="left"> 
                                              <table width="101%" height="109">
                                                <tr> 
                                                  <td width="53%" height="4"> 
                                                    <div align="left"> <img src="updateimg/communication1.gif" width="123" height="95"> 
                                                      <img src="updateimg/admin.gif" width="123" height="95"> 
                                                      <img src="updateimg/kavita.jpg" width="123" height="95"> 
                                                      <img src="updateimg/manish.jpg" width="123" height="95"> 
                                                      <img src="updateimg/documentation.gif" width="120" height="95"> 
                                                    </div>
                                                  </td>
                                                </tr>
                                              </table>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <table width="95%" height="667">
                                        <tr bgcolor="#333333" bordercolor="#0000FF"> 
                                          <td height="25"> 
                                            <div align="center"><b><font size="5" color="#3366FF">UDAAN 
                                              WELCOMES 2005 BY GOING ONLINE WITH 
                                              GALILEO INDIA AND SINGAPORE HIGH 
                                              COMMISSION...</font></b></div>
                                          </td>
                                        </tr>
                                        <tr bgcolor="#333333" bordercolor="#0000FF"> 
                                          <td height="537"> 
                                            <div align="justify"><font color="#FFFFFF" face="Garamond" size="4"><b>WE, 
                                              THE ENTIRE <font color="#00FFFF"><font color="#3366FF">"<u>UDAAN</u>&quot;</font> 
                                              <font color="#FFFFFF">TEAM</font> 
                                              </font> TAKES THE PRIVILEDGE TO 
                                              WISH YOU ALL A VERY HAPPY AND PROSPEROUS 
                                              NEW YEAR AHEAD! <br>
                                              <br>
                                              AT THE OUTSET OF THE YEAR WE ARE 
                                              PLEASED TO INFORM YOU THAT WE START 
                                              THIS NEW YEAR WITH A GREAT BASH 
                                              ANNOUNCING A GRAND TIE-UP WITH GALILEO 
                                              INDIA. THIS MEANS EASY ACCESS TO 
                                              FREE INFORMATION TO YOU ALL OUT 
                                              THERE…NOT ONLY OUR REGISTERED AGENTS 
                                              BUT ALSO THOSE WHO ARE REGISTERED 
                                              GALILEO USERS. FOR FURTHER INFORMATION 
                                              CLICK ON THE LINK:<br>
                                              <br>
                                              </b></font> </div>
                                            <table width="600%" height="81">
                                              <tr> 
                                                <td height="95"> 
                                                  <div align="left"><a href="http://www.udaanindia.com/forms/Galileo%20Users.pdf"><img src="updateimg/logo_gal_col.gif" width="152" height="124" border="0"></a> 
                                                    <a href="http://www.udaanindia.com/forms/Galileo%20Users.pdf"><img src="updateimg/logo_galileo.gif" width="152" height="124" border="0"></a> 
                                                    <a href="http://www.udaanindia.com/forms/Galileo%20Users.pdf"><img src="updateimg/logo_gal_col.gif" width="152" height="124" border="0"></a> 
                                                    <a href="http://www.udaanindia.com/forms/Galileo%20Users.pdf"><img src="updateimg/logo_galileo.gif" width="152" height="124" border="0"></a> 
                                                  </div>
                                                </td>
                                              </tr>
                                            </table>
                                            <p align="justify"><font color="#FFFFFF" face="Garamond" size="4"><b>2005 
                                              SAW ANOTHER MILESTONE BEING ACHIEVED 
                                              BY <font color="#3366FF">"<u>UDAAN</u>" 
                                              </font>WHEN IT WAS ANNOUNCED AS 
                                              ONE OF THE 15 AGENTS WHO HAS BEEN 
                                              SELECTED AND AUTHORISED BY<font color="#3366FF"> 
                                              "<u>SINGAPORE HIGH COMMISSION" - 
                                              NEW DELHI</u></font> TO SUBMIT VISA 
                                              APPLICATIONS AS BONAFIDE AGENT OF 
                                              THE HIGH COMMISSION. CLICK ON THE 
                                              LINK FOR FURTHER INFORMATION ON 
                                              THE LATEST PROCEDURES OF WEB APPLICATION 
                                              THROUGH <font color="#00FFFF"><font color="#FFFFFF" face="Garamond" size="4"><b><font color="#00FFFF"><font color="#3366FF"><i>'<u> 
                                              SAVE</u>' </i></font></font> </b></font><font color="#FFFFFF"></font><font color="#3366FF"><i><br>
                                              </i></font></font></b></font><font color="#FFFFFF"><br>
                                              </font></p>
                                            <table width="98%">
                                              <tr> 
                                                <td><a href="http://www.udaanindia.com/forms/Singapore%20Online.pdf"><img src="updateimg/sImage1.jpg" width="628" height="132" border="0"></a></td>
                                              </tr>
                                            </table>
                                            <p align="justify"><font color="#FFFFFF"> 
                                              </font></p>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"></div>
                                    </div>
                                  </td>
                                </tr>
                                <tbody> </tbody> 
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update011104.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><b><font face="Arial, Helvetica, sans-serif"></font></b><a href="update250105.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
          <td><!-- #include file="HomeBottom.asp" --> </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
