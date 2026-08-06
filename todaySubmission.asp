
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


<table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> <BR>
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              TODAY's SUBMISSION </font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
    <%
    
    PageNo = request("page")
IF PageNo="" then
	PageNo=1

END IF
   today=date
taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")

stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.subdate)="&day(today)&" and Month(paxstatus.subdate)="&Month(today)&" and year(paxstatus.subdate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"
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
    
    	response.write "&nbsp;<a href='todaysubmission.asp?page="&i&"'>"&i &"</a>&nbsp;"
    end if
 next
end if 
 response.write "</td></tr></table>"

%></td></tr>
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
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                                </tr>
                            <% 
                         
if rs.eof then 
 response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else
rs.absolutepage=PageNo
 end if

For x = 1 to rs.Pagesize
if rs.eof then 
  exit for
else 
'while not rs.eof
paxID=cdbl(rs.fields("paxID"))
refno=cdbl(rs.fields("refno"))
agent=cint(rs.fields("agent"))
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno &"&paxID="&paxID&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write "</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
call writeIDDescription("embassy",rs.fields("countryID"))
else 
call writeIDDescription("embassy",rs.fields("countryID"))
end if
response.write "<tr bgcolor='#F0F0FF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
'wend
end if
Next
response.write "<table width=300 border=0><tr>"
response.write "<td align='center'>"
If PageNo > 1 then
	response.write "<form method='post' action='todaysubmission.asp'>"
	response.write "<input type='hidden' name='Page' value=" & PageNo-1 & " >"
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='<< Prev'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td><td align='center'>"
If NOT rs.eof then
	response.write "<form method='post' action='todaysubmission.asp'>"	
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
		response.write "<input type='hidden' name='Page' value=" & PageNo+1 & ">"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='Next >>'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td></tr></table>"				 





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
                <tr> 
            <td align="center"><img src="images/linebottom.jpg" width="660" height="13"></td>
          </tr>
              </table>
            </td>
          </tr>
          <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
          
        </table>