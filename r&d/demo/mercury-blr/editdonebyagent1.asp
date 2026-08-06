<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%
response.buffer=true

	agentdes=request("agent")
	newagentdes=request("newagent")
	agent=cint(request("agentid"))
	
	set rs=server.createobject("adodb.recordset")
	set rs2=server.createobject("adodb.recordset")
	stmt="select * from  agents where description='" &newagentdes &"' and '"& agentdes&"' <> '"&newagentdes&"'"
	rs.open stmt,con,2,3
	
if not rs.eof then

 'response.write "agent name already exist"
  response.clear
'  myurl= "agenthome.asp?agent="&newagentdes&"&flag=1"
  response.redirect(myurl)
  rs.close
else
rs.close
  agent=cint(request("agentid"))
  
  stmt="select * from agents where agentsID="&agent
  
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
'  myurl= "agenthome.asp?agent="&newagentdes&"&flag=2"
'  response.redirect(myurl)
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="765" border="0" cellspacing="0" cellpadding="0" align="left">
  <tr>
    <td><!-- #include file="topagent.asp" -->
    </td>
  </tr>
  <tr>
    <td>
      <div align="center"> 
        <p><b><font size="5" color="#FF9900"><br>
          Thanks !</font><br>
          <br>
          </b></p>
        <p><b> Your Information has been Updated Successfully. <br>
          Thanks For Giving your latest information. </b></p>
        <p>&nbsp;</p>
        <p>&nbsp; </p>
      </div>
    </td>
  </tr>
  <tr>
                <td><!-- #include file="homeBottom.asp" --></td>
          
    </tr>
</table>
</body>
</html>
