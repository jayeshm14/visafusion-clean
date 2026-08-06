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
ivalue=cint(request("entries"))
entries=cint(request("entries"))
pname=request("pname")
agentID=request("agent")
mainStatusFlag="N"
totalAmount=0
oldtotalAmount=0

insertEntry="Y"
set rs=server.createobject("adodb.recordset")
canadaid=getIDForDescription("Embassy","canada")

for k=1 to entries
		Temppaxname=request("name"&k)
	response.write "<tr> <td colspan=6><font size=2 color='#0000ff'><b>"&ucase(Temppaxname)&"</b></font></td></tr>"
		
		
		if request.form("countryID"&k)<> "" then
		country=request.form("countryID"&k)
				
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
						if weekday(Tempcoldate)=1  then
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
						if weekday(Tempsubdate)=1  then
						response.write "<tr> <td colspan=6><img src='images/alert1.gif'> <font size=2 color='#006600'> Submission date falls on the weekend "&formatDatetime(Tempsubdate,1)&".</font></td></tr> "
						insertEntry="N"
						end if 
					
					end if
				
		end if
	
	
	next

response.write "<tr> <td colspan=6 align=center><input type=button value='EDIT' onclick='javascript:history.back()' ID='Button1' NAME='Button1'></td></tr>"

set rs=nothing


%>


<%
for i=1 to entries
'tot = cdbl(request("handlingfee"&i)) + cdbl(request("couriercharges"&i)) + cdbl(request("misccharges"&i))
'response.Write tot& request("name"&i)&" refno"&request("refno"&i) &" paxid "&request("paxid"&i)  &" cntry "&request("countryID"&i) &" status "&request("status"&i)&" oldsts"&request("oldstatus"&i)&"<BR> "
if request("subdate"&i)<>request("oldsubdate"&i) or request("coldate"&i)<>request("oldcoldate"&i)then
response.Write request("name"&i)&" Subdate or coldate is changed"
end if

next
IF insertEntry="Y" Then

set rs=server.createobject("adodb.recordset")
set rsDetails=server.createobject("adodb.recordset")
set rsHistory = server.createObject("Adodb.Recordset")
set rsc=server.createobject("adodb.recordset")

i=1
change=1

while i<= ivalue 
refno=request("refno"&i)
rs.open "select * from  paxstatus where refno ="&refno &" and paxID="& request("paxid"&i) &" and countryID="&request("countryID"&i),con,2,3
if  rs.eof then
i=i+1
rs.close
else
totalAmount=0
if request("visafee"&i)<>"" then
rs("visafee")=cdbl(request("visafee"&i))
totalAmount=totalAmount+cdbl(request("visafee"&i))
else
rs("visafee")=null
End if
if request("ddcharges"&i)<>"" then
rs("ddcharges")=cdbl(request("ddcharges"&i))
totalAmount=totalAmount+cdbl(request("ddcharges"&i))
else
rs("ddcharges")=null
End if

'if request("handling"&i)<>"" then
'rs("Handlingfee")=cdbl(request("handling"&i))
'else
'rs("Handlingfee")=null
'End if
totalAmount=totalAmount+cdbl(request("handlingfee"&i)) + cdbl(request("couriercharges"&i)) + cdbl(request("misccharges"&i))

if totalAmount>0 then
rs("total")=cdbl(totalAmount)

else
rs("total")=null
End if 



mytempstatus=Cint(request("status"&i))
rs("statusid")=mytempstatus
if mytempstatus >400 and mytempstatus<500 then
mainStatusFlag="Y"
end if
		'rs("category")=cint(request("categorymain"&i))
		rs("remarks")=request("remark"&i)
		if request("subdate"&i)<>"" then
		rs("subdate")=usrToSysDate(request("subdate"&i))
		End if
		if request("coldate"&i&l)<>"" then
		rs("coldate")=usrToSysDate(request("coldate"&i))
		rs("colcheck")=request("colcheck"&i)
		end if
		
		'if trim(request("sentdate"&i&l))<>""  then
		'rs("sentdate")=usrToSysDate(request("sentdate"&i))
		'end if
		rs("entryDateTime")=formatDateTime(Now(),0)
rs.update
rs.close

If request("status"&i)<> request("oldstatus"&i) then
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=cdbl(request("paxid"&i))
				rsHistory("CountryID")=Cint(Request.Form("countryID"&i))
				rsHistory("statusID")=cint(request("status"&i))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("remarks")=trim(request("remark"&i))
				rsHistory("updatedby")=trim(request("username"))
				rsHistory.update
				rsHistory.close

change=2
end If				
end if

'Update the main status 
rs.open "select * from  mainentry where refno ="&refno,con,2,3

if mainStatusFlag="Y" then
rs("status")=401
Else
If request("status"&i)<> request("oldstatus"&i) then

rs("status")=request("status"&i)

end if
End if
'if request("sentdate")<>"" then
'rs("sentdate")=(request("sentdate"))
'end if
'rs("internalremark")=trim(request("intremark"&i))
'rs("externalremark")=trim(request("externalrem"))

rs.update
rs.close()
i=i+1
'loop ends here
wend




'set rsbalance=server.createobject("adodb.recordset")
'		stmt="select * from masterbalance where agentID="&agentID

'		rsbalance.open stmt, con,2,3
'		if not rsbalance.eof then
'		masterbalance=rsbalance.fields("masterbalance")
'		else
'		rsbalance.addnew
'		rsbalance.fields("agentid")=cint(agentID)
'		rsbalance.fields("masterbalance")=0
'		rsbalance.update
		
'		masterbalance=0
'		end if
		
'		if oldtotalAmount <> 0 then
'		masterbalance=masterbalance+oldtotalAmount-totalAmount
'		else
		
'		masterbalance=masterbalance-totalAmount
		
'		end if
'		rsbalance.close
	
'set rs1=server.createobject("adodb.recordset")
'stmt="select * from ledger where refno="&refno&" and reftype='B'"
'rs1.open stmt, con,2,3


'if  rs1.eof then
'			rs1.addnew
'			rs1.fields("agentid")=agentid
'			rs1.fields("paxname")=pname
'			rs1.fields("refno")=refno
			
'			if totalAmount<> "" then
'			rs1.fields("debit")=totalAmount
'			rs1.fields("balance")=masterbalance
'			end if
			
'			rs1.fields("reftype")="B"
'			rs1.fields("transactiontype")="Visa processing"
'			rs1.update
			
			
'else

'			rs1.fields("agentid")=agentid
'			rs1.fields("paxname")=pname
'			rs1.fields("refno")=refno
'			if totalAmount<> "" then
'			rs1.fields("debit")=totalAmount
			
'			rs1.fields("balance")=masterbalance
'			end if
			
'			rs1.fields("reftype")="B"
'			rs1.fields("transactiontype")="Visa processing"
'			rs1.update
			
			
	
'end if
' this updates the masterbalance
'daysAllowed=0
'		stmt2="select payment from agents  where agentsID="&agentID
'		rsbalance.open stmt2, con,2,3
'		if not rsbalance.eof then
'		if isnull(trim(rsbalance.fields("payment"))) or  rsbalance.fields("payment")="" then
'		daysAllowed=0
'		else
'		daysAllowed=cint(rsbalance.fields("payment"))
'		end if
'		end if
'		rsbalance.update
			
'		rsbalance.close
		
'		stmt2="select masterbalance, duedate from masterbalance  where agentID="&agentID
'		rsbalance.open stmt2, con,2,3
'		if not rsbalance.eof then
'		 rsbalance.fields("masterbalance")=masterbalance
'		 if masterbalance<0 and (isnull(rsbalance.fields("duedate")) or rsbalance.fields("duedate") = "" )then
'		  rsbalance.fields("duedate") =date()+ daysAllowed
'		 end if
'		End if
		
'		rsbalance.update
'		rsbalance.close

'if change=2 then
if request("subdate"&i)<>request("oldsubdate"&i) or request("coldate"&i)<>request("oldcoldate"&i)or request("status"&i)<>request("status"&i)or request("remark"&i)<>request("oldremark"&i) then

rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close

end if
'end if

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

refno=cdbl(refno)
agent=agentid
updatedby=trim(request("username"))
remark=trim(request("remark"&i))

sqlbh="insert into bighistory values('"&refno&"','"&agent&"','"&FormatDateTime(now(),0)&"','"&updatedby&"','"&remark&"')"
con.execute(sqlbh)

'***** Big history insert *****+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

response.write "<p align=center><font size=2 color=#0000CC face=arial>The information for the refrence number <b>"&request("refno")&" </b> has been added successfully.</P>"
response.write "<P align=center><A HREF='collection.asp'>CLICK HERE TO ADD MORE COLLECTION INFORMATIONS</A></p>"

response.clear
myurl= "BulkCollection.asp?page="&request("page")&"&cmd="&cmd&"&agent="&request("agent")&"&countryID="&request("countryID")&"&date="&request("date")
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
