<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
</head>

<body bgcolor="#FFFFFF" onLoad="MM_preloadImages('images/submission2.jpg','images/collection2.jpg','images/edit2.jpg','images/reports2.jpg','images/visa2.jpg','images/advsearch2.jpg')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="81%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td colspan="6"><img src="images/top.jpg"></td>
  </tr>
  </table>
 
  <font size="2" face="Arial, Helvetica, sans-serif"></font><font size="2" face="Arial, Helvetica, sans-serif"></font> 
      <table width="100%" border="0">
        
        <tr> 
          
          <td width="14%"><a href="holidayList.asp"> HOLIDAY LIST</a></td>
          <td width="14%"><a href="javascript:print()">PRINT</a></td>
          <td width="17%"><a href="agent.asp?uname=<%=session("uname") %>" >HOME</a></td>
          <td width="17%"><a href="relogin.asp" >LOGOUT</a> </td>
        </tr>
        <tr> 
          <td colspan=6> <font size="2" color="#CC0000" face="Arial, Helvetica, sans-serif"> 
            <b><marquee> <%holidaylist= MonthlyHolidayList(now())
                    response.write holidaylist %> </marquee></b> </font> </td>
        </tr>
        <tr bordercolor="#3333FF"> 
          <td colspan=6> <font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"> 
            <b>TODAY'S UPDATE <br>
            <font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><%tU= todaysupdate(date())
                    response.write tU %></font> </b> </font> </td>
        </tr>
        
      </table>
   
</body>
</html>
