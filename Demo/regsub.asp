<!-- #include file="connection.asp" -->
<%
response.buffer=true
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
         
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>
                <%


set rs=server.createobject("adodb.recordset")
stmt="select* from agents where description='"&lcase(request("agentname"))&"'"
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
rs("payment")=lcase(request("payment"))
rs.update
rs.close
rs.open "select max(agentsid) from agents",con
if not rs.eof then
agentID=rs(0)
end if
rs.close

set rsbalance=server.createobject("adodb.recordset")
		set rsbalance=server.createobject("adodb.recordset")
		stmt="select * from masterbalance where agentID="&agentID
		rsbalance.open stmt, con,2,3
		if  rsbalance.eof then
		rsbalance.addnew
		rsbalance.fields("agentid")=cint(agentID)
		rsbalance.fields("masterbalance")=0
		rsbalance.update
		masterbalance=0
		end if
		rsbalance.close
		
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
<b>PLEASE CHANGE AGENT IDENTITY.<br>AGENT WITH THIS IDENTITY ALREADY EXISTS.</font></td>
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
    </td>
  </tr>
   <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
