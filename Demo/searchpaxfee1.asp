<%@ Language=VBScript %>
<%
response.buffer= true
%>
<!-- #include file="connection.asp" -->
      <table width="765" border="1" align="center">
        <tr bgcolor="#CCCCFF"> 
          <td width="44"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Ref 
            #</b></font></td>
          <td width="78"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>PAX 
            Name</b></font></td>
          <td width="106"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Agent 
            Name</b></font></td>
          <td width="58"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Country</b></font></td>
          <td width="53"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Status</b></font></td>
          <td width="66"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Recieved</b></font></td>
          <td width="51"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Submit</b></font></td>
          <td width="73"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Collection</b></font></td>
          <td width="40"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>Total</b></font></td>
          <td width="76"><font size="1" face="Arial, Helvetica, 
sans-serif" color="#3300CC"><b>B</b></font></td>
        </tr>
        
<%
 mydate=date()-1
 mydate=Cdate(mydate)
 today=date() 

set rs=server.createobject("adodb.recordset")

if request("countryID")<>""  then
countryID=Cint(request("countryID"))
stmt ="select mainentry.bill, Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and paxstatus.statusID<>'601' order by mainentry.refno"
end if 

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
%><tr> 
          <td width="44"><font face="arial" size="1" 
color="#000000"><%=refno%></font></td>
          <td width="78"><font face="arial" size="1" color="#000000"><a href='Paxstatus.asp?refno=<%=refno%> & "&paxID=<%=paxID%>'><%=ucase(rs.fields("paxname"))%></a></font></td>
          <td width="106"><font face="arial" size="1" 
color="#000000"><a href='editentry.asp?refno=<%=refno%>'><% call writeIDDescription("agents",agent) %></a></font></td>
          <td width="58"> <font size="1"><%
if rs.fields("countryID")="" then
call writeIDDescription("embassy",0)
else 
response.write "<a href='collectionFormPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
response.write "</a>"
end if
%> </font></td>
          <td width="53"> <font face="arial" size="1" 
color="#000000"><a href='collectionform.asp?refno=<%=refno%>'> 
            <%
call writeIDDescription("status",rs.fields("statusid"))
%> </a></font> </td>
          <td width="66"><font face="arial" size="1" 
color="#000000"><%=receivedate%></font></td>
          <td width="51"><font face="arial" size="1" 
color="#000000"><%=subdate%></font></td>
          <td width="73"><font face="arial" size="1" color="#000000"> 
<%
if coldate <> "" then
response.write coldate
else
response.write "&nbsp;"
end if
%> </font></td>
          <td width="40"><font face="arial" size="1" 
color="#000000"><%=rs.fields("totalpax")%></font></td>
          <td width="76"> <font size="1"><%
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"<a href='refnototaldetailsub.asp?refno="&refno&"'> "
end if
response.write rs.fields("bill")&" "
if rs.fields("bill")="Y" and session("priv")="adm" then
response.write"</a>"
end if
%> </font></td>
        </tr>
        <tr> 
          <td height=2 colspan=11></td>
        </tr>
        <%
rs.movenext
wend
end if
rs.close()
%> 
      </table>