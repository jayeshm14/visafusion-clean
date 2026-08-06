<%@ Language=VBScript %>
<%
response.buffer= true
%>

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
            <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><span class="tableCaption">Profile</span> 
              </font></font></b></div>
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
                      <td>
<!-- #include file="connection.asp" -->

<%

if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>


      


<% if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
%>

<link rel="stylesheet" href="Styles.css">
</head>

<body   topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  
           <tr><td>&nbsp;</td></tr>
         
              <tr>
                <td align="center">
                <span class="tableCaption">SEARCH RESULTS </span> 

<body>


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
                              <span class="WSRightBold">
                              Pax: </span><input type="text " name="keywords" value="<%=request("keywords")%>" SIZE=15>
                              <span class="WSRightBold">Agent:</span>
                               <select size=1  name="agent" ><option value="" Selected>ALL </OPTION>
                                
                                              <% 
                                              	agentid=request("agent")
                                            
						if Isnull(agentid) or IsEmpty(agentid) or agentid="" then
						agentid=0
						End If
						Call LoadListBox("agents",agentid)
						%> 
                                </select>
                                <span class="WSRightBold">Country:</span>
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
      <td> 
       
    <tr> 
      <td height="2"> 
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td><img src="images/linetop.jpg" width="660" height="13"></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                 
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              
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
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" and paxstatus.Subdate >"& mydate&" order by mainentry.refno"
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
response.write "<tr><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
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

response.write "<tr><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
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

response.write "<tr><td height=2 colspan=11></td></tr>"
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
          <tr> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
             Hotel Information </font></font></b></div>
            </td>
          </tr>
        </table>
       
<table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Hotel</b></font></td>
                                <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>From</b></font></td>
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>To</b></font></td>
                              
                             <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Rooms</b></font></td>
                              
                                </tr>


<%

while not rsquote.eof

response.write "<tr ><td>"&rsquote("refno")&"</td>"
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
          <tr> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
             Cabs Information </font></font></b></div>
            </td>
          </tr>
        </table>

<table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Vehicle</b></font></td>
                                <td nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Cab Owner</b></font></td>
                                <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>From</b></font></td>
                              <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>To</b></font></td>
                              
                             
                              
                                </tr>
<%

while not rsquote.eof

response.write "<tr><td>"&rsquote("refno")&"</td>"
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
