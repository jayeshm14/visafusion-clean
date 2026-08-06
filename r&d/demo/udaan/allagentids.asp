<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<table>
<%
today=date()
set rs=server.createobject("adodb.recordset")
stmt ="select  distinct(Mainentry.Agent) from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and paxstatus.refno=mainentry.refno and (paxstatus.Subdate=#"&today&"# or paxstatus.coldate=#"&today&"# or paxstatus.sentdate=#"&today&"# or paxstatus.entrydatetime=#"&today&"#)"
response.write stmt
rs.open stmt,con
if rs.eof then 
response.write"<tr><td  align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
response.write rs.fields("agent") &"<br>"
rs.movenext
wend
end if
rs.close()
%>
</table>