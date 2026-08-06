<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<html>
<head>
<title>Udaan India Pvt. Ltd.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css">
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
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/back.gif" onLoad="MM_preloadImages('images/logonn2.gif','images/homen2.gif','images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
                <td width="10%"><a href="Default.asp"><img src="images/homen1.gif" width="99" height="20" border="0" name="Image7" onMouseOver="MM_swapImage('Image7','','images/homen2.gif',1)"></a></td>
                <td width="10%"><a href="profile.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)"><img src="images/profilen1.gif" width="102" height="20" name="Image1" border="0"></a></td>
                <td width="10%"><a href="update.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)"><img src="images/updaten1.gif" width="102" height="20" name="Image2" border="0"></a></td>
                <td width="10%"><a href="registration.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" border="0"></a></td>
                <td width="10%"><a href="contactus.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)"><img src="images/contactn1.gif" width="102" height="20" name="Image4" border="0"></a></td>
                <td width="10%"><a href="queries.asp"><img src="images/queriean3.gif" width="101" height="20" name="Image5" border="0"></a></td>
                <td width="7%"><a href="logon.asp"><img src="images/logonn1.gif" width="100" height="20" name="Image6" onMouseOver="MM_swapImage('Image6','','images/logonn2.gif',1)" border="0"></a></td>
                <td width="32%"><img src="images/pixekn.gif" width="58" height="20"></td>
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr> <%
                    country=cint(request("countrylist"))
		            category=request("category")
					countryF=request("countryFor")
              
              description=trim(request("visaInfo"))
			set rs= server.createobject("adodb.recordset")
			set rs1= server.createobject("adodb.recordset")
                %> 
                <table width=90% align="center">
                  <tr>
                    <td align="center"><br>
                      <span class="WSRightBold"><font size="4"> <%            
              stmt2="select* from embassy where embassyID="&country
              rs1.open stmt2,con,2,3
              if not rs1.eof then
              response.write ucase(rs1("description"))&"</FONT></span></td><tr><td align='center'><span class='WSRightBold'><FONT SIZE='4'>"
              response.write ucase(rs1("embassyname")) & " </FONT></span></td></tr><TR><td>"
              response.write "<span class='WSRightBold'>CHANCERY : </span><span class='WebSite'>"
		if trim(rs1("street1"))<>"" then
		response.write ucase(rs1("street1")) & " "
		end if
		if trim(rs1("street2"))<>"" then
		response.write ucase(rs1("street2")) & " "
		end if
		if trim(rs1("area"))<>"" then
		response.write ucase(rs1("area"))&" "
		end if
		if trim(rs1("city"))<>"" then
		response.write ucase(rs1("city"))&" "
		end if
		response.write "</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>PHONE :</span><span class='WebSite'>"& rs1("phoneno") &"</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>FACSIMILE :</span><span class='WebSite'>"& rs1("faxno") &"</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>EMAIL :</span><span class='WebSite'> "& rs1("emailID") &"</span></td></tr><tr><td></table>"
              end if
              rs1.close
              %> 
                      <form method="post" action="visaInfoSubmit.asp" name="queries">
                        <table width="75%" align="center">
                          <tr> 
                            <td colspan=6 align="center"> 
                              <div align="left"><span class="WSRightBold"> VISA 
                                REQUIREMENTS</span> </div>
                            </td>
                          </tr>
                          <%
      if request("submit")="Get Information" then
      %> 
                          <tr> 
                            <td colspan=6 align=="center"> <%
      
	     	stmt="select* from visaInfo where countryID="&country&"and categoryID="&category&" and countryFor="&countryF
			rs.open stmt,con,2,3
			if not rs.eof then
				information=ucase(rs("information"))
	            response.write information
          %> </td>
                          </tr>
	        <% else %> 
                          <tr> 
                            <td colspan=6 align=="center"> <%
			response.write "<br><br><center><B><FONT face='arial' SIZE='4'>FOR THIS QUERY PLEASE <a href='contactus.asp'>CONTACT US.</a> </FONT></B></center><br><br>"
			end if
		end if
		
             
               %> </td>
                          </tr>

                          <tr> 
                            <td colspan=4 align="center">&nbsp; </td>
                            <td colspan=4 align=="center" width="52%"> </td>
                          </tr>
                        </table>
                        <!-- #include file="HomeBottom.asp" -->
                      </form>
                      </font></span>
                </table>
            </table>
      </table>
</table>
