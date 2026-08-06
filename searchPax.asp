<% server.scripttimeout=3000 %>
<!-- #include file="connection.asp" -->
<%
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>

<% if session("priv")="adm" then
%> 
<!-- #include file="topadmin.asp"-->           
<%
else
%>
<!-- #include file="top.asp"--> 
<% 
end if
%>
<html>
<head>
<title>UdaanIndia.com</title>
<link rel="stylesheet" href="Styles.css">

<script language="javascript">

function check()
{
if((document.form1.agent.value=="") && (document.form1.countryID.value=="") && (document.form1.keywords.value==""))
	{
	alert ("You are Selecting All Country of All Agents. I Think U want to Hang The Server. Because it will take lot's of time for taking all data. ");
	return false;
	}
document.form1.submit()
}
</script>
        

</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
  
           <tr><td>&nbsp;</td></tr>
         
              <tr bgcolor="#FFE898"> 
          <td height="19"> 
            <div align="center"><span class="tableCaption">ADVANCE SEARCH</span></div>
          </td>
        </tr>
<TR><td>&nbsp;</td></tr>
      <tr> 
          <td height="19"> 
            <div align="center"><div align="center">
                              <form method="post" name="form1" action="searchPax.asp" onSubmit="return check()">
                              <span class="WSRightBold">
                              Pax: </span><input type="text " name="keywords" value="<%=Trim(request("keywords"))%>" SIZE=15>
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
          </td>
        </tr>

  
      
  <table width="64%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
       
    <tr> 
      <td height="2"> 
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr> 
            <td><img src="images/linetop.jpg" width="675" height="13"></td>
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
                              <td width="39"><font size="2" face="verdana" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="verdana" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="verdana" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td width="52"><font size="2" face="verdana" color="#3300CC"><b>Country</b></font></td>
                                <td width="47"><font size="2" face="verdana" color="#3300CC"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="verdana" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="verdana" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="verdana" color="#3300CC"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="verdana" color="#3300CC"><b>Total</b></font></td>
<td width="10"><font size="2" face="verdana" color="#3300CC"><b>B</b></font></td>
                              
                                </tr>
                                
<%  
                            
 mydate=date()-3
 mydate=Cdate(mydate)
 today=date() 

if len(trim(request("keywords")))<3 and trim(request("keywords"))<>"" then
response.write("Please Contact to System Administrator")
 mydate=date()-1
 mydate=Cdate(mydate)
end if

set rs=server.createobject("adodb.recordset")

stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno"

if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' order by entryDetails.Paxname"
end if 

if request("agent")<>""  and  request("keywords") = "" then
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by mainentry.refno"
end if 

if request("countryID")<>""  then
countryID=Cint(request("countryID"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by mainentry.refno"
end if 

if request("countryID")<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"  and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.Paxname"
end if 

if request("countryID")<>"" and request("agent")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.Paxname"
end if 

if request("countryID")<>"" and request("agent")<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.Paxname"
end if 

if request("uma")="yes" then

if request("sc_sdate")="" and request("agent")<>"" and  request("sc_edate")="" then
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&request("agent")&" order by MainEntry.receivedate"
end if

if request("sc_sdate")<>""  and request("agent")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate >'"&sdate&"'  order by MainEntry.receivedate"
end if 

if request("sc_edate")<>""  and request("agent")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_edate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate >='"& sdate&"'  order by MainEntry.receivedate"
end if 
 
if request("sc_sdate")<>"" and request("agent")<>"" and  request("sc_edate")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
edate=UsrToSysDate(request("sc_edate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.paxID,paxstatus.colcheck,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and Mainentry.receivedate >='"& sdate&"' and  Mainentry.receivedate <='"& edate&"'  order by MainEntry.receivedate"
end if 

end if


if request("uma1")="yes" then
if request("sc_sdate")="" and request("countryID")<>"" and  request("sc_edate")="" then
countryID=Cint(request("countryID"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" order by MainEntry.receivedate"
end if

if request("sc_sdate")<>""  and request("countryID")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"  and Mainentry.receivedate >'"&sdate&"'  order by MainEntry.receivedate"
end if 

if request("sc_edate")<>""  and request("countryID")<>""  then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_edate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"  and Mainentry.receivedate >='"& sdate&"'  order by MainEntry.receivedate"
end if 
 
if request("sc_sdate")<>"" and request("countryID")<>"" and  request("sc_edate")<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(request("agent"))
sdate=UsrToSysDate(request("sc_sdate"))
edate=UsrToSysDate(request("sc_edate"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.paxID,paxstatus.colcheck,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"  and Mainentry.receivedate >='"& sdate&"' and  Mainentry.receivedate <='"& edate&"'  order by MainEntry.receivedate"
end if 
end if


if request("refno")<>""  then
refno=request("refno")
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno, paxstatus.colcheck, paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.refno='"&refno&"' order by entryDetails.Paxname"
end if 

if request("pptno")<>""  then
pptno=request("pptno")
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and entryDetails.passportno LIKE '%"&pptno&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno"
end if

'response.write stmt

rs.open stmt,con,3,3
if rs.eof then 
response.write "<tr><td colspan=11 align=center><font face='verdana' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
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

response.write "<tr><td><font face='verdana' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='verdana' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='verdana' size=2 color='#000000'><a href='editentry.asp?refno="&refno&"'>"
call writeIDDescription("agents",agent)
response.write"</a></font></td><td><font face='verdana' size=2 color='#000000'>"

if rs.fields("countryID")="" then
call writeIDDescription("embassy",0)
else 
response.write "<a href='collectionFormPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
response.write "</a>"
end if

response.write "</td><td><font face='verdana' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='verdana' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='verdana' size=2 color='#000000'>"&subdate&"</font></td><td><font face='verdana' size=2 color='#000000'>"

if coldate <> "" then
response.write coldate
else
response.write "&nbsp;"
response.write"</font></td>"
end if
response.write"<td><font face='verdana' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td>"

response.write"<td><font face='verdana' size=2 color='#000000'>"
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"<a href='refnototaldetailsub.asp?refno="&refno&"'> "
end if
response.write rs.fields("bill")&"</font>"
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"</a>"
end if
response.write"</td></tr>"

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

stmt ="select distinct(paxhotel.refno),paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms, paxstatus.sentdate from paxhotel,mainentry, paxstatus where mainentry.refno=paxhotel.refno and paxhotel.refno=paxstatus.refno and paxhotel.name LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxhotel.name"

if request("refno")<>""  then
refno=request("refno")
stmt ="select paxhotel.refno,paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms from paxhotel,mainentry where mainentry.refno=paxhotel.refno and Mainentry.refno='"&refno&"' order by paxhotel.refno"
end if

if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select distinct(paxhotel.refno),paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms, paxstatus.sentdate from paxhotel,mainentry, paxstatus where mainentry.refno=paxhotel.refno and paxhotel.refno=paxstatus.refno and Mainentry.Agent ="&request("agent")&" and paxhotel.name LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxhotel.name"
end if 

if request("agent")<>""  and  request("keywords") = "" then
stmt ="select distinct(paxhotel.refno),paxhotel.name,mainentry.agent,paxhotel.hotelname,paxhotel.arrivaldate,paxhotel.departdate,paxhotel.noofrooms, paxstatus.sentdate from paxhotel,mainentry,paxstatus where mainentry.refno=paxhotel.refno and paxhotel.refno=paxstatus.refno and Mainentry.Agent ="&request("agent")&" and paxhotel.name LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxhotel.name"
end if 

rsquote.open stmt,con,3,3
if not rsquote.eof then
%>
<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="verdana"><font color="#000099">
             Hotel Information </font></font></b></div>
            </td>
          </tr>
        </table>
       
<table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="verdana" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td ><font size="2" face="verdana" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td ><font size="2" face="verdana" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td ><font size="2" face="verdana" color="#3300CC"><b>Hotel</b></font></td>
                                <td><font size="2" face="verdana" color="#3300CC"><b>From</b></font></td>
                              <td ><font size="2" face="verdana" color="#3300CC"><b>To</b></font></td>
                              
                             <td><font size="2" face="verdana" color="#3300CC"><b>Rooms</b></font></td>
                              
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

stmt ="select distinct(paxcab.refno),paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner, paxstatus.sentdate from paxcab,mainentry, paxstatus where mainentry.refno=paxcab.refno and paxcab.refno=paxstatus.refno and paxcab.name LIKE '%"&request("keywords")&"%' and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxcab.name"

if request("refno")<>""  then
refno=request("refno")
stmt ="select paxcab.refno,paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner from paxcab,mainentry where mainentry.refno=paxcab.refno and  Mainentry.refno='"&refno&"' order by paxcab.refno"
end if

if request("agent")<>""  and  request("keywords")<>"" then
stmt ="select distinct(paxcab.refno),paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner, paxstatus.sentdate from paxcab,mainentry,paxstatus where mainentry.refno=paxcab.refno and paxcab.refno=paxstatus.refno and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxcab.name"
end if 

if request("agent")<>""  and  request("keywords") = "" then
stmt ="select distinct(paxcab.refno),paxcab.name,mainentry.agent,paxcab.vehical,paxcab.sdate,paxcab.enddate,paxcab.cabowner, paxstatus.sentdate from paxcab,mainentry,paxstatus where mainentry.refno=paxcab.refno and paxcab.refno=paxstatus.refno  and  Mainentry.Agent ="&request("agent")&" and paxcab.name LIKE '%"&request("keywords")&"%'  and (paxstatus.Sentdate >'"&mydate&"' or paxstatus.sentdate is null) order by paxcab.name"
end if 


rsquote.open stmt,con,3,3
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
%>
<tr><td><%=rsquote("refno")%></td>
<%
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
%>
</table><%

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
            <td><img src="images/linebottom.jpg" width="675" height="13"></td>
			<tr>
             <td height="30" align="right" bgcolor="#FFFFFF"><a href="#top" class="righmgtop"><img src="updateimg/top.gif" alt="Top" width="38" height="18" border="0"></a></td>
            </tr>
   
        </table>
      </td>
    </tr>
    <tr>
                <td><!-- #include file="empBottom.asp"--></td>
          
    </tr>
  </table>

                