<% response.buffer=true %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
function MM_preloadImages() { //v2.0
  if (document.images) {
    var imgFiles = MM_preloadImages.arguments;
    if (document.preloadArray==null) document.preloadArray = new Array();
    var i = document.preloadArray.length;
    with (document) for (var j=0; j<imgFiles.length; j++) if (imgFiles[j].charAt(0)!="#"){
      preloadArray[i] = new Image;
      preloadArray[i++].src = imgFiles[j];
  } }
}

function MM_swapImgRestore() { //v2.0
  if (document.MM_swapImgData != null)
    for (var i=0; i<(document.MM_swapImgData.length-1); i+=2)
      document.MM_swapImgData[i].src = document.MM_swapImgData[i+1];
}

function MM_swapImage() { //v2.0
  var i,j=0,objStr,obj,swapArray=new Array,oldArray=document.MM_swapImgData;
  for (i=0; i < (MM_swapImage.arguments.length-2); i+=3) {
    objStr = MM_swapImage.arguments[(navigator.appName == 'Netscape')?i:i+1];
    if ((objStr.indexOf('document.layers[')==0 && document.layers==null) ||
        (objStr.indexOf('document.all[')   ==0 && document.all   ==null))
      objStr = 'document'+objStr.substring(objStr.lastIndexOf('.'),objStr.length);
    obj = eval(objStr);
    if (obj != null) {
      swapArray[j++] = obj;
      swapArray[j++] = (oldArray==null || oldArray[j-1]!=obj)?obj.src:oldArray[j];
      obj.src = MM_swapImage.arguments[i+2];
  } }
  document.MM_swapImgData = swapArray; //used for restore
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td>&nbsp;</td></tr>
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="2%"> 
            <table width="75%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="images/bird1.jpg" width="114" height="81"></td>
              </tr>
              <tr>
                <td><img src="images/bird2.jpg" width="114" height="57"></td>
              </tr>
              <tr>
                <td><img src="images/home1.jpg" width="114" height="31" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image1','document.Image1','images/home2.jpg','#982339540000')"></td>
              </tr>
              <tr>
                <td><img src="images/news1.jpg" width="114" height="32" name="Image2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image2','document.Image2','images/news2.jpg','#982339618320')"></td>
              </tr>
              <tr>
                <td><img src="images/services1.jpg" width="114" height="34" name="Image3" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image3','document.Image3','images/services2.jpg','#982339651880')"></td>
              </tr>
              <tr>
                <td><img src="images/about1.jpg" width="114" height="36" name="Image4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image4','document.Image4','images/about2.jpg','#982339709880')"></td>
              </tr>
              <tr>
                <td><img src="images/contact1.jpg" width="114" height="33" name="Image5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image5','document.Image5','images/contact2.jpg','#982339751960')"></td>
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
                      <td width="34%"><img src="images/go1.jpg" width="38" height="28" name="Image6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image6','document.Image6','images/go2.jpg','#982340617580')"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td><img src="images/last.jpg" width="114" height="94"></td>
              </tr>
            </table>
          </td>
          <td width="98%" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="images/top.jpg" WIDTH="646" HEIGHT="98"></td>
              </tr>
              <tr>
                <td valign="top"> 
                  <table width="99%" border="0">
                    <tr> <%RESPONSE.WRITE session("lname")%> 
                      <td><a href="entry.asp">Submission</a></td>
                      <td><a href="collection.asp">Collection</a></td>
                      <td><a href="status.asp">Status</a></td>
                      <td>Reports</td>
                      <td>Visa Info</td>
                      <td><a href="searchEntry.asp">Search </a></td>
                    </tr>
                    <tr> 
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000">SUBMISSION 
                        FORM</font></b> </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <table border="0" align="center">
              <tr>
                <td> <font size="2" color="#006600"><%

response.write "<P align=center>The entry for the agent <b>"
call writeIDDescription("agents",request("agent"))
REsponse.write "</B>regarding  Passenger <b>"&ucase(request("pname"))& "</b> have been recorded successfully."
response.write "<P align=center>The reference number for this record is <b><font size=3 color=blue>"&request("refno")& " </font></b>."
%> <br>
                  To add more entries <a href="entry.asp"> <b>click here</b></a>. </font></td>
              </tr>
            </table>

</td>
        </tr>
      </table>
    </td>
  </tr>
  
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
