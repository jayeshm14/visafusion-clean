<%@ Language=VBScript %>
<% response.buffer=true %>
<!-- #include file="connection.asp" -->
<table>
<%

insertEntry="Y"

entries=cint(Request.Form ("raj"))
count=cint(Request.Form ("venesh"))
set rs=server.createobject("adodb.recordset")
canadaid=getIDForDescription("Embassy","canada")


for k=1 to entries
		Temppaxname=request("name"&k)
	response.write "<tr> <td colspan=6><font size=2 color='#0000ff'><b>"&ucase(Temppaxname)&"</b></font></td></tr>"
		
		
	for l=1 to count
		
		if request.form("country"&k&l)<> "" then
		country=request.form("country"&k&l)
				
				if cint(country)= cint(canadaid) and Request.Form("dob"&k&l)=""  then
					Response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Date of birth is required for Canada </font></td></tr>"
				end if

				if Request.Form("subdate"&k&l) <> "" then
				Tempsubdate=UsrToSysDate(Request.Form("subdate"&k&l))
				End if
				if Request.Form("coldate"&k&l) <> "" then
				Tempcoldate=UsrToSysDate(Request.Form("coldate"&k&l))
				End if
					if Tempcoldate<>"" then
					query1="select * from holidaylist where countryID="&country&" and (Day(holiday)="&day(Tempcoldate)&" and month(holiday)="&month(Tempcoldate)&" and year(holiday)="&year(Tempcoldate)&")"
					
					rs.open query1,con
					if not rs.eof then
					response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Embassy of <B>"
					call writeIDDescription("embassy",country)
					response.write " </b> is closed on "&formatdatetime(rs("holiday"),1)&" Due to <B> "&ucase(rs("description"))&"</b>. Collection not possible. <BR></font></td></tr>"
					insertEntry="N"
					end if
					rs.close
						if weekday(Tempcoldate)=1 or weekday(Tempcoldate)=7 then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Collection date falls on the weekend "&formatDatetime(Tempcoldate,1)&".</font></td></tr> "
						insertEntry="N"
						end if 
					end if
					if Tempsubdate<>"" then
					query1="select * from holidaylist where countryID="&country&" and ((Day(holiday)="&day(Tempsubdate)&" and month(holiday)="&month(Tempsubdate)&" and year(holiday)="&year(Tempsubdate)&"))"
					
					rs.open query1,con
					if not rs.eof then
					response.write "<tr> <td colspan=6><img src='images/alert1.gif'><font size=2 color='#006600'> Embassy of <B>"
					call writeIDDescription("embassy",country)
					response.write " </b> is closed on "&formatdatetime(rs("holiday"),1)&" Due to <B> "&ucase(rs("description"))&"</b>. Submission not possible.<BR></font></td></tr>"
					insertEntry="N"
					end if
					rs.close
						if weekday(Tempsubdate)=1 or weekday(Tempsubdate)=7 then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Submission date falls on the weekend "&formatDatetime(Tempsubdate,1)&".</font></td></tr> "
						insertEntry="N"
						end if 
					
					end if
				
		end if
	
	next
	next

response.write "<tr> <td colspan=6 align=center><input type=button value='EDIT' onclick='javascript:history.back()'></td></tr>"



%>

</table> 
<%
if insertEntry="Y" then

nameofuser=session("uname")

entries=cint(Request.Form ("raj"))
count=cint(Request.Form ("venesh"))

newid=0
refno=0

set rsHistory=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rsTemp=server.createobject("adodb.recordset")
set rsc=server.createobject("adodb.recordset")

application.lock()
rs.open "select max(refno) from mainentry ",con,2,3
newid=1
if not rs.eof then
newid=rs(0)
newid=newid+1
else
newid=1
end if
rs.close

rs.open "select * from mainentry",con,2,3
rs.addnew
rs("refno")=newid
rs("paxname")=request("name1")
rs("agent")=request("agent")
rs("refferer")=request("refname")
rs("companyname")=request("company")
rs("totalpassengers")=cint(request("totalp"))
rs("entries")=cint(request("entries"))
if request("dob")<>"" then
rs("dateofbirth")=UsrToSysDate(request("dob"))
end if
if request("subdate")<>"" then
rs("subdate")=request("subdate")
subdate=request("subdate")
End if
if request("coldate")<>"" then
rs("coldate")=request("coldate")
coldate=request("coldate")
end if
if request("recdate")<>"" then
rs("receivedate")=request("recdate")
end if
if request("travdate")<>"" then
rs("traveldate")=request("travdate")
end if
rs("category")=cint(request("category"))
rs("passportno")=request("passport")
rs("status")=cint(request("status"))
rs("attestation")=cint(request("attestation"))
rs("poe")=cint(request("poe"))
rs("enteredby")=trim(request("username"))
rs("EntryDateTime")=FormatDateTime(now(),0)
rs("externalremark")=request("retrieveremark")
rs("bill")="N"
rs.update
rs.close

rs.open "select max(refno) from mainentry ",con,2,3
if not rs.eof then
refno=rs(0)
end if
rs.close

rs.open "select * from entrydetails where refno=1",con,2,3
	  	
	for k=1 to entries
		rs.addnew
		rs("refno")=refno
		if request("name"&k)<> "" then
		rs("paxname")=request("name"&k)
		else
		rs("paxname")="NE"
		end if
		if request.form("dob"&k)<>"" then
		rs("dateofbirth")=UsrToSysDate(request.form("dob"&k))
		end if 
		rs("category")=cint(request.form("category"))
		if trim(request("totp"&k))<>"" then
		rs("totalpax")=cint(request("totp"&k))
		end if 
		if trim(request("epassport"&k))<>"" then
		rs("passportno")=request("epassport"&k)
		end if 
		rs.update
		Paxid=1
	       	rsTemp.open "select max(PaxID) from entryDetails ",con,2,3
		if not rsTemp.eof then
		Paxid=rsTemp(0)
		end if
		rsTemp.close
		
	for l=1 to count
		
		if request.form("country"&k&l)<> "" then
				rsCountry.open "Select * from PaxStatus where paxid=1",con,2,3
				rsCountry.addnew
				rsCountry("PaxID")=cdbl(Paxid)
				rsCountry("Refno")=cdbl(Refno)
				rsCountry("entrytype")=cint(request("entrytype"&k&l))
				rsCountry("category")=cint(request("categorytype"&k&l))
				rsCountry("CountryID")=Cint(Request.Form("country"&k&l))
				if Request.Form("subdate"&k&l) <> "" then
				rsCountry("subdate")=UsrToSysDate(Request.Form("subdate"&k&l))
				End if
				if Request.Form("coldate"&k&l) <> "" then
				rsCountry("coldate")=UsrToSysDate(Request.Form("coldate"&k&l))
				rsCountry("colcheck")=request("colcheck"&k&l)
				End if
				rsCountry("statusID")=cint(request("status"))
				rsCountry.update
				rsCountry.close
				
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=Cdbl(Paxid)
				rsHistory("CountryID")=Cint(Request.Form("country"&k&l))
				rsHistory("statusID")=cint(request("status"))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("updatedby")=trim(request("username"))
				rsHistory.update
				rsHistory.close
		'response.write "<BR>entry is:"&refno&request("name"&k)&Request.Form("country"&k&l)&cint(request("totp"&k))
		end if
	
	next
	next


rs.close

rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

refno=cdbl(refno)
agent=request("agent")
updatedby=trim(request("username"))
remark=request("retrieveremark")

sqlbh="insert into bighistory values('"&refno&"','"&agent&"','"&FormatDateTime(now(),0)&"','"&updatedby&"','"&remark&"')"
con.execute(sqlbh)

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

application.unlock()
response.clear
myurl= "entry.asp?msgID=1&pname="&request("name1")&"&refno="&refno
response.redirect(myurl)

End if
%>
