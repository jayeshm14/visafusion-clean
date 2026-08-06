<% if session("priv")<>"" and session("uname")<>"" then %>
<!-- #include file="connection.asp" -->
<%

set rs=server.createobject("ADODB.recordset")
if ucase(session("priv"))="AGT" then
priv="AGT"
rs.open("select * from agents where description='"&session("uname")&"'"),con,2,3
if not rs.eof then
cname=rs.fields("companyname")
phone=rs.fields("phoneno")
fax=rs.fields("faxno")
email=rs.fields("emailid")
city=rs.fields("city")
end if
rs.close
end if
if ucase(session("priv"))="GUEST" then
priv="GUEST"
rs.open("select * from registration where uid='"&session("uname")&"'"),con,2,3
if not rs.eof then
name=rs.fields("name")
cname=rs.fields("company")
phone=rs.fields("phoneno")
fax=rs.fields("faxno")
email=rs.fields("emailid")
city=rs.fields("city")
end if
rs.close
end if
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
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>

<script language="JavaScript">
<!--

function numvalid(a)
{
if(isNaN(a.value))
{
alert("Please fill numeric value for" + a.name)
a.focus()
a.select()
}
}

function mail()
{
if (document.form1.email.value!="")
	{ 
		var email,ln;
		email=document.form1.email.value;
		ln=email.indexOf('@',1);
		if ( ln > 0)
		{	
			if (email.indexOf(".",ln+1) <3 )
			{
				alert ("Please enter valid Email.");
		document.form1.email.focus()
		document.form1.email.select()
				return false;	
			}
		}
		else
		{
			alert ("You have entered wrong Email Id, please enter the correct Email Id.");
		document.form1.email.focus()
		document.form1.email.select()
			return false;
		}
	}
	else
		{alert("Enter the Email Id.");
		document.form1.email.focus()
		document.form1.email.select()
		return false;}
}	

function check()
{
if(document.form1.msgtxt.value==""){
alert("Please enter your Any Question ?  Remarks ?  Suggestions ?  Queries ?")
document.form1.msgtxt.focus()
return false
}
if(document.form1.name.value==""){
alert("Please enter your Name!.")
document.form1.name.focus()
return false
}
if(document.form1.phone.value==""){
alert("Please Enter your Phone No.")
document.form1.phone.focus()
return false
}
if(document.form1.email.value==""){
alert("Please enter your Email address.")
document.form1.email.focus()
return false
}
if(document.form1.city.value==""){
alert("Please enter the name of the City in which you are residing.")
document.form1.city.focus()
return false
}
}
//-->
</script>

</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="MM_preloadImages('images/queriean2.gif','images/logonn2.gif','images/homen2.gif','images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif')">
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
                <td width="12%"><a href="update.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)"><img src="images/updaten1.gif" width="102" height="20" name="Image2" border="0"></a></td>
                <td width="12%"><a href="registration.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" border="0"></a></td>
                <td width="12%"><a href="contactus.asp"><img src="images/contactn3.gif" width="102" height="20" name="Image4" border="0"></a></td>
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
        <tr align="left"> 
          <td><img src="images/threei.gif" width="760" height="26" usemap="#Map" border="0"><map name="Map"><area shape="rect" coords="329,2,436,24"><area shape="rect" coords="461,1,597,24"><area shape="rect" coords="619,2,720,24"></map></td>
        </tr>
        <tr> 
          <td height="320"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2" height="276"> 
                  <table width="100%" border="0">
                    <tr> 
                      <td width="1%" height="173"><img src="images/pixel.gif" width="33" height="13"></td>
                      <td width="99%" height="173"> 
                        <div align="justify"> 
                          <form method="post" action="contactsendpre.asp" name="form1"  <% if priv="" then %>onSubmit="return check()"<% end if %>>
                            <table width="100%" border="0">
                              <tr> 
                                <td colspan="3" height="22"> 
                                  <div align="center"><span class="wsrightbold"><font size="2" face="Arial, Helvetica, sans-serif"> 
                                    &nbsp; <br>
                                    <font size="4">ANY QUERIES ? &nbsp;REMARKS 
                                    ? &nbsp;SUGGESTIONS ?</font></font></span></div>
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" colspan="3"> 
                                  <div align="center"> 
                                    <textarea name="msgtxt" rows="7" cols="60"></textarea>
                                  </div>
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">NAME 
                                  &amp; DESIGNATION :</font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="name" value="<%=name%>">
                                  <input type="hidden" name="priv" value="<%=priv%>">
                                  <input type="hidden" name="uid" value="<%=session("uname")%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">COMPANY 
                                  NAME :</font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="cname" value="<%=cname%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">PHONE 
                                  : </font><font size="2" face="Arial, Helvetica, sans-serif"> 
                                  </font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="phone" <% if priv="" then %>onBlur="return numvalid(this)"<%end if%> value="<%=phone%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">FAX 
                                  : </font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="fax" <% if priv="" then %>onBlur="return numvalid(this)"<%end if%> value="<%=fax%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">EMAIL 
                                  : </font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="email" <% if priv="" then %>onChange="return mail()"<%end if%> value="<%=email%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"><b><font size="2" face="Verdana" color="#FF0033">CITY 
                                  : </font></b></td>
                                <td height="2" width="45%"> 
                                  <input type="text" name="city" value="<%=city%>">
                                </td>
                              </tr>
                              <tr> 
                                <td height="2" width="27%">&nbsp;</td>
                                <td height="2" width="28%"> 
                                  <div align="right"> 
                                    <input type="submit" name="Submit" value="Submit">
                                  </div>
                                </td>
                                <td height="2" width="45%"> 
                                  <input type="reset" name="Submit2" value="Reset">
                                </td>
                              </tr>
                            </table>
                          </form>
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td width="1%" height="2">&nbsp;</td>
                      <td width="99%" height="2"><b></b></td>
                    </tr>
                  </table>
                  <div align="center"><b><font face="Verdana" size="2" color="#0000FF">WRITE 
                    TO US FOR OUR <font color="#FF0000">&quot; CORPORATE TRAVEL 
                    SPECIAL&quot;</font><font color="#FF6633"> </font>OR <font color="#FF0000">&quot; 
                    LEISURE TRAVEL SPECIAL&quot;</font> OR FOR ANY REQUISITION 
                    FOR VISA APPLICATION FORMS.</font></b></div>
                </td>
              </tr>
              <tr> 
                <td colspan="2" height="41"> 
                  <table align="center" width="100%">
                    <tr> 
                      <td width="8%" valign="top" height="46">&nbsp;</td>
                      <td width="33%" valign="top" height="46"><span class="wsrightbold"><font face="Verdana" size="2" color="#333333">UDAAN 
                        INDIA PRIVATE LIMITED :</font></span></td>
                      <td width="59%" height="46"> 
                        <p><span class="website"> <font face="Verdana" size="2"># 
                          309 - 312 SOMDUTT CHAMBERS II,<br>
                          9, BHIKAIJI CAMA PLACE, <br>
                          NEW DELHI 110 066.</font></span></p>
                      </td>
                    </tr>
                    
                    <tr> 
                      <td width="8%" valign="top">&nbsp; </td>
                      <td width="33%" valign="top"><span class="wsrightbold"><font face="Verdana" size="2" color="#333333">CONTACT 
                        US ON :</font></span></td>
                      <td width="59%"><span class="wsrightbold"><font face="Verdana" size="2" color="#FF0000">PHONES 
                        :</font><font face="Verdana" size="2" color="#333333"> 
                        </font></span><span class="website"><font face="Verdana" size="2">011 
                        - 2616 0840 / 2617 7435 / 2610 3864 <br>
                        2619 6928 / 2618 2402 / 2618 2403.</font></span></td>
                    </tr>
                    <tr> 
                      <td width="8%"> </td>
                      <td width="33%"></td>
                      <td width="59%"><span class="wsrightbold"> <font face="Verdana" size="2" color="#FF0000">FACSIMILE 
                        :</font> </span><span class="website"><font face="Verdana">011 
                        - 2616 0606.</font></span></td>
                    </tr>
                    <tr> 
                      <td width="8%">&nbsp; </td>
                      <td width="33%">&nbsp;</td>
                      <td width="59%"><span class="wsrightbold"><font face="Verdana" size="2" color="#FF0000">E-MAIL 
                        :</font> </span><span class="website"><a href="mailto:udaan@spectranet.com"><font face="Verdana" size="2">udaan@spectranet.com 
                        </font></a></span> </td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="2">&nbsp; </td>
                      <td width="59%" height="2">&nbsp; </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td colspan="2" height="2"> 
                  <p align="center"><font color="#006633"><b><font face="Verdana" size="2" color="#FF0000">TO 
                    ESTABLISH YOUR USER ID / PASSWORD</font><font face="Verdana" size="2"> 
                    <a href="registration.asp">CLICK HERE</a></font></b> </font><br>
                  </p>
                  </td>
              </tr>
              <tr> 
                <td colspan="2" height="2">&nbsp; </td>
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
