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
<style type="text/css"> <!-- a { font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #006600}
	a:hover { font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
	--></style>
<body>
	<table width="99%" border="0">
		<tr>
			<%
             cmd=request("cmd")
             today=request("date")
             PageNo = request("page")
IF PageNo="" then
	PageNo=1

END IF
 %>
			<td colspan="5" align="center">
				<p align="center"><font size="2" color="#006600"><b>
							<%
     if request("msgID")="1" then 
                   response.write " The information regarding "&ucase(request("pname"))&" updated successfully."
   end if
     %></font></B></p>
			</td>
		</tr>
	</table>
	<form name="Filter" action="BulkCollection.asp" method="post" ID="Filter">
		<input type='hidden' name='cmd' value="<%=cmd%>" >
		<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090"
			ID="Table1">
			<TBODY>
				<tr bgcolor="#fffff0">
					<td height="19">
						<div align="center"><b><font size="3" color="#cc0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
										BULK UPDATE </font></font></b>
						</div>
					</td>
				</tr>
				<tr bgcolor="#fffff0">
					<td>
						<table width="100%" ID="Table8">
							<tr>
								
            <td><span class="WSRightBold"><font face="Verdana" size="2" color="#FF0066"><b>COUNTRY:</b></font></span></td>
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
								
            <td><span class="WSRightBold"><font face="Verdana" size="2"><b><font color="#FF0066">STATUS:</font></b></font></span></td>
								
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
								
            <td><span class="WSRightBold"><font face="Verdana" size="2"><b><font color="#FF0066">AGENT:</font></b></font></span></td>
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
								
            <td nowrap><span class="WSRightBold"> <font color="#FF0066"><b><font face="Verdana" size="2">RECEIVE 
              DATE:</font></b></font></span></td>
								<td>
									<select name="date" ID="Select3">
										<option value="" Selected>ALL</option>
										<% for i=0 to 90 %>
										<option value="<%=Cdate(date()-i)%>"
                                      <% newdate=cstr(date()-i)
                                      if Isnull(today) or IsEmpty(today) or today="" then
                                      today=date()
                                      else
									  if day(newdate)=day(today) and Month(newdate)=Month(today) and year(newdate)=year(today) then 
                                      response.Write " Selected "
                                      end if
						End If
                                      
                                      response.Write " > "& systousrdate(cdate(date())-i)
                                      %>
										</option>
										<% next %>
									</select>
								</td>
							</tr>
							
								<tr>
								<td colspan=4 align=center>
								<input type="submit" value=" Display Records " name="submit" class="ud" ID="Submit1">
								</td></tr>
						</table>
					</td>
				</tr>
			</TBODY></table>
	</form>
	<!--DIV align="center" -->
	<FORM id="Form2" name="collection" action="BulkCollectionSubmit.asp" method="post">
		<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="44%" align="center" border="0">
			<TR>
				<TD>
					
				</TD>
			</TR>
			<TR>
				<TD height="2">
					<TABLE id="Table4" cellSpacing="0" cellPadding="0" width="750" align="center" bgColor="#000c80"
						border="0">
						<TR>
							<TD><IMG height="13" src="images/linetop.jpg" width="750"></TD>
						</TR>
						<TR>
							<TD>
								<TABLE id="Table5" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
									<TR>
										<TD align="left" width="1"><IMG height="7" src="images/pixelsline.gif" width="1"></TD>
										<TD width="750">
											<TABLE id="Table6" cellSpacing="0" cellPadding="0" width="100%" bgColor="#fffff8" background="images/backform.jpg"
												border="0">
												<TR>
													<TD>
														<%  
               
            date1=date()-5
            date2=date()-60
            today=date() 
            categoryid=getIDForDescription("category","Attestation")
 
 Stmt="SELECT entryDetails.refno refno, paxStatus.statusID, paxStatus.remarks, paxStatus.colcheck, paxStatus.category category, mainentry.AgentInstruction, mainentry.internalremark internalremark, mainentry.agent agent,Mainentry.receivedate, agents.description agentname, entryDetails.PaxID, PaxStatus.CountryID, embassy.description countryName, entryDetails.Paxname, PaxStatus.subdate, PaxStatus.coldate, PaxStatus.visafee,PaxStatus.ddcharges,paxStatus.handlingfee,paxStatus.couriercharges,paxStatus.misccharges,paxStatus.total FROM  PaxStatus,embassy, entryDetails, mainentry, agents WHERE  PaxStatus.refno = entryDetails.refno AND PaxStatus.PaxID = entryDetails.PaxID and PaxStatus.refno=mainentry.refno and mainentry.agent*=agents.agentsid and embassy.embassyid=PaxStatus.CountryID and  (PaxStatus.coldate IS NULL or PaxStatus.subdate IS NULL) "
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


if request("countryID")="" and request("agent")="" and request("date")="" and request("statusID")="" then
stmt = stmt & " and 1=2"
end if

 if cmd="all" then
 Stmt=Stmt &" order by PaxStatus.refno desc"
 end if
 if cmd="agent" then

 Stmt=Stmt &" order by agents.description"
 end if
 if cmd="date" then
 
 Stmt=Stmt &" order by receivedate desc"
 end if
 if cmd="status" then
 
 Stmt=Stmt &" order by paxStatus.statusID"
 end if
 
 

 if cmd="" or isNull(cmd) then
  Stmt=Stmt &" order by embassy.description, PaxStatus.refno desc"
 end if

 'response.Write stmt
set rs=server.createobject("adodb.recordset")

rs.open stmt,con,3,3
TotalRecs = rs.recordcount
rs.Pagesize=10
TotalPages = cInt(rs.pagecount)
response.write "<table width='100%'> <tr bgcolor='#CCCCFF'><td>"
If PageNo = 1 then
	response.write "<Font face='arial' size=2 color='#006600'>Total <b>" & TotalRecs & "</b> entries in <b>" & TotalPages & "</b> page(s).</b></font>"
else 
	response.write "<Font face='arial' size=2 color='#006600'><b> Page " & pageno & " of " & TotalPages & "</b></font>"
End If

if TotalPages>1 then
response.write "</td><td align=right><Font face='arial' size=2 color='#006600'>Pages :</font> "

for i=1 to TotalPages
if (i mod 20)=0 then 
response.write "<br>"
end if
if i=cint(pageno) then
    	response.write "&nbsp;<Font face='arial' size=2 color='#0000FF'><b>"&i &"</b></font>&nbsp;"
    else
    
    	response.write "&nbsp;<a href='BulkCollection.asp?page="&i&"&cmd="&cmd&"&agent="&request("agent")&"&countryID="&request("countryID")&"&date="&request("date")&"&statusID="&request("statusID")&"'><Font face='arial' size=2 color='#006600'>"&i &"</font></a>&nbsp;"
    end if
 next
end if 
 response.write "</td></tr></table>"

 %>
														
                        <TABLE id="Table7" width="100%" align="center" border="0">
                          <TR bgColor="#ccccff"> 
                            <TD width="50"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Ref 
                                #</B></font></div>
                            </TD>
                            <TD width="50"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Recieved</B></font></div>
                            </TD>
                            <TD width="100"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>PAX 
                                Name</B></font></div>
                            </TD>
                            <TD width="100"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Agent 
                                Name</B></font></div>
                            </TD>
                            <TD width="70"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Country 
                                </B></font> </div>
                            </TD>
                            <TD width="50"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Sub. 
                                Date</B></font></div>
                            </TD>
                            <TD width="50"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Col. 
                                Date</B></font></div>
                            </TD>
                            <TD width="36"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>CHK</B></font></div>
                            </TD>
                            <TD width="52"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>Visa 
                                fee</B></font></div>
                            </TD>
                            <TD width="70"> 
                              <div align="center"><font face="Verdana" color="#3300cc" size="2"><B>DD 
                                Charges</B></font></div>
                            </TD>
                          </TR>
                          <%                            

if rs.eof then 
 response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><b><font color='red' font face='verdana' size='3'>NO DATA FOUND</b></font></td></tr>" 
else
rs.absolutepage=PageNo
 end if

For x = 1 to rs.Pagesize
if rs.eof then 
  exit for
else 

'while not rs.eof
refno=rs.fields("refno")  
paxID=rs.fields("paxID") 
intremark=ucase(rs.fields("internalremark"))
retrieveremark=ucase(rs.fields("AgentInstruction"))  
remarks= rs.fields("remarks") 
agent=rs("agent")
status="status"
category=rs("category")
visafee=rs("visafee")
ddcharges=rs("ddcharges")
recdate=rs("receivedate")
countryName= rs.fields("countryName")
countryID= rs.fields("CountryID")
statusCountry= rs.fields("statusID") 
colcheck=rs.Fields("colcheck")
handlingfee=rs.Fields("handlingfee")
couriercharges=rs.Fields("couriercharges")
misccharges=rs.Fields("misccharges")
if isnull(handlingfee) or handlingfee="" then
handlingfee=0
end if
if isnull(couriercharges) or couriercharges="" then
couriercharges=0
end if
if isnull(misccharges) or misccharges="" then
misccharges=0
end if


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

%> 
                          <input type="hidden" name="refno<%=x%>" value="<%=refno%>" >
                          <input type="hidden" name="paxID<%=x%>" value="<%=paxID%>" >
                          <input type="hidden" name="countryID<%=x%>" value="<%=countryID%>" >
                          <input type="hidden" name="name<%=x%>" value="<%=rs.fields("paxname")%>" >
                          <input type="hidden" name="handlingfee<%=x%>" value="<%=handlingfee%>" >
                          <input type="hidden" name="couriercharges<%=x%>" value="<%=couriercharges%>" >
                          <input type="hidden" name="misccharges<%=x%>" value="<%=misccharges%>" >
                          <input type="hidden" name="oldstatus<%=x%>" value="<%=statusCountry%>" >
                          <input type="hidden" name="oldvisafee<%=x%>" value="<%=visafee%>" >
                          <input type="hidden" name="oldDDcharges<%=x%>" value="<%=ddcharges%>" >
                          <input type="hidden" name="oldsubdate<%=x%>" value="<%=subdate%>" >
                          <input type="hidden" name="oldcoldate<%=x%>" value="<%=coldate%>" >
                          <input type="hidden" name="oldremark<%=x%>" value="<%=remarks%>" >
                          <%
'sentdate=rs.fields("sentdate")
'if  sentdate <> "" then
'sentdate=day(sentdate)&"/"&Month(sentdate)&"/"&year(sentdate)
'End if

response.write "<tr bgcolor='#F0F0FF'><td width='20'><font face='arial' size=2 color='#006600'>"&refno&"</font></td><td width='20'><font face='arial' size=2 color='#006600'>"& recdate &"</font></td><td ><font face='arial' size=2 color='#006600'>"
if countryList="" then
'response.write ""&ucase(rs.fields("paxname"))&""

response.write "<a target='_blank' href='Paxstatus.asp?refno="&refno&"&paxID="&paxID&"' >"&ucase(rs.fields("paxname"))&"</a>"
else
if cint(category)=cint(categoryid) then
response.write "<a href='refnoDetail.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >"&ucase(rs.fields("paxname"))&"</a>(ATTEST)"
else
response.write "<a href='refnoDetail.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >"&ucase(rs.fields("paxname"))&"</a>"
end if
end if
response.write "</font></td><td ><font face='arial' size=2 color='#006600'><a target='_blank' href='collectionform.asp?refno="&refno&"' >"
call writeIddescription("agents",agent)
response.write "</a></font></td><td><font face='arial' size=2 color='#006600'>"&countryName
response.write "</font></td><td><font face='arial' size=2 color='#006600'>"
response.write "<input type=text name=subdate"&x&" size=8 value="&subdate&" >"
response.write "</font></td><td><font face='arial' size=2 color='#006600'>"
response.write "<input type=text name=coldate"&x&" size=8 value="&coldate&" >"
response.write "</font></td><td> <font face='arial' size=1 color='#006600'>"
                      
response.write "<input type=radio name=colcheck"&x&"  value='conf'"
                      if colcheck="conf" then 
                      response.write " Checked"
                      End if 
                    
response.write "ID='Radio1'>CONF.<br><input type=radio name=colcheck"&x&"  value='chk'" 
                       if colcheck="chk" then 
                      response.write " Checked"
                      End if 
                      
response.write "ID='Radio2'> CHK.</font></td><td><font face='arial' size=2 color='#006600'>"
response.write "<input type=text name=visafee"&x&" size=6 value="&visafee&" >"
response.write "&nbsp;</font></td><td><font face='arial' size=2 color='#006600'>"
response.write "<input type=text name=ddcharges"&x&" size=6 value="&ddcharges&" ></font></td></TR>"
response.write "<tr bgcolor='#F0F0FF'><td colspan=5 align='left' nowrap><font size=2 face='arial' color='#0000CC'><b>Internal Remark :</b><font size=2 face='arial' color=#C35068><input type=text size=35 name=remark"&x&" value='"&remarks&"' ></font></font></td>"
response.write "<td colspan=4 align='left'><font size=2 face='arial' color='#0000CC'><b>Status :</b></font>"
response.write "<select name='status"&x&"' size='1'>"
Call LoadListBox("status",statusCountry)
response.write "</select></td></tr>"

response.write "<tr bgcolor='#F0F0FF'><td height=5 colspan=12 bgcolor='#A0A0A0'></td></tr>"

rs.movenext
'wend
 end if
Next
response.write "<input type='hidden' name='entries' value="&x-1&" >"
response.write "<input type='hidden' name='username' value="&session("uname")&" >"
response.write "<input type='hidden' name='cmd' value="&cmd& " >"
response.write "<input type='hidden' name='Page' value=" & PageNo & ">"
response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
response.write "<input type='hidden' name='date' value=" & request("date") & " >"
response.write "<input type='hidden' name='statusID' value=" & request("statusID") & " >"


response.write "<table width=100% border=0 align=center cellSpacing=0 cellPadding=0><tr cellSpacing=1 cellPadding=1 bgcolor='#CCCCFF' align=center>"
response.write "<td colspan=2 align='center'><input type=submit value=Submit> <input type=reset value=Reset>"
response.write "</td></tr></FORM><tr bgcolor='#A0A0A0' ><td height=5 colspan=2 align='left'></td></tr><tr bgcolor='#CCCCFF'><td align='left'>"

If PageNo > 1 then
	response.write "<form method='post' action='BulkCollection.asp'>"
		
	response.write "<input type='hidden' name='Page' value=" & PageNo-1 & " >"
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='date' value=" & request("date") & " >"
	response.write "<input type='hidden' name='statusID' value=" & request("statusID") & " >"
	
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='<< Prev' class='ud'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td><td align='right'>"
If NOT rs.eof then
	response.write "<form method='post' action='BulkCollection.asp'>"	
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<input type='hidden' name='Page' value=" & PageNo+1 & ">"
		
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='date' value=" & request("date") & " >"
	response.write "<input type='hidden' name='statusID' value=" & request("statusID") & " >"
	
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='Next >>' class='ud'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td></tr></table>"				 

rs.close()
%> 
                        </TABLE>
													</TD>
												</TR>
											</TABLE>
										</TD>
										<TD align="right" width="1"><IMG height="7" src="images/pixelsline.gif" width="1">
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR>
							<TD><IMG height="13" src="images/linebottom.jpg" width="750"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	<!--/DIV-->
</body>
