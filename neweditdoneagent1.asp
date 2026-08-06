<%@ Language=VBScript %>
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


	agentdes=request("agent")
	
	newagentdes=request("newagent")
	
	agent=cint(request("agentid"))
	
	set rs=server.createobject("adodb.recordset")
	set rs2=server.createobject("adodb.recordset")
	stmt="select * from  newagents where description='" &newagentdes &"' and '"& agentdes&"' <> '"&newagentdes&"'"
	rs.open stmt,con,2,3
	
if not rs.eof then

 'response.write "agent name already exist"
  response.clear
  myurl= "newagenthome.asp?agent="&newagentdes&"&flag=1"
  response.redirect(myurl)
  rs.close
else
rs.close
  agent=cint(request("agentid"))
  
  stmt="select * from newagents where newagentsID="&agent
  
  rs.open stmt,con,2,3
  if not rs.eof then
    rs("description")=newagentdes
rs("companyname")=request("company")
rs("complexname")=request("complexname")
rs("street1")=request("street1")
rs("street2")=request("street2")
rs("area")=request("area")
rs("city")=request("city")
rs("pincode")=request("pincode")
rs("phoneno")=request("phoneno")
rs("faxno")=request("faxno")
rs("emailid")=request("emailid")
rs("directorname")=request("directorname")
rs("acno")=request("acno")
rs("payment")=request("payment")
rs.update
    'response.write "new  informa saved"
  end if

  response.clear
  myurl= "newagenthome.asp?agent="&newagentdes&"&flag=2"
  response.redirect(myurl)
end if
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
