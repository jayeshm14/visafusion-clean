<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer=true
%>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
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
              <tr>
                <td>
<%

agent=cint(request("agent"))
bank=cint(Request.Form ("bank"))
amount=Request.Form("amount")
if trim(amount)<>"" then
amount=cdbl(amount)
else
amount=0
end if
paidas=Request.Form("paidas")
ddno=Request.Form("ddno")
if Request.Form("dddate")<>"" then
dddate=Request.Form("dddate")
end if 
remark=Request.Form("remark")

maxdate=date()
				set rs1=server.createobject("adodb.recordset")
				  stmt1="select * from masterbalance where  agentid="&agent 
				     
				  rs1.open stmt1, con,2,3
if rs1.eof then
				  rs1.addnew
				  rs1.fields("agentID")=agent
				  rs1.fields("masterBalance")="0"
				  
				  prev_balance=rs1("masterBalance")
				  

		 set rs=server.createobject("adodb.recordset")
		stmt="select * from ledger where reftype='P' order by invno desc"

		rs.open stmt, con,3,3

if not rs.eof then
recno=rs("invno")
recno=cint(recno)+1
else
recno=1
end if
		 
				  
		rs.addnew
		rs.fields("reftype")="P"	
		rs.fields("transdate")=FormatDateTime(Now(),0)
		rs.fields("agentid")=agent
		rs.fields("bank")=bank
		rs.fields("invno")=recno
		if trim(amount)<>"" then
		rs.fields("credit")=amount
		credit=rs.fields("credit")
		rs.fields("balance")=prev_balance+credit
		end if
		
		rs.fields("paidas")=paidas
		rs.fields("transactiontype")="deposit"
		
		
		rs.fields("ddno")=ddno
		rs.fields("remark")=remark
		if dddate<>"" then
		rs.fields("dddate")=dddate
		end if 

		rs.fields("ENTRYDATETIME")=FormatDateTime(Now(),0)
		
		rs.update
		masterbalance1=prev_balance+credit
		
		rs1.fields("masterbalance")=masterbalance1
		rs1.update
		
		
		
		
	
else
            rs1.fields("agentID")=agent
	    		  
				  prev_balance=rs1("masterBalance")
				  
		 
		 set rs=server.createobject("adodb.recordset")
		stmt="select * from ledger where reftype='P' order by invno desc"

		rs.open stmt, con,3,3

if not rs.eof then
recno=rs("invno")
recno=cint(recno)+1
else
recno=1
end if
			  
		rs.addnew
		rs.fields("reftype")="P"	
		rs.fields("transdate")=FormatDateTime(Now(),0)
		rs.fields("agentid")=agent
		rs.fields("bank")=bank
		rs.fields("invno")=recno
		if trim(amount)<>"" then
		rs.fields("credit")=amount
		credit=rs.fields("credit")
		rs.fields("balance")=prev_balance+credit
		end if
		
		rs.fields("paidas")=paidas
		rs.fields("transactiontype")="deposit"
		
		
		rs.fields("ddno")=ddno
		rs.fields("remark")=remark
		if dddate<>"" then
		rs.fields("dddate")=dddate
		end if 

		rs.fields("ENTRYDATETIME")=FormatDateTime(Now(),0)
		
		rs.update
		masterbalance1=prev_balance+credit
		
		rs1.fields("masterbalance")=masterbalance1
		if masterbalance1>0 then
		rs1.fields("duedate")=null
		end if
		rs1.update
		

end if

response.write " <P ALIGN=CENTER>PAYMENT REGARDING <b> "
call writeiddescription("agents",agent)
response.write "</b> HAS BEEN ADDED<BR><br>"

response.write "<table border='1'><tr><TD>DATE</TD><TD>CREDIT</TD><TD>PREVIOUS BALANCE</TD><TD>PRESENT BALANCE</TD></TR>"
response.write "<TR><TD>"&date()&"</td><td>"&credit&"</td><td>"&prev_balance&"</td><td>"&masterbalance1&"</td></tR></TABLE>"
response.write "<p align=center><a href=collection.asp> Back to collection page</a><br>"
response.write "<a href='agentStatement.asp?agent="&agent&"' > View Statement</a><br></p>"
response.clear
myurl= "paymentReceive.asp?msgID=1&pname="&request("agent")
response.redirect(myurl)
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


