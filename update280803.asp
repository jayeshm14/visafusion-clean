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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="228">
              <tr> 
                <td width="21" height="2">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" height="2"> 
                  <div align="center"><b></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="870">&nbsp;</td>
                <td colspan="3" height="870"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="112"> 
                        <table width="457" align="center" height="813" border="0" bgcolor="#E8FFE8">
                          <tr> 
                            <td height="2" colspan="3"> 
                              <div align="center"><b><font 
            face="Arial Black" color=#000080 size=6><i>UPDATE</i></font><i><font 
            face=Arial color=#000080 size=6> </font><font face="Arial" color="#000080" size="4">28th 
                                August 2003</font></i><font 
            face="Arial Black" color=#000080 size=6><i><font size="3"> </font></i></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="8" colspan="3"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">ARGENTINA</span></u></font></b></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="2"> 
                              <div align="justify"><font face="Arial" size="2">AS 
                                PER RECENT NOTIFICATION FROM THE EMBASSY OF THE 
                                ARGENTINE REPUBLIC – NEW DELHI, WITH EFFECT FROM 
                                1st SEPTEMBER 2003 THE VISA FEES FOR ARGENTINA 
                                WILL BE ACCEPTED ONLY IN THE FORM OF DEMAND DRAFT 
                                DRAWN IN FAVOUR OF "<b><font color="#FF0033">EMBASSY 
                                OF THE ARGENTINE REPUBLIC - NEW DELHI - A/C. NO. 
                                310221161</font>&quot;</b>. KINDLY NOTE THE FEE 
                                FOR THE VARIOUS CATEGORIES IS AS FOLLOWS:- </font></div>
                            </td>
                            <td height="6" rowspan="2" width="195" valign="top"> 
                              <div align="right"><img src="updateimg/argentina.jpg" width="180" height="220"></div>
                            </td>
                          </tr>
                          <tr> 
                            <td height="2" width="179"><font face="Arial"><b>* 
                              VISA FEE</b></font></td>
                            <td height="2" width="94"><font face="Arial"><b>RS. 
                              2400/-</b></font></td>
                          </tr>
                          <tr> </tr>
                          <tr> 
                            <td height="2" colspan="3"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr> 
                            <td height="2" colspan="3"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">UNITED 
                                KINGDOM</span></u></font></b></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="299" colspan="3"> 
                              <table width="100%" height="320">
                                <tr> 
                                  <td valign=top align=left height=2 colspan="2"> 
                                    <div align="justify"><b><font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial">AS 
                                      PER RECENT NOTIFICATION FROM 'BRITISH HIGH 
                                      COMMISSION' - NEW DELHI, WITH IMMEDIATE 
                                      EFFECT THE REVISED VISA FEE WILL BE AS FOLLOWS.</font></span></font></b></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right colspan="2" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"> 
                                      Visitor, Student, Passengers in Transit, 
                                      Returning Residents :</font></b></font></div>
                                  </td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="284"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="http://www.udaanindia.com/updateimg/bluearrow.gif" width="24" height="15">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">STANDARD 
                                    VISA :</font></font></span></b> </td>
                                  <td valign=top align=left height=2 width="155"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    &nbsp;2700.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="284"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="http://www.udaanindia.com/updateimg/bluearrow.gif" width="24" height="15"></font></font></b></font></font></font></span><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                    ENTRY (1 YEAR)</font></font></span></b> </td>
                                  <td valign=top align=left height=2 width="155"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    &nbsp;4500.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="284"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="http://www.udaanindia.com/updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                    ENTRY (2 YEARS)</font></font></span></b> </td>
                                  <td valign=top align=left height=2 width="155"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS.&nbsp; 
                                    5250.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="284"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="http://www.udaanindia.com/updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                    ENTRY (5 YEARS)</font></font></span></b> </td>
                                  <td valign=top align=left height=2 width="155"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    &nbsp;6600.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=left height=2 width="284"><b><span 
                        style="mso-bidi-font-size: 10.0pt"><font size="2"><font color="#800080" size="4"><font face=Arial><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF"><img src="http://www.udaanindia.com/updateimg/bluearrow.gif" width="24" height="15"></font></font></b><b><font face="Arial, Helvetica, sans-serif" size="2"><font color="#3333FF">&nbsp;</font></font></b></font></font><font face="Arial, Helvetica, sans-serif" color="#3333FF">MULTIPLE 
                                    ENTRY (10 YEARS)</font></font></span></b> 
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#3333FF"><b><font face="Arial, Helvetica, sans-serif" size="2">RS. 
                                    11250.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Settlement :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs.&nbsp; 
                                    19500.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Student :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;2700.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Certificate of Entitlement :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;8250.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Long Term Entry :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;5650.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Direct Airside Transit :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;2000.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Dependant Territory :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;1650.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Dep. Tery. Telex Fee :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;&nbsp;800.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right width="284" height=2> 
                                    <div align="left"><font color="#3333FF"><b><font color="#1F3F1F"><img src="http://www.udaanindia.com/updateimg/bl_pin.gif" width="21" height="21"></font></b></font><font color="#1F3F1F"><b> 
                                      Call Out Fee :</b></font></div>
                                  </td>
                                  <td valign=top align=left height=2 width="155"><font color="#1F3F1F"><b><font face="Arial, Helvetica, sans-serif" size="2">Rs. 
                                    &nbsp;&nbsp;5400.00</font></b></font></td>
                                </tr>
                                <tr> 
                                  <td valign=top align=right colspan="2" height=2> 
                                    <div align="justify"><font face="Arial" size="2"><b>FEE 
                                      WILL BE ACCEPTED BY DEMAND DRAFT IN FAVOUR 
                                      OF '<font size="2"><span style="mso-bidi-font-size: 10.0pt"><font face="Arial" color="#FF0033">BRITISH 
                                      HIGH COMMISSION</font></span></font> ' PAYABLE 
                                      AT NEW DELHI </b></font></div>
                                  </td>
                                </tr>
                                <tbody> </tbody> 
                              </table>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"> 
                              <div align="justify"><font face="Arial" size="2"><b>* 
                                <font color="#FF0033">THE APPLICANT SHOULD PROVIDE 
                                AUTHORITY LETTER</font></b> FOR REPRESENTATIVE 
                                TO SUBMIT CASES ON BEHALF OF PAX.</font></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="450" height="1"></td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"> 
                              <div align="center"><b><font color="#800080" size="4" face="Arial"><u><span style="mso-bidi-font-size: 10.0pt">ITALY</span></u></font></b></div>
                            </td>
                          </tr>
                          <tr > 
                            <td height="2" colspan="3"> 
                              <div align="justify"><font size="2" face="Arial">AS 
                                PER RECENT NOTIFICATION FROM THE 'EMBASSY OF ITALY' 
                                - NEW DELHI WITH EFFECT FROM 1st SEPTEMBER <b><font color="#FF0033">THERE 
                                WOULD BE NO COLLECTION ON WEDNESDAYS</font></b>. 
                                APPLICATIONS WOULD HOWEVER BE ACCEPTED FOR PROCESSING 
                                ON ALL DAYS MONDAY - FRIDAY.</font></div>
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
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"><a href="update120803.asp"><img src="updateimg/previous.jpg" border="0" width="70" height="37"></a></font></b></td>
                <td height="2" width="650"> 
                  <div align="right"><a href="update040903.asp"><img src="updateimg/next.jpg" width="70" height="37" border="0"></a>&nbsp;</div>
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
