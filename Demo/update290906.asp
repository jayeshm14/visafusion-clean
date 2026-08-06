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
                <td width="21" height="279">&nbsp;</td>
                <td colspan="3" height="279"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="685"> 
                        <table width="659" align="center" height="421" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="438" colspan="2"> 
                              <table width="98%" border="1" height="487">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="420" bordercolor="#000000"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><img src="updateimg/update%20heading.png" width="193" height="67"></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td> 
                                            <div align="center"></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"><font face="Verdana" size="4">Greece 
                                        Embassy launches new Call Center in Delhi…<br>
                                        </font><font face="Verdana" size="3"><br>
                                        <font size="2">In accordance to latest 
                                        regulations from the Greece Embassy, all 
                                        visa applications has to be applied through 
                                        the Embassy authorized submission center 
                                        mentioned below:<br>
                                        <br>
                                        <b><font color="#FF3300">Visa Processing 
                                        Services <br>
                                        A Division of BLS Detectives Ltd<br>
                                        </font><font face="Verdana" size="3"><font size="2"><font color="#6600FF"><b><font color="#FF3300">912, 
                                        Indra Prakash Building</font></b></font></font></font><font color="#FF3300"> 
                                        <br>
                                        </font><font face="Verdana" size="3" color="#FF3300"><font size="2"><b>21, 
                                        Barakambha Road</b></font></font><font color="#FF3300"> 
                                        - </font><font face="Verdana" size="3" color="#FF3300"><font size="2"><b>New 
                                        Delhi<br>
                                        </b><font size="2"><b>Contact No. 32573186, 
                                        23715283</b></font><b> </b></font></font></b><br>
                                        <b>E-mail:</b> <b><font face="Verdana" size="3"><font size="2"><font color="#6600FF"><b>greece@blsdetectives.com</b></font></font></font><font color="#6600FF"> 
                                        </font></b><br>
                                        <b>Website:</b> <font face="Verdana" size="3"><font size="2"><font color="#6600FF"><b>www.bls-greece.com</b></font></font></font><font color="#6600FF"><b><br>
                                        <br>
                                        <br>
                                        </b></font> Apart from the applicable 
                                        visa application fee, the center would 
                                        be levying a Service Charge of <b>Rs.281 
                                        /-</b> towards each application submitted. 
                                        <br>
                                        <br>
                                        The <b>BLS</b> working hours are from 
                                        <b>Monday to Saturday during 09:00 hours 
                                        to 13:00</b> hours for submission and 
                                        the collection timings will be <b>15:00 
                                        hours to 18:00 hours.<br>
                                        </b><br>
                                        Please note, that the above center will 
                                        only act as a submission and collection 
                                        center and all visa application will continue 
                                        to be assessed by the Visa Officers at 
                                        the Greece Embassy in New Delhi.<br>
                                        <br>
                                        </font><font size="4">Austria Visa to 
                                        be serviced by VFS India Pvt. Ltd... </font><font size="2"><br>
                                        <br>
                                        F<b>rom October 01st, 2006, VFS India 
                                        Pvt. Ltd </b>will serve, as the authorized 
                                        outsourced center for all visa applications 
                                        required for applying for a visa to Austria. 
                                        The procedures of application continues 
                                        to be the same. </font><font face="Verdana" size="3"><font size="2">All 
                                        visa applications has to be applied through 
                                        the Embassy authorized submission center 
                                        mentioned below:</font></font><font size="2"><br>
                                        <br>
                                        <b><font color="#FF3300">VFS (India) Pvt. 
                                        Ltd.<br>
                                        5. S-1 Level, Block-E,<br>
                                        International Trade Tower,<br>
                                        Nehru Place, New Delhi - 110019<br>
                                        Contact No. - 41608609</font></b><br>
                                        <br>
                                        </font><font face="Verdana" size="3"><font size="2">Apart 
                                        from the applicable visa application fee, 
                                        the<b> VFS would be levying a Service 
                                        Charge</b> of <b>Rs.440 /-</b> towards 
                                        each application submitted.<br>
                                        <br>
                                        </font><font face="Verdana" size="3"><font size="2">The 
                                        <b>VFS</b> working hours are from <b>Monday 
                                        to Friday during 08:00 hours to 12:00</b> 
                                        hours for submission and the collection 
                                        timings will be <b>13:00 hours to 16:00 
                                        hours.<br>
                                        <br>
                                        <br>
                                        </b></font><font face="Verdana" size="3"><font size="4">Embassy 
                                        of Argentina...<br>
                                        <br>
                                        <font size="2">As per the new Guidelines 
                                        from the Embassy, agents are allowed to<b> 
                                        Submit and Collect</b> the requisite documents 
                                        for visa on behalf of the clients.<br>
                                        <br>
                                        <b>1.)</b> Personal Presence is no more 
                                        Mandatory</font>.<br>
                                        <font size="2"><b>2.)</b> Interview will 
                                        take place only if called for by the Embassy<br>
                                        <b>3.)</b> Documents required are the 
                                        same as per our website ( <b><a href="http://www.udaanindia.com">www.udaanindia.com</a></b> 
                                        )<br>
                                        <br>
                                        </font></font></font></font></font></font>
                                        <table width="100%" border="1">
                                          <tr bgcolor="#FFFFFF"> 
                                            <td> 
                                              <div align="center"><font face="Verdana" size="4" color="#FF0000" >&quot; 
                                                Important Notice&quot;</font></div>
                                            </td>
                                          </tr>
                                        </table>
                                        <font face="Verdana" size="3"><font face="Verdana" size="3"><font face="Verdana" size="3"><font face="Verdana" size="3"><font size="4"><font size="2"> 
                                        <br>
                                        Kindly note all the<b> Embassies and High 
                                        Commissions</b> are taking a very serious 
                                        view of the <b>Dummy Ticket </b>being 
                                        used to obtain visas. Embassies are checking 
                                        at randomly for all tickets submitted 
                                        alongwith the application and if they 
                                        are not found to be genuine, this could 
                                        result in delay or outright rejection 
                                        of the visa. <b>Kindly double check the 
                                        Tickets</b> which are enclosed, especially<b> 
                                        E-Tickets,</b> to avoid inconvenience.<br>
                                        </font></font></font></font></font><font size="2"> 
                                        <br>
                                        </font></font> </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="12"> 
                                            <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                              and support us, to serve you better</font> 
                                              &quot;</div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"></font></marquee></div>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                      <b> </b><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="645" height="6"></div>
                                  </td>
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
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2"><b><font face="Arial, Helvetica, sans-serif"></font></b></td>
                <td height="2" width="650"> 
                  <div align="right">&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2"> 
                  <form method="post" action="subscribe.asp" name="form1" onSubmit="return check()">
                    <table width="100%" border="0" bgcolor="#CCCCCC" height="8">
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
                          <input type="submit" name="Submit" value="SUBSCRIBE">
                          <input type="text" name="u_mail" size="15" maxlength="70" onChange="return mail()">
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
