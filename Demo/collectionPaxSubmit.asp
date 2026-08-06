<!-- #include file="connection.asp" -->
<% response.buffer=true %>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/profilen2.gif','images/updaten2.gif','images/registrationn2.gif','images/contactn2.gif','images/queriean2.gif','images/logout2.gif')" >
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
refno=cdbl(request("refno"))
ivalue=cint(request("ivalue"))
entries=cint(request("ivalue"))
pname=request("pname")
agentID=request("agent")
mainStatusFlag="N"
sentStatusID=getIDForDescription("Status","Sent")
obtStatusID=getIDForDescription("Status","Obtained")
sendEmail="N"
totalAmount=0
oldtotalAmount=0
sendSMS="N"

insertEntry="Y"
set rs=server.createobject("adodb.recordset")
canadaid=getIDForDescription("Embassy","canada")

for k=1 to entries
		Tempcoldate=""
		Tempsubdate=""
		Temppaxname=""
		Temppaxname=request("name"&k)
	response.write "<tr> <td colspan=6><font size=2 color='#0000ff'><b>"&ucase(Temppaxname)&"</b></font></td></tr>"
		
		
		if request.form("countryinv"&k)<> "" then
		country=request.form("countryinv"&k)
				
				if cint(country)= cint(canadaid) and Request.Form("dob"&k)=""  then
					Response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Date of birth is required for Canada </font></td></tr>"
				end if

				if Request.Form("subdate"&k) <> "" then
				Tempsubdate=UsrToSysDate(Request.Form("subdate"&k))
				End if
				if Request.Form("coldate"&k) <> "" then
				Tempcoldate=UsrToSysDate(Request.Form("coldate"&k))
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
					'Checking for the Collection date falling on sunday 
					
						if weekday(Tempcoldate)=1  then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Collection date falls on the weekend "&formatDatetime(Tempcoldate,1)&".</font></td></tr> "
						insertEntry="N"
						end if 
						
						'Checking for the Collection date falling on the Weekend for the embassy 
					
						
						query1="select * from weeklyoff where EmbassyID="&country&" and weekend="&weekday(Tempcoldate)
						
						rs.open query1,con
						if not rs.eof then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Embassy of <B>"
						call writeIDDescription("embassy",country)
						response.write " </b> is closed on "&formatdatetime(Tempcoldate,1)&" Due to <B> "&ucase(rs("description"))&"</b>. Collection not possible. <BR></font></td></tr>"
						insertEntry="N"
						end if
						rs.close
						
						
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
						if weekday(Tempsubdate)=1 then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Submission date falls on the weekend "&formatDatetime(Tempsubdate,1)&".</font></td></tr> "
						insertEntry="N"
						end if 
						
						'Checking for the Submisson date falling on the Weekend for the embassy 
												
						query1="select * from weeklyoff where EmbassyID="&country&" and weekend="&weekday(Tempsubdate)
						rs.open query1,con
						if not rs.eof then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Embassy of <B>"
						call writeIDDescription("embassy",country)
						response.write " </b> is closed on "&formatdatetime(Tempsubdate,1)&" Due to <B> "&ucase(rs("description"))&"</b>. Submission not possible. <BR></font></td></tr>"
						insertEntry="N"
						end if
						rs.close
					
					end if
				
		end if
	
	
	next

response.write "<tr> <td colspan=6 align=center><input type=button value='EDIT' onclick='javascript:history.back()' ID='Button1' NAME='Button1'></td></tr>"

set rs=nothing


%>

<%

IF insertEntry="Y" Then


set rs=server.createobject("adodb.recordset")
set rsDetails=server.createobject("adodb.recordset")
set rsHistory = server.createObject("Adodb.Recordset")
set rsc=server.createobject("adodb.recordset")
i=1
while i<= ivalue 
mystmt="select * from  paxstatus where refno ="&refno &" and paxID="& request("paxid"&i) &" and countryID="&request("countryinv"&i)
response.write mystmt
rs.open mystmt,con,2,3

if  rs.eof then
response.write "notfound "&ivalue
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
if request("VFSTTCharges"&i)<>"" then
rs("VFSTTCharges")=cdbl(request("VFSTTCharges"&i))
End if
if request("misc"&i)<>"" then
rs("miscCharges")=cdbl(request("misc"&i))
End if
if request("total"&i)<>"" then
rs("total")=cdbl(request("total"&i))
totalAmount=totalAmount+request("total"&i)
if request("oldtotal"&i)<>"" then
oldtotalAmount=oldtotalAmount+request("oldtotal"&i)
end if
End if 
'now updating the table Entry details
mytempstatus=cint(request("status"&i))
rs("statusid")=mytempstatus
if mytempstatus >400 and mytempstatus<500 then
mainStatusFlag="Y"
sendSMS="Y"
countrySMS=request("countryinv"&i)
SMSstatus=mytempstatus
end if
if Cint(sentStatusID)= mytempstatus OR Cint(obtStatusID)= mytempstatus then
sendEmail="Y"
end if
		rs("category")=cint(request("categorymain"&i))
		rs("remarks")=request("remark"&i)
		if request("subdate"&i)<>"" then
		rs("subdate")=usrToSysDate(request("subdate"&i))
		End if
		if request("coldate"&i&l)<>"" then
		rs("coldate")=usrToSysDate(request("coldate"&i))
		rs("colcheck")=request("colcheck"&i)
		end if
		if trim(request("sentdate"&i&l))<>""  then
		rs("sentdate")=usrToSysDate(request("sentdate"&i))
		end if
		rs("entryDateTime")=formatDateTime(Now(),0)
rs.update
rs.close
response.write "status"& request("status"&i)&"old status"&request("oldstatus"&i) 
				If request("status"&i)<> request("oldstatus"&i) then
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=cdbl(request("paxid"&i))
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
		
		if oldtotalAmount <> "" then
		masterbalance=masterbalance+oldtotalAmount-totalAmount
		else
		masterbalance=masterbalance-totalAmount
		end if
		
		rsbalance.close
		
	
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
			rs1.fields("balance")=masterbalance
			end if
			
			rs1.fields("reftype")="v"
			rs1.fields("transactiontype")="hotel debit"
			rs1.update
			
else

			rs1.fields("agentid")=agentid
			rs1.fields("paxname")=pname
			rs1.fields("refno")=refno
			if totalAmount<> "" then
			rs1.fields("debit")=totalAmount
			rs1.fields("balance")=masterbalance
			end if
			
			rs1.fields("reftype")="v"
			rs1.fields("transactiontype")="Visa processing"
			rs1.update
			
	
end if

' THE CODE BELOW  UPDATES THE MASTERBALANCE
'daysAllowed=0
'		stmt2="select payment from agents  where agentsID="&agentID
'		rsbalance.open stmt2, con,2,3
'		if not rsbalance.eof then
'		if isnull(trim(rsbalance.fields("payment"))) or  rsbalance.fields("payment")="" then
'		daysAllowed=0
'		else
'		response.write rsbalance.fields("payment")
'		daysAllowed=cint(rsbalance.fields("payment"))
'		end if
'		end if
'		rsbalance.update
			
'		rsbalance.close
		
'		stmt2="select masterbalance, duedate from masterbalance  where agentID="&agentID
'		rsbalance.open stmt2, con,2,3
'		if not rsbalance.eof then
'		rsbalance.fields("masterbalance")=masterbalance
'		if masterbalance<0 and (isnull(rsbalance.fields("duedate")) or rsbalance.fields("duedate") = "" )then
'		rsbalance.fields("duedate") =date()+ daysAllowed
'		end if
'		End if
'			rsbalance.update
'			rsbalance.close


rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

refno=cdbl(refno)
agent=agentid
updatedby=trim(request("username"))
remark=trim(request("internalrem"))

sqlbh="insert into bighistory values('"&refno&"','"&agent&"','"&FormatDateTime(now(),0)&"','"&updatedby&"','"&remark&"')"
con.execute(sqlbh)

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

response.write "<p align=center><font size=2 color=#0000CC face=arial>The information for the refrence number <b>"&request("refno")&" </b> has been added successfully.</P>"
response.write "<P align=center><A HREF='collection.asp'>CLICK HERE TO ADD MORE COLLECTION INFORMATIONS</A></p>"

response.clear
myurl= "collection.asp?msgID=1&pname="&request("pname")&"&page="&request("page")&"&cmd="&request("cmd")&"&sentEmail="&sendEmail&"&refno="&refno&"&sendSMS="&sendSMS&"&agentID="&agentid&"&country="&countrySMS&"&updatedby="&updatedby&"&SMSstatus="&SMSstatus 
response.redirect(myurl)  
END if 'end if for the insertEntry="Y"              
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
