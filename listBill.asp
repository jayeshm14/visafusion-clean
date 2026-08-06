<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>UDAAN INDIA - List of Bills</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')"><table width="75%" border="0" cellspacing="0" cellpadding="0" align="center"> 
<tr valign="top" align="left"> 
    <td><!-- #include file="topAdmin.asp" --></td>
  </tr>
  
  <tr>
    <td>

<style type="text/css">
<!--
a {  font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #000000}
a:hover {  font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>


    <table width="100%" border="0">
      <%   if pan<>1 then
             cmd=request("cmd")
             end if
             sentstatusID=getIDForDescription("status","Sent")
             PageNo = request("page")
		IF PageNo="" then
		PageNo=1
		END IF
             %> 
      <tr> 
        <td width="10%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=today">Today's</a></div>
        </td>
        <td width="10%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=all">Show All</a></div>
        </td>
        <td width="15%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=Billed">Bills Generated 
            </a></div>
        </td>
        <td width="11%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=date">Date Wise</a></div>
        </td>
        <td width="12%" height="2"> 
          <div align="center"><a href="dailybill.asp">Show Bills</a></div>
        </td>
        <td width="11%" height="2"> 
          <div align="center"><a href="searchbyinvno.asp">Invoice No.</a></div>
        </td>
        <td width="10%" height="2">
          <div align="center"><a href="agentStatement1.asp">Statement</a></div>
        </td>
        <td width="10%" height="2">
          <div align="center"><a href="DailyVisafee.asp">Visa Fee</a></div>
        </td>
        <td width="14%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=status">Status Wise</a></div>
        </td>
        <td width="10%" height="2"> 
          <div align="center"><a href="listBill.asp?cmd=sent">Sent</a></div>
        </td>
      </tr>
    </table>
            
            <form name="Filter" action="listbill.asp" method="post" ID="Filter">
		<input type='hidden' name='cmd' value="<%=cmd%>" ID="Hidden1">
		<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090"
			ID="Table1">
			<TBODY>
				<tr bgcolor="#fffff0">
					<td height="19">
						<div align="center"><b><font size="3" color="#cc0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
										SEARCH  </font></font></b>
						</div>
					</td>
				</tr>
				<tr bgcolor="#fffff0">
					<td>
					
				
				<table width="100%" ID="Table8">
							<tr>
								<td><span class="WSRightBold">COUNTRY:</span></td>
								<td>
									<select name="countryID" size="1" ID="Select1">
										<option value="" Selected>ALL</option>
										<% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy",countryID)
	              	%>
									</select>
								</td>
								<td><span class="WSRightBold">STATUS:</span></td>
								
								<td>
								<select name="statusID" size="1" ID="statusID">
								<option value="" Selected>ALL</option>
																				<%
											statusID= request("statusID")
											if Isnull(statusID) or IsEmpty(statusID) or statusID="" then
												statusID=0
											End If
											Call LoadListBox("status",statusID)
											%>
								</select>
								
								</td>
								</tr>
								<tr>
								<td><span class="WSRightBold">AGENT:</span></td>
								<td>
									<select size="1" name="agent" ID="Select2">
										<option value="" Selected>ALL
										</option>
										<% 
                        agentid=request("agent")
                                            
						if Isnull(agentid) or IsEmpty(agentid) or agentid="" then
						agentid=0
						End If
						Call LoadListBox("agents",agentid)
						%>
									</select>
								</td>
								<td nowrap><span class="WSRightBold"> REF NO.:</span></td>
								<td>
									<input type="text" name="refno" value="<%=request("refno")%>" size=30 ID="Text1">
								</td>
							</tr>
							
								<tr>
								<td colspan=4 align=center>
								<input type="submit" value=" Display Records " name="submit" class="ud" ID="Submit1">
								</td></tr>
						</table>
				
				
					</td>
				</tr>
				<table> 
				</form>
            
            <TABLE WIDTH="300" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<TR>
		<TD>&nbsp;</TD>
	</TR>
</TABLE>

<form name=collection action="listbill.asp" method="post">
      <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr> 
          <td> 
            <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
              <tr bgcolor="#FFFFF0"> 
                <td height="19"> 
                  <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><i> 
                    <% if cmd="date" then
              response.write"GENERATE BILLS(DATE WISE)"
              END IF
              if cmd="today" then
              response.write"GENERATE BILLS ( TODAY )"
              END IF
              if cmd="Billed" then
              response.write"BILLS GENERATED "
              END IF
              if cmd="status" then
              response.write"GENERATE BILLS ( STATUS  )"
              END IF
              if cmd="sent" then
              response.write"GENERATE BILLS ( SENT )"
              END IF
              if cmd="all" then
              response.write"GENERATE BILLS ( ALL CASES )"
              END IF
              if cmd="" or isNull(cmd) then
              response.write"GENERATE BILLS ( REF.# )"
              end if
              if cmd="search" then
              response.write"GENERATE BILLS ( SEARCH )"
              end if
              
              %> </i></font></font></b></div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td height="2"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#000C80">
              <tr> 
                <td><img src="images/linetop.jpg" width="660" height="13"></td>
              </tr>
              <tr> 
                <td height="13"> 
                  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                      <td width="560"> 
                        <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                          <tr valign="top"> 
                            <td align="center" bgcolor="#" valign="top"> 
<% date1=date()-30
            today=date() 
            categoryid=getIDForDescription("category","Attestation")
 
 IF pan=1 then
 response.write "BILL GENERATED FOR REF NO"&refno 
 end if
 if cmd="all" then
 
 Stmt="select * from Mainentry  where bill='N' order by refno desc"
 end if
 if cmd="Billed" then
 stmt="select * from Mainentry  where bill='Y' and receiveDate>'"&date1 &"'  order by refno desc"
 end if
 if cmd="date" then
  stmt="select * from Mainentry  where bill='N' and receiveDate>'"&date1 &"' and status="&sentstatusID&" order by receivedate desc"
 end if
 if cmd="today" then
 stmt="select * from Mainentry  where bill='N' and (Day(receivedate)="&day(today)&" and month(receivedate)="&month(today)&" and year(receivedate)="&year(today)&") and status="&sentstatusID&" order by refno desc"
 end if
 if cmd="" or isNull(cmd) then
  stmt="select * from Mainentry where bill='N' and receiveDate>'"&date1 &"' and status="&sentstatusID&" order by refno desc"
 end if
 if cmd="status" then

 stmt="select * from Mainentry  where bill='N' and receiveDate>'"&date1 &"' and status="&sentstatusID&" order by Status"
 end if
 if cmd="sent" then
 stmt="select * from Mainentry  where bill='N' and status="&sentstatusID&" order by refno desc"
 end if
 
'if any of the above is selected then

if request("countryID")<>"" OR request("agent") <>"" OR request("refno")<>"" OR request("statusID")<>"" then
 
 Stmt="SELECT distinct Mainentry.* FROM  PaxStatus,embassy, entryDetails, mainentry, agents WHERE  PaxStatus.refno = entryDetails.refno AND PaxStatus.PaxID = entryDetails.PaxID and PaxStatus.refno=mainentry.refno and mainentry.agent*=agents.agentsid and embassy.embassyid=PaxStatus.CountryID and mainentry.bill='N' "
if request("countryID")<>"" then
countryID=Cint(request("countryID"))
stmt = stmt & " and paxstatus.countryID =" & countryID
end if 

if request("agent")<>"" then
agentID=Cint(request("agent"))
stmt = stmt & " and Mainentry.Agent =" & agentID
end if 
if request("date")<>"" then
recdate=request("date")
stmt = stmt & " and convert(char(12),Mainentry.receivedate,101)='" & recdate&"'"
end if 
if request("statusID")<>"" then
statusID=request("statusID")
stmt = stmt & " and paxStatus.statusID =" & statusID
end if 
 if request("refno")<>"" then
stmt = stmt & " and mainentry.refno="&request("refno")
 end if
stmt = stmt & " order by mainentry.refno desc"

end if


set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset") 

rs.open stmt,con,3,3
if rs.eof then 
response.write "<font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font>" 
else 
TotalRecs = rs.recordcount
rs.Pagesize=10
TotalPages = cInt(rs.pagecount)
response.write "<table width='100%'><tr><td>"
If PageNo = 1 then
	response.write "<Font face='arial' size=2 color='FFFFFF'>Total <b>" & TotalRecs & "</b> entries in <b>" & TotalPages & "</b> page(s).</b></font>"
else 
	response.write "<Font face='arial' size=2 color='FFFFFF'><b> Page " & pageno & " of " & TotalPages & "</b></font>"
End If

if TotalPages>1 then
response.write "</td><td align=right>Pages : "

for i=1 to TotalPages
if (i mod 20)=0 then 
response.write "<br>"
end if
if i=cint(pageno) then
    	response.write "&nbsp;<Font face='arial' size=2 color='#FFFFFF'><b>"&i &"</b></font>&nbsp;"
    else
       	response.write "&nbsp;<a href='listbill.asp?page="&i&"&cmd="&cmd&"&countryID="&request("countryID")&"&agent="&request("agent")&"&refno="&request("refno")&"&statusID="&request("statusID")&"'><font color='#CCCCFF'>"&i &"</font></a>&nbsp;"
    end if
 next
end if 

response.write "</td></tr></table>"
%> 
                              <table width="658" border="0" valign="top" vspace="0" hspace="0" cellpadding="0" cellspacing="0">
                                <tr bgcolor="#CCCCFF" valign="top"> 
                                  <td width="84" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                    #</b></font></td>
                                  <td width="59" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                                  <td width="81" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                    Name</b></font></td>
                                  <td width="42" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                                  <td width="110" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                    Name</b></font></td>
                                  <td width="54" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                                  <td width="60" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                                  <td width="81" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Bill</b></font></td>
                                  <%
                              if cmd="Billed" then
                              %> 
                                  <td width="87" height="10"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Credit</b></font></td>
                                  <%
			      end if
			      %> </tr>
                                <%  
               
            
if rs.eof then %> 
                                <tr bgcolor="#F0F0FF">
                                  <td colspan=11 align=center><font face="arial" size=2 color="#ff0000">NO 
                                    DATA FOUND</font></td>
                                </tr>
                                <%
else
rs.absolutepage=PageNo
 end if

For x = 1 to rs.Pagesize
if rs.eof then 
  exit for
else 
'while not rs.eof
	refno=rs.fields("refno")  
	agent=rs("agent")
	status=rs("status")
	category=rs("category")
	recdate=rs.fields("receivedate")
	if  recdate <> "" then
	recdate=day(recdate)&"/"&Month(recdate)&"/"&year(recdate)
	End if

	subdate=rs.fields("subdate")
	if  subdate <> "" then
	subdate=day(subdate)&"/"&Month(subdate)&"/"&year(subdate)
	End if

	coldate=rs.fields("coldate")
	if  coldate <> "" then
	coldate=day(coldate)&"/"&Month(coldate)&"/"&year(coldate)
	End if
	sentdate=rs.fields("sentdate")
	if  sentdate <> "" then
	sentdate=day(sentdate)&"/"&Month(sentdate)&"/"&year(sentdate)
	End if
	
	iremark=rs.fields("internalremark")
	exremark=rs.fields("externalremark")

set rs2=server.createobject("adodb.recordset")
countryList=""
Tempstmt="select distinct(countryID) from PaxStatus where Refno="&refno
rsCountry.open Tempstmt,con
firstflag="Y"
while not rsCountry.Eof
country=rsCountry.fields("countryID")
if firstflag="Y" then
countryList=countryList& getDescriptionForID("Embassy",country)
firstflag="N"
else
countryList=countryList&", "& getDescriptionForID("Embassy",country)
end if
rsCountry.movenext
Wend
rsCountry.close
%> 
                                <tr bgcolor="#F0F0FF">
                                  <td width="84"><font face="arial" size=2 color="red"><b><%=refno%><% 
poe=rs.fields("poe")
poe=getDescriptionForID("poe",poe)
if ucase(poe)<>ucase("None") then
response.write("<br><b>"&poe&"</b>")
end if
%></b></font></td>
                                  <td width="59"><font face="arial" size=2 color="#000000"><%=recdate%></font></td>
                                  <td width="81"><font face="arial" size=2 color="#000000"> 
                                    <%
if countryList="" then
response.write ""&ucase(rs.fields("paxname"))&""
else
if category=categoryid then
response.write ""&ucase(rs.fields("paxname"))&"(Attest)"
else %> <a href="refnoDetail.asp?refno=<%=refno%>"><%=ucase(rs.fields("paxname"))%></a> 
                                    <% end if
end if %> </font></td>
                                  <td width="42"><font face="arial" size=2 color="#000000"><%=rs.fields("totalpassengers")%></font></td>
                                  <td width="110"><font face="arial" size=2 color="#000000"><a href=searchPax.asp?agent=<%= agent%> > 
                                    <%
call writeIddescription("agents",agent)%> </a></font></td>
                                  <td width="54"><font face="arial" size=2 color="#000000"><a href="collectionBillform.asp?refno=<%=refno%>" > 
                                    <%
if status <> "" then
call writeIddescription("status",status)
end if %> </a></font></td>
                                  <td width="60"><%=countryList %> <%
if cmd="Billed" then %> &nbsp;</td>
                                  <td width="81"><font face="arial" size=2 color="#000000"><a href="editbill.asp?refno=<%=refno%>&cmd=<%=cmd%>">Edit</a> 
                                    <a href="refnoTotaldetailsub.asp?refno=<%=refno%>&cmd=<%=cmd%>">/Print</a></font></td>
                                  <%
flag="c" %> 
                                  <td width="87"><font face="arial" size=2 color="#000000"><a href="creditnote.asp?refno=<%=refno%>&cmd=<%=cmd%>">Cr 
                                    N</a> <a href="creditprint.asp?refno=<%=refno%>&cmd=<%=cmd%>">/Print</a></font></td>
                                </tr>
                                <% else %> 
                                  <td width="84"><font face="arial" size=2 color="#000000"><a href="refnoTotaldetail.asp?refno=<%=refno%>&cmd=<%=cmd%>" >BILL</a> 
                                    </font></td>
                                  <td width="59">&nbsp;</td>
                                </tr>
							<% if iremark<>"" then %>
                                <tr bgcolor="#FFFFFF">
                                  <td width="84" valign="top"><b><font color="red">I.Remark</font></b></td>
                                  <td height=5 colspan=12 bgcolor="#FFFFFF"><%=iremark%></td>
                                </tr>
                            <% end if %> 
							<% if exremark<>"" then %>
                                <tr bgcolor="#FFFFFF">
                                  <td width="84" valign="top"><b>Ex.Remark</b></td>
                                  <td height=5 colspan=12 bgcolor="#FFFFFF"><%=exremark%></td>
                                </tr>
                             <% end if %>
                                <tr bgcolor="#F0F0FF">
                                  <td height=5 colspan=12 bgcolor="#A0A0A0"></td>
                                </tr>
                                <% end if
rs.movenext
'wend
end if
Next

response.write "<table width=300 border=0><tr>"
response.write "<td align='center'>"
If PageNo > 1 then
	response.write "<form method='post' action='listbill.asp'>"
	response.write "<input type='hidden' name='Page' value=" & PageNo-1 & " >"
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='refno' value=" & request("refno") & " >"
	response.write "<input type='hidden' name='statusID' value=" & request("statusID") & " >"
	'response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='<< Prev'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td><td align='center'>"
If NOT rs.eof then
	response.write "<form method='post' action='listbill.asp'>"	
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<input type='hidden' name='Page' value=" & PageNo+1 & ">"
	
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='refno' value=" & request("refno") & " >"
	response.write "<input type='hidden' name='statusID' value=" & request("statusID") & " >"
	'response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='Next >>'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td></tr></table>"
end if
rs.close()
%> 
                              </table>
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
                <td height="2"><img src="images/linebottom.jpg" width="660" height="8"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td><!-- #include file="adminBottom.asp" --></td>
        </tr>
      </table>
    </form>
    
    </td>
  </tr>
</table>
</body>
</html>