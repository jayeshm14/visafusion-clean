<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<link rel="stylesheet" href="styles.css" type="text/css">
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/home2.jpg','#982339540000');MM_preloadImages('images/news2.jpg','#982339618320');MM_preloadImages('images/services2.jpg','#982339651880');MM_preloadImages('images/about2.jpg','#982339709880');MM_preloadImages('images/contact2.jpg','#982339751960');MM_preloadImages('images/go2.jpg','#982340617580')">
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              
               <%
             agent=cint(request("agent"))
            
             today= date()
             cmd=request("cmd")
             sdate=UsrToSysDate(request("sc_sdate"))
	     edate=UsrToSysDate(request("sc_edate"))
             %> 
              <tr><td>&nbsp;</td></tr>
          <tr><td align="center">
    <form action="agentStatement.asp" method="post">
	<input type="hidden" name="cmd" value="frm">
   <span class="WSRightBold"> STATEMENT FOR AGENT:</span>
    		<select size=1  name="agent" >
                     <%
                     Call LoadListBox("agents",agent)
                     %>
                     
                   	</select>
                    
                     <span class="WSRightBold">DATES:</span>
                        <input type="text" name="sc_sdate" value="<%=request("sc_sdate")%>" size="10" >
                        - <input type="text" name="sc_edate" value="<%=request("sc_edate")%>" size="10" >
                        </font> 
                        </font>  
                        <input type="submit" class="ud" value="Go" > </form>
                      
   
    
    </td></tr>
    <tr>
    <td align="center"> <span class="WSRightBold">
    <a href="agentStatement.asp?agent=<%=cint(request("agent"))%>&cmd=today">Today's</a>&nbsp;&nbsp;&nbsp;
     
<a href="agentStatement.asp?agent=<%=cint(request("agent"))%>&cmd=all">Show All</a>
   </span> </td></tr>
              
         
    <tr> <td>
               
<%



set rs=server.createobject("adodb.recordset")
'set rsinv=server.createobject("adodb.recordset")
'set rscr=server.createobject("adodb.recordset")

if cmd="frm" and (request.form("sc_sdate")="" or IsEmpty(request.form("sc_sdate"))) then
edate=UsrToSysDate(request.form("sc_edate"))
'edate=cdate(edate)
'edate=edate+1
stmt="select * from ledger where  agentid="&agent&" and day(entrydatetime)="&day(edate)&" and month(entrydatetime)="&month(edate)&" and year(entrydatetime)="&year(edate) 

end if


if cmd="frm" and (request.form("sc_edate")="" or IsEmpty(request.form("sc_edate"))) then
sdate=UsrToSysDate(request.form("sc_sdate"))
'sdate=cdate(sdate)
stmt="select * from ledger where  agentid="&agent& " and day(entrydatetime)="&day(sdate)&" and month(entrydatetime)="&month(sdate)&" and year(entrydatetime)="&year(sdate) 
end if

if cmd="frm" and (request.form("sc_sdate")<>""  and  request.form("sc_edate")<>"") then
sdate=UsrToSysDate(request.form("sc_sdate"))

sdate=cdate(sdate)
edate=UsrToSysDate(request.form("sc_edate"))
edate=cdate(edate)
edate=edate+1
stmt="select * from ledger where  agentid="&agent&" and entrydatetime >'"&sdate&"' and entrydatetime <'"&edate&"'"

end if

if cmd="frm" and (request.form("sc_sdate")=""  and  request.form("sc_edate")="") then
sdate=UsrToSysDate(request.form("sc_sdate"))

sdate=cdate(sdate)
edate=UsrToSysDate(request.form("sc_edate"))
edate=cdate(edate)
edate=edate+1
stmt="select * from ledger where  agentid="&agent & " and  month(entrydatetime)="&month(date())&" and year(entrydatetime)="&year(date())

end if
if cmd="today" then
stmt="select * from ledger where  agentid="&agent & " and day(entrydatetime)="&day(date())&" and month(entrydatetime)="&month(date())&" and year(entrydatetime)="&year(date())

end if
if cmd="all" or isnull(cmd) or cmd="" then  
stmt="select * from ledger where  agentid="&agent & " and  month(entrydatetime)="&month(date())&" and year(entrydatetime)="&year(date())

end if
'response.write stmt
rs.open stmt, con,2,3
if rs.eof then 
response.write "<table border='1' ALIGN='CENTER'><tr><TD><span class='WSRightBold'>DATE</span></TD><TD><span class='WSRightBold'>BANK</span></TD><TD><span class='WSRightBold'>TRANSACTION DETAILS</span></TD><TD><span class='WSRightBold'>REF NO.</span></TD><TD><span class='WSRightBold'>PAXNAME</span></TD><TD><span class='WSRightBold'>DEBIT</span></TD><TD><span class='WSRightBold'>CREDIT</span></TD><TD><span class='WSRightBold'>BALANCE</span></TD></TR>"

response.write "<tr><TD colspan=8 ALIGN='CENTER'><font size=2 color=#006600>NO DATA FOUND</font></td></tr>"  
else
%>
    <table border="1" ALIGN="CENTER" width="748">
      <tr> 
        <TD width="39"> <span class="WSRightBold"><font face="Arial, Helvetica, sans-serif" size="2">DATE</font></span></TD>
        <TD width="43"><span class="WSRightBold"><font size="2" face="Arial, Helvetica, sans-serif">BANK</font></span></TD>
        <TD width="123"><span class="WSRightBold"><font face="Arial, Helvetica, sans-serif" size="2">TRANSACTION 
          DETAILS</font></span></TD>
        <TD width="51"><span class="WSRightBold"><font size="2" face="Arial, Helvetica, sans-serif">REF 
          NO.</font></span></TD>
        <TD width="104"><span class="WSRightBold"><font face="Arial, Helvetica, sans-serif" size="2">PAXNAME</font></span></TD>
        <TD width="64"><font face="Arial, Helvetica, sans-serif" size="2"><b>VCH.TYPE</b></font></TD>
        <TD width="62"><font face="Arial, Helvetica, sans-serif" size="2"><b>VCH.NO.</b></font></TD>
        <TD width="48"><span class="WSRightBold"><font face="Arial, Helvetica, sans-serif" size="2">DEBIT</font></span></TD>
        <TD width="59"><span class="WSRightBold"><font face="Arial, Helvetica, sans-serif" size="2">CREDIT</font></span></TD>
        <TD width="91"><span class="WSRightBold"><font size="2" face="Arial, Helvetica, sans-serif">BALANCE</font></span></TD>
      </TR>
      <%
while not rs.eof
	  entrydate=SysToUsrDate(rs("entrydatetime"))
	  bankID=rs("bank")
	  transtype=rs("transactiontype")
	  refno=rs("refno")
	  name=rs("paxname")
	  credit=rs("credit")
	  debit=rs("debit")
	  balance=rs("balance")
	  if balance<0 then
	  balance1=-(rs("balance"))
	  else
	  balance1=rs("balance")
	  end if
'if refno<>"" then
'sqlinv="select invoiceno from invoice where refno="&refno&" and invtype='B'"
'rsinv.open sqlinv, con,2,3

'sqlcr="select invoiceno from invoice where refno="&refno&" and invtype='C'"
'rscr.open sqlcr, con,2,3	
'end if
	%> 
      <TR> 
        <TD width="39"><%=entrydate%></TD>
        <TD width="43"> <font face="Arial, Helvetica, sans-serif" size="2"><%if bankID <> "" then
	call writeiddescription("bank",bankID)
	else
	response.write "&nbsp;"
	end if %> </font></TD>
        <TD width="123"><font face="Arial, Helvetica, sans-serif" size="2"><%=UCASE(transtype)%> 
          </font></TD>
        <TD width="51"> <font face="Arial, Helvetica, sans-serif" size="2"><%	if refno <> "" then
	response.write refno
	else
	response.write "&nbsp;"
	end if %> </font></TD>
        <TD width="104"> <font size="2" face="Arial, Helvetica, sans-serif"><%	 if name <> "" then
	 response.write name 
	 else
	 response.write "&nbsp;"
	end if %> </font></TD>
        <TD width="64"><font size="2" face="Arial, Helvetica, sans-serif"><%	 if rs("reftype") = "B" then
	 response.write("SALES") 
	 elseif rs("reftype")="C" then
	 response.write ("CR.NOTE")
     elseif rs("reftype")="P" then
	 response.write ("RECEIPT")
	end if %></font></TD>
        <TD width="62"><font size="2" face="Arial, Helvetica, sans-serif"><%	 if rs("reftype") = "B" then
	 response.write("inv.no-") 
	 elseif rs("reftype")="C" then
	 response.write ("cn.no-")
     elseif rs("reftype")="P" then
	 response.write ("rec.no.-")
	end if
Response.write(rs("invno")) %> </font></TD>
        <TD width="48">
<% if debit<>"" then
response.write debit
else 
response.write "&nbsp;"
end if %> 
          <div align="right"></div>
        </TD>
        <TD width="59"> 
<% if credit<>"" then
response.write credit
else
response.write "&nbsp;"
end if %> 
          <div align="right"></div>
        </TD>
        <TD align='right' width="91"><%=balance1 %> <%	if balance>0 then
	%> <font size="2" face="Arial, Helvetica, sans-serif">(CR)</font> <%else%> 
          <font face="Arial, Helvetica, sans-serif" size="2">(DR)</font> <%
	end if
	%> </TD>
      </TR>
      <%
'if refno<>"" then
'rsinv.close
'rscr.close
'end if

rs.movenext
wend %> 
    </table>
<%
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
   <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
