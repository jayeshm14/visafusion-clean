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

refno=request("refno")
paxname=request("paxname")
agent=request("agent")
invno=request("invoiceno")
response.write invno
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

set invoiceno=server.createobject("adodb.recordset")
'set invoicerem=server.createobject("adodb.recordset")

invoiceno.open "select * from invoice where refno="&refno&" and invtype='C'", con
if invoiceno.eof then
  stmt="insert into invoice(refno,invoiceno,invtype) values("&refno&","&invno&",'C')"
  con.execute stmt
end if
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

stmt=stmt+" where refno="&refno&" and invtype ='C'"

con.execute stmt
gtotal=0

     set invdtl=server.createobject("adodb.recordset")

if ivalue=1  then
   
	paxID=request("paxid")
	visafee=request("visafee")
	dd=request("dd")
	handling=cdbl(request("handling"))
	countryid=request("country")
	stmt =" select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid &" and invtype='C'"

        invdtl.open stmt, con
    if invdtl.eof then
	  stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","& handling &","&dd&",'C')"
	  con.execute stmt
	else
	  stmt =" update invoicedetail set visafee ="&visafee &", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid&" and invtype='C'"
          con.execute stmt
    end if  
      '---- grand toal
gtotal= visafee+handling +dd

'------
 invdtl.close	

else
 
  for i=1 to ivalue
	paxID=request("paxid")(i)
	
	visafee=request("visafee")(i)
	dd=request("dd")(i)
	handling=request("handling")(i)
	countryid=request("country")(i)

	stmt =" select 1 from invoicedetail where invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid& " and invtype ='C'"
        invdtl.open stmt, con
    if invdtl.eof then
          stmt="insert into invoicedetail (invoiceno,paxid,countryid,visafee,handlingfee,ddcharges,invtype)"
	  stmt=stmt+" values("&invno&","&paxid&","&countryid&","&visafee &","& handling &","&dd&", 'C')"
	  
	  con.execute stmt
	else  
	   stmt =" update invoicedetail set visafee ="&visafee &", handlingfee="& handling &",ddcharges="&dd&" where  invoiceno ="&invno &" and paxid ="&paxid&" and countryid ="&countryid &" and invtype ='C'"
	 
          con.execute stmt
    end if  
      
'---- grand toal
gtotal= gtotal+ visafee+handling +dd

'------
    invdtl.close    
   next
    
end if

balance=0
gtotal= gtotal+ hotelfee+cabfee+courier+poe+misc+attest

set rbalance= server.createobject("adodb.recordset")
rbalance.open "select * from ledger where refno=" & refno & " and reftype='C'",con

if not rbalance.eof then
 pbal=rbalance("balance")
 pcredit =rbalance("credit")
if (pcredit="" or isNull(pcredit))  then
pcredit=0
end if

 balance=pbal+(gtotal-pcredit)

 rbalance.close
else
 set mbalance = server.createobject("adodb.recordset")
 mbalance.open "select * from masterbalance where agentid=" & agent,con
 if not mbalance.eof then
  masbalance =mbalance("masterbalance")
 else
  stmt = "insert into masterbalance(agentid,masterbalance) values ("&agent&",0) "
  con.execute stmt
  masbalanc=0
 end if
 stmt = "insert into ledger(agentid,refno,credit,balance,entrydateTime,reftype,paxname,transactiontype) values ("&agent&","&refno&","&gtotal&","&masbalance-gtotal&",'"&todaydate&"','C','"&paxname&"','Visa processing') "
 con.execute stmt
 balance =masbalance-gtotal
end if

con.execute "update invoice set grandtotal =" & gtotal &",invoicedate='"&formatdatetime(now,2)&"' where refno =" & refno &" and invtype='C'"
sqlup="update ledger set credit = "& gtotal & ",balance=" & balance & ",invno="&invno&" where refno =" & refno &" and reftype='C'"
con.execute sqlup

con.execute "update masterbalance set masterbalance=" & balance & "  where agentid =" & agent


response.write "<span class='WebSite'>Credit Entry Updated</span>"



%>




<span class="WebSite"><a Href="listBill.asp?cmd=<%=request("cmd1") %>">Back</span></a>


    
    </td>
  </tr>
</table>
</body>
</html>




