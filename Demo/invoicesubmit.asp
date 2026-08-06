<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td><!-- #include file="topAdmin.asp"-->
    </td>
  </tr>
  <tr>
    <td align="center">
    <%
todaydate=Day(Now())&"/" &Month(Now())&"/"&Year(Now())
todaydate=UsrToSysDate(todaydate)

application.lock

refno=request("refno")
paxname=request("paxname")
agent=request("agent")
invno=request("invoiceno")
invoicedate=request("invoicedate")

cabfee=request("cabfee")
courier=request("courier")
attest=request("attest")
attestremark=request("attestremark")
poe=request("poe")
poeremark=trim(request("poeremark"))
misc=request("misc")
miscremark=trim(request("miscremark"))
remark=TRIM(request("remark"))
hotelfee=request("hotelfee")
ivalue=request("i")
invtype=request("invtype")

'if invtype="b" then

set invoiceno=server.createobject("adodb.recordset")
set invoicerem=server.createobject("adodb.recordset")
stmt="update invoice set invoicedate='"&invoicedate&"'"

if not(cabfee="" or isNull(cabfee))  then
stmt=stmt+" ,cabfee="&cabfee

end if
if not (hotelfee="" or isNull(hotelfee)) then
stmt=stmt+" ,hotelfee="&hotelfee
end if

if not(courier="" or isNull(courier)) then
stmt=stmt+" ,courierfee="&courier
else
courier=0
end if

if not(attest="" or isNull(attest)) then
stmt=stmt+" ,attestfee="&attest
else
attest=0
end if

if not(poe="" or isNull(poe)) then
stmt=stmt+" ,poe="&poe
else
poe=0
end if


if not(misc="" or isNull(misc)) then
stmt=stmt+" ,misc="&misc
else
misc=0
end if

stmt=stmt+" ,attestremark='"&attestremark&"'"
stmt=stmt+" ,poeremark='"&poeremark&"'"
stmt=stmt+" ,miscremark='"&miscremark&"'"
stmt=stmt+" ,remark='"&remark&"'"

stmt=stmt+" where refno="&refno&" and invtype ='B'"

con.execute stmt
gtotal=0

     set invdtl=server.createobject("adodb.recordset")

if ivalue=1  then
   
	paxID=request("paxid")
	visafee=request("visafee")
	VFSTTCharges = request("VFSTTCharges")
	dd=request("dd")
	handling=cdbl(request("handling"))
	countryid=request("country")
	stmt =" select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid&" and invtype='B'"
        invdtl.open stmt, con
        if invdtl.eof then
	  stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,VFSTTCharges,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","&VFSTTCharges &","& handling &","&dd&",'B')"
	  con.execute stmt
	else
	  stmt =" update invoicedetail set visafee ="&visafee &", VFSTTCharges = "&VFSTTCharges&", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid&" and invtype='B'"
          con.execute stmt
        end if  
      '---- grand toal
gtotal= visafee+VFSTTCharges+handling +dd
'------
 invdtl.close	
else
 
  for i=1 to ivalue
	paxID=request("paxid")(i)
	
	visafee=request("visafee")(i)
	VFSTTCharges=request("VFSTTCharges")(i)
	dd=request("dd")(i)
	handling=request("handling")(i)
	countryid=request("country")(i)

	stmt =" select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid&" and invtype='B'"
        invdtl.open stmt, con
        if invdtl.eof then
          stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,VFSTTCharges,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","&VFSTTCharges &","& handling &","&dd&",'B')"
	  con.execute stmt
	else  
	  stmt =" update invoicedetail set visafee ="&visafee &", VFSTTCharges ="&VFSTTCharges &", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid&" and invtype='B'"
          con.execute stmt
        end if  
      
'---- grand toal
gtotal= gtotal+ visafee+VFSTTCharges+handling +dd
'------
    invdtl.close    
   next
    
end if

balance=0
gtotal= gtotal+ hotelfee+cabfee+courier+poe+misc+attest

'set rbalance= server.createobject("adodb.recordset")
'rbalance.open "select * from ledger where refno=" & refno &" and reftype='B'",con

'if not rbalance.eof then
' pbal=rbalance("balance")
' pdebit =rbalance("debit")

' balance=pbal-(gtotal-pdebit)
' rbalance.close
'else
' set mbalance = server.createobject("adodb.recordset")
' mbalance.open "select * from masterbalance where agentid=" & agent,con
' if not mbalance.eof then
'  masbalance =mbalance("masterbalance")
' else
'  stmt = "insert into masterbalance(agentid,masterbalance) values ("&agent&",0) "
'  con.execute stmt
'  masbalanc=0
' end if
' stmt = "insert into ledger(agentid,refno,debit,balance,entrydateTime,reftype,paxname,transactiontype) values ("&agent&","&refno&","&gtotal&","&masbalance-gtotal&",'"&todaydate&"','B','"&paxname&"','Visa processing') "
' con.execute stmt
' balance =masbalance-gtotal
'end if
gtotal = request.form("grandtotal")
con.execute "update invoice set grandtotal =" & gtotal &",invoicedate='"&invoicedate&"' where refno =" & refno &" and invtype='B'"
'con.execute "update ledger set debit = "& gtotal & ",balance=" & balance & ", entrydatetime='"&todaydate&"'  where refno =" & refno & " and reftype='B'"
'con.execute "update masterbalance set masterbalance=" & balance & "  where agentid =" & agent

'set rsmain = server.createobject("adodb.recordset")
'stmt="select * from changesbill where  refno="&refno 
'rsmain.open stmt,con,2,3
'rsmain.AddNew
'rsmain.fields("refno")=refno
'rsmain.fields("Description")="INVOICE"
'rsmain.update
'rsmain.close

application.unlock

'response.write "<span class='WebSite'>your bill has been saved</span>"

%>



<input type="submit" value="back">
<span class="WebSite"><a Href="listBill.asp?cmd=<%=request("cmd1") %>">Back</span></a>


    
    </td>
  </tr>
</table>
</body>
</html>




