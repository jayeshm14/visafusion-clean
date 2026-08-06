 <%@ Language=VBScript %>
<!-- #include file="connection.asp" --> 
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
//-->
</script>
<script language="javascript">
<!--
function CheckNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
return false;
}
}

function putvalue1(var1)
{
CheckNum(var1)
document.entry.entries.value = document.entry.totalp.value
}

function checkAll()
{
getentries=document.entry.entries.value
gettotalp=document.entry.totalp.value
getcountry=document.entry.countrylist.value
flag=0
msg=""
if (isNaN(getentries))
{
msg=msg+"Please enter a valid number in the entries.\n"
flag=1
}
if (isNaN(gettotalp))
{
msg=msg+"Please enter a valid number in the Passengers.\n"
flag=1
}

if (getcountry=="")
{
msg=msg+"Please select a country.\n"
}
if (flag==1)
{
alert(msg)
return false;
}

}

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
</head>

<body background="images/background.jpg" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/submission2.jpg','images/home2.jpg','images/news2.jpg','images/services2.jpg','images/about2.jpg','images/contact2.jpg','images/go2.jpg','images/collection2.jpg','images/edit2.jpg','images/reports2.jpg','images/visa2.jpg','images/advsearch2.jpg')">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="15%" valign="top"> 
            <table width="75%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="images/bird1.jpg" width="114" height="81"></td>
              </tr>
              <tr>
                <td><img src="images/bird2.jpg" width="114" height="57"></td>
              </tr>
              <tr>
                <td><img src="images/home1.jpg" width="114" height="31" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/home2.jpg',1)"></td>
              </tr>
              <tr>
                <td><img src="images/news1.jpg" width="114" height="32" name="Image2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/news2.jpg',1)"></td>
              </tr>
              <tr>
                <td><img src="images/services1.jpg" width="114" height="34" name="Image3" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','images/services2.jpg',1)"></td>
              </tr>
              <tr>
                <td><img src="images/about1.jpg" width="114" height="36" name="Image4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','images/about2.jpg',1)"></td>
              </tr>
              <tr>
                <td><img src="images/contact1.jpg" width="114" height="33" name="Image5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','images/contact2.jpg',1)"></td>
              </tr>
              <tr>
                <td><img src="images/search.jpg" width="114" height="26"></td>
              </tr>
              <tr>
                <td>
                  <table width="75%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="9%"><img src="images/1.jpg" width="11" height="28"></td>
                      <td width="57%"> 
                        <table width="75%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><img src="images/pixel.gif" width="65" height="1"></td>
                          </tr>
                          <tr>
                            <td>
                              <input type="text" name="textfield" size="7">
                            </td>
                          </tr>
                          <tr>
                            <td><img src="images/pixel.gif" width="65" height="1"></td>
                          </tr>
                        </table>
                      </td>
                      <td width="34%"><img src="images/go1.jpg" width="38" height="28" name="Image6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','images/go2.jpg',1)"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td><img src="images/last.jpg" width="114" height="94"></td>
              </tr>
            </table>
          </td>
          <td width="85%" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td colspan="6"><img src="images/top.jpg" WIDTH="646" HEIGHT="98"></td>
              </tr>
              <tr> <%RESPONSE.WRITE session("lname")&session("uname")%> 
                <td colspan="6"><font size="2" face="Arial, Helvetica, sans-serif"></font><font size="2" face="Arial, Helvetica, sans-serif"></font> 
                  <table width="99%" border="0">
                    <tr>
                      <td><font size="2" face="Arial, Helvetica, sans-serif"><a href="entry.asp"><img src="images/submission1.jpg" width="102" height="20" border="0" name="Image7" onMouseOver="MM_swapImage('Image7','','images/submission2.jpg',1)" onMouseOut="MM_swapImgRestore()"></a></font></td>
                      <td><a href="collection.asp"><img src="images/collection1.jpg" width="102" height="20" name="Image8" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','images/collection2.jpg',1)" border="0"></a></td>
                      <td><a href="editEntry.asp"><img src="images/edit1.jpg" width="102" height="20" name="Image9" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','images/edit2.jpg',1)" border="0"></a></td>
                      <td><img src="images/reports1.jpg" width="102" height="20" name="Image10" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','images/reports2.jpg',1)"></td>
                      <td><img src="images/visa1.jpg" width="102" height="20" name="Image11" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','images/visa2.jpg',1)"></td>
                      <td><a href="searchEntry.asp"><img src="images/advsearch1.jpg" width="102" height="20" name="Image12" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','images/advsearch2.jpg',1)" border="0"></a></td>
                    </tr>
                  </table>
                  </td>
              </tr>
              <tr> 
                <td height="4" colspan="6"> 
                  <p align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#FF0000">
                    </font></font></b></p>
                </td>
              </tr>
              <tr> <font size="3" color="#006600" face="arial"><b><%RESPONSE.WRITE session("uname")%></b></font> 
            </table>
           
            <form action="searchentry.asp" method="post" name="entry" onsubmit="return checkAll()">
              <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
                  <td>
                    
                      
                    <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
                      <tr bgcolor="#FFFFF0"> 
                        <td height="19"> 
                          <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><i>SEARCH RESULT</i></font></font></b> </div>
                        </td>
                        <tr>
                        <!-- #include file="listCountryone.asp" -->
                        </tr>
</table>
<font size="2" face="Arial, Helvetica, sans-serif" color="#0000CC"><b> </b></font> 
</body>
</html>
