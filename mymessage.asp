<%if request("msgid")="1" then
response.write "<table width='100%'><tr><td align='center'><font size=2 color=#006600><b>MESSAGE DELETED SUCCESSFULLY.</b></font></td></tr></table>"
end if
%>

<table BORDER=0 vALIGN=right  width=90% align="center">
  <tr BGCOLOR="#F0F0FF" > 
    <td align="center" colspan=6><span class="TableCaption"> INBOX</span> </td>
  </tr>
  <tr BGCOLOR="#FFF3CA"> 
    <Th><span class="ColumnHeaderFont">&nbsp;</span></th>
    <Th align="left"> 
      <div align="center"><b><font face="Verdana" size="2" color="#0000FF"><span class="ColumnHeaderFont">From</span></font></b></div>
    </th>
    <Th align="left"> 
      <div align="center"><b><font face="Verdana" size="2" color="#0000FF"><span class="ColumnHeaderFont">Subject</span></font></b></div>
    </th>
    <Th align="left"> 
      <div align="center"><b><font face="Verdana" size="2" color="#0000FF"><span class="ColumnHeaderFont">Sent 
        Date</span></font></b></div>
    </th>
    <Th align="left"> 
      <div align="center"><b><font face="Verdana" size="2" color="#0000FF"><span class="ColumnHeaderFont">Task 
        Date</span></font></b></div>
    </th>
    <Th align="left"> 
      <div align="center"><b><font face="Verdana" size="2" color="#0000FF"><span class="ColumnHeaderFont">Delete</span></font></b></div>
    </th>
  </tr>
  <%

set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
rs.open "select* from scheduler where messageto='"&request("uname")&"' ORDER BY SENTDATE DESC",con,2,3
IF rs.eof then
response.Write "<TR><TD COLSPAN=6 ALIGN=CENTER><font size=2 color=#006600><B> NO NEW MESSAGE FOUND</B></FONT></TD></TR>"
End if
while not rs.eof
response.write"<tr bgcolor='#F0F0FF'><td width='5%' align='left'>" 
if rs("messageread")="n" then
response.write ("<img src=images/new.gif>")
else
response.write ("<img src=images/old.gif> "&"</td>")
end if
response.write"<td  width='15%' align='left'>"
response.write "<a href=readmessage.asp?id="&rs("messageid")&">"&ucase(rs("messagefrom"))&"</a>"
response.write"</td><td width='35%' align='left'>"
if rs("subject")= "" then
response.write "<a href=readmessage.asp?id="&rs("messageid")&">[None]</a>"
else
response.write "<a href=readmessage.asp?id="&rs("messageid")&">"& left(ucase(rs("subject")),40)&"</a>"
end if
response.write"</td><td  width='20%' align='left'><span class='TableDataFont'>"
response.write rs("sentdate")
response.write"</span></td><td width='10%' align='left'><span class='TableDataFont'>"
response.write rs("date")
response.write"</span></td><td width='10%' align='left'>"
response.write"<a href=deletemessage.asp?id="&rs("messageid")&">"&"DELETE</a>"
rs.movenext
wend
rs.close
%> 
</table>
<TABLE WIDTH="300" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
</TABLE>

</body></html>