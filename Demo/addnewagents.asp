<!-- #include file="connection.asp" -->
<%
response.buffer=true
%>
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
                <td><!-- #include file="topadmin.asp" --></table></td>
              </tr>
              <tr>
                <td>
                <%
set rs=server.createobject("adodb.recordset")
stmt="select * from agents where description='"&lcase(request("agentname"))&"'"
rs.open stmt,con,2,3

if TRIM(request("agentname"))= "" then
response.write "NAME IS REQUIRED."

ELSE
if rs.EOF then
rs.addnew
rs("description")=lcase(request("agentname"))
rs("companyname")=lcase(request("company"))
rs("complexname")=lcase(request("complex"))
rs("street1")=lcase(request("street1"))
rs("street2")=lcase(request("street2"))
rs("area")=lcase(request("area"))
rs("city")=lcase(request("city"))
rs("pincode")=lcase(request("pincode"))
rs("phoneno")=lcase(request("phoneno"))
rs("faxno")=lcase(request("faxno"))
rs("emailid")=lcase(request("emailid"))
rs("directorname")=lcase(request("directorname"))
rs("acno")=lcase(request("acno"))
rs("TAAI")=lcase(request("TAAI"))
rs("TAFI")=lcase(request("TAFI"))
rs("IATA")=lcase(request("IATA"))
rs("DirectorPH")=lcase(request("DirectorPH"))
rs("AcMgrPH")=lcase(request("AcMgrPH"))
rs("VisaInchargeName")=lcase(request("VisaInchargeName"))
rs("VisaInchargePH")=lcase(request("VisaInchargePH"))
rs("payment")=lcase(request("payment"))
rs("active")="Y"
rs("enteredby") = ucase(session("uname"))
rs.update
rs.close
rs.open "select max(agentsid) from agents",con
if not rs.eof then
agentID=rs(0)
end if
rs.close

if request("web")="yes" then
%>
<!-- #include file="connectionweb.asp" -->
<%
set rsweb=server.createobject("adodb.recordset")
stmtweb="select* from agents where description='"&lcase(request("agentname"))&"'"
rsweb.open stmtweb,webcon,2,3

if rsweb.EOF then
rsweb.addnew
rsweb("agentsid")=cdbl(agentid)
rsweb("description")=lcase(request("agentname"))
rsweb("companyname")=lcase(request("company"))
rsweb("complexname")=lcase(request("complex"))
rsweb("street1")=lcase(request("street1"))
rsweb("street2")=lcase(request("street2"))
rsweb("area")=lcase(request("area"))
rsweb("city")=lcase(request("city"))
rsweb("pincode")=lcase(request("pincode"))
rsweb("phoneno")=lcase(request("phoneno"))
rsweb("faxno")=lcase(request("faxno"))
rsweb("emailid")=lcase(request("emailid"))
rsweb("directorname")=lcase(request("directorname"))
rsweb("acno")=lcase(request("acno"))
rsweb("TAAI")=lcase(request("TAAI"))
rsweb("TAFI")=lcase(request("TAFI"))
rsweb("IATA")=lcase(request("IATA"))
rsweb("DirectorPH")=lcase(request("DirectorPH"))
rsweb("AcMgrPH")=lcase(request("AcMgrPH"))
rsweb("VisaInchargeName")=lcase(request("VisaInchargeName"))
rsweb("VisaInchargePH")=lcase(request("VisaInchargePH"))
rsweb("payment")=lcase(request("payment"))
rsweb("active")="Y"
rsweb.update
rsweb.close

end if
end if

'set rsbalance=server.createobject("adodb.recordset")
'		set rsbalance=server.createobject("adodb.recordset")
'		stmt="select * from masterbalance where agentID="&agentID
'		rsbalance.open stmt, con,2,3
'		if  rsbalance.eof then
'		rsbalance.addnew
'		rsbalance.fields("agentid")=cint(agentID)
'		rsbalance.fields("masterbalance")=0
'		rsbalance.update
'		masterbalance=0
'		end if
'		rsbalance.close
		
'response.write"<b><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>The agent <B> "& ucase(request("agentname"))&"</b> Has been added successfully.<BR></font>"
response.clear
  myurl= "agenthome.asp?agent="&ucase(request("agentname"))&"&flag=3"
  response.redirect(myurl)
else
response.clear
  myurl= "agenthome.asp?agent="&ucase(request("agentname"))&"&flag=4"
  response.redirect(myurl)
%>
<table><tr><td>
<font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>
<b>PLEASE CHANGE AGENT IDENTITY.<br>AGENT WITH THIS IDENTITY ALREADY EXISTS.</b></font></td>
</tr><tr>
<td colspan=2 align="center"><font size='2' color='#CC0000' face='Arial, Helvetica, sans-serif'>
<input type=button name=b1 value='EDIT' onclick='javascript:history.back()' >
</font></td></tr>
</table>
<%
end if
END IF
%>

                
                
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    
  
   <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  

</body>
</html>