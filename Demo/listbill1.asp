<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
todaydate=Day(Now())&"/" &Month(Now())&"/"&Year(Now())
todaydate=UsrToSysDate(todaydate)

'response.write todaydate

message=request.form("message")
paxname=replace(request.form("paxname"),"'","`")

if message="bill formed" then

refno=request("refno")
agent=request("agent")

application.lock

set invoiceno=server.createobject("adodb.recordset")
invoiceno.open "select invoiceno from invoice where invtype='B'order by invoiceno desc",con
if invoiceno.eof then
invno=1
else
invno=invoiceno("invoiceno")
invno=invno+1
end if
invoiceno.close
set invoiceno=nothing
'invno=request("invoiceno")

'invoicedate=date()
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

set rs=server.createobject("adodb.recordset")
rs.open "select * from invoice where refno="&refno&" and invtype ='B'",con
if rs.eof then
  stmt="insert into invoice(refno,invoiceno,invtype) values("&refno&","&invno&",'B')"
  con.execute stmt
end if
rs.close
set rs=nothing

stmt="update invoice set invoicedate='"&formatdatetime(now,2)&"'"

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
if visafee="" then
visafee=0
end if
	VFSTTCharges=request("VFSTTCharges")
if VFSTTCharges="" then
VFSTTCharges=0
end if
	dd=request("dd")
if dd="" then
dd=0
end if
	handling=request("handling")
if handling="" then
handling=0
end if
	countryid=request("country")
	stmt ="select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid
        invdtl.open stmt, con
        if invdtl.eof then
	  stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,VFSTTCharges,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","&VFSTTCharges &","& handling &","&dd&",'B')"

	  con.execute stmt
	else
	  stmt =" update invoicedetail set visafee ="&visafee &", VFSTTCharges ="&VFSTTCharges &", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid
          con.execute stmt
        end if  
      '---- grand toal
gtotal= cdbl(visafee)+cdbl(VFSTTCharges)+cdbl(handling)+cdbl(dd)

'------
 invdtl.close	
else
 
  for i=1 to ivalue
	paxID=request("paxid")(i)
	
	visafee=request("visafee")(i)
if visafee="" then
visafee=0
end if
	VFSTTCharges=request("VFSTTCharges")(i)
if VFSTTCharges="" then
VFSTTCharges=0
end if
	dd=request("dd")(i)
if dd="" then
dd=0
end if
	handling=request("handling")(i)
if handling="" then
handling=0
end if
	countryid=request("country")(i)

	stmt =" select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid
        invdtl.open stmt, con
        if invdtl.eof then
          stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,VFSTTCharges,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","&VFSTTCharges&","& handling &","&dd&",'B')"

	  con.execute stmt
	else  
	  stmt =" update invoicedetail set visafee ="&visafee &", VFSTTCharges ="&VFSTTCharges &", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid
          con.execute stmt
        end if  
      
'---- grand toal
gtotal= cdbl(gtotal)+ cdbl(visafee)+cdbl(VFSTTCharges)+cdbl(handling)+cdbl(dd)
'------
    invdtl.close    
   next
    
end if

'balance=0
gtotal= cdbl(gtotal)+cdbl(hotelfee)+cdbl(cabfee)+cdbl(courier)+cdbl(poe)+cdbl(misc)+cdbl(attest)

'set rbalance= server.createobject("adodb.recordset")
'rbalance.open "select * from ledger where refno=" & refno&" and reftype='B'",con

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
grandtotal = request.form("GrandTotal")
con.execute "update invoice set grandtotal =" & gtotal &",invoicedate='"&formatdatetime(now,2)&"' where refno =" & refno
'con.execute "update ledger set debit = "& gtotal & ",balance=" & balance & ",entrydateTime='"&todaydate&"',invno='"&invno&"' where refno =" & refno & " and reftype='B'"
'con.execute "update masterbalance set masterbalance=" & balance & "  where agentid =" & agent
cmd="all"

pan=1

set rsmain = server.createobject("adodb.recordset")
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con,2,3
rsmain.fields("bill")="Y"
rsmain.update
rsmain.close

'stmt="select * from changesbill where  refno="&refno 
'rsmain.open stmt,con,2,3
'rsmain.AddNew
'rsmain.fields("refno")=refno
'rsmain.fields("Description")="INVOICE"
'rsmain.update
'rsmain.close

end if
application.unlock

response.redirect "printask.asp?refno="&refno
%>
