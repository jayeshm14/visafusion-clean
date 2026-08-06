<%@ Language=VBScript %>
<% response.buffer=true 
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>
<!-- #include file="connection.asp" -->
<%
refno=request("refno")
categoryid=getIDForDescription("category","Attestation")

set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rsInvoice=server.createobject("adodb.recordset")
set rsHistory=server.createobject("adodb.recordset")
set rsAttest=server.createobject("adodb.recordset")
set rsc=server.createobject("adodb.recordset")

mainStatusFlag="N"

application.lock()
stmt="select * from mainentry where refno="&refno
rs.open stmt,con,2,3
rs("paxname")=request("pname")
rs("agent")=request("agentlist")
rs("refferer")=request("refname")
rs("companyname")=request("company")
rs("totalpassengers")=cint(request("totalp"))
rs("entries")=cint(request("entries"))


if trim(request("recdate"))<>"" then
rs("receivedate")=usrToSysDate(request("recdate"))
end if
if trim(request("travdate"))<>"" then
rs("traveldate")=usrToSysDate(request("travdate"))
end if

rs("entrytype")=request("entrytype")
'rs("category")=request("category")

rs("attestation")=request("attestation")
rs("poe")=request("poe")
rs("internalremark")=trim(request("internalrem"))
rs("externalremark")=trim(request("externalrem"))
rs("agentinstruction")=trim(request("instruction"))
rs("enteredby")=request("username")
rs.update
rs.close


i=1
ivalue=cint(request("ivalue"))

while i<= ivalue

rs.open "select * from  entrydetails where  paxid="& request("paxid"&i),con,2,3
if not rs.eof then
		totalcountry=cint(request.form("totalcountry"&i))
		rs("paxname")=request("pname"&i)
		rs("passportno")=request("passport"&i)
		if request("totalp"&i)<>"" then
		rs("totalpax")=cint(request("totalp"&i))
		end if
		if request("dob"&i)<>"" then
		rs("dateofbirth")=usrToSysDate(request("dob"&i))
		end if
		rs.update
		l=1


	    for l=1 to totalcountry
	 
		if request("country"&i&l)<>"" then
		

		stmtCountry="select * from  paxstatus where paxid="& request("paxid"&i)& " and countryid="& request("country"&i&l)
		rsCountry.open stmtCountry,con,2,3
		
		mytempstatus=cint(request("status"&i&l))

		if mytempstatus >400 and mytempstatus<500 then
		mainStatusFlag="Y"
		end if
		rsCountry("statusid")=mytempstatus
		if not categoryid=cint(request("category")) then
		rsCountry("entrytype")=cint(request("entrytype"&i&l))
		end if
		
		rsCountry("category")=cint(request("categorymain"&i&l))
		rsCountry("remarks")=trim(request("remark"&i&l))
		if request("subdate"&i&l)<>"" then
		rsCountry("subdate")=usrToSysDate(request("subdate"&i&l))
		else
		rsCountry("subdate")=null

		End if
		if request("coldate"&i&l)<>"" then
		rsCountry("coldate")=usrToSysDate(request("coldate"&i&l))
		rsCountry("colcheck")=request("colcheck"&i&l)
		else
		rsCountry("coldate")=null

		end if
		if trim(request("sentdate"&i&l))<>""  then
		rsCountry("sentdate")=usrToSysDate(request("sentdate"&i&l))
		else
		rsCountry("sentdate")=null
		end if
		
		rsCountry.update
		rsCountry.close
						certcount=cint(Request.Form("totalcert"&i&l))
						
						
						 
                      				if categoryid=cint(request("category")) then
                     				con.execute("delete from paxAttestation where paxid="&request("paxid"&i)& " and countryid="& request("country"&i&l))
						for mm=1 to certcount
						'response.write "Certificateids:"& Request.Form("CertificateID"&i&l&mm)
						'response.write "Certificateids:CertificateID"&i&l&mm
						if Request.Form("CertificateID"&i&l&mm)<>"" then
						rsAttest.open "Select * from PaxAttestation where paxid=1",con,2,3
						rsAttest.addNew
						rsAttest("PaxID")=Cint(request("paxid"&i))
						rsAttest("CountryID")=Cint(Request.Form("country"&i&l))
						rsAttest("AttestationID")=Cint(Request.Form("AttestationID"&i&l))
						rsAttest("CertificateID")=Cint(Request.Form("CertificateID"&i&l&mm))
						
						rsAttest.update
						rsAttest.close
						response.write "<br>"&Request.Form("CertificateID"&i&l&mm)
						end if
						next
						
						end if
						
		
		If request("status"&i&l)=request("oldstatus"&i&l) then
		else
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=cdbl(request("paxid"&i))
				rsHistory("CountryID")=Cint(request("country"&i&l))
				rsHistory("statusID")=cint(request("status"))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("remarks")=trim(request("remark"&i&l))
				rsHistory("updatedby")=session("uname")
				rsHistory.update
				rsHistory.close
		End if
		End if

	   next

i=i+1
rs.close
else
response.write "Data not  found in the Database."
end if
wend
rs.open "select * from  mainentry where refno ="&refno,con,2,3

if mainStatusFlag="Y" then
rs("status")=401
Else
rs("status")=request("status")
End if

rs.update
rs.close()

rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

refno=cdbl(refno)
agent=request("agentlist")
updatedby=trim(request("username"))
remark=trim(request("internalrem"))

sqlbh="insert into bighistory values('"&refno&"','"&agent&"','"&FormatDateTime(now(),0)&"','"&updatedby&"','"&remark&"')"
con.execute(sqlbh)

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


response.write "<p align=center><font size=2 color=#0000CC face=arial>The information for the refrence number <b>"&request("refno")&" </b> has been added successfully.</P>"
response.write "<P align=center><A HREF='editEntry.asp?refno="&refno&"'>CLICK HERE TO ADD MORE COLLECTION INFORMATIONS</A></p>"

application.unlock()
response.clear
myurl= "collection.asp?msgID=1&pname="&request("pname")
response.redirect(myurl)      

%>

