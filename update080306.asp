<%@ Language=VBScript %>
<%
response.buffer= true

if session("priv")="" or session("priv")= "guest" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>
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
                <td width="21" height="456">&nbsp;</td>
                <td colspan="3" height="456"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="685"> 
                        <table width="659" align="center" height="421" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="655" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="851" colspan="2"> 
                              <table width="98%" border="1" height="487">
                                <tr bordercolor="#000000" valign="top"> 
                                  <td width="62%" height="962"> 
                                    <div align="justify"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                            <div align="center"><img src="updateimg/update%20heading.png" width="173" height="67"></div>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td> 
                                            <div align="center"><img src="updateimg/date%20heading%20030306.png" width="340" height="58"></div>
                                          </td>
                                        </tr>
                                      </table>
                                      <div align="justify"> 
                                        <p align="justify"><font face="Verdana" size="3"><b>High 
                                          Commission For Malaysia...Processing 
                                          Time</b><font size="2"><b><font size="3">...</font></b><br>
                                          <br>
                                          As per the latest update from High Commission 
                                          For Malaysia, after receipt of complete 
                                          application by the High Commission, 
                                          <b>processing of I-VISA would take 2-business 
                                          days, that means if we submit the documents 
                                          for I-VISA today, the stamping would 
                                          be obtained only tomorrow.</b> There 
                                          would be no same day requests entertained.<br>
                                          <br>
                                          <b>To expedite</b> the process of registering 
                                          online for I-Visa and to <b>save one 
                                          valuable day</b> of processing, before 
                                          sending the documents to us, you can 
                                          also scan the below mentioned requirements 
                                          and <b>mail it to us by 3:00pm</b> at 
                                          <font color="#0000CC"><b>ivisa-malaysia@udaanindia.com</b></font><br>
                                          <br>
                                          <b>·</b> Passport size colour photograph 
                                          with light back Ground<br>
                                          <b>·</b> First, Second and last page 
                                          of the passport<br>
                                          <br>
                                          *********************************************************************** 
                                          <br>
                                          <font size="3"><b>Australian High Commission...Revised 
                                          TT Services Charges...<br>
                                          <br>
                                          </b><font size="2">With immediate effect, 
                                          <b><font size="3" color="#0000CC">Rs.450 
                                          /-</font></b> would be levied as TT 
                                          Services charges instead of <b><font color="#3300CC">386/-,</font></b> 
                                          for all Australian Visa applications.</font><b><br>
                                          <font size="2"><br>
                                          ***********************************************************************<br>
                                          </font></b></font></font></font><font face="Verdana" size="3"><b>British 
                                          High Commission...New Submission and 
                                          Collection timings...</b><font size="2"><br>
                                          </font><font size="2"><br>
                                          With effect from <b>6th March 2006,</b> 
                                          following would be the Submission and 
                                          Collection timings at <b>VFS for UK 
                                          Visa</b>: - <br>
                                          <br>
                                          <b>Submission: -</b> 7:00am - 8:30am<br>
                                          <b>Collection: -</b> 7:00pm - 7:30pm<br>
                                          <br>
                                          *********************************************************************** 
                                          <br>
                                          <font size="3"><b>Embassy of Republic 
                                          of Hungary...</b><br>
                                          <br>
                                          <font size="2">With effect from <b>1st 
                                          march 2006,</b> the visa fee should 
                                          be deposited in any branch of <b>ABN 
                                          Amro Bank</b> in the form of cash in 
                                          the favour of <b>"Hungarian Embassy 
                                          Consular, A/c # 1180865"</b> </font><br>
                                          <br>
                                          <font size="2">The application would 
                                          be entertained with the receipt of cash 
                                          deposit only. In case of Urgent Processing 
                                          of Visa, the applicant needs to submit 
                                          the visa fee one day prior to the submission 
                                          of the application, therefore in case 
                                          of urgent visas kindly inform us one 
                                          day in advance <b>(by 12:30pm)</b> of 
                                          the travel date.<br>
                                          <br>
                                          <b>Kindly note the Embassy works on 
                                          Monday/ Wednesday/ Friday</b></font></font></font></font><font face="Verdana" size="3"><font size="2"><br>
                                          <br>
                                          *********************************************************************** 
                                          <br>
                                          </font></font><font face="Verdana" size="3"><b>South 
                                          African High Commission...</b><font size="2"><br>
                                          <br>
                                          With immediate effect, the <b>&quot;South 
                                          African High Commission&quot; - New 
                                          Delhi</b>, would not entertain any refund 
                                          of the repatriation deposits without 
                                          the original receipt issued to the applicant. 
                                          <b>Kindly inform all concerned to retain 
                                          this slip, till the time the refund 
                                          has been claimed. </b></font></font></p>
                                      </div>
                                      <table width="100%" border="1" height="74">
                                        <tr> 
                                          <td height="2"> 
                                            <div align="center"><font face="Verdana" size="4">&quot;Co-operate 
                                              and support us, to serve you better</font> 
                                              &quot;</div>
                                            <div align="left"> 
                                              <div align="center"><marquee behavior = "alternate"><font face="Monotype Corsiva" size="4" color="#0000FF"><b><img src="updateimg/bird76.gif" width="40" height="40">Udaan 
                                                India Pvt. Ltd.</b></font></marquee></div>
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
                    <table width="98%" border="0" bgcolor="#CCCCCC" height="8">
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
