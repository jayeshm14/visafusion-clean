<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
input.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 9pt; font-style: normal; background-color: #FFCC00; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px}
-->
</style>
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
<script language="javascript">
function checkup()
{
if(document.formup.keywords.value==""){
alert("Please enter any keyword !.")
document.formup.keywords.focus()
return false
}
document.formup.submit()
}
</script>

<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="images/topn1.jpg" width="760" height="71"></td>
        </tr>
        <tr> 
          <td> 
            
      <table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="images/pixekn.gif" width="11" height="20"></td> 
                
          <td colspan="2"><a href="default.asp"><img src="images/homenf1.gif" width="99" height="20" border="0"></a></td>
                
          <td width="13%"><a href="profile.asp"><img src="images/profilen1.gif" width="102" height="20" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/profilen2.gif',1)" border="0"></a></td>
                
          <td width="13%"><a href="update.asp"><img src="images/updaten1.gif" width="102" height="20" name="Image2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/updaten2.gif',1)" border="0"></a></td>
                
          <td width="13%"><a href="registration.asp"><img src="images/registrationn1.gif" width="102" height="20" name="Image3" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/registrationn2.gif',1)" border="0"></a></td>
                
          <td width="13%"><a href="contactus.asp"><img src="images/contactn1.gif" width="102" height="20" name="Image4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','images/contactn2.gif',1)" border="0"></a></td>
                
          <td width="13%"><a href="visaInfo.asp"><img src="images/queriean1.gif" width="101" height="20" name="Image5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','images/queriean2.gif',1)" border="0"></a></td>
                
          <td width="13%"><a href="logon.asp"><img src="images/logout1.gif" width="100" height="20" name="Image6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','images/logout2.gif',1)" border="0"></a></td>
                
          <td width="8%"><img src="images/pixekn.gif" width="58" height="20"></td>
              </tr>
            </table>
          </td>
        </tr>
        
  <tr bordercolor="#666633"> 
    <td> 
      
        
      <table width="93%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFE898">
        <tr>
          <td bgcolor="#FFFFFF"><img src="images/pixekn.gif" width="8" height="8"></td> 
          <td>
            <div align="center"><span class="barfont"><a href="agentHome.asp?uname=<%=session("uname")%>">Agents</a> | 
				<a href="entry.asp#formtop?uname=<%=session("uname")%>">Submission</a> 
              | <a href="collection.asp?uname=<%=session("uname")%>">Collection</a> 
              | <a href="holidayhome.asp?uname=<%=session("uname")%>">Holidays</a> 
              |<a href="visainfo.asp?uname=<%=session("uname")%>"> Visa Information</a> 
              | <a href="calendar.asp?uname=<%=session("uname")%>">Messages</a> 
              |<a href="searchEntry.asp?uname=<%=session("uname")%>">Advance Search</a> 
              |<a href="dailyprintref.asp?uname=<%=session("uname")%>">Daily Print</a> 
              |<a href="dailybill.asp?uname=<%=session("uname")%>">Dispatch</a>
			| <a href="javascript:print()">Print</a> | <%
              if session("priv")="adm" then
              %> <a href="administrator.asp?uname=<%=session("uname")%>"> <%
              else
              %> <a href="employee.asp?uname=<%=session("uname")%>"> <%
               end if
               %> Back</span></div>
          </td>
          
        </tr>
      </table>
      
    </td>
        </tr>
      </table>
   
<div align="left" class="TableCaption">
  <div id="Layer1" style="position:absolute; width:234px; height:35px; z-index:1; left: 329px; top: 7px"> 
    <form name=formup action="searchPax.asp" onSubmit="return checkup()">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Search</font></b></td>
        <td><b><font size="2">:</font></b></td>
        <td> 
          <input type="text" name="keywords">
        </td>
        <td> 
          <input class="ud" type="submit" name="Submit3" value="go">
        </td>
      </tr>
    </table>
</form>
  </div>
</div>
