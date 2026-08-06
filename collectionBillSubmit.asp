<!-- #include file="connection.asp" -->
<% response.buffer=true %>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
          
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td valign="top">
<%

'refno=cint(request("refno"))
ivalue=cint(request("ivalue"))
pname=request("pname")
agentID=request("agent")
mainStatusFlag="N"
totalAmount=0
set rs=server.createobject("adodb.recordset")
set rsDetails=server.createobject("adodb.recordset")
set rsHistory = server.createObject("Adodb.Recordset")

i=1
while i<= ivalue 
rs.open "select * from  paxAttestation where certificat ="&refno &" and paxID="& request("paxid"&i) &" and countryID="&request("countryinv"&i),con,2,3
if  rs.eof then
i=i+1
rs.close
else
if request("visafee"&i)<>"" then
rs("visafee")=cdbl(request("visafee"&i))
End if
if request("dd"&i)<>"" then
rs("ddcharges")=cdbl(request("dd"&i))
End if
if request("courier"&i)<>"" then
rs("couriercharges")=cdbl(request("courier"&i))
End if
if request("handling"&i)<>"" then
rs("Handlingfee")=cdbl(request("handling"&i))
End if
if request("misc"&i)<>"" then
rs("miscCharges")=cdbl(request("misc"&i))
End if
if request("total"&i)<>"" then
rs("total")=cdbl(request("total"&i))
totalAmount=totalAmount+request("total"&i)
End if 
'now updating the table Entry details
mytempstatus=cint(request("status"&i))
rs("statusid")=mytempstatus
if mytempstatus >400 and mytempstatus<500 then
mainStatusFlag="Y"
end if
		rs("category")=cint(request("categorymain"&i))
		rs("remarks")=request("remark"&i)
		if request("subdate"&i)<>"" then
		rs("subdate")=usrToSysDate(request("subdate"&i))
		End if
		if request("coldate"&i&l)<>"" then
		rs("coldate")=usrToSysDate(request("coldate"&i))
		end if
		if trim(request("sentdate"&i&l))<>""  then
		rs("sentdate")=usrToSysDate(request("sentdate"&i))
		end if
		rs("entryDateTime")=formatDateTime(Now(),0)
rs.update
rs.close

If request("status"&i)<> request("oldstatus"&i) then
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=Cint(request("paxid"&i))
				rsHistory("CountryID")=Cint(Request.Form("countryinv"&i))
				rsHistory("statusID")=cint(request("status"&i))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("remarks")=trim(request("remark"&i))
				rsHistory("updatedby")=trim(request("username"))
				rsHistory.update
				rsHistory.close
end If				
end if
i=i+1
wend

rs.open "select * from  mainentry where refno ="&refno,con,2,3

if mainStatusFlag="Y" then
rs("status")=401
Else
rs("status")=request("mainstatus")
End if
if request("sentdate")<>"" then
rs("sentdate")=(request("sentdate"))
end if
rs("internalremark")=trim(request("internalrem"))
rs("externalremark")=trim(request("externalrem"))
rs.update
rs.close()


set rsbalance=server.createobject("adodb.recordset")
		stmt="select * from masterbalance where agentID="&agentID

		rsbalance.open stmt, con,2,3
		if not rsbalance.eof then
		masterbalance=rsbalance.fields("masterbalance")
		else
		rsbalance.addnew
		rsbalance.fields("agentid")=cint(agentID)
		rsbalance.fields("masterbalance")=0
		rsbalance.update
		masterbalance=0
		end if
		
	
set rs1=server.createobject("adodb.recordset")
stmt="select * from ledger where refno="&refno&" and reftype='v'"
rs1.open stmt, con,2,3


if  rs1.eof then
			rs1.addnew
			rs1.fields("agentid")=agentid
			rs1.fields("paxname")=pname
			rs1.fields("refno")=refno
			
			if totalAmount<> "" then
			rs1.fields("debit")=totalAmount
			rs1.fields("balance")=masterbalance-totalAmount
			end if
			
			rs1.fields("reftype")="v"
			rs1.fields("transactiontype")="hotel debit"
			rs1.update
			debit=rs1.fields("debit")
			masterbalance=rsbalance.fields("masterbalance")
			
			masterbalance1=masterbalance-debit
			
			rsbalance.fields("masterbalance")=masterbalance1
			rsbalance.update
			
			rsbalance.close
			'rs1.close
else

			rs1.fields("agentid")=agentid
			rs1.fields("paxname")=pname
			rs1.fields("refno")=refno
			if totalAmount<> "" then
			rs1.fields("debit")=totalAmount
			rs1.fields("balance")=masterbalance-totalAmount
			end if
			
			rs1.fields("reftype")="v"
			rs1.fields("transactiontype")="Visa processing"
			rs1.update
			debit=rs1.fields("debit")
			
			masterbalance1=rsbalance.fields("masterbalance")-debit
			
			rsbalance.fields("masterbalance")=masterbalance1
			rsbalance.update
			
	
end if



response.write "<p align=center><font size=2 color=#0000CC face=arial>The information for the refrence number <b>"&request("refno")&" </b> has been added successfully.</P>"
response.write "<P align=center><A HREF='collection.asp'>CLICK HERE TO ADD MORE COLLECTION INFORMATIONS</A></p>"

response.clear
myurl= "collection.asp?msgID=1&pname="&request("pname")
response.redirect(myurl)                
 %>               
                </td>
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
