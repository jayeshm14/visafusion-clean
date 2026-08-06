<!-- #include file="connection.asp" -->
<%
today=date-1
taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")

stmt ="select paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.visafee,paxstatus.sentdate,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.subdate)="&day(today)&" and Month(paxstatus.subdate)="&Month(today)&" and year(paxstatus.subdate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by paxstatus.refno"
rs.open stmt,con,3,3
                        
if rs.eof then 
 response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else
%>
<form>
  <table width="100%" border="1">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td width="10%"><b>Ref #</b></td>
      <td width="11%"><b>Visa Fee</b></td>
      <td width="12%"><b>Visa Fee (B)</b></td>
      <td colspan="2" width="64%"><b>Remarks</b></td>
    </tr>
    <%
set rs1=server.createobject("adodb.recordset")

while not rs.eof
refno=cdbl(rs.fields("refno"))
agent=cint(rs.fields("agent"))
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
visafee=rs.fields("visafee")
internalremark=rs.fields("internalremark")
paxid=rs.fields("paxid")
countryid=rs.fields("countryid")

stmt1 ="select visafee from invoicedetail where paxid='"&paxid&"' and countryid='"&countryid&"'"
rs1.open stmt1,con,3,3
if not rs1.eof then
visafee1=rs1.fields("visafee")
else
visafee1=""
end if
rs1.close
%> 
    <tr> 
      <td width="3%" height="2"> 
        <input type="checkbox" name="checkbox" value="checkbox">
      </td>
      <td width="10%" height="2"><%=refno%></td>
      <td width="11%" height="2"><%=visafee%>&nbsp;</td>
      <td width="12%" height="2"><%=visafee1%>&nbsp;</td>
      <td colspan="2" width="64%" height="2"><%=internalremark%>&nbsp;</td>
    </tr>
    <%
rs.movenext
wend

end if

%> 
  </table>
</form>