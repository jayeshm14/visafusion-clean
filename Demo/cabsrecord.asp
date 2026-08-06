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
response.write refno
agentid=cint(request("agentid"))
name=Request.Form ("name")
set rsbalance=server.createobject("adodb.recordset")
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
stmt="select * from paxcab where refno="&refno
 
 rs.open stmt, con,2,3
 

if  rs.eof then
rs.addnew
rs("refno")=refno
rs("name")=Request.Form ("name")
if  Request.Form("orderedby") <> "" then
rs("orderedby")=Request.Form("orderedby")
end if
if  Request.Form("cabowner") <> "" then
rs("cabowner")=Request.Form("cabowner")
end if
if  Request.Form("vehicalno") <> "" then
rs("cabno")=Request.Form("vehicalno")
end if
if  Request.Form("vehical") <> "" then
rs("vehical")=Request.Form("vehical")
end if
if  Request.Form("ac") <> "" then
rs("ac")=Request.Form("ac")
end if
if  Request.Form("sdate") <> "" then
rs("sdate")=usrToSysDate(Request.Form("sdate"))
end if
if  Request.Form("enddate") <> "" then
rs("enddate")=usrToSysDate(Request.Form("enddate"))
end if
if  Request.Form("from") <> "" then
rs("startfrom")=Request.Form("from")
end if
if  Request.Form("dest") <> "" then
rs("dest")=Request.Form("dest")
end if
if  Request.Form("mode") <> "" then
rs("mode")=Request.Form("mode")
end if
if  Request.Form("standeredkms") <> "" then
rs("standeredkm")=cint(Request.Form("standeredkms"))
end if
if  Request.Form("standeredhours") <> "" then
rs("standeredhour")=Request.Form("standeredhours")
end if

if  Request.Form("actualkms") <> "" then
rs("actualkm")=cint(Request.Form("actualkms"))
end if
if  Request.Form("actualhours") <> "" then
rs("actualhour")=Request.Form("actualhours")
end if
if  Request.Form("extrakms") <> "" then
rs("extrakm")=cint(Request.Form("extrakms"))
end if
if  Request.Form("extrahours") <> "" then
rs("extrahour")=Request.Form("extrahours")
end if
if  Request.Form("extrainf") <> "" then
rs("extrainfo")=Request.Form("extrainf")
end if

if  Request.Form("extraamount") <> "" then
rs("extraamount")=cdbl(Request.Form("extraamount"))
end if



if Request.Form("ratesperday") <> "" then
rs("ratesperday")=cint(Request.Form("ratesperday"))
end if
if  Request.Form("noofday") <> "" then
rs("noofday")=cint(Request.Form("noofday"))
end if
if  Request.Form("total") <> "" then
rs("total")=cdbl(Request.Form("total"))
end if
rs.update
rs.close
else
rs.fields("refno")=refno
rs("name")=Request.Form ("name")
if  Request.Form("orderedby") <> "" then
rs("orderedby")=Request.Form("orderedby")
end if
if  Request.Form("cabowner") <> "" then
rs("cabowner")=Request.Form("cabowner")
end if
if  Request.Form("vehicalno") <> "" then
rs("cabno")=Request.Form("vehicalno")
end if
if  Request.Form("vehical") <> "" then
rs("vehical")=Request.Form("vehical")
end if
if  Request.Form("ac") <> "" then
rs("ac")=Request.Form("ac")
end if
if  Request.Form("sdate") <> "" then
rs("sdate")=usrToSysDate(Request.Form("sdate"))
end if
if  Request.Form("enddate") <> "" then
rs("enddate")=usrToSysDate(Request.Form("enddate"))
end if
if  Request.Form("from") <> "" then
rs("startfrom")=Request.Form("from")
end if
if  Request.Form("dest") <> "" then
rs("dest")=Request.Form("dest")
end if
if  Request.Form("mode") <> "" then
rs("mode")=Request.Form("mode")
end if
if  Request.Form("standeredkms") <> "" then
rs("standeredkm")=cint(Request.Form("standeredkms"))
end if
if  Request.Form("standeredhours") <> "" then
rs("standeredhour")=Request.Form("standeredhours")
end if

if  Request.Form("actualkms") <> "" then
rs("actualkm")=cint(Request.Form("actualkms"))
end if
if  Request.Form("actualhours") <> "" then
rs("actualhour")=Request.Form("actualhours")
end if
if  Request.Form("extrakms") <> "" then
rs("extrakm")=cint(Request.Form("extrakms"))
end if
if  Request.Form("extrahours") <> "" then
rs("extrahour")=Request.Form("extrahours")
end if
if  Request.Form("extrainf") <> "" then
rs("extrainfo")=Request.Form("extrainf")
end if

if  Request.Form("extraamount") <> "" then
rs("extraamount")=cdbl(Request.Form("extraamount"))
end if

if  Request.Form("ratesperday") <> "" then
rs("ratesperday")=cint(Request.Form("ratesperday"))
end if
if  Request.Form("noofday") <> "" then
rs("noofday")=cint(Request.Form("noofday"))
end if
response.write "ttt"&Request.Form("total")
if  Request.Form("total") <> "" then
rs("total")=cdbl(Request.Form("total"))

end if
rs.update
end if
'rs.close
		set rs1=server.createobject("adodb.recordset")
		stmt1="select * from ledger where agentID="&agentid&" and reftype='c' and refno="&refno
		
		rs1.open stmt1,con,2,3
	if  rs1.eof then
		rs1.addnew
		rs1.fields("agentid")=agentid
		rs1.fields("paxname")=name
		rs1.fields("refno")=refno
		if Request.Form ("total")<> "" then
		rs1.fields("debit")=cdbl(Request.Form ("total"))
		rs1.fields("balance")=masterbalance
		
		end if
		
		rs1.fields("reftype")="c"
		rs1.fields("transactiontype")="CAB BOOKING"
		rs1.update
		
		rs1.close
		else
		rs1.fields("agentid")=agentid
		rs1.fields("paxname")=name
		rs1.fields("refno")=refno
		if Request.Form ("total")<> "" then
		rs1.fields("debit")=cdbl(Request.Form ("total"))
		rs1.fields("balance")=masterbalance
		end if
		
		rs1.fields("reftype")="c"
		rs1.fields("transactiontype")="CAB BOOKING"
		rs1.update
		rs1.close
	
		
end if	
'HERE WE WILL UPDATE THE MASTERTABLE
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
		REsponse.write "masterbalance:"& masterbalance
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
			

		
		response.write "<TABLE border='1' width='80%'><tr><td><font size=2 color=#0000CC><b>DATE</B></FONT></td><td><font size=2 color=#0000CC><b> REF NO</B></FONT></td><td><font size=2 color=#0000CC><b> AGENT </B></FONT></td><td><font size=2 color=#0000CC><b>PAXNAME</B></FONT></td><td><font size=2 color=#0000CC><b>DEBIT</B></FONT></td><td><font size=2 color=#0000CC><b>PREVIOUS BALANCE</B></FONT></td><td><font size=2 color=#0000CC><b>PRESENT BALANCE</B></FONT></td><TR>"
		response.write "<TR><TD>"&date()&"</td><td>"&refno&"</td><td>"
		
		call writeIddescription("agents",agentID)
		response.write "</td><td>"& ucase(name)& "</td><td>"& debit&"</td><td align='center'>"&masterbalance &"</td><td align='center'>"&masterbalance1&"</td></tr></table>"             


response.clear
myurl= "collection.asp?msgID=1&pname="&request("name")&"&agent="&agentid&"&page="&request("page")&"&cmd="&request("cmd")
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


