<!-- #include file="connection.asp" -->
<% response.buffer=true %>
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

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
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
                <td><img src="images/top.jpg"></td>
              </tr>
              <tr>
                <td valign=top> 
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
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000"> REFERENCE DETAILS</font></b> </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
<form name=collection action="collectionsubmit.asp" method="post">
              
<%
refno=request("refno")
set rs=server.createobject("adodb.recordset")
stmt="select * from mainEntry where refno="&refno
rs.open stmt,con,2,3
if rs.eof then
response.write "<font size=2 color=#0000CC> Please check the reference number.</font>"
else

agent=rs.fields("agent")
refname=rs.fields("refferer")
recdate=rs.fields("receivedate")
pname=rs.fields("paxname")
dob=rs.fields("dateofbirth")
passport=rs.fields("passportno")
entries=rs.fields("entries")
company=rs.fields("companyname")
totalp=rs.fields("totalpassengers")
subdate=rs.fields("subdate")
coldate=rs.fields("coldate")
category=rs.fields("category")
attestation=rs.fields("attestation")
poe=rs.fields("poe")
entrytype=rs.fields("entrytype")
status=rs.fields("status")
%> 
              <table width=75% border=0 cellspacing=1 cellpadding=1 align="center">
                <tr> 
                  <td colspan="2"><font size="2" color="#0000CC"><b>Date: <% response.write(formatdatetime(now(),1))%></b></font></td>
                  <td colspan="2"><font size="2" color="#0000CC"><b>Refrence Number: 
                    <%= refno %> </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Agent</b></font></td>
                  <td colspan=3> <font size="2" color="#0000CC"><b><%= agent%> 
                    <input type="hidden" name="agent" value="<%=agent %>" >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Refferer Name</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= refname %> 
                    <input type="hidden" name="refname" value="<%=refname %>" >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Company</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=company %> 
                    <input type="hidden" name="company" value="<%=company %>" >
                    </b></font></td>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>PAX Name</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= pname %> 
                    <input type="hidden" name="pname" value="<%=pname %>" >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Passport No 
                    </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=passport %> 
                    <input type="hidden" name="passport" value="<%=passport %>" >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b> Pessengers 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= totalp %> 
                    <input type="hidden" name="totalp" value=<%=totalp %> >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Entries </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= entries %> 
                    <input type="hidden" name="entries" value=<%=entries %> >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Date Of Birth 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%=dob%> 
                    <input type="hidden" name="dob" value="<%=dob %>" >
                     </b></font> 
                  <td width="25%"><font size="2" color="#0000CC"><b>Receive date 
                    </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=recdate%> 
                    <input type="hidden" name="recdate" value="<%=recdate %>" >
                    </b></font></td>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Submit Date 
                    </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= subdate %> 
                    <input type="hidden" name="subdate" value="<%=subdate %>" >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Collection 
                    Date </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= coldate %> 
                    <input type="hidden" name="coldate" value="<%=coldate %>" >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Category </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= category %> 
                    <input type="hidden" name="category" value="<%=category %>" >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Attestation 
                    </b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= attestation%> 
                    <input type="hidden" name="attestation" value="<%=attestation %>" >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>POE/ECNR </b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= poe %> 
                    <input type="hidden" name="poe" value="<%=poe %>" >
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Status</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%= status %> 
                    <input type="hidden" name="status" value="<%=status %>" >
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%">&nbsp;</td>
                  <td width="30%">&nbsp;</td>
                  <td width="25%">&nbsp;</td>
                  <td width="19%">&nbsp;</td>
                </tr>
                
              </table>
              <% End if%>
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
