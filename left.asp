<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
<!--
function refsub()
{
document.searchform.method="post";
document.searchform.action="searchPax.asp";
document.searchform.submit();
}


function MM_swapImgRestore() { //v2.0
  if (document.MM_swapImgData != null)
    for (var i=0; i<(document.MM_swapImgData.length-1); i+=2)
      document.MM_swapImgData[i].src = document.MM_swapImgData[i+1];
}

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

<body bgcolor="#FFFFFF" onLoad="MM_preloadImages('images/home2.jpg','#982339540000');MM_preloadImages('images/news2.jpg','#982339618320');MM_preloadImages('images/services2.jpg','#982339651880');MM_preloadImages('images/about2.jpg','#982339709880');MM_preloadImages('images/contact2.jpg','#982339751960');MM_preloadImages('images/go2.jpg','#982340617580')">
<table width="0%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="0%" border="0" cellpadding="0" cellspacing="0">
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
                    <form name="searchform" action="searchPax.asp">
                      <tr> 
                        <td> 
                          <input type="text" name="keywords" size="7">
                        </td>
                      </tr>
                      <tr> 
                        <td><img src="images/pixel.gif" width="65" height="1"></td>
                      </tr>
                    </form>
                  </table>
                </td>
                <td width="34%"><img src="images/go1.jpg" onclick="refsub()" width="38" height="28" name="Image6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('document.Image6','document.Image6','images/go2.jpg','#982340617580')"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><img src="images/last.jpg" width="114" height="94"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
