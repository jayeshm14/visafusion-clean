<!-- #include file="connection.asp" -->
<%
response.buffer= true
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
<%
            date1=date()-3
if request("date")<>"" then
      today=request("date")
else
      today=date() 
end if


%>
<table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> <BR>
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              TODAY's COLLECTIONS </font></font></b></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
                       
              <div align="center"><br><form name=form1 action="todaycollection.asp">
              <table width=100%>
              <tr><td><span class="WSRightBold"><font color='red' font face='verdana' size='2'>AGENT:</font></span></td>
              <td>
              <select size=1  name="agent" ID="Select2"><option value="" Selected>ALL </OPTION>
                                
                                              <% 
                                              	agentid=request("agent")
                                            
						if Isnull(agentid) or IsEmpty(agentid) or agentid="" then
						agentid=0
						End If
						Call LoadListBox("agents",agentid)
						%> 
                                </select>
              </td>
              <td><span class="WSRightBold"><font color='red' font face='verdana' size='2'>DATE:</font></span></td>
              <td>
              
              
                                    <select name="date" ID="Select3">
<% 
i=20
while i<>0 %> 
                                      <option value="<%=Cdate(date()+i)%>"><%=systousrdate(cdate(date())+i)%></option>
                                      <% 
i=i-1
wend  %> 
                                      <option value="<%=date()%>" Selected ><%=systousrdate(date())%></option>
                                      <% for i=1 to 50 %> 
                                      <option value="<%=Cdate(date()-i)%>"
                                      <% newdate=cstr(date()-i)
                                      if day(newdate)=day(today) and Month(newdate)=Month(today) and year(newdate)=year(today) then 
                                      response.Write " Selected "
                                      end if
                                      response.Write " > "& systousrdate(cdate(date())-i)
                                      %>
                                      </option>
                                      <% next %> 
                                    </select>
              </td></tr>
              
              <tr><td><span class="WSRightBold"><font color='red' font face='verdana' size='2'>COUNTRY:</font></span></td>
              <td>
              <select name="countryID" size="1" ID="Select1"><option value="" Selected>ALL</OPTION>
                                 
                          <% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy",countryID)
	              	%> 
                        </select>
              </td>
              <td>&nbsp;</td>
              <td><input type="submit" value=" GO " name="submit" class="ud" ID="Submit1">
              </td></tr>
              </table>
                                    
                                  </form>
                                </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
      <%
      cmd=request("cmd")
             PageNo = request("page")
IF PageNo="" then
	PageNo=1

END IF
                  
taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")
stmt ="SELECT Entrydetails.Totalpax,entryDetails.Paxname,EntryDetails.paxname,paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,paxstatus.category,MainEntry.receivedate, Mainentry.Agent, MainEntry.internalRemark,MainEntry.poe,MainEntry.agentInstruction,Embassy.description countryName,Agents.description agentname FROM  PaxStatus,embassy, entryDetails, mainentry, agents WHERE  PaxStatus.refno = entryDetails.refno AND PaxStatus.PaxID = entryDetails.PaxID and PaxStatus.refno=mainentry.refno and mainentry.agent*=agents.agentsid and embassy.embassyid=PaxStatus.CountryID and  day(paxstatus.coldate)="&day(today)&" and Month(paxstatus.coldate)="&Month(today)&" and year(paxstatus.coldate)="&year(today) 

if request("countryID")<>"" then
countryID=Cint(request("countryID"))
stmt = stmt & " and paxstatus.countryID =" & countryID
end if 
if request("agent")<>"" then
agentID=Cint(request("agent"))
stmt = stmt & " and Mainentry.Agent =" & agentID
end if 

stmt = stmt&" ORDER BY countryname"
rs.open stmt,con,3,3

TotalRecs = rs.recordcount
rs.Pagesize=10
TotalPages = cInt(rs.pagecount)
response.write "<table width='100%'> <tr><td>"
If PageNo = 1 then
	response.write "<Font face='arial' size=2>Total <b>" & TotalRecs & "</b> entries in <b>" & TotalPages & "</b> page(s).</b></font>"
else 
	response.write "<Font face='arial' size=2><b> Page " & pageno & " of " & TotalPages & "</b></font>"
End If

if TotalPages>1 then
response.write "</td><td align=right>Pages : "

for i=1 to TotalPages
if i=cint(pageno) then
    	response.write "&nbsp;<Font face='arial' size=2 color='#0000FF'><b>"&i &"</b></font>&nbsp;"
    else
    
    	response.write "&nbsp;<a href='todaycollection.asp?page="&i&"&date="&request("date")&"&countryID="&request("countryID")&"&agent="&request("agent")&"'>"&i &"</a>&nbsp;"
    end if
 next
end if 
 response.write "</td></tr></table>"
 %>
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
                              <td width="39"><font size="2" face="verdana" color="#3300CC"><b><center>Ref 
                                #</center></b></font></td>
                              <td width="70"><font size="2" face="verdana" color="#3300CC"><b><center>PAX 
                                Name</center></b></font></td>
                              <td width="95"><font size="2" face="verdana" color="#3300CC"><b><center>Agent 
                                Name</center></b></font></td>
                                <td width="47"><font size="2" face="verdana" color="#3300CC"><b><center>Status</center></b></font></td>
                              <td width="59"><font size="2" face="verdana" color="#3300CC"><b><center>Recieved</center></b></font></td>
                              <td width="46"><font size="2" face="verdana" color="#3300CC"><b><center>Submit</center></b></font></td>
                              <td width="65"><font size="2" face="verdana" color="#3300CC"><b><center>Collection</center></b></font></td>
                             <td width="36"><font size="2" face="verdana" color="#3300CC"><b><center>Total</center></b></font></td>
                              <td width="52"><font size="2" face="verdana" color="#3300CC"><b><center>Country</center></b></font></td>
                                </tr>
                           <%
             

if rs.eof then 
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 
'while not rs.eof
if rs.eof then 
 response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'><span class='WSRightBold'>NO DATA FOUND</span></font></td></tr>" 
else
rs.absolutepage=PageNo
 end if

For x = 1 to rs.Pagesize
if rs.eof then 
  exit for
else 
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
iremark=rs.fields("internalremark")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
countryName=rs.Fields("countryName")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font>"

poe=rs.fields("poe")
poe=getDescriptionForID("poe",poe)
if ucase(poe)<>ucase("None") then
response.write("<br><b>"&poe&"</b><img src='images/alert1.gif' width='40' height='20'>")
end if

response.write"</td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
'call writeIDDescription("embassy",rs.fields("countryID"))
response.Write countryName
else 
'call writeIDDescription("embassy",rs.fields("countryID"))
response.Write countryName
end if
if iremark<>"" then
response.write "<tr bgcolor='#FFFFFF'><td height=2 colspan=11><b><FONT COLOR='RED'>Internal Remark : </FONT>"&iremark&"</b></td></tr>"
end if
response.write "<tr bgcolor='#F0F0FF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
'wend
end if

Next
response.write "<table width=300 border=0><tr>"
response.write "<td align='center'>"
If PageNo > 1 then
	response.write "<form method='post' action='todaycollection.asp'>"
	response.write "<input type='hidden' name='Page' value=" & PageNo-1 & " >"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<input type='hidden' name='date' value="&request("date")& " >"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='<< Prev'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td><td align='center'>"
If NOT rs.eof then
	response.write "<form method='post' action='todaycollection.asp'>"	
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<input type='hidden' name='Page' value=" & PageNo+1 & ">"
	response.write "<input type='hidden' name='countryID' value=" & request("countryID") & " >"
	response.write "<input type='hidden' name='agent' value=" & request("agent") & " >"
	response.write "<input type='hidden' name='date' value="&request("date")& " >"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='Next >>'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td></tr></table>"				 

end if
rs.close()
%> 
                          </table>
                          
                          </table>
                          <img src="images/linebottom.jpg" width="660" height="13">
                          </td>
                      </tr>
                    </table>
                  </td>
                  <td align="right" width="1"> <img src="images/pixelsline.gif" width="1" height="7"> 
                  </td>
                </tr><tr> 
            	<td align="center" ><!--img src="images/linebottom.jpg" width="660" height="13"--></td>
         	</tr>
                
              </table>
            </td>
          </tr>
         <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
        </table>