<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF">
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td> 
      <table width="75%" align="center" cellpadding="0" cellspacing="0">
        <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><span class="tableCaption">Search Result</span> 
              </font></b></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td> 
      <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr bgcolor="#FFFFFF"> 
          <td><img src="images/linetopgreen1.gif" width="660" height="10"></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                <td width="560"> 
                  <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                    <tr> 
                      <td><!-- #include file="connection.asp" -->
<script language="javascript">
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
a {  font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #000000}
a:hover {  font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>

<body >

<script language="javascript">
function confirm1()
{
a1= document.searchform.keywords.value
a2= document.searchform.agent.value
a3= document.searchform.countryID.value
if (a1=="" && a2=="" && a3=="" )
{
conval=window.confirm("THIS WILL SHOW ALL THE DATA AND MAY TAKE TIME. CONTINUE???")
if(conval)
{
location.href="paxStatus.asp"
}
else
{
return false
}
}
}
</script>
         
                          
      <div align="center">
                              <form name="searchform" action="searchPax.asp" onsubmit="return confirm1()" >
                              Pax:<input type="text " name="keywords" value="<%=request("keywords")%>" SIZE=15>
                              Agent:
                               <select size=1  name="agent" ><option value="" Selected>ALL </OPTION>
                                
                                              <% 
                                              	agentid=request("agent")
                                            
						if Isnull(agentid) or IsEmpty(agentid) or agentid="" then
						agentid=0
						End If
						Call LoadListBox("agents",agentid)
						%> 
                                </select>
                                Country:
                                <select name="countryID" size="1"><option value="" Selected>ALL</OPTION>
                                 
                          <% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy",countryID)
	              	%> 
                        </select>
                                
                              <input type="submit" value="GO">
                            </form>  
</div>
  
      
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
          <tr> 
            <td><img src="images/linetop.jpg" width="660" height="13"></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                 
                          <table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><span class="WSRightBold">Ref 
                                #</span></td>
                              <td width="70"><span class="WSRightBold">PAX 
                                Name</span></td>
                              <td width="95"><span class="WSRightBold">Agent 
                                Name</span></td>
                                <td width="52"><span class="WSRightBold">Country</span></td>
                                <td width="47"><span class="WSRightBold">Status</span></td>
                              <td width="59"><span class="WSRightBold">Recieved</span></td>
                              <td width="46"><span class="WSRightBold">Submit</span></td>
                              <td width="65"><span class="WSRightBold">Collection</span></td>
                             <td width="36"><span class="WSRightBold">Total</span></td>
                              
                                </tr>
                                
<%  
                            
 mydate=date()-30
 mydate=Cdate(mydate)
 today=date() 

                      
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and entryDetails.Paxname LIKE '%"&request("keywords")&"%' order by entryDetails.Paxname"
if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' order by entryDetails.Paxname"
end if 
if request("agent")<>""  and  request("keywords") = "" then
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" and paxstatus.Subdate >"& mydate&" order by entryDetails.Paxname"
end if 
if request("countryID")<>""  then
countryID=Cint(request("countryID"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and paxstatus.Subdate >"& mydate&" order by entryDetails.Paxname"
end if 
if request("countryID")<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"  and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and paxstatus.Subdate >"& mydate&" order by entryDetails.Paxname"
end if 
if request("countryID")<>"" and request("agent")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and paxstatus.Subdate >"& mydate&" order by entryDetails.Paxname"
end if 

if request("countryID")<>"" and request("agent")<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and paxstatus.Subdate >"& mydate&" order by entryDetails.Paxname"
end if 
if request("sc_sdate")<>""  and request("agent")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate =#"& sdate&"#  order by entryDetails.Paxname"
end if 
if request("sc_edate")<>""  and request("agent")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_edate"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate =#"& sdate&"#  order by entryDetails.Paxname"
end if 
if request("sc_sdate")<>"" and request("agent")<>"" and  request("sc_edate")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
edate=UsrToSysDate(request("sc_edate"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.paxID,paxstatus.colcheck,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate >=#"& sdate&"# and  Mainentry.receivedate <=#"& edate&"#  order by entryDetails.Paxname"
end if 
if request("refno")<>""  then

refno=Cint(request("refno"))
stmt ="select Entrydetails.Totalpax, paxstatus.refno, paxstatus.colcheck, paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.refno="&refno&"   order by entryDetails.Paxname"
end if 
'response.write stmt
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
check=rs.fields("colcheck")

if check="chk" and coldate<>"" then
coldate="CHK - "&coldate
end if

response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'>"

if rs.fields("countryID")="" then
call writeIDDescription("embassy",0)
else 
response.write "<a href='collectionFormPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
response.write "</a>"
end if

response.write "</td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td></tr>"

response.write "<tr bgcolor='#F0F0FF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()
%> 
 </table>
<%
 set rsquote=server.createobject("adodb.recordset")
today=currentdate
stmt ="select paxhotel.refno,paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms from paxhotel,mainentry where mainentry.refno=paxhotel.refno and paxhotel.name LIKE '%"&request("keywords")&"%'  order by paxhotel.name"
if request("refno")<>""  then

refno=Cint(request("refno"))
stmt ="select paxhotel.refno,paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms from paxhotel,mainentry where mainentry.refno=paxhotel.refno and  Mainentry.refno="&refno&"  and paxhotel.name LIKE '%"&request("keywords")&"%'  order by paxhotel.name"

end if

if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select paxhotel.refno,paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms from paxhotel,mainentry where mainentry.refno=paxhotel.refno and  Mainentry.Agent ="&request("agent")&" and paxhotel.name LIKE '%"&request("keywords")&"%'  order by paxhotel.name"

end if 
if request("agent")<>""  and  request("keywords") = "" then
stmt ="select paxhotel.refno,paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms from paxhotel,mainentry where mainentry.refno=paxhotel.refno and  Mainentry.Agent ="&request("agent")&" and paxhotel.name LIKE '%"&request("keywords")&"%'  order by paxhotel.name"
end if 


rsquote.open stmt,con
if not rsquote.eof then
%>
<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
             Hotel Information </font></font></b></div>
            </td>
          </tr>
        </table>
       
<table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><span class="WSRightBold">Ref 
                                #</span></td>
                              <td ><span class="WSRightBold">PAX 
                                Name</span></td>
                              <td ><span class="WSRightBold">Agent 
                                Name</span></td>
                                <td ><span class="WSRightBold">Hotel</span></td>
                                <td><span class="WSRightBold">From</span></td>
                              <td ><span class="WSRightBold">To</span></td>
                              
                             <td><span class="WSRightBold">Rooms</span></td>
                              
                                </tr>


<%

while not rsquote.eof

response.write "<tr bgcolor='#ffffff'><td>"&rsquote("refno")&"</td>"
response.write "<td>"&ucase(rsquote("name"))&"</td>"
response.write "<td>"
call writeIDDescription("agents",rsquote("agent"))

response.write "</td><td>"
call writeIDDescription("hotel",rsquote("hotelname"))

response.write "</td><td>"&systousrdate(rsquote("arrivaldate"))&"</td>"
response.write "<td>"&systousrdate(rsquote("departdate"))&"</td>"
response.write "<td>"&rsquote("noofrooms")&"</td></tr>"
rsquote.movenext
wend
response.write "</table>"
'else
'response.write "<tr bgcolor='#ffffff'><td colspan='6' align = 'center'>NO ENTRY FOR HOTEL<td></tr>"

end if

rsquote.close()
 
 %>
                       
                          
                          


       
 <%
 stmt=""
 set rsquote=server.createobject("adodb.recordset")
today=currentdate
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
if  request("keywords")<>"" then
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno  and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
'stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.hotelname,paxcab.arrivaldate,paxcab.departdate,paxcab.noofrooms from paxcab,mainentry where mainentry.refno=paxcab.refno and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"

end if 
if request("refno")<>""  then

refno=Cint(request("refno"))
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno  and  Mainentry.refno="&refno&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
'stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.hotelname,paxcab.arrivaldate,paxcab.departdate,paxcab.noofrooms from paxcab,mainentry where mainentry.refno=paxcab.refno and  Mainentry.refno="&refno&"  and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"

end if

if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno  and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
'stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.hotelname,paxcab.arrivaldate,paxcab.departdate,paxcab.noofrooms from paxcab,mainentry where mainentry.refno=paxcab.refno and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"

end if 
if request("agent")<>""  and  request("keywords") = "" then
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno  and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
'stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.hotelname,paxcab.arrivaldate,paxcab.departdate,paxcab.noofrooms from paxcab,mainentry where mainentry.refno=paxcab.refno and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  order by paxcab.name"
end if 


rsquote.open stmt,con
if not rsquote.eof then
%>

<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
             Cabs Information </font></font></b></div>
            </td>
          </tr>
        </table>

<table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td ><span class="WSRightBold">Ref 
                                #</span></td>
                              <td><span class="WSRightBold">PAX 
                                Name</span></td>
                              <td><span class="WSRightBold">Agent 
                                Name</span></td>
                                <td><span class="WSRightBold">Vehicle</span></td>
                                <td nowrap><span class="WSRightBold">Cab Owner</span></td>
                                <td><span class="WSRightBold">From</span></td>
                              <td><span class="WSRightBold">To</span></td>
                              
                             
                              
                                </tr>
<%

while not rsquote.eof

response.write "<tr bgcolor='#ffffff'><td>"&rsquote("refno")&"</td>"
response.write "<td>"&ucase(rsquote("name"))&"</td><td>"

if rsquote("agent")<>"" then
call writeIDDescription("agents",rsquote("agent"))
End if


response.write "</td><td>"&rsquote("vehical")&"</td>"
response.write "<td>"&rsquote("cabowner")&"</td>"
response.write "<td>"&systousrdate(rsquote("sdate"))&"</td>"
response.write "<td>"&systousrdate(rsquote("enddate"))&"</td>"

rsquote.movenext
wend
response.write "</table>"

end if
rsquote.close()
 
 %>
                       
                     
                          
                          
                          
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td align="right" width="1"> <img src="images/pixelsline.gif" width="1" height="7"> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td><img src="images/linebottom.jpg" width="660" height="13"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  </table>

                </td>
                    </tr>
                  </table>
                </td>
            </table>
          </td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td><img src="images/linetopgreen2.gif" width="660" height="10"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
