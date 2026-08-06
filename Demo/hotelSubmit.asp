<%@ Language=VBScript %>
<% response.buffer=true %>
<!-- #include file="connection.asp" -->


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
                <td>
                
<%

refno=cdbl(request("refno"))
agentid=cint(request("agentid"))
name=Request.Form ("name")
hotelname=Request.Form ("hotelname")
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
		
		if request("oldtotal") <>"" then
		masterbalance=masterbalance+cint(request("oldtotal") )-cdbl(Request.Form ("total"))
		else
		if Request.Form ("total")<> "" then
		masterbalance=masterbalance-cdbl(Request.Form ("total"))
		end if
		end if
		rsbalance.close
		


set rs=server.createobject("adodb.recordset")
stmt="select * from paxhotel where refno="&refno
rs.open stmt, con,2,3
if  rs.eof then
		rs.addnew
		rs.fields("refno")=refno
		rs.fields("name")=name
		rs.fields("hotelname")=hotelname
		if Request.Form ("tariff")<> "" then
		rs("tariff")=cint(Request.Form ("tariff"))
		end if
		if Request.Form ("days")<> "" then
		rs("nosofdays")=cint(Request.Form ("days"))
		end if
		if Request.Form ("transp")<> "" then
		rs("transportation")=cint(Request.Form ("transp"))
		else
		rs("transportation")=null
		end if
		if Request.Form ("misc")<> "" then
		rs("misccharges")=cint(Request.Form ("misc"))
		end if
		if Request.Form ("total")<> "" then
		rs("total")=cdbl(Request.Form ("total"))
		end if
		if request("arrivaldate")<>"" then
				rs("arrivaldate")=usrToSysDate(request("arrivaldate"))
		End if
		if request("arrivalt")<>"" then
				rs("arrivaltime")=request("arrivalt")
		End if
		if request("depdate")<>"" then
				rs("departdate")=usrToSysDate(request("depdate"))
		End if
		if request("deptime")<>"" then
				rs("departtime")=request("deptime")
		End if
		if request("rooms")<>"" then
				rs("noofrooms")=cint(request("rooms"))
		End if
		if request("flightdetail")<>"" then
				rs("flightdetail")=request("flightdetail")
		End if
		if request("flightstatus")<>"" then
				rs("flightstatus")=request("flightstatus")
		End if
		rs.update
		rs.close
else
		
		rs.fields("name")=name
		rs.fields("hotelname")=hotelname
		if Request.Form ("tariff")<> "" then
		rs("tariff")=cint(Request.Form ("tariff"))
		end if
		if Request.Form ("days")<> "" then
		rs("nosofdays")=cint(Request.Form ("days"))
		else
		rs("nosofdays")=null
		end if
		if Request.Form ("transp")<> "" then
		rs("transportation")=cint(Request.Form ("transp"))
		else
		rs("transportation")=null
		end if
		if Request.Form ("misc")<> "" then
		rs("misccharges")=cint(Request.Form ("misc"))
		end if
		if Request.Form ("total")<> "" then
		rs("total")=cdbl(Request.Form ("total"))
		end if
		if request("arrivaldate")<>"" then
		rs("arrivaldate")=usrToSysDate(request("arrivaldate"))
		End if
		if request("arrivalt")<>"" then
		rs("arrivaltime")=request("arrivalt")
		End if
		if request("depdate")<>"" then
		rs("departdate")=usrToSysDate(request("depdate"))
		End if
		if request("deptime")<>"" then
		rs("departtime")=request("deptime")
		End if
		if request("rooms")<>"" then
		rs("noofrooms")=cdbl(request("rooms"))
		end if
		
		if request("flightdetail")<>"" then
		rs("flightdetail")=request("flightdetail")
		End if
		if request("flightstatus")<>"" then
		rs("flightstatus")=request("flightstatus")
		End if
		rs.update
rs.close
end if
set rs1=server.createobject("adodb.recordset")
stmt="select * from ledger where refno="&refno&" and reftype='h'"
rs1.open stmt, con,2,3


if  rs1.eof then
			rs1.addnew
			rs1.fields("agentid")=agentid
			rs1.fields("paxname")=name
			rs1.fields("refno")=refno
			
			if Request.Form ("total")<> "" then
			rs1.fields("debit")=cdbl(Request.Form ("total"))
			rs1.fields("balance")=masterbalance
			else
			rs1.fields("debit")=null
			end if
			
			rs1.fields("reftype")="h"
			rs1.fields("transactiontype")="Hotel Booking"
			rs1.update
			debit=rs1.fields("debit")
			
else

			rs1.fields("agentid")=agentid
			rs1.fields("paxname")=name
			rs1.fields("refno")=refno
			
			if Request.Form ("total")<> "" then
			rs1.fields("debit")=cdbl(Request.Form ("total"))
			rs1.fields("balance")=masterbalance
			end if
			
			rs1.fields("reftype")="h"
			rs1.fields("transactiontype")="Hotel Booking"
			rs1.update
			
	
end if
' this updates the masterbalance
daysAllowed=0
		stmt2="select payment from agents  where agentsID="&agentID
		rsbalance.open stmt2, con,2,3
		if not rsbalance.eof then
		if isnull(trim(rsbalance.fields("payment"))) or  rsbalance.fields("payment")="" then
		daysAllowed=0
		else
		response.write rsbalance.fields("payment")
		daysAllowed=rsbalance.fields("payment")
		end if
		end if
		rsbalance.update
			
		rsbalance.close
		
		stmt2="select masterbalance, duedate from masterbalance  where agentID="&agentID
		rsbalance.open stmt2, con,2,3
		if not rsbalance.eof then
		rsbalance.fields("masterbalance")=masterbalance
		if masterbalance<0 and (isnull(rsbalance.fields("duedate")) or rsbalance.fields("duedate") = "" )then
		rsbalance.fields("duedate") =date()+ daysAllowed
		end if
		End if
			rsbalance.update
			
			rsbalance.close
			

response.clear
myurl= "collection.asp?msgID=1&pname="&request("name")&"&agent="&agentid&"&page="&request("page")&"&cmd="&request("cmd")
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


