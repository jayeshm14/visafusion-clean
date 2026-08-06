<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">
<a Href="listBill.asp?cmd=<%=request("cmd") %>"> <font size="4" color="#000000"> <%=udaanName%></font></a></td></tr>
<tr><td  align="center"><font face='arial' size=2 color='#000000'> <%=udaanAddress%></font></TD></TR>
<tr><td align="center"><font face='arial' size=2 color='#000000'> <%=udaanContact%></font></td></tr></table>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">&nbsp;
 <font size="4"> </font> </td></tr></TABLE>



<%
refno=cint(request("refno"))
GrandTotal=0
set rsmain=server.createobject("adodb.recordset")
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con
agentid=rsmain.fields("agent")
paxname=rsmain.fields("paxname")
recdate=SysTOUsrDate(rsmain.fields("receivedate"))

rsmain.close

stmt="select * from agents where  agentsid="&agentid 
rsmain.open stmt,con
company=rsmain.fields("companyname")
street1=rsmain.fields("street1")
street2=rsmain.fields("street2")
area=rsmain.fields("area")
city=rsmain.fields("city")
pincode=rsmain.fields("pincode")
rsmain.close

%>

<table width="658" border="0" align="center">
                           
 <tr bgcolor="#ffffff" border=0> 

                              
    <td><br>
                             <%
                             response.write company 
                             if street1<>"" then
                             response.write street1 &"<br>"
                             end if
                             if street2<>"" then
                             response.write street2 &"<br>"
                             end if
                             if area<>"" then
                             response.write area &"<br>"
                             end if
                             if city<>"" then
                             response.write city &" - "&pincode
                             end if
                             %>
                              </td>
                              
                              
                              <td align="right" >
                              
                              INVOICE NO. <%= refno %> <br>
                              DATED. <%= systousrdate(date()) %>
                              
                              </td>
</tr>    
</table>                       
 
<table width="658" border="1" align="center">
  <tr bgcolor="#ffffff" > 
    <td align="center">DATE 
     </td>
    <td > 
      <div align="center">
        PARTICULARS</div>
    </td>
    
    <td > 
      <div align="center">Amount</div>
    </td>
    <%
tot="0"
set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.total,paxstatus.refno, paxstatus.colcheck, paxstatus.paxID,EntryDetails.paxname,paxstatus.countryID,paxstatus.statusID,paxstatus.sentdate,entryDetails.Paxname, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.refno="&refno&"   order by entryDetails.Paxname"
rs.open stmt,con
  
	if not rs.eof then
%> </tr>
  <tr bgcolor="#ffffFF"> 
    <td align="center"><%=recdate%> 
     </td>
    <td  nowrap align="center">
    
    <td >
      &nbsp;</td>
    <td >&nbsp</td>
  </tr>
  <%	
	
	while not rs.eof
	total=rs.fields("total")
	response.write "<tr><td>&nbsp;</td><td ALIGN='center'>"&ucase(rs.fields("paxname"))&""
	
	
	response.write "</td><td align='center'>"
	call writeIDDescription("embassy", rs("countryID"))
	response.write"<td>"&total&"&nbsp;</td></tr>"
	
	
	if not (isNull(total) or total="" )then
	GrandTotal=GrandTotal+total
	end if
	rs.movenext
	wend

end if  
 
rs.close
stmt="select * from paxcab where refno="&refno

rs1.open stmt,con
if rs1.eof then
tot1="0"
else
%> 
  <tr bgcolor="#ffffFF"> 
    <td align="center"><%=SysTOUsrDate(formatdatetime(rs1.fields("entryDateTime"),2))%> 
     </td>
    <td  nowrap ALIGN="CENTER">
    CAB BOOKING CHARGES: 
    <td >
      &nbsp;</td>
    <td >&nbsp</td>
  </tr>
  <%
			
			if rs1.fields("sdate")<>"" then
			sdate=systousrdate(rs1.fields("sdate"))
			end if
			if rs1.fields("enddate")<>"" then
			enddate=systousrdate(rs1.fields("enddate")) 
			end if
			cabno=rs1.fields("cabno")
			
			tot1=rs1.fields("total")
			if not (isNull(tot1) or tot1="" )then
			GrandTotal=GrandTotal+tot1
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td >&nbsp; 
     </td>
    <td  nowrap>
    <%=ucase(rs1.fields("name"))%> BOOKED <%=ucase(rs1.fields("vehical"))%> from 
    <%=rs1.fields("sdate")%> to <%=rs1.fields("enddate")%> 
    <td >
      &nbsp;</td>
    <td ><%=tot1%>&nbsp;</td>
  </tr>
  <%
			end if

rs1.close 
tot2="0"
stmt="select * from paxhotel where refno="&refno

rs1.open stmt,con
if not rs1.eof then

%> 
  <tr bgcolor="#ffffFF"> 
    <td ALIGN="CENTER"><%=SysTOUsrDate(formatdatetime(rs1.fields("entryDateTime"),2))%> 
     </td>
    <td  nowrap ALIGN="CENTER">
    HOTEL BOOKING CHARGES: 
    <td >
      &nbsp;</td>
    <td >&nbsp</td>
  </tr>
  <%
			
			if rs1.fields("arrivaldate")<>"" then
			sdate=systousrdate(rs1.fields("arrivaldate"))
			end if
			if rs1.fields("departdate")<>"" then
			enddate=systousrdate(rs1.fields("departdate")) 
			end if
			cabno=rs1.fields("nosofdays")
	
			tot2=rs1.fields("total")
			if not (isNull(tot2) or tot2="" )then
			GrandTotal=GrandTotal+tot2
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td >&nbsp; 
     </td>
    <td  nowrap>
    <%=ucase(rs1.fields("name"))%> BOOKED <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname")))
                              response.write " from"& sdate&" to"&enddate
                              %> 
    <td >
      &nbsp;</td>
    <td ><%= tot2 %>&nbsp;</td>
  </tr>
  <%
			end if

rs1.close 
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con,2,3
rsmain.fields("bill")="Y"
rsmain.update
rsmain.close
%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="3" > 
      <div align="center">
       
        Total:</div>
    </td>
    <td ><%= GrandTotal %></td>
    &nbsp; </tr>
</table>
<table width="658" border="0" align="center">
                           
 <tr bgcolor="#ffffff" > <td width="450">
 E. & O. E.<br>
 1. Subject to Delhi Juridiction. <br>
 2.Please check, Interest chargeable on the bill not paid with in 15 days.<br>
 3.Service tax, if applicable will be charged separate.<br>
 4.In case of the discrepency, kindly return the bill for necessary correction with in 10 days.
 </td>
 <td>&nbsp;
 
 </td>
 </tr>
 <tr width="300"><td align="right" colspan=2>
 <b>Authorised Signatory.</b>
 </td></tr></table>
 
 