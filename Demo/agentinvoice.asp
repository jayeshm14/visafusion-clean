<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->


<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr><tr>
              
               <%
             agent=cint(request("agent"))
             
             cmd=request("cmd")
             sdate=UsrToSysDate(request("sc_sdate"))
	     edate=UsrToSysDate(request("sc_edate"))
             %> 
          
     
    <td> 
    <a href="agentinvoice.asp?agent=<%=cint(request("agent"))%>&cmd=today">Today's</a>
     
<a href="agentinvoice.asp?agent=<%=cint(request("agent"))%>&cmd=all">Show All</a></div>
    <form action="agentinvoice.asp" method="post">
    <input type="hidden" name="agent" value="<%= agent %>" > 
    <font size="2" face="arial">
                        <b>Dates:</b> </font> 
                        <input type="text" name="sc_sdate" value="<%=request.form("sc_sdate") %>" size="10" >
                        -<input type="text" name="sc_edate" value="<%=request.form("sc_edate") %>" size="10" >
                        </font> 
                        </font>  
                        <input type="submit" value="Go"> </form>
                      
    
    
    </td>
    </tr>
              
         
    <tr> <td>
               
<%

today=date()

set rs=server.createobject("adodb.recordset")

if cmd="all" or isnull(cmd) or cmd="" then  
stmt="select * from ledger where  agentid="&agent 
end if
if (request.form("sc_sdate")="" or IsEmpty(request.form("sc_sdate"))) then
edate=UsrToSysDate(request.form("sc_edate"))
edate=cdate(edate)
edate=edate+1
stmt="select * from ledger where  agentid="&agent&" and entrydatetime <#"&edate&"#"
end if

if request.form("sc_edate")="" or IsEmpty(request.form("sc_edate")) then
sdate=UsrToSysDate(request.form("sc_sdate"))
sdate=cdate(sdate)
stmt="select * from ledger where  agentid="&agent&" and entrydatetime >#"&sdate&"#"
end if

if (request.form("sc_sdate")<>""  and  request.form("sc_edate")<>"") then
sdate=UsrToSysDate(request.form("sc_sdate"))
sdate=cdate(sdate)
edate=UsrToSysDate(request.form("sc_edate"))
edate=cdate(edate)
edate=edate+1
stmt="select * from ledger where  agentid="&agent&"and entrydatetime >#"&sdate&"# and entrydatetime <#"&edate&"#"
end if

if cmd="today" then
stmt="select * from ledger where  agentid="&agent & " and entrydatetime=#"&today&"#"
end if

'response.write "<br>" & stmt
rs.open stmt, con,2,3
if rs.eof then 
response.write "NO TRANSACTION FOR THIS AGENT"  
else
response.write "DETAILED INVOICE INFOMATION REGARDING "
call writeiddescription("agents",agent)
response.write "<table border='1' ALIGN='CENTER'><tr><TD><font size=2 color=#0000CC><b>DATE</B></FONT></TD><TD><font size=2 color=#0000CC><b>BANK</B></FONT></TD><TD><font size=2 color=#0000CC><b>TRANSACTION DETAILS</B></FONT></TD><TD><font size=2 color=#0000CC><b>REF NO.</B></FONT></TD><TD><font size=2 color=#0000CC><b>PAXNAME</B></FONT></TD><TD><font size=2 color=#0000CC><b>CREDIT</B></FONT></TD><TD><font size=2 color=#0000CC><b>DEBIT</B></FONT></TD><TD><font size=2 color=#0000CC><b>BALANCE</B></FONT></TD></TR>"
while not rs.eof
	  entrydate=SysToUsrDate(rs("entrydatetime"))
	  bankID=rs("bank")
	  transtype=rs("transactiontype")
	  refno=rs("refno")
	  name=rs("paxname")
	  credit=rs("credit")
	  debit=rs("debit")
	  balance=rs("balance")  
	
	
	response.write "<TR><TD>"&entrydate& "</TD><TD>"
	if bankID <> "" then
	call writeiddescription("bank",bankID)
	else
	response.write "&nbsp;"
	end if
	response.write "</TD><TD>"&UCASE(transtype)& "</TD><TD>"
	if refno <> "" then
	response.write refno
	else
	response.write "&nbsp;"
	end if
	response.write "</TD><TD>"
	 if name <> "" then
	 response.write name 
	 else
	 response.write "&nbsp;"
	end if
	response.write "</TD><TD>"&credit&"</TD><TD>"&debit&"</TD><TD>"&balance&"</TD></TR>"
rs.movenext
wend
response.write "</table>"
end if
'response.write "<table border='1'><tr><TD>DATE</TD><TD>CREDIT</TD><TD>PREVIOUS BALANCE</TD><TD>PRESENT BALANCE</TD></TR>"
'response.write "<TR><TD>"&date()&"</td><td>"&credit&"</td><td>"&prev_balance&"</td><td>"&masterbalance1&"</td></tR></TABLE>"
'response.write "<p align=center><a href=collection.asp> Back to collection page</a><br>"
'response.write "<a href=collection.asp>collection page</a><br></p>"


%> </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>


