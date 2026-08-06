<%@ Language=VBScript %>
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
                <td><!-- #include file="topadmin.asp" --></td>
              </tr>
              <tr>
                <td>
<%             
set rsLoadListBox=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
rsLoadListBox.activeconnection=con
qry="select distinct(mainentry.REFNO) from  Paxstatus,mainentry where Paxstatus.refno=mainentry.refno  and (day(Paxstatus.entryDateTime)=day(date()) and month(Paxstatus.entryDateTime)=month(date()) and year(Paxstatus.entryDateTime)=year(date()) )"
rsLoadListBox.open qry,con,2,3
while not rsLoadListBox.eof
refno=rsLoadListBox(0)
response.write "refno"&refno&"<br>"

qry2="select sum(total) from  Paxstatus where refno="&refno &" and (day(Paxstatus.coldate)=day(date()) and month(Paxstatus.coldate)=month(date()) and year(Paxstatus.coldate)=year(date()))"
rs2.open qry2,con
while not rs2.eof
response.write "PAX STATUS TOTAL:"&rs2(0)&"<br>"
rs2.movenext
wend
rs2.close
qry2="select sum(total) from  paxhotel  where refno="&refno
rs2.open qry2,con
while not rs2.eof
response.write "PAX HOTEL TOTAL:"&rs2(0)&"<br>"

rs2.movenext
wend
rs2.close
qry3="select sum(total) from  Paxcab where  refno="&refno
rs2.open qry3,con
while not rs2.eof
response.write "PAX CAB TOTAL:"&rs2(0)&"<br>"
rs2.movenext
wend
rs2.close
rsLoadListBox.movenext
wend
rsLoadListBox.close
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
