<!-- #include file="connection.asp" -->
<table width="75%" border="0" cellspacing="0" cellpadding="0" ID="Table1">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
  </table>

<%
from=request("from")
confirm=request("confirm")
message=request("message")
updatedby=request("uname")

if (message <>"" and ucase(confirm) = "Y" ) then 

set rs=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
stmt="select smsno,agentsID from agents where smsno is not null"
'stmt="select left(phoneno,10) phoneno,smsno,agentsID from agents where phoneno is not null"


 rs.open stmt,con,2,3
 if not rs.eof then
 while not rs.eof 
 cellno=rs("smsno")
 'cellno=rs("phoneno")
 agentID=rs("agentsID")
 stmt2="select * from smsqueue where 1=2"
 rs2.open stmt2,con,2,3
			  
			if rs2.eof then
			rs2.addnew
			rs2.fields("cellno")=cellno
			rs2.fields("refno")=0
			rs2.fields("agentID")=agentID
			rs2.fields("paxname")="BULK"
			rs2.fields("Message")=message
			rs2.fields("sentby")=updatedby
			rs2.fields("sentdate")=now()
			rs2.update
			rs2.Close
			Response.Write("<BR>SMS Sent at "& cellno)
			end if
rs.MoveNext
wend
 else
 Response.Write("SMS Number not available for SMS Update.")
 end if
 rs.Close
 
  else
 
%>
<form name=sendsms action=sendsmstoAll.asp method=post>
<input type=hidden name=uname value="<%= request("uname") %>" ID="Text3">
<TABLE align=center WIDTH="600" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<TR>
		<TD colspan=3> <span class="TableCaption">SMS Updates For All Agents</span></TD>
		
	</TR>
	<TR>
		
      <TD colspan=3>&nbsp; </TD>
	</TR>
	
	<TR>
		<TD><span class="TableDataFont">Message</span></TD>
		<TD>:</TD>
		<TD>
        <textarea name="message" cols="40" id="Textarea1" maxlength="160" rows="4"></textarea>
      </TD>
	</TR>
	
	<TR>
		<TD><span class="TableDataFont">Confirm</span></TD>
		<TD>:</TD>
		<TD><input type=text size=2 maxlength=1 name=confirm ID="Text2"></span></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD></TD>
		<TD><input value="Send SMS To All" type=submit ID="Submit1" NAME="Submit1"></TD>
	</TR>
</TABLE>

</form>
<% end if%>
<table width="75%" border="0" cellspacing="0" cellpadding="0" ID="Table2">

<tr>
                <td><!-- #include file="adminBottom.asp" --></td>
    </tr>
  
</table>


