<% server.scripttimeout=2000 %>
<%
set con=server.createobject("ADODB.Connection")
'con.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"
con.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&SERVER.MAPPATH("db1.mdb")

'set webcon=server.createobject("ADODB.Connection")
'webcon.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=NETDB"

'Set webcon=server.CreateObject ("ADODB.Connection")
'webcon.open "driver={SQL server};Server=65.57.230.105;uid=udaanindia;pwd=uda3000;database=udaanindia"

dim i
set rs=server.createobject("ADODB.RecordSet")
set rs1=server.createobject("ADODB.RecordSet")
set rs2=server.createobject("ADODB.RecordSet")
set rss1=server.createobject("ADODB.RecordSet")
set rss2=server.createobject("ADODB.RecordSet")

rs.open "select refno from mainentry order by refno", con, 3,3
if rs.eof then
response.write "You Have no changes in database............"
else
response.write rs.recordcount&"<br><br>"
while not rs.eof

response.write rs("refno")&"<br>"

'************************ MainEntry table update/insert *************************

'	rs1.open "select * from mainentry where refno="&rs("refno")&"", con,2,3
'	rs2.open "select * from mainentry where refno="&rs("refno")&"", webcon,2,3
'
'	if rs2.eof then
'	rs2.addnew
'	end if
'	for i=0 to rs1.fields.count-1
'		rs2.fields(i)=rs1.fields(i)
'	next
'	rs2.update
'	rs1.close	
'	rs2.close
'
''************************ End MainEntry ***************************************
''************************ EntryDetails table update/insert *************************
'
'	rs1.open "select * from entrydetails where refno="&rs("refno")&"", con,2,3
'	webcon.execute("delete from entrydetails where refno="&rs("refno")&"")
'	rs2.open "select * from entrydetails where refno="&rs("refno")&"", webcon,2,3
'
'	while not rs1.eof
'	rs2.addnew
'	for i=0 to rs1.fields.count-1
'		rs2.fields(i)=rs1.fields(i)
'	next
'	rs2.update
'
'	'************************ PaxStatus table update/insert *************************
'		rss1.open "select * from statushistory where paxid="&rs1("paxid")&"", con,2,3
'		webcon.execute("delete from statushistory where paxid="&rs1("paxid")&"")
'		rss2.open "select * from statushistory where paxid="&rs1("paxid")&"", webcon,2,3
'
'		while not rss1.eof
'		rss2.addnew
'		for i=0 to rss1.fields.count-1
'			rss2.fields(i)=rss1.fields(i)
'		next
'		rss2.update
'		rss1.movenext
'		wend
'		rss1.close
'		rss2.close
'	'************************ End PaxStatus ***************************************
'	rs1.movenext
'	wend
'	rs1.close	
'	rs2.close

'************************ End EntryDetails ***************************************
'************************ PaxStatus table update/insert *************************

'	rs1.open "select * from paxstatus where refno="&rs("refno")&"", con,2,3
'	webcon.execute("delete from paxstatus where refno="&rs("refno")&"")
'	rs2.open "select * from paxstatus where refno="&rs("refno")&"", webcon,2,3
'
'	while not rs1.eof
'	rs2.addnew
'	for i=0 to rs1.fields.count-1
'		rs2.fields(i)=rs1.fields(i)
'	next
'	rs2.update
'	rs1.movenext
'	wend
'	rs1.close	
'	rs2.close
'
''************************ End EntryDetails ***************************************
'
'con.execute("delete from mainentry where refno="&rs("refno")&"")
'
rs.movenext
wend
end if
%>
