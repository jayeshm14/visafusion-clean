<!-- #include file="connection.asp" -->
<table width="75%" border="0" cellspacing="0" cellpadding="0" ID="Table1">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
  </table>

<%
cellno=request("sendto")
DisplayNameGSM=request("from")
DisplayNameCDMA= 919818720698
confirm=request("confirm")
message=request("message")
updatedby=request("uname")



if (message <>"" and cellno <>"") then 

'SMSUrl="http://sms.spectranet.com/sms3/cgi-bin/bulksms.cgi?username=udaanind&pwd=india123&to="&cellno&"&msg="&message&"&sendas="&DisplayName
SMSUrl="http://api.messaging4u.com/india/SendingSMS.aspx?username=udaanindia&pwd=rajan1604&to="&cellno&"&msg="&message&"&gsmsenderid="&DisplayNameGSM&"&cdmasenderid="&DisplayNameCDMA
'response.write(SMSUrl)
Response.Write("<BR> Connecting...  ")
 Set oHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
 oHTTP.Open "GET",SMSUrl , false
 oHTTP.Send
 responsestr=oHTTP.ResponseText
 Response.Write("SMS Sent at "&cellno &" SMS Status: "&responsestr)
 
 

'set rs2=server.createobject("adodb.recordset")

' stmt2="select * from smshistory where 1=2"
' rs2.open stmt2,con,2,3
	  
'if rs2.eof then
'rs2.addnew
			
'rs2.fields("cellno")=cellno
'rs2.fields("refno")=0
'rs2.fields("paxname")="Manual"
'rs2.fields("agentID")=0
'rs2.fields("Status")=responsestr
'rs2.fields("Message")=message
'rs2.fields("sentby")=sentby
'rs2.fields("sentdate")=now()
'rs2.update
'rs2.Close
'Response.Write("<BR>SMS Sent at "& cellno)
'			end if

 
 End if
 
%>
<form name=sendsms action=SendSMSManually.asp method=post>
<input type=hidden name=uname value="<%= request("uname") %>" ID="Text3">
<TABLE align=center WIDTH="600" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<TR>
		<TD colspan=3> <span class="TableCaption">Send SMS To Users</span></TD>
		
	</TR>
	<TR>
		<TD colspan=3>&nbsp;</TD>
	</TR>
	<TR>
		<TD><span class="TableDataFont">From</span></TD>
		<TD>:</TD>
		<TD><input type=text size=30 maxlength=50 name=from ID="Text1"></span></TD>
	</TR>
	<TR>
		<TD><span class="TableDataFont">Send To</span></TD>
		<TD>:</TD>
		<TD><input type=text size=30 name=sendto ID="Text4"></span></TD>
	</TR>
	<TR>
		<TD><span class="TableDataFont">Message</span></TD>
		<TD>:</TD>
		<TD>
<script language="javascript" type="text/javascript">
<!--
function imposeMaxLength(Object, MaxLen)
{
  return (Object.value.length <= MaxLen);
}
-->
</script>

<textarea name="message" cols=40 rows=10 ID "Textarea1" onkeypress="return imposeMaxLength(this, 158);" ></textarea> 
		
	</TR>
	
	<TR>
		<TD><span class="TableDataFont">&nbsp;</span></TD>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD></TD>
		<TD></TD>
		<TD><input value="Send SMS" type=submit ID="Submit1" NAME="Submit1"></TD>
	</TR>
</TABLE>

</form>

<table width="75%" border="0" cellspacing="0" cellpadding="0" ID="Table2">

<tr>
                <td><!-- #include file="adminBottom.asp" --></td>
    </tr>
  
</table>


