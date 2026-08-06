<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<script language="javascript">
function checkAll()
{
	MYflag=0
	flag=0
	msg=""
	a=document.agentform.agent.value
	len1=a.length
	//alert("value & len:"+a+ulen)
	if (len1==0)
	{
	msg=msg+"AGENT NAME IS REQUIRED.\n"
	flag=1
	}
	
	
	for (i=0 ; i<len1;i++)
	{
	  str=a.substring(i,i+1)
	  
		if(str==" ")
		{ 
		
		 MYflag=1
		}
	}
	if (MYflag==1)
	{
	msg=msg+"SPACES ARE NOT ALLOWED IN AGENT NAME.\n"
	flag=1
	}
	
	if (flag==1)
	{
	alert(msg)
	return false;
	}
}
function checkNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
window.document.agentform.payment.select()
return false;
}
}

</script>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">

          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
               <td> 
      
<!-- here i have to put  code -->
<% if request("agentusb")="yesuma" then
%>
<!-- #include file="topagent.asp" -->           
<% else 
if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
end if
%>
<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
input.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 9pt; font-style: normal; background-color: #FFCC00; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px}
-->
</style>
            <script>
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

<script language="JavaScript1.2"  type="text/javascript">
	<!--

		function UdaanChat() {
window.open("http://www.udaanindia.com/chat/Clientdefault.asp?uname=<%= Chatid %>","","height=500,width=500,left=80,top=80");
		}

	// -->
</script>



<style type="text/css">
<!--
a.ud {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #333333; text-decoration: none}
a.ud:hover {  font-family: Arial, Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>
<link rel="stylesheet" href="Styles.css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="114">



              <tr>
                
          <td> <body bgcolor="#FFFFFF"> 
            <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr> 
                <td> 
                  <table width="75%" align="center" cellpadding="0" cellspacing="0">
                    <tr bgcolor="#FFE898"> 
                      <td height="19"> 
                        <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><span class="tableCaption">VISA 
                          FORMS</span></font></font></b> </div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="2"> 
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
                    </tr>
                    <tr bgcolor="#009933"> 
                      <td height="4626"> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                            <td bgcolor="#FFFFFF"> 
                              <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                <tr> 
                                  <td> 
                                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" height="8" >
                                      <tr> 
                                        <td height="2"> 
                                          <div align="center"><span class="WSRightBold"><font size="3"><a href="#a">A</a> 
                                            - <a href="#b">B</a> - <a href="#c">C</a> 
                                            - <a href="#d">D</a> - <a href="#e">E</a> 
                                            - <a href="#f">F</a> - <a href="#g">G</a> 
                                            - <a href="#h">H</a> -<a href="#i"> 
                                            I </a>- <a href="#j">J</a> - <a href="#k">K</a> 
                                            - <a href="#l">L</a> - <a href="#m">M</a> 
                                            - <a href="#n">N</a> - <a href="#o">O</a> 
                                            - <a href="#p">P</a> - Q - <a href="#r">R</a> 
                                            - <a href="#s">S</a> - <a href="#t">T</a> 
                                            - <a href="#u">U</a> - <a href="#v">V</a> 
                                            - W - X - <a href="#y">Y</a> - <a href="#z">Z</a></font></span></div>
                                        </td>
                                      </tr>
                                      <tr> 
                                        <td height="2"> 
                                              <table width="100%" border="1" height="4229" bordercolor="#003333">
                                                <tr> 
                                                  <td colspan="14" height="57"> 
                                                    <div align="justify"><font face="Arial" size="2"><b><font face="Verdana" size="3">YOU 
                                                      CAN DOWNLOAD FORMS BY CLICK 
                                                      ON BELOW LINKS, THE FILES 
                                                      ARE IN .PDF FORMAT (<font color="#6666FF">PLEASE 
                                                      OPEN WITH ACROBAT READER</font>), 
                                                      IT WILL TAKE SOME TIME TO 
                                                      DOWNLOAD.<br>
                                                      </font><br>
                                                      <font color="#FF3333" face="Verdana">FOR 
                                                      DOWNLOAD ACROBAT READER 
                                                      CLICK HERE --&gt;&gt;</font></b></font> 
                                                      <font face="Arial" size="2"><a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank"><img src="updateimg/get_adobe_reader.gif" width="88" height="31" border="0"></a></font></div>
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="5"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">A</font><a name="a"></a></b></font></td>
                                                  <td width="87%" height="5">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">ARGENTINA</font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Argentina.pdf" target="_blank">ARGENTINA 
                                                    VISA FORM</a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="39"><font face="Verdana"><b><font size="3">AUSTRALIA</font></b></font></td>
                                                  <td width="87%" height="39"> 
                                                    <p><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                      <font face="Verdana"><a href="http://www.udaanindia.com/forms/aus/48R-Tourist.pdf" target="_blank"><b><font size="2">TOURIST( 
                                                      48R )</font></b></a> <font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></font> 
                                                      <font face="Verdana"><a href="http://www.udaanindia.com/forms/aus/456-small%20stay%20business.pdf" target="_blank"><font size="2"><b>BUSINESS( 
                                                      456 )</b></font></a> <font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></font> 
                                                      <font face="Verdana"><a href="http://www.udaanindia.com/forms/aus/M67-FAMILY%20SHEET.pdf" target="_blank"><font size="2"><b>DETAIL 
                                                      OF RELATIVES<br>
                                                      ( M-67 ) </b></font><font face="Verdana"><font size="2"></font></font><font size="2"><b> 
                                                      </b></font><font face="Verdana"><font size="2"><b></b></font></font></a><font face="Verdana"><font face="Verdana"><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></font><font size="2"><b><a href="http://www.udaanindia.com/forms/aus/1066-long%20stay%20business.pdf" target="_blank">LONG 
                                                      STAY BUSINESS FORM( 1066 
                                                      )</a></b></font></font><font size="2"><b> 
                                                      <br>
                                                      </b></font><font size="2"><b> 
                                                      </b></font></font> <font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                      <font face="Verdana"><a href="http://www.udaanindia.com/forms/aus/876-Transit%20form.pdf" target="_blank"><font size="2"><b>TRANSIT 
                                                      FORM( 876 )</b></font></a> 
                                                      </font><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                      <b><font size="2" face="Verdana"><a href="http://www.udaanindia.com/forms/aus/Medical%20Form%20No-26.pdf">MEDICAL 
                                                      FORM ( No-26)</a></font></b> 
                                                      <b><font size="2" face="Verdana"><br>
                                                      <b><img src="images/dnload.gif" width="20" height="20"></b> 
                                                      <a href="http://www.udaanindia.com/forms/aus/Medical%20Form%20No-160.pdf">MEDICAL 
                                                      FORM ( No-160 )</a></font></b><font face="Verdana"> 
                                                      <font face="Verdana"><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></font> 
                                                      <b><font size="2"><a href="http://www.udaanindia.com/forms/aus/AUTHORISATION%20FORM%20FOR%20AUSTRALIA-956.pdf">AUTHORISATION 
                                                      FORM FOR AUSTRALIA-( 956 
                                                      ) </a></font></b> </font></p>
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="20"><font face="Verdana" size="3"><b>AFGHANISTAN</b></font></td>
                                                  <td width="87%" height="20"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Afganistan.pdf" target="_blank">AFGHANISTAN 
                                                    VISA FORM</a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="20"><font face="Verdana" size="3"><b>ALGERIA</b></font></td>
                                                  <td width="87%" height="20"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/algeria.pdf" target="_blank">ALGERIA 
                                                    VISA FORM</a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="20"><font face="Verdana" size="3"><b>ANGOLA</b></font></td>
                                                  <td width="87%" height="20"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/ANGOLA.PDF" target="_blank">ANGOLA 
                                                    VISA FORM</a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="20"><font face="Verdana" size="3"><b>ARMENIA</b></font></td>
                                                  <td width="87%" height="20"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Armenia.pdf" target="_blank">ARMENIA 
                                                    VISA FORM</a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="20"><font face="Verdana"><b><font size="3">AUSTRIA</font></b></font></td>
                                                  <td width="87%" height="20"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/austria.pdf" target="_blank"><b><font size="2">AUSTRIA 
                                                    FORM</font></b></a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b>AZERBAIJAN</b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/Azerbaijan.pdf" target="_blank"><b><font size="2">AZERBAIJAN 
                                                    VISA FORM</font></b></a></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">B</font><a name="b"></a></b></font></td>
                                                  <td width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">BAHAMAS</font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/uk/VAF5%20-%20Overseas%20Territory%20visa%20form.pdf" target="_blank"><b><font size="2">BAHAMAS 
                                                    / BELIZE VISA FORM</font></b></a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">BELGIUM</font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/Belgium.pdf" target="_blank"><b><font size="2">BELGIUM 
                                                    VISA FORM</font></b></a></font>
                                                    <img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/BELGIUM-MEDICAL-ATT.pdf" target="_blank"><b><font size="2">BELGIUM 
                                                    MEDICAL ATT. FORM</font></b></a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BELARUS</b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/BELARUS%20VISA%20FORM.pdf" target="_blank"><b><font size="2">BELARUS 
                                                    VISA FORM</font></b></a></font><font face="Verdana" size="2"><b> 
                                                    </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BENIN</b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Benin.pdf" target="_blank"><b>BENIN 
                                                    VISA FORM</b></a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">BRAZIL</font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/Brazil.pdf" target="_blank"><b><font size="2">BRAZIL 
                                                    VISA FORM</font></b></a> </font><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/Brazil%20Seaman%20Family.pdf" target="_blank"><b><font size="2">LETTER 
                                                    OF FORMAT FROM SHIPPING COMPANIES 
                                                    ( SEAMAN FAMILY )</font></b></a></font>
                                                    <font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/Brazil%20work%20letter%20of%20undertaking.pdf" target="_blank"><b><font size="2"> Letter of Undertaking (Brazil Work)
                                                    </font></b></a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">BULGARIA</font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/BULGARIA%20VISA%20FORM.pdf" target="_blank"><b><font size="2">BULGARIA 
                                                    VISA FORM</font></b></a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BURKINA 
                                                    FASO</b></font> </td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Burkina%20Faso.pdf" target="_blank"><b>BURKINA 
                                                    FASO VISA FORM</b></a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana"><b><font size="3">BRUNEI 
                                                    DARUSSALAM </font></b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/BRUNEI/Brunei.pdf" target="_blank"><b>BRUNEI 
                                                    DARUSSALAM VISA FORM</b></a> 
                                                    <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/BRUNEI/Bru-doct-list.pdf">LIST 
                                                    OF PANEL DOCTORS</a><br>
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/BRUNEI/bru-medical-form.pdf">BRUNEI 
                                                    MEDICAL FORM</a></b></font></td>
                                                </tr>
                                                <tr>
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BOTSWANA</b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/BOTSWANA.pdf" target="_blank"><b><font size="2">BOTSWANA 
                                                    VISA FORM</font></b></a></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BOSNIA 
                                                    HERZEGOVINA </b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/BOSNIA%20HERZEGOVINA.pdf">BOSNIA 
                                                    HERZEGOVINA VISA FORM</a></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Verdana" size="3"><b>BANGLADESH</b></font></td>
                                                  <td width="87%" height="2"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/bangladesh.pdf" target="_blank"><b>BANGLADESH 
                                                    VISA FORM</b></a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">C</font><a name="c"></a></b></font></td>
                                                  <td width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="25"><font face="Verdana"><b><font size="3">CANADA</font></b></font></td>
                                                  <td valign="top" width="87%" height="25"> 
                                                    <p><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <a href="http://www.udaanindia.com/forms/canada/canada-family-sheet.pdf" target="_blank">CANADA 
                                                      FAMILY SHEEET</a> <b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <b><a href="http://www.udaanindia.com/forms/canada/IMM5257B-RESIDANT.pdf" target="_blank">BUSINESS,TOURIST 
                                                      AND RESIDENCE FORM </a></b><img src="images/dnload.gif" width="20" height="20"> 
                                                      </b></b><b><a href="http://www.udaanindia.com/forms/canada/IMM1295B-WORK.pdf" target="_blank">CANADA 
                                                      WORK VISA FORM</a></b> <b><img src="images/dnload.gif" width="20" height="20"></b><b><b><a href="http://www.udaanindia.com/forms/canada/IMM1294S-STUDY.pdf" target="_blank">CANADA 
                                                      STUDY VISA FORM</a></b></b><br>
                                                      <b></b> <b><b></b></b></b></b></font><font face="Verdana"><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b></font></b></font></b></font></font><font size="2" face="Verdana"><b><b><a href="http://www.udaanindia.com/forms/canada/Canada-Travellor-Form.pdf" target="_blank">CANADA 
                                                      TRAVELER FORM</a></b></b></font> 
                                                      <font face="Verdana"><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b></font></b></font></b></font></font> 
                                                      <font size="2" face="Verdana"><b><b><a href="http://www.udaanindia.com/forms/canada/Student-Questionaire.pdf" target="_blank">STUDENT 
                                                      QUESTIONAIRE FORM<br>
                                                      </a></b></b></font>
                                                      <font face="Verdana"><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/canada/Canada%20Consent%20Form.pdf">CANADA 
                                                      CONSENT FORM</a></b></font></b></font></b></font></b></font></font> 
                                                    </p>
                                                    <font face="Verdana"><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/canada/Canada%20Authority%20Letter.pdf">CANADA 
                                                      AUTHORITY LETTER</a></b></font></b></font></b></font></b></font></font> 
                                                    </p>
                                                  </td>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="21"><font face="Verdana"><b><font size="3">CHINA</font></b></font></td>
                                                  <td valign="top" width="87%" height="21"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/china.pdf" target="_blank">CHINA 
                                                    VISA FORM </a></b></font><font face="Verdana"><img src="images/dnload.gif" width="20" height="20"><u><font color="#0000CC"><a href="http://www.udaanindia.com/forms/China Medical form.pdf" target="_blank"><b><font size="2">CHINA 
                                                    MEDICAL FORM</font></b></a></font></u></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top"><font face="Verdana" size="3"><b>CHILE</b></font></td>
                                                  <td valign="top" width="87%"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Chile.pdf" target="_blank">CHILE 
                                                    VISA FORM</a> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/CHILE-AUTH.DOC" target="_blank">CHILE 
                                                    AUTHORITY LETTER</a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top"><font face="Verdana" size="3"><b>CONGO</b></font></td>
                                                  <td valign="top" width="87%"><font face="Verdana" size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Congo.pdf" target="_blank">CONGO 
                                                    VISA FORM</a> </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top"><font face="Verdana"><b><font size="3">CYPRUS</font></b></font></td>
                                                  <td valign="top" width="87%"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/Cyprus.pdf" target="_blank"><b><font size="2">CYPRUS 
                                                    VISA FORM</font></b></a> </font><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/Cyprus%20Sponsership%20form.pdf" target="_blank"><b><font size="2">CYPRUS 
                                                    SPONSERSHIP FORM</font></b></a></font><font size="2" face="Verdana"><b><b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">CROATIA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Croatia.pdf" target="_blank"><b>CROATIA 
                                                    VISA FORM</b></a> <img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Croatia%20Invitation%20Format.pdf" target="_blank"><b>CROATIA 
                                                    INVITATION FORMAT<br>
                                                    </b></a><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Croatia%20Sponsership%20Format.pdf" target="_blank"><b>CROATIA 
                                                    SPONSERSHIP FORMAT</b></a> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>CUBA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/CUBA.PDF" target="_blank"><b>CUBA 
                                                    VISA FORM</b></a> </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">CZECH</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b> 
                                                    <img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font face="Verdana"><a href="http://www.udaanindia.com/forms/czech.pdf" target="_blank"><b><font size="2">CZECH 
                                                    VISA FORM</font></b></a> </font><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/Czech%20Affidavit.pdf" target="_blank"><b><font size="2">AFFIDAVIT 
                                                    ONLY FOR CZECH MULTIPLE VISA</font></b></a>
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></b></font><font face="Verdana"><a href="http://www.udaanindia.com/forms/Czech%20Attestation.pdf" target="_blank"><b><font size="2">CZECH ATTESTATION VISA</font></b></a></font><font size="2" face="Verdana"><b><b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>COSTA 
                                                    RICA </b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/costarica.pdf" target="_blank"><b>COSTA 
                                                    RICA VISA FORM</b></a> </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>CAMBODIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Cambodia.pdf" target="_blank"><b>CAMBODIA 
                                                    VISA FORM</b></a> </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>COLOMBIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/columbia.pdf" target="_blank"><b>COLOMBIA 
                                                    VISA FORM</b></a></b> <b><img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/Colombia%20work%20permit.pdf" target="_blank"><b>COLOMBIA 
                                                    WORK VISA FORM</b></a></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">D</font><a name="d"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="29"><font face="Verdana" size="3"><b>DJIBOUTI</b></font></td>
                                                  <td valign="top" width="87%" height="29"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/DJIBOUTI.pdf" target="_blank">DJIBOUTI 
                                                    VISA FORM</a> </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="29"><font face="Verdana"><b><font size="3">DUBAI</font></b></font></td>
                                                  <td valign="top" width="87%" height="29"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/Dubai.pdf">DUBAI 
                                                    VISA FORM</a></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="29"><font face="Verdana"><b><font size="3">DENMARK</font></b></font></td>
                                                  <td valign="top" width="87%" height="29"> 
                                                    <font face="Verdana"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b> 
                                                    <a href="http://www.udaanindia.com/forms/DENMARK.pdf">DENMARK 
                                                    VISA FORM </a><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <font size="2"><a href="http://www.udaanindia.com/forms/DENMARK-WORK.pdf">DENMARK 
                                                    WORK VISA FORM</a></font><br>
                                                    </b></font><font face="Verdana"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b></font></b></font><font size="2"><b> 
                                                    </b></font><font face="Verdana"><b><font size="2"><a href="http://www.udaanindia.com/forms/DENMARK%20FAMILY%20INFORMATION.pdf">DENMARK 
                                                    FAMILY INFORMATION VISA FORM</a></font></b></font><font size="2"><b> 
                                                    </b></font><font face="Verdana"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b></font></b></font> 
                                                    </b></font><font face="Verdana"><b><font size="2"><a href="http://www.udaanindia.com/forms/DENMARK%20CONSENT%20FORM.pdf" target="_blank">DENMARK 
                                                    CONSENT VISA FORM</a></font></b></font>
                                                    <font face="Verdana"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"></b></font></b></font></b></font><font size="2"><b> 
                                                    </b></font><font face="Verdana"><b><font size="2"><a href="http://www.udaanindia.com/forms/DENMARK%20DECLARATION%20MEDICAL%20INSURANCE.pdf">DECLARATION-MEDICAL TRAVEL INSURANCE
                                                    </a></font></b></font><font size="2"><b> 
                                                    </b></font>
                                                    <font size="2"><b> 
                                                    <font size="2"><b> </b></font></b></font></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="31"><font face="Verdana" size="3"><b>DOMINICAN 
                                                    REPUBLIC </b></font></td>
                                                  <td valign="top" width="87%" height="31"><font face="Verdana"><b><font size="2"><b><font size="2"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    </b></font><font face="Verdana"><b><font size="2"><a href="http://www.udaanindia.com/forms/DOMINICAN%20REPUBLIC.pdf">DOMINICAN 
                                                    REPUBLIC VISA FORM</a></font></b></font><font size="2"><b> 
                                                    </b></font></b></font></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="31"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">E</font><a name="e"></a> 
                                                    </b></font></td>
                                                  <td valign="top" width="87%" height="31">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ETHIOPIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><a href="http://www.udaanindia.com/forms/ETHIOPIA.pdf">ETHIOPIA 
                                                    VISA FORM</a></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ESTONIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><a href="http://www.udaanindia.com/forms/Estonia.pdf">ESTONIA 
                                                    VISA FORM</a> <b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/Estonia-inv.pdf">ESTONIA 
                                                    INVITATION FORM</a></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">ECUADOR</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><a href="http://www.udaanindia.com/forms/Ecuador%20visa%20form.pdf">ECUADOR 
                                                    VISA FORM</a></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ERITREA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><a href="http://www.udaanindia.com/forms/Eritrea.pdf">ERITREA 
                                                    VISA FORM</a></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">EGYPT</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/Egypt.pdf">EGYPT 
                                                    VISA FORM</a></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">EL SALVADOR</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/EL-SALVADOR.pdf">EL SALVADOR 
                                                    VISA FORM</a></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">F</font><a name="f"></a> 
                                                    </b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">FINLAND</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><a href="http://www.udaanindia.com/forms/FINLAND.PDF">FINLAND 
                                                    VISA FORM</a> <b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><a href="http://www.udaanindia.com/forms/Finland%20work%20permit.pdf">FINLAND 
                                                    WORK VISA FORM</a></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">FRANCE</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><a href="http://www.udaanindia.com/forms/France.pdf">FRANCE 
                                                    VISA FORM </a></b></b></b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><a href="http://www.udaanindia.com/forms/France%20Undertaking%20Form.pdf">FRANCE 
                                                    UNDERTAKING FORM</a></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">G</font><a name="g"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>GABON</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/GABON%20VISA%20FORM.PDF">GABON 
                                                    VISA FORM</a></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>GAMBIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/GAMBIA%20VISA%20FORM.pdf">GAMBIA 
                                                    VISA FORM</a></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>GHANA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Ghana.pdf">GHANA 
                                                    VISA FORM</a></b></b></b></b> 
                                                    </b></b></font> </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>GEORGIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/Georgia.pdf">GEORGIA 
                                                    VISA FORM</a></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">GERMANY</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/German.pdf">GERMANY 
                                                    VISA FORM</a></b></b></b></b></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Germany%20Residence%20visa.pdf">GERMANY 
                                                    RESIDENCE VISA FORM<br>
                                                    </a></b></b></b></b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><a href="http://www.udaanindia.com/forms/Germany%20Residence%20visa.pdf"> 
                                                    </a><a href="http://www.udaanindia.com/forms/Germany%20Declaration%20Form.pdf" target="_blank">GERMANY 
                                                    DECLARATION FORM </a></b></b></b></b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/GERMAN%20LONG%20TERM%20DECLARATION%20FORM.pdf" target="_blank">GERMANY 
                                                    LONG TERM DECLARATION FORM</a></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">GREECE</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Greece.pdf">GREECE 
                                                    VISA FORM</a></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>GUYANA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/GUYANA%20VISA%20FORM.pdf">GUYANA 
                                                    VISA FORM</a></b></b></b></b></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">H</font><a name="h"></a> 
                                                    </b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">HONGKONG</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Hong-kong.pdf">HONGKONG 
                                                    VISA FORM</a></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">HUNGARY</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><a href="http://www.udaanindia.com/forms/Hungary%20Long%20Term.pdf">HUNGARY 
                                                    LONG TERM VISA FORM</a></b></b></b></b></b> 
                                                    <b><img src="images/dnload.gif" width="20" height="20"></b></b> 
                                                    <b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Hungary%20Short%20Term.pdf">HUNGARY 
                                                    SHORT TERM VISA FORM</a></b></b></b></b></b></b> 
                                                    <b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/Hungary%20Declaration%20Form.pdf">HUNGARY 
                                                    DECLARATION FORM FOR MULTIPLE 
                                                    VISA<br>
                                                    </a></b></b></b></b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/Schengen%20visa%20form%20-%20Hungary.pdf">SCHENGEN 
                                                    VISA FORM FOR HUNGARY</a></b></b></b></b> 
                                                    </b></b></b>
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/Undertaking%20Visa%20form.pdf">UNDERTAKING 
                                                    FORM FOR HUNGARY </a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">I</font><a name="i"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">ICELAND</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><a href="http://www.udaanindia.com/forms/ICELAND.pdf">ICELAND 
                                                    VISA FORM</a></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">INDONESIA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><a href="http://www.udaanindia.com/forms/INDONESIA.pdf">INDONESIA 
                                                    VISA FORM</a></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">ISRAEL</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/ISRAEL.PDF">ISRAEL 
                                                    VISA FORM</a></b> <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/ISRAEL-DATA-PROTECTION-NOTICE.PDF">ISRAEL DATA PROTECTION NOTICE</a></b>
                                                    
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/ISRAEL-VFS-CONSENT.PDF">ISRAEL VFS CONSENT FORM 
                                                    </a></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>IRAQ</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Iraq.pdf">IRAQ 
                                                    VISA FORM</a></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>IRAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Iran.pdf">IRAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>IRELAND</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/IRELAND.pdf">IRELAND 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ITALY</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Italy.pdf">ITALY 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Italy%20Invitation%20Form.pdf">ITALY 
                                                    INVITATION FORM</a></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/DECLARATION%20ON%20TRAVEL%20HEALTH%20INSURANCE.pdf">DECLARATION 
                                                    ON TRAVEL HEALTH INSURANCE</a> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>IVORYCOAST</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/IVORYCOST.pdf">IVORYCOAST 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">J</font><a name="j"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">JAPAN</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Japan.pdf">JAPAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b>
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/Japan-Gaurantee-Letter.pdf">JAPAN GAURANTEE LETTER
                                                    </a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>JORDAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Jordan.pdf">JORDAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>JAMAICA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/JAMAICA.PDF">JAMAICA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">K</font><a name="k"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">KENYA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Kenya.pdf">KENYA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">KOREA(SOUTH)</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Koria(south).pdf">KOREA(SOUTH) 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>KAZAKSTAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Kazakhstan.pdf">KAZAKSTAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b>&nbsp; 
                                                 <img src="images/dnload.gif" width="20" height="20"> <a href="http://www.udaanindia.com/forms/covering_letter_kazakhstan.pdf">KAZAKHSTAN COVERING LETTER</a></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>KYRGYZSTAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/KYRGYZ.PDF">KYRGYZSTAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">L</font><a name="l"></a> 
                                                    </b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">LUXEMBOURG</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Luxembourg.pdf"> 
                                                    LUXEMBOURG VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>LAOS</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Laos.pdf">LAOS 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>LEBANON</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Lebanon.pdf">LEBANON 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>LESOTHO</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Lesotho.pdf">LESOTHO 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>LIBYA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Libya.pdf">LIBYA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>LITHUANIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Lithuania.pdf">LITHUANIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">M</font><a name="m"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">MALAYSIA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/malaysia.pdf">MALAYSIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">MALAWI</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/MALAWI.PDF">MALAWI 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">MAURITIUS</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Mauritius.pdf">MAURITIUS 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font size="3" face="Verdana"><b>MADAGASCAR</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></font> 
                                                    <font size="2" face="Verdana"><b><a href="http://www.udaanindia.com/forms/Madagascar.pdf">MADAGASCAR 
                                                    VISA FORM</a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">MOROCCO</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Morocco.pdf"> 
                                                    MOROCCO VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>MALTA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Malta.pdf">MALTA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>MEXICO</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Mexico.pdf">MEXICO 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b>
                                                    <img src="images/dnload.gif" width="20" height="20"> <b><a href="http://www.udaanindia.com/forms/Mexico-BIOMETRIC.PDF">MEXICO 
                                                    VISA FORM</a></b></font>
                                                    </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>MONGOLIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Mongolia.pdf">MONGOLIA 
                                                    BUSINESS VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> <img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/Mongoliatou.pdf">MONGOLIA 
                                                    TOURIST VISA FORM</a> 
                                                    </b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>MOZAMBIQUE</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Mozambique.pdf">MOZAMBIQUE 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>MYANMAR</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Myanmar-Business.pdf">MYANMAR 
                                                    BUSINESS FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Myanmar-Tourist.pdf">MYANMAR 
                                                    TOURIST FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b>
                                                    
                                                  <img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Myanmar-Arrival.pdf">MYANMAR 
                                                    ARRIVAL FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">N</font><a name="n"></a> 
                                                    </b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">NETHERLAND</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Netherlands.pdf">NETHERLAND 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Netherlands%20Antilles%20Visa%20Form.pdf">NETHERLAND 
                                                    ANTILLES VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="8"><font face="Verdana"><b><font size="3">NEW 
                                                    ZEALAND </font></b></font></td>
                                                  <td valign="top" width="87%" height="8"> 
                                                    <p><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Newzealand/newzealand%20familysheet.pdf">NEWZEALAND 
                                                      FAMILY SHEET FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1004-residant%20visa.pdf">NEWZEALAND 
                                                      RESIDENT VISA FORM </a><b><b><img src="images/dnload.gif" width="20" height="20"></b></b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1015-work%20permit.pdf">NEWZEALAND 
                                                      WORK PERMIT FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><img src="images/dnload.gif" width="20" height="20"></b></b> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf"> 
                                                      BUSINESS AND TOURIST FORM 
                                                      </a><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf"> 
                                                      </a><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Newzealand/Newzeland%20Study.pdf">NEWZEALAND 
                                                      STUDY FORM</a></b></b></b></b></b></b></b></b></b></b></b></b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf"> 
                                                      <br>
                                                      </a><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><a href="http://www.udaanindia.com/forms/Newzealand/nzis1017-Tour-Bussi.pdf"> 
                                                      </a><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      </b></b></b></b></b></b></b><a href="http://www.udaanindia.com/forms/Newzealand/Newzeland%20Transit.pdf">NEWZEALAND 
                                                      TRANSIT VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      </b></font></p>
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="2"> 
                                                    <font face="Verdana"><b><font size="3">NORWAY</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"> 
                                                    <p><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Norway%20Additional%20Form.pdf">NORWAY 
                                                      ADDITIONAL FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/norway%20residence%20or%20work%20permit.pdf">NORWAY 
                                                      RESIDENCE OR WORK FORM </a><b><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b></b><a href="http://www.udaanindia.com/forms/norway%20residence%20or%20work%20permit.pdf"> 
                                                      </a><b><a href="http://www.udaanindia.com/forms/NORWAY.PDF">NORWAY 
                                                      VISA FORM</a>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>NAMIBIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Namibia.pdf">NAMIBIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>NEPAL</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/nepal.pdf"> 
                                                    NEPAL VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>NICARAGUA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Nicaragua.pdf">NICARAGUA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>NIGER</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Niger.pdf">NIGER 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="20"><font face="Verdana" size="3"><b>NIGERIA</b></font></td>
                                                  <td valign="top" width="87%" height="20"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/Nigeria.pdf">NIGERIA 
                                                    VISA FORM</a></b><b><a href="http://www.udaanindia.com/forms/Nigeria%20Work,Dependent,twp-entry%20permit.pdf"> 
                                                    </a> </b><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/NIGERIA%20STR%20EMPLOYMENT%20FORM.pdf">NIGERIA 
                                                    STR EMPLOYMENT FORM<br>
                                                    </a><img src="images/dnload.gif" width="20" height="20"> 
                                                    <a href="http://www.udaanindia.com/forms/NIGERIA%20STR%20SPOUSE%20OR%20FAMILY%20MEMBER%20FORM.pdf">NIGERIA 
                                                    STR SPOUSE OR FAMILY MEMBER 
                                                    FORM</a></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="23"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">O</font><a name="o"></a></b></font></td>
                                                  <td valign="top" width="87%" height="23">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">OMAN</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b></font> 
                                                    <font size="2" face="Verdana"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Oman04.pdf">OMAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></font> 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">P</font><a name="p"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">PHILIPPINES</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Phillipines.pdf">PHILIPPINES 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Phillipines%20Medical%20visa%20form.pdf">PHILIPPINES 
                                                    MEDICAL VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">PORTUGAL</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/PORTUGAL.PDF">PORTUGAL 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>PERU</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Peru.pdf">PERU 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="26"><font face="Verdana" size="3"><b>PAKISTAN</b></font></td>
                                                  <td valign="top" width="87%" height="26"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Pakistan.pdf">PAKISTAN 
                                                    BUSINESS VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Pakistan-non-indians.pdf">PAKISTAN 
                                                    FOREIGN NATIONAL FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/PAKISTAN%20TOURIST%20FORM.pdf" target="_blank">PAKISTAN 
                                                    TOURIST VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>PAPUA 
                                                    NEW GUINEA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/PAPUA%20NEW%20GUINEA.pdf">PAPUA 
                                                    NEW GUINEA VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b>PARAGUAY</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/PARAGUAY.pdf">PARAGUAY 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>PANAMA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Panama.pdf">PANAMA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>POLAND</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/POLAND.PDF">POLAND 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">R</font><a name="r"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">RUSSIA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Russia.pdf">RUSSIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>RWANDA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Rwanda_all.pdf">RWANDA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ROMANIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Romania.pdf">ROMANIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">S</font><a name="s"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">SINGAPORE</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/singapore.pdf">SINGAPORE 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="19"><font face="Verdana"><b><font size="3">SOUTH 
                                                    AFRICA</font></b></font></td>
                                                  <td valign="top" width="87%" height="19"> 
                                                    <p><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/safrica/safrica.pdf">SOUTH 
                                                      AFRICA VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/safrica/safrica-tourist.pdf"> 
                                                      TOURIST VISA FORM (PAGE 
                                                      1)<br>
                                                      </a><b><b><b><b><b>
                                                      <img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/SA-powerofattorney.PDF"> 
                                                      POWER OF ATTORNEY FORM<br>
                                                      </a><b><img src="images/dnload.gif" width="20" height="20"></b></b></b><a href="http://www.udaanindia.com/forms/safrica/safrica2-tourist.pdf">TOURIST 
                                                      VISA FORM (PAGE 2) </a><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/safrica/WORK-STUDY-PERMIT.pdf"> 
                                                      WORK AND STUDY PERMIT FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <br>
                                                      <b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b> 
                                                      </b></b></b></b><a href="http://www.udaanindia.com/forms/safrica/S.Africa%20Medical%20and%20Radiological%20Report.pdf">SOUTH 
                                                      AFRICA MEDICAL AND RADIOLOGICAL 
                                                      REPORT</a><b><b><b><b> </b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></font></p>
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">SPAIN</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/SPAIN.PDF">SPAIN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Spain%20Authorisation%20Letter.PDF">SPAIN 
                                                    AUTHORIZATION FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">SRI 
                                                    LANKA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Srilanka.pdf">SRI 
                                                    LANKA VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="22"><font face="Verdana"><b><font size="3">SWEDEN</font></b></font></td>
                                                  <td valign="top" width="87%" height="22"> 
                                                    <p><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/sweden/appendix-A-Business.pdf">APPENDIX- 
                                                      A FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b> 
                                                      <a href="http://www.udaanindia.com/forms/sweden/appendix-B-Tourist.pdf">APPENDIX- 
                                                      B FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/sweden/appendix-D.pdf">APPENDIX- 
                                                      D FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      </b><br>
                                                      <b><b><img src="images/dnload.gif" width="20" height="20"></b></b> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/sweden/workpermit.pdf">WORK 
                                                      PERMIT VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/sweden/entryvisa.pdf">ENTRY 
                                                      VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <b><b><b><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b></b></b></b> 
                                                      <b><a href="http://www.udaanindia.com/forms/sweden/SWEDEN%20RESIDENCE%20VISA%20FORM.pdf">RESIDENCE 
                                                      VISA FORM</a></b>
                                                      <b><img src="images/dnload.gif" width="20" height="20"></b></b></b></b></b></b> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/sweden/POWER%20OF%20ATTORNEY.pdf">POWER 
                                                      OF ATTORNEY</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><b><b><b><img src="images/dnload.gif" width="20" height="20"></b></b></b></b></b></b> <b><a href="http://www.udaanindia.com/forms/sweden/swedan_consent.pdf">
                                                    SWEDISH VISA CONSENT FORM</a><img src="images/dnload.gif" width="20" height="20">
                                                    <a href="http://www.udaanindia.com/forms/sweden/swedan_medical.pdf">
                                                    MEDICAL TRAVEL DECLARATION 
                                                    FORM</a></font></p>
                                                  
                                                 <img src="images/dnload.gif" width="20" height="20">
                                                    <a href="http://www.udaanindia.com/forms/DISCLAMER.pdf">
                                                   DISCLAMER</a></font></p>
                                                  </td> 
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">SWITZERLAND</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/switzerland.pdf">SWITZERLAND 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b>
                                                    </font>
                                                    <font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/Disclaimer-Form.pdf">Disclaimer Form</a></b></font>
                                                    <font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><a href="http://www.udaanindia.com/forms/Declaration-Form.pdf">Declaration Form</a></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SLOVENIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/SlovENIA.pdf">SLOVENIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SLOVAK</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Slovakia.pdf">SLOVAK 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SENEGAL</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Senegal.pdf">SENEGAL 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SERBIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/SERBIA%20FORM.pdf">SERBIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SURINAME</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/SURINAME-VISA.PDF">SURINAME 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SUDAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/SUDAN.PDF">SUDAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SYRIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Syria.pdf">SYRIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>SAUDI 
                                                    ARABIA</b></font> </td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="20" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/saudi.pdf">SAUDI 
                                                    ARABIA VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b>
                                                    <b><img src="images/dnload.gif" width="20" height="20"><b><a href="http://www.udaanindia.com/forms/SAUDI TEMP WORK FORMAT.pdf">SAUDI 
                                                    ARABIA TEMPORARY WORK PERMIT FORMAT.PDF</a></b><br>
</font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">T</font><a name="t"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>THAILAND</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Thailand.pdf">THAILAND 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">TAIWAN</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/TAIWAN.PDF">TAIWAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">TANZANIA</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Tanzania.pdf">TANZANIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>TAJIKISTAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/TAJIKISTAN.pdf">TAJIKISTAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">TURKEY</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Turkey.pdf">TURKEY 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>TRINIDAD 
                                                    &amp; TOBAGO</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Trinidad.pdf">TRINIDAD 
                                                    &amp; TOBAGO VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>TUNISIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Tunisia.pdf">TUNISIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Tunisia%20Additional%20Sheet.pdf">TUNISIA 
                                                    ADDITIONAL SHEET FOR BUSINESS 
                                                    VISA </a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font size="3" face="Verdana"><b>TURKMENISTAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/TURKMENISTAN.pdf" target="_blank">TURKMENISTAN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">U</font><a name="u"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="middle" height="29"><font face="Verdana" size="2"><b><font size="3">UNITED 
                                                    KINGDOM</font></b></font></td>
                                                  <td valign="top" width="87%" height="29"> 
                                                    <p><b><font size="2" face="Verdana"><img src="images/dnload.gif" width="21" height="20"> <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UK/ukb.pdf">BUSINESS FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                      <img src="images/dnload.gif" width="21" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UK/tourist.pdf">TOURIST VISA FORM
                                                    </a></b></b></b></b></b>
                                                    </b></b></b></b></b></b></b>
                                                    </b></b></b></b></b></b></b>
                                                    </b></b></b></b></b><img src="images/dnload.gif" width="21" height="20">
                                                    <a href="http://www.udaanindia.com/forms/UK/fv.pdf">
                                                    FAMILY VISIT VISA FORM</a> <a href="http://www.udaanindia.com/forms/UK/tourist.pdf"> 
 
                                                      <img src="images/dnload.gif" width="21" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UK/visitt.pdf">VISIT AND TRANSIT 
                                                      VISA FORM </a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><img src="images/dnload.gif" width="21" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UK/STUDENT%20MORE%20THAT%20SIX%20MONTHS.pdf">STUDENT&nbsp; VISA FORM </a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><img src="images/dnload.gif" width="21" height="20"> 
                                                      <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UK/WORK%20PERMIT.pdf"> 
                                                      WORK PERMIT VISA FORM</a><a href="http://www.udaanindia.com/forms/UK/STUDENT%20MORE%20THAT%20SIX%20MONTHS.pdf">
                                                      </a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b><img src="images/dnload.gif" width="21" height="20"> <a href="http://www.udaanindia.com/forms/UK/st2.pdf">
                                                    STUDENT VISIT
                                                    </a><img src="images/dnload.gif" width="20" height="20"><a href="http://www.udaanindia.com/forms/UK/d1.pdf">DIRECT 
                                                    AIRSIDE TRANSIT FORM</a><a href="http://www.udaanindia.com/forms/UK/st2.pdf"><br>
                                                    </a><b><b><b><img src="images/dnload.gif" width="20" height="20"></b><a href="http://www.udaanindia.com/forms/UK/VAF2%20-%20Settlement.pdf">PERMANENT 
                                                      RESIDENCE FORM</a></b></b> <br>
                                                      <img src="images/dnload.gif" width="20" height="20"> 
                                                      <a href="http://www.udaanindia.com/forms/UK/ADDITIONAL%20DOMESTIC%20WORKER.pdf">ADDITIONAL 
                                                      DOMESTIC WORKER FORM</a><b><b><b> 
                                                      </b></b></b></font></p>
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="2"><b><font size="3">U.S.A.</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/USA/DS156-nonimegrant%20visa%20form.pdf">NON-IMMIGRANT 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/USA/DS-0157-supplement%20nonimegrant.pdf">SUPPLEMENT 
                                                    NON-IMMIGRANT VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>UGANDA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Uganda.pdf">UGANDA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>UKRAINE</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/UKRAINE.PDF">UKRAINE 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>URUGUAY</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Uruguary.pdf">URUGUAY 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>UZBEKISTAN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Uzbekistan1.pdf">UZBEKISTAN 
                                                    VISA FORM( PAGE 1)</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    <b><b><img src="images/dnload.gif" width="21" height="20"><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Uzbekistan2.pdf">UZBEKISTAN 
                                                    VISA FORM( PAGE 2)</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">V</font><a name="v"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">VIETNAM</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/vietnam.pdf">VIETNAM 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>VENEZUELA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Venejuela.pdf">VENEZUELA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">Y</font><a name="y"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>YEMEN</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Yamen.pdf">YEMEN 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Arial, Helvetica, sans-serif" size="2" color="#006633"><b><font size="6">Z</font><a name="z"></a></b></font></td>
                                                  <td valign="top" width="87%" height="2">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana"><b><font size="3">ZIMBABWE</font></b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/zimbabwe.pdf">ZIMBABWE 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                                <tr> 
                                                  <td colspan="13" valign="top" height="2"><font face="Verdana" size="3"><b>ZAMBIA</b></font></td>
                                                  <td valign="top" width="87%" height="2"><font size="2" face="Verdana"><b><b><b><img src="images/dnload.gif" width="21" height="20"> 
                                                    <b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><b><a href="http://www.udaanindia.com/forms/Zambia.pdf">ZAMBIA 
                                                    VISA FORM</a></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b></b> 
                                                    </b></b></b></b></b></b></b></b></b></b></b></font></td>
                                                </tr>
                                              </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                            </td>
                            <td align="right" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td><img src="images/linetopgreen2.gif" width="660" height="8"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td> <!-- #include file="HomeBottom.asp" --> </td>
              </tr>
            </table>
          
        </body>
</html>