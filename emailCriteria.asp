<!-- #include file="connection.asp" -->
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
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
                 
   <pre>             
<%
status=request("status")
if Request("date1")<>"" then
date1=Request("date1")
else
date1=Date()
end if
Response.write "<B>FOR PAX STATUS="&status&" AND SUBMITTED AFTER "&date1&" <br>"
Response.write "<B>EMAIL HAS BEEN SENT TO FOLLOWING AGENTS :<br>"

set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rsPending=server.createobject("adodb.recordset")
set rscountry=server.createobject("adodb.recordset")
set rsAgentEmail=server.createobject("adodb.recordset")

mainStmt="select * from mainEntry where status='"&status&"' and (Day(subdate)>="&day(date1)&" and month(subdate)>="&month(date1)&" and year(subdate)="&year(date1)&")"
rsPending.open mainStmt,con
while not rsPending.eof

refno=rsPending("refno")
subdate=rsPending("subdate")

stmt="select * from mainEntry where refno="&refno
rs.open stmt,con
if rs.eof then
response.write "Please check the reference number."
else

agent=rs.fields("agent")
refname=rs.fields("refferer")
recdate=rs.fields("receivedate")
pname=rs.fields("paxname")
dob=rs.fields("dateofbirth")
passport=rs.fields("passportno")
entries=rs.fields("entries")
company=rs.fields("companyname")
totalp=rs.fields("totalpassengers")
subdate=rs.fields("subdate")
coldate=rs.fields("coldate")
sentdate=rs.fields("sentdate")
category=rs.fields("category")
attestation=rs.fields("attestation")
poe=rs.fields("poe")
entrytype=rs.fields("entrytype")
status=rs.fields("status")

'Get the email of the Agent
doemail="no"
rsAgentEmail.open "select * from Agents where agentname='"&lcase(agent) &"'",con
if not rsAgentEmail.EOF then
agentEmail=rsAgentEmail("emailid")
doemail="yes"
end if
rsAgentEmail.close()
emailSubject="Email From Udaan Regarding "&pname
emailBody=""

emailBody=emailBody& "Date: "& formatdatetime(now(),1)&chr("13") 
emailBody=emailBody& "Refrence Number= "& refno &chr("13") 
emailBody=emailBody& "Agent="& ucase(agent)&chr("13") 
emailBody=emailBody& "Referer="& refname &chr("13") 
emailBody=emailBody& "PAX Name="& ucase(pname) &chr("13") 
emailBody=emailBody& "Company="&company  &chr("13") 
emailBody=emailBody& "Passport No = "&passport &chr("13") 
emailBody=emailBody& "Pessengers = "& totalp &chr("13") 
emailBody=emailBody& "Date Of Birth = "&dob &chr("13") 
emailBody=emailBody& "Receive date = "&recdate &chr("13") 
emailBody=emailBody& "Submit Date ="& subdate &chr("13") 
emailBody=emailBody& "Collection Date ="& coldate  &chr("13") 
emailBody=emailBody& "Category = "& category  &chr("13") 
emailBody=emailBody& "Attestation = "& attestation &chr("13") 
emailBody=emailBody& "POE/ECNR ="& poe  &chr("13") 
emailBody=emailBody& "Status="& status  &chr("13") 
emailBody=emailBody& "Country(s)= "

		stmt1="select distinct(cname) from entrydetails where refno="&refno
		rs1.open stmt1,con
		flag11="y"
		while not rs1.eof
		if flag11="y" then
		mycontlist=mycontlist& rs1.fields("cname")
		flag11="n" 
		Else
		mycontlist=mycontlist&", "& rs1.fields("cname")
		End if
		rs1.movenext
		wend
		rs1.close
		
emailBody=emailBody& mycontlist&chr("13") 
emailBody=emailBody& "Sent Date= "& sentdate &chr("13") 
                  
                
   
i=0
stmt1="select distinct(passengername) from entrydetails where refno="&refno
rs1.open stmt1,con
set rs2=server.createobject("adodb.recordset")
stmt2="select * from invoice where refno="&refno 
rs2.activeconnection=con
rs2.open stmt2
temp_flag=n
while not rs1.eof
if not rs2.eof then
temp_flag=y
temp_ddcharges=rs2("ddcharges")
temp_handlingfee=rs2("handlingfee")
temp_visafee=rs2("visafee")
temp_couriercharges=rs2("couriercharges")
temp_misccharges=rs2("misccharges")
temp_total=rs2("total")
temp_status=rs2("status")
temp_remark=rs2("remark")
end if

i=i+1
countrylist=""
pname1=rs1.fields("passengername")
getcountry="select cname from entrydetails where passengername='"&pname1&"' and refno="&refno
rscountry.activeconnection=con
rscountry.open getcountry,con
while not rscountry.eof
countrylist=countrylist& rscountry.fields("cname")& ", "
rscountry.movenext
wend
rscountry.close()

emailBody=emailBody& " ----------------------------------------------------------------------------"&chr("13") 
emailBody=emailBody& "                  Information regarding  "& ucase(pname1) &" for countries "& ucase(countrylist)  &chr("13") 
                      
'emailBody=emailBody& "Visa Fee="& temp_visafee &chr("13") 
'emailBody=emailBody& "DD Charges= "&temp_ddcharges &chr("13") 
'emailBody=emailBody& "Courier Charges="&temp_couriercharges &chr("13") 
'emailBody=emailBody& "Handling Charges="&temp_handlingfee &chr("13") 
'emailBody=emailBody& "Misc. Charges="&temp_misccharges &chr("13") 
'emailBody=emailBody& "Total="&temp_total &chr("13") 
emailBody=emailBody& "Status="& temp_status &chr("13") 
emailBody=emailBody& "Remarks="&temp_remark &chr("13") 
 
if (temp_flag=y) and not rs2.eof then
rs2.movenext
end if
rs1.movenext

wend
rs2.close
rs1.close
           
emailBody=emailBody& "CLient Remarks= "& rs("externalremark")&chr("13")
'response.write emailBody
 End if
 
'sending the email Now
If doemail="yes" then
Set objNewEmail = Server.CreateObject("CDONTS.NewMail")
objNewEmail.from="rajvenesh.p@igiindia.com"
objNewEmail.to= Cstr(agentEmail)
objNewEmail.subject=emailSubject
objNewEmail.body= emailBody
objNewEmail.send
Set objNewEmail = Nothing
End if
Response.write "<br><B>Subdate :"&subdate &"Refrence number:"&refno &" Agent's Email: "&agentEmail &"</B><br>"

rs.close
rsPending.movenext
Wend 
 %>

  </pre>              
               
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
