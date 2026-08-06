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
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="2%" valign="top"> 
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
                  <tr> 
                <td colspan="6"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><%= session("lname")%> 
                </font></b>
                </td>
              </tr>
                    <tr> 
                      <td><a href="entry.asp">Submission</a></td>
                      <td><a href="collection.asp">Collection</a></td>
                      <td><a href="status.asp">Status</a></td>
                      <td>Reports</td>
                      <td>Visa Info</td>
                      <td><a href="searchEntry.asp">Search </a></td>
                    </tr>
                    <tr> 
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000">SEARCH 
                        RESULTS</font></b> </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
<form name="collection" action="collectionform.asp" method="post">
              <table width="75%" border="1" align="center">
                <tr bgcolor="#CCCCFF"> 
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Reference 
                    No.</b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Subdate
                  </b></font></td>
                    <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent
                    </b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                    Name</b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Pessangers</b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                </tr>
                <%  
              refno=request("refno")
            date1=request.form("sc_sdate")
            date2=request.form("sc_edate")
            coldate=request.form("sc_sdate")
            agent=request.form("agentlist")
            agent_name=request.querystring("agent")
 set rs=server.createobject("adodb.recordset")
 set rs1=server.createobject("adodb.recordset") 
 
 
 if isempty(agent_name) then
 stmt="select * from Mainentry where agent='"&request("agentlist")&"' and (Day(subdate)="&day(date1)&" and month(subdate)="&month(date1)&" and year(subdate)="&year(date1)&")"
 else
 stmt="select * from Mainentry where agent="&"'"&lcase(agent_name)&"'" & "order by refno desc"
 end if
 
 if request("agentdate")<>"" then
 if date1="" and date2<>"" then
 stmt="select * from Mainentry where agent='"&request("agentlist")&"' and (Day(subdate)="&day(date2)&" and month(subdate)="&month(date2)&" and year(subdate)="&year(date2)&")"
 End if
 if date1<>"" and date1="" then
 stmt="select * from Mainentry where agent='"&request("agentlist")&"' and (Day(subdate)="&day(date1)&" and month(subdate)="&month(date1)&" and year(subdate)="&year(date1)&")"
 End if
 if date1="" and date1="" then
 stmt="select * from Mainentry where agent='"&request("agentlist")&"'"
 End if
 if date1<>"" and date2<>"" then
 stmt="select * from Mainentry where agent='"&request("agentlist")&"' and ((Day(subdate)>="&day(date1)&" and month(subdate)="&month(date1)&" OR year(subdate)="&year(date1)&") and (Day(subdate)<="&day(date2)&" and month(subdate)<="&month(date2)&" and year(subdate)="&year(date2)&"))"
 End if
 End if 
 
 rs.open stmt,con
if rs.eof then 
response.write "<font size='3' color='#CC0000'> Please check the values entered</font>" 
else 
while not rs.eof
refno=rs.fields("refno")            
response.write "<tr><td>"&refno&"</td><td><font size='3' color='#CC0000'>"&rs.fields("subdate")&"</font></td><td><font size='3' color='#CC0000'>"&ucase(rs.fields("agent"))&"</FONT></td><td><a href='search_ref2.asp?refno="&refno&"' >"&rs.fields("paxname")&"</a></td>"
response.write "<td>"&rs.fields("totalpassengers")&"</td> <td>"

stmt1="select distinct(cname) from entrydetails where refno="&refno
rs1.open stmt1,con
while not rs1.eof
response.write rs1.fields("cname")&", "
rs1.movenext
wend
rs1.close
response.write "&nbsp;</td></tr>"
rs.movenext
wend
end if
%> 
              </table>
            </form>
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
