<%@ Language=VBScript %>
<% response.buffer=true %>
<!-- #include file="connection.asp" -->
<TABLE border='1' width='80%'><tr><td><font size=2 color=#0000CC><b> AGENT </B></FONT></td><td><font size=2 color=#0000CC><b>Expected Date</B></FONT></td><td><font size=2 color=#0000CC><b>PRESENT BALANCE</B></FONT></td><td><font size=2 color=#0000CC><b>MAIL</B></FONT></td><TR>
<%
		set rsbalance=server.createobject("adodb.recordset")
		stmt2= "select * from masterbalance  where duedate<='"&date()&"'"
		rsbalance.open stmt2, con,2,3
		if not rsbalance.eof then
		while not rsbalance.eof 
		masterbalance=rsbalance.fields("masterbalance")
		
		duedate=rsbalance.fields("duedate")
		response.write "<TR><td>"

		call writeIddescription("agents",rsbalance("agentID"))
		response.write "</td><td>"& FormatDateTime(dueDate,1)&"</td><td align='center'>"&masterbalance &"</td><td align='center'>Email</td></tr>"             
                rsbalance.movenext
		wend 
		else
		response.write "<TR><td colspan=4 align='center'> NO DATA FOUND</td></tr>"
		
		end if
%>
</table>