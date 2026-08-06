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
          
            
         
          <td width="98%" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td valign=top> 
                  <table width="99%" border="0">
                    <tr>
                      <td><a href="entry.asp">Submission</a></td>
                      <td><a href="collection.asp">Collection</a></td>
                      <td><a href="status.asp">Status</a></td>
                      <td>Reports</td>
                      <td>Visa Info</td>
                      <td><a href="searchEntry.asp">Search </a></td>
                    </tr>
                    <tr> 
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000">EMAIL MESSAGE SENT TO AGENT
                       </font></b> </td>
                    </tr>
                   
                  </table>
                  
                </td>
              </tr>
            </table>
<form name=collection action="collectionsubmit.asp" method="post">
              
<%
refno=request("refno")
set rs=server.createobject("adodb.recordset")
set rsInvoice=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rscountry=server.createobject("adodb.recordset")
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
                    <%= refno %> 
                    <input type="hidden" name="refno" value="<%= refno %>" ></b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Agent</b></font></td>
                  <td colspan=3> <font size="2" color="#006600"><b>
                  <%
                  call writeIDDescription("agents",agent)
                  %> 
                    
                    </b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Referer</b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b><%= refname %> 
                    
                    </b></font></td>
                  <td width="25%"><font size="2" color="#0000CC"><b>Company</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b><%=company %> 
                    
                    </b></font></td>
                
                </table>
                 <table width=75% border=1 cellspacing=1 cellpadding=1 align="center">
      <%
i=0

countrylist=""

getcountry="select * from entrydetails where  refno="&refno &" Order by paxname"
rscountry.activeconnection=con
rscountry.open getcountry,con
while not rscountry.eof
i=i+1
pname1=rscountry.fields("paxname")
PaxID=rscountry("Paxid")
getinvoice="select * from paxstatus where  refno="&refno&" and PaxID="&PaxID
rsInvoice.open getinvoice,con
while not rsInvoice.EOF 
temp_status=rsInvoice("statusID")
temp_ddcharges=rsInvoice("ddcharges")
temp_handlingfee=rsInvoice("handlingfee")
temp_visafee=rsInvoice("visafee")
temp_couriercharges=rsInvoice("couriercharges")
temp_misccharges=rsInvoice("misccharges")
temp_total=rsInvoice("total")

%>
   
    		<tr> 
                  <td > 
                    
                    <font size="3" color="#006600"><b> <%= ucase(pname1) %></b></font>
                     <td > 
                   <%
                      call writeIDDescription("embassy", rsinvoice.fields("countryID")) 
                      %> </b></font> </div>
                     
                  </td>
                
                  
                  <td > <font size="2" color="#006600"><b> 
                           <%
                      call writeIDDescription("status", rsinvoice.fields("statusID")) 
                      %>
                    </b></font>
                    </td>
                  
                  
                  <td  colspan=3> <font size="2" color="#006600"><b> 
                    <%=temp_remark%></b></font></td>
                </tr>
                
<%                
rsInvoice.movenext
wend
 rsInvoice.close
rscountry.movenext
wend
rscountry.close()

 %>               
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
