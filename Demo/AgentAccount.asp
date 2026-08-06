<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">
<b> <font size="4"> <%=udaanName%></b></td></tr>
<tr><td  align="center"><font face='arial' size=2 color='#000000'> <%=udaanAddress%></font></TD></TR>
<tr><td align="center"><font face='arial' size=2 color='#000000'> <%=udaanContact%></font></td></tr></table>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">&nbsp;
<b> <font size="4"> </font> </b></td></tr></TABLE>

<table>


<%

agentID=cint(request("agentID"))
refno=cint(request("refno"))
GrandTotal=0
set rsmain=server.createobject("adodb.recordset")
set rspax=server.createobject("adodb.recordset")
stmt="select * from mainentry where  agent="&agentID&"and subdate='"&date()&"'"

rsmain.open stmt,con,2,3
response.write "DATE"&date()&"<br>"
response.write "AGENT : "
call writeIDDescription("agents",agentID)
while not rsmain.eof
refno=rsmain.fields("refno")

RESPONSE.WRITE "REFNO"&refno

%>

<table width="658" border="1" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>DATE 
                                </b></font></td>
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>DESCRIPTION
                            </b></font></td>
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total 
                                Name</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Amount</b></font></td>
                               
                               
<%
visatotal="0"
set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.total,paxstatus.refno, paxstatus.colcheck, paxstatus.paxID,EntryDetails.paxname,paxstatus.countryID,paxstatus.statusID,paxstatus.sentdate,entryDetails.Paxname, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.refno="&refno&"   order by entryDetails.Paxname"
rs.open stmt,con
  
	if not rs.eof then
%>
 </tr>


<tr bgcolor="#ffffFF"> 
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><%=recdate%>
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Visa Processing charges:
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               &nbsp;</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>&nbsp</b></font></td></tr>
                                     
<%	
	
	while not rs.eof
	total=rs.fields("total")
	response.write "<tr><td></td><td><font size='2' face='Arial, Helvetica, sans-serif' color='#000000'><b>"&ucase(rs.fields("paxname"))&"</b></font>"
	response.write " <font size='2' face='Arial, Helvetica, sans-serif' color='#000000'><b>for country "
	call writeIDDescription("embassy", rs("countryID"))
	response.write "<b></font></td><td>"&rs("totalpax")&"<td>"&total&"</td></tr>"
	
	visatotal=visatotal+total
	
	
	rs.movenext
	wend
	GrandTotal=GrandTotal+visatotal
	

end if  
rs.close
stmt="select * from paxcab where refno="&refno
rs1.open stmt,con
if rs1.eof then
paxtotal=0
else
%>
			
			<tr bgcolor="#ffffFF"> 
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><%=formatdatetime(rs1.fields("entryDateTime"),2)%>
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Cab Booking charges:
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               &nbsp;</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>&nbsp</b></font></td></tr>

			
			<%
			
			if rs1.fields("sdate")<>"" then
			sdate=systousrdate(rs1.fields("sdate"))
			end if
			if rs1.fields("enddate")<>"" then
			enddate=systousrdate(rs1.fields("enddate")) 
			end if
			cabno=rs1.fields("cabno")
			
			paxtotal=rs1.fields("total")
			GrandTotal=GrandTotal+paxtotal
			%>
			<tr bgcolor="#ffffFF"> 
                         
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>&nbsp;
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>
                              <%=ucase(rs1.fields("name"))%> booked <%=ucase(rs1.fields("vehical"))%> from <%=ucase(rs1.fields("sdate"))%> to <%=ucase(rs1.fields("enddate"))%>
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               &nbsp;</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b><%= paxtotal %></b></font></td></tr>
 <%
			end if

rs1.close 
hoteltotal=0
stmt="select * from paxhotel where refno="&refno

rs1.open stmt,con
if not rs1.eof then

%>
			
			<tr bgcolor="#ffffFF"> 
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><%=formatdatetime(rs1.fields("entryDateTime"),2)%>
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Hotel Booking charges:
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               &nbsp;</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>&nbsp</b></font></td></tr>

			
			<%
			
			if rs1.fields("arrivaldate")<>"" then
			sdate=systousrdate(rs1.fields("arrivaldate"))
			end if
			if rs1.fields("departdate")<>"" then
			enddate=systousrdate(rs1.fields("departdate")) 
			end if
			cabno=rs1.fields("nosofdays")
	
			hoteltotal=rs1.fields("total")
			GrandTotal=GrandTotal+hoteltotal
			%>
			<tr bgcolor="#ffffFF"> 
                         
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>&nbsp;
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>
                              <%=ucase(rs1.fields("name"))%> booked <%=ucase(rs1.fields("hotelname"))%> from <%=sdate%> to <%=enddate%>
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               &nbsp;</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b><%= hoteltotal %></b></font></td></tr>
 <%
			end if

rs1.close 


rsmain.movenext
wend
rsmain.close
%>
<tr bgcolor="#ffffFF"> 
                         
                              <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                                </b></font></td>
                              <td  nowrap><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>&nbsp;
                              
                        <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>
                               Total:</b></font></td>
                                <td ><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b><%= GrandTotal %></b></font></td></tr>
