<html>
<head>
<meta http-equiv="Content-Language" content="en-us">

<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
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
                <td width="21" height="211">&nbsp;</td>
                <td colspan="3" height="211"> 
                  <table height="1" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tbody> 
                    <tr> 
                      <td colspan="2" height="192"> 
                        <table width="658" align="center" height="345" border="1" bordercolor="#333333">
                          <tr> 
                            <td height="2" colspan="2"><img src="http://www.udaanindia.com/updateimg/back-ground.jpg" width="695" height="6"></td>
                          </tr>
                          <tr valign="top" > 
                            <td height="2" colspan="2">
                              <table width="695" border="0" align="right" cellpadding="0" cellspacing="0" class="tdborder">
                                <tr> 
                                  <td height="2320" bgcolor="BD402C"> 
                                    <p class="visaparagraph"><br>
                                      <font size="3" face="Verdana" color="#FFFFFF"><b><font size="2" color="#FFFFCC">Our 
                                      Communication Team offers unmatched experience 
                                      and reliable services to travelers across 
                                      the country. Regardless of where your trip 
                                      begins and ends, Our Communication Team 
                                      ensures that travelers never miss a trip 
                                      due to incomplete paperwork.</font></b></font></p>
                                    <ul type="disc" class="li">
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">Effective 
                                        Communication</font></b></font></li>
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">Personalized 
                                        Service</font></b></font></li>
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">In-depth 
                                        knowledge of visas</font></b></font></li>
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">Responsive</font></b></font></li>
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">Cooperative/ 
                                        Supportive</font></b></font></li>
                                      <li><font size="2" color="#FFFFCC"><b><font face="Verdana">Resourceful</font></b></font><br>
                                      </li>
                                    </ul>
                                    <p class="paragraph1"><strong><font size="2" color="#FFFF33">COMMUNICATION 
                                      :</font><font size="2"> <br>
                                      </font></strong></p>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="2">
                                          <p align="justify"><strong><font color="#FFFFCC">Mr. 
                                            Harpreet Singh ( Ops - Manager )</font><font size="2"><br>
                                            </font><a href="mailto:harpreet@udaanindia.com"><font color="#FFFF33">harpreet@udaanindia.com</font></a><font size="2"><br>
                                            <font face="Verdana">Mob No: +919818201852</font></font></strong><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            very efficient operations Manager 
                                            who will never let you down. When 
                                            in trouble on any visa and status 
                                            contact him. He is also responsible 
                                            for registration of New agents desirous 
                                            of doing business with us.You may 
                                            also contact him for Group Queries.</font></p>
                                        </td>
                                        <td width="21%" height="2"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/harpreet.jpg" width="117" height="134" border="1"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td height="2" width="79%"> 
                                          <p align="justify"><b><font color="#FFFFCC">Ms. 
                                            Pooja Sarin</font></b><font color="#FFFFCC"> 
                                            -<b> ( Key Account Manager )</b></font><br>
                                            <a href="mailto:pooja@udaanindia.com"><font color="#FFFF33"><b>pooja@udaanindia.com</b></font></a><br>
                                            <font size="2" face="Verdana"><b>Mob 
                                            No: +91 9810063345</b></font><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            very proficient Key Account Manager 
                                            who is dealing with all embassies, 
                                            visa related queries, status and registration 
                                            of New agents desirous of doing business 
                                            with us. She is very knowledgeable 
                                            on Attestation of Certificates required 
                                            by embassies. You may also contact 
                                            her for Group Queries. </font></p>
                                        </td>
                                        <td height="2" width="21%"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/POOJA.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="2"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Ms. 
                                            Shamila</font><br>
                                            </strong> <a href="mailto:shamila@udaanindia.com"><font color="#FFFF33"><b>shamila@udaanindia.com</b></font></a> 
                                            <br>
                                            <b><font size="2" face="Verdana">Direct: 
                                            - +91-11-666 03650 / 26160840 ( Ext. 
                                            - 224 )</font></b><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            communication executive who has hordes 
                                            of experience in getting things done 
                                            for Australia, Newzealand and Papua 
                                            New Guinea. </font></p>
                                        </td>
                                        <td width="21%" height="2"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/SHAMILA.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td height="5" width="79%"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Ms. 
                                            Megha Malhotra</font></strong><br>
                                            <a href="mailto:megha@udaanindia.com"><font color="#FFFF33"><b>megha@udaanindia.com</b><br>
                                            </font></a><font size="2" face="Verdana"><b>Direct: 
                                            - +91-11-66603653 / 54</b></font><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            quiet and effcient communication executive 
                                            who will get your things done. Deals 
                                            with all pending cases and additional 
                                            documents.</font><br>
                                          </p>
                                        </td>
                                        <td height="5" width="21%"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/MEGHA%20PHOTO.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td height="33" width="79%"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Mr. 
                                            Vipin Mishra</font></strong><br>
                                            <font size="2" face="Verdana"> <b>Mob 
                                            No: - +91 - 9818119166</b></font><br>
                                            <a href="mailto:vipin@udaanindia.com"><font color="#FFFF33"><b>vipin@udaanindia.com</b></font></a> 
                                            <br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            Senior communication executive with 
                                            tons of experience both in accounts 
                                            as well as communication. Deals with 
                                            attestation and visa related queries 
                                            for all embassies.You may also contact 
                                            him for Group Queries.</font></p>
                                        </td>
                                        <td height="33" width="21%"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/VIPIN%20MISHRA.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="28"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Ms. 
                                            Shalini Bali</font></strong> <br>
                                            <font size="2" face="Verdana"><b>Direct: 
                                            - +91-11- - 26160840 ( Ext. - 215)</b></font><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            responsible communication executive 
                                            who deals with queries for all embassies 
                                            and status of your visas. </font></p>
                                        </td>
                                        <td width="21%" height="28"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/SHALINI%20BALI.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <font size="2"><b><font color="#FFFF33">INFORMATION 
                                    TECHNOLOGY :</font></b></font><font size="2"><b><font color="#FFFF33"></font></b></font><br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Mr. 
                                            Arun Saxena : ( Manager - IT )</font></strong><font size="2"><br>
                                            </font>
                                          <a href="mailto:pankaj@udaanindia.com">
                                          <font color="#FFFF33"><b>arun@udaanindia.com</b></font></a> 
                                            <font size="2"> <br>
                                            <b><font face="Verdana">Direct: - 
                                            +91-11- 26160840 ( Ext. - 216 )</font></b></font><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            very experienced IT Manager who is 
                                            well proficient in IT, Web site related 
                                            queries and responsible for issuing 
                                            of User ID and registration of New 
                                            agents desirous of doing business 
                                            with us. Responsible also for handling 
                                            and advising on USA visa.</font></p>
                                        </td>
                                        <td width="21%"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/ARUN.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <font size="2"><b><font color="#FFFF33">MARKETING 
                                    AND SALES :</font></b></font> <b></b><br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="123"> 
                                          <p align="justify"><b><font color="#FFFFCC"><br>
                                            Mr. Deepak Khera</font></b><br>
                                            <a href="mailto:deepak@udaanindia.com"><font color="#FFFF33"><b>deepak@udaanindia.com</b></font></a><br>
                                            <b><font size="2" face="Verdana">Mob 
                                            No: +91-9818128817</font></b><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">A 
                                            very efficient and experienced Sales 
                                            Manager who has hordes of experience 
                                            both in sales and communication. He 
                                            takes care of all visa related queries 
                                            in respect of all embassies with particular 
                                            reference to visas for Srilankan nationals. 
                                            He is also responsible for registration 
                                            of New agents desirous of doing business 
                                            with us.The two service appartments 
                                            are also being run under his able 
                                            guidance.For all requirements of accomodation 
                                            in these two service appartments, 
                                            please contact him.</font></p>
                                        </td>
                                        <td width="21%" height="123"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/DEEPAK.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="99%" border="1">
                                      <tr> 
                                        <td width="80%" height="88"> 
                                          <p align="justify"><b><font color="#FFFFCC">Ms. 
                                            Priyanka Kamboj</font></b><br>
                                            <b><font size="2" face="Verdana">Mob 
                                            No: 91987339939</font></b><br>
                                            <font size="2" face="Verdana" color="#FFFFFF">Deals 
                                            with all incoming mails on</font><font size="2" face="Verdana"> 
                                            <a href="mailto:udaan@spectranet.com"><font color="#FFFF33">udaan@spectranet.com</font></a> 
                                            <font color="#FFFFFF">and </font><a href="mailto:udaan@udaanindia.com"><font color="#FFFF33">udaan@udaanindia.com</font></a>. 
                                            <font color="#FFFFFF">You will get 
                                            the right answer in the least possible 
                                            time from her which includes querries 
                                            related to visa requirements for all 
                                            embassies and status of your visas.</font></font></p>
                                        </td>
                                        <td width="20%" height="88"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/PRIYANKA%20KAMBOJ.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <font size="2"><b><font color="#FFFF33">ACCOUNTS 
                                    :</font></b></font><br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="13"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Mr. 
                                            H.K. Shah : ( G.M. Finance )</font></strong><br>
                                            <b><font size="2" face="Verdana">Direct: 
                                            -&nbsp; +91-11-26711467 / 09818424501</font></b><br>
                                            <a href="mailto:hkshah@udaanindia.com"><font color="#FFFF33"><b>hkshah@udaanindia.com</b></font></a><a href="mailto:nirlap@udaanindia.com" class="mailto"> 
                                            <br>
                                            </a><font size="2" face="Verdana" color="#FFFFFF">Very 
                                            Senior - almost founder member of 
                                            Udaan family. He is a pillar of Udaan 
                                            and takes care of all finance matters 
                                            including all important billing and 
                                            recovery of debts. Do contact him 
                                            for all financial aspects.</font></p>
                                        </td>
                                        <td width="21%" height="13"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/HK%20SHAH.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
                                    <br>
                                    <table width="100%" border="1">
                                      <tr> 
                                        <td width="79%" height="2"> 
                                          <p align="justify"><strong><font color="#FFFFCC">Mr. 
                                            Sanjay</font></strong><font color="#FFFFCC"><b> 
                                            Notiyal</b></font><br>
                                            <b><font size="2" face="Verdana">Direct: 
                                            -&nbsp; +91-11-66603652</font></b><br>
                                            <a href="mailto:accounts.udaan@udaanindia.com"><b><font color="#FFFF33">accounts.udaan@udaanindia.com</font></b></a><a href="mailto:nirlap@udaanindia.com" class="mailto"> 
                                            <br>
                                            </a><font size="2" face="Verdana" color="#FFFFFF">An 
                                            experienced and responsible account 
                                            executive who deals with Billing and 
                                            related queries.</font></p>
                                        </td>
                                        <td width="21%" height="2"> 
                                          <div align="right"><img src="http://www.udaanindia.com/updateimg/SANJAY.jpg" width="117" height="134" border="2"></div>
                                        </td>
                                      </tr>
                                    </table>
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
          <td><!-- #include file="HomeBottom.asp" --></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>