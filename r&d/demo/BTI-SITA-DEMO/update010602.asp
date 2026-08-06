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
            <table width="760" border="0" cellspacing="0" cellpadding="0" height="469">
              <tr> 
                <td width="21">&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td colspan="3" width="783"> 
                  <div align="center"><b><font face="Arial Black" color="#000080" size="6"><i>UPDATE</i></font><i><font face="Arial" color="#000080" size="6"> </font><font face="Arial" color="#000080" size="4">1st June 2002 </font></i></b></div>
                </td>
              </tr>
              <tr> 
                <td width="21" height="80">&nbsp;</td>
                <td colspan="3" height="80" width="783"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td colspan="5">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="5"> 
                        <hr>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="5"> 
                        <div align="center"><b><font face="Arial, Helvetica, sans-serif" color="#840084"><u>UNITED 
                          KINGDOM </u></font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="5"> 
                        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">VISA 
                          APPLICATION DROP BOX</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="5">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td height="2" valign="top" colspan="5"> 
                        <div align="JUSTIFY"><font size="2" face="Arial, Helvetica, sans-serif"><b>THE 
                          BRTISH HIGH COMMISSION IN NEW DELHI IS PLEASED TO OFFER 
                          VISA CUSTOMERS THE ADVANTAGE OF LODGING. ``NON-PRESENT`` 
                          APPLICATION THROUGH THE VISA DROP BOX. IF YOU MEET ONE 
                          OR MORE OF THE CRITERIA SET OUT BELOW. WE WILL BE HAPPY 
                          TO ACCEPT AND PROCESS YOUR APPLICATION WITHOUT THE NEED 
                          FOR YOU TO ATTEND THE VISA OFFICE.</b></font></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="5" height="2"><b></b></td>
                    </tr>
                    <tr> 
                      <td colspan="5" height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">THE 
                          DROP BOX WILL BE OPEN TO ACCEPT APPLICATION BETWEEN 
                          0900 AND 1200. { MONDAY TO FRIDAY }. PLEASE ENSURE THAT 
                          YOU HAVE ENCLOSED ALL THE RELEVANT DOCUMENTS. THE EMBASSY 
                          WILL GIVE YOU OR YOUR REPRESENTATIVE A RECEIPT WHICH 
                          YOU WILL NEED TO PRODUCE IN ORDER TO COLLECT THE PASSPORT. 
                          WE AIM TO HAVE YOUR PASSPORT READY ON THE FOLLOWING 
                          DAY.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="5" height="2">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="5" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#000099">YOR 
                        ARE ELIGIABLE TO USE THIS FACILITY</font></b></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2"> 
                          YOU HAVE TRAVELLED TO THE U.K. IN THE LAST TEN YEARS, 
                          AND HAVE EVIDENCE OF THIS TRAVEL.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          HAVE TO TRAVELLED TO THE US, AUSTRALIA, NEWZEALAND, 
                          CANADA, SWITZERLAND OR SCHENGEN COUNTRIES WITHIN THE 
                          LAST FIVE YEARS, AND HAVE EVIDENCE OF THIS TRAVEL.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE AGED OVER 65 AND ARE VISITING A SON OR DAUGHTER 
                          IN U.K. YOU WILL NEED FUL DOCUMENTARY EVIDENCE OF YOUR 
                          CIRCUMSTANCES IN INDIA, EVIDENCE THAT THE VISITS IS 
                          AFFORDABLE; AN INVITATION FROM YOUR SPONSOR EXPLANING 
                          YOUR RELATIONSHIP, AND ANY OTHER INFORMATION YOU THINK 
                          WILL HELP TO SHOW THAT YOU ARE A GENUINE VISITOR WHO 
                          INTENDS TO LEAVE THE U.K. AFTER A VISIT.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A DIPLOMAT IN THE INDIAN FOREIGN SERVICE { APPLICATIONS 
                          SHOULD BE ACCOMPAINED BY AN M.E.A. NOTE } OR AN OFFICER 
                          OF THE INDIAN ADMINSTRATIVE SERVICE.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE DIPLOMAT SERVING IN A DIPLOMATIC MISSION IN INDIA. 
                          YOUR APPLICATION SHOULD BE ACCOMPAINED BY A NOTE VERBAL 
                          FROM THE MISSION.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE THE SPOUSE OR CHILD ( UNDER 18 ) OF ONE OF A PERSON 
                          WHO MEETS ONE OF THE ABOVE CRITERIA. AND ARE TRAVELLING 
                          WITH THEM.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A STUDENT SPONSORED BY THE BRITISH COUNCIL, OR A 
                          LIFE MEMBER OF THE ASSOCIATION OF BRITISH SCHOLARS.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A CONTRACT SEAMAN. APPLICATION MUST BE ACCOMPANIED 
                          BY A LETTER FROM A RECOGNISED SHIPPING COMPANY ALONG 
                          WITH YOUR SEAMAN`S BOOK.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A NAUTICAL STUDENT. APPLICATION MUST BE SUPPORTED 
                          BY UNIVERSITY ACCEPTANCE LETTER AND EVIDENCE OF FUNDING.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A MEMBER OF AN AIRLINE CREW WORKING ON A ROUTE WHICH 
                          LANDS IN THE UNITED KINGDOM.</font></b></div>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="2" valign="top"><b><font face="Arial, Helvetica, sans-serif" size="2"><img src="updateimg/bluearrow.gif" align="top" WIDTH="24" HEIGHT="15"></font></b> 
                      </td>
                      <td height="2"> 
                        <div align="JUSTIFY"><b><font face="Arial, Helvetica, sans-serif" size="2">YOU 
                          ARE A RETURNING RESIDENT WITH EVIDENCE OF YOUR CURRENT 
                          IMMIGRATION STATUS IN THE UNITED KINGDOM (COPIES OF 
                          YOUR OLD PASSPORT OR LETTERS FROM THE UNITED KINGDOM 
                          HOME OFFICE SHOWING THAT YOU HAVE BEEN GRANTED INDEFINITE 
                          LEAVE TO REMAIN).</font></b></div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td width="21" height="2">&nbsp;</td>
                <td colspan="2" height="2" width="69"><b><font face="Arial, Helvetica, sans-serif"><a href="update230502.ASP"><img src="updateimg/previous.jpg" border="0" WIDTH="70" HEIGHT="37"></a></font></b></td>
                <td width="712" height="2"> 
                  <div align="right"><a href="update040602.asp"><img src="updateimg/next.jpg" border="0" WIDTH="70" HEIGHT="37"></a>&nbsp;</div>
                </td>
              </tr>
              <tr> 
                <td width="21">&nbsp;</td>
                <td colspan="3" rowspan="2" width="783"> 
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
