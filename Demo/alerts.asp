 <%@ Language=VBScript %>
<!-- #include file="connection.asp" -->


<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>
<% if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>


<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
 <tr><td>&nbsp;</td></tr>

  

   <tr>
                <td>
                
               

<%

                      cmd=request("cmd")
        
        
set rsAlert=server.createobject("adodb.recordset")
mytime=cdate("02:00:00 PM")
 date1=date()-3
 today=date() 
 Writetableheadflag="Y"
if time>mytime then
stmt ="select Entrydetails.Totalpax, paxstatus.entrydatetime, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.coldate)="&day(today)&" and Month(paxstatus.coldate)="&Month(today)&" and year(paxstatus.coldate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"

rsAlert.open stmt,con
while not rsAlert.Eof
if NOT (IsNull(rsAlert("coldate")) or IsNull(rsAlert("entrydatetime")) ) then
if formatDateTime(rsAlert("coldate"),2) <> formatDateTime(rsAlert("entrydatetime"),2) then
if Writetableheadflag="Y" then
%>

<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
<tr bgcolor="#FFFFF0"> 
            <td colspan="2"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              ALERTS </font></font></b></div>
            </td>
          </tr>
<%

Writetableheadflag="N"
end if
response.write "<tr><td><font face='arial' size=1 color='#000000'>PLEASE CHECK  <B>"&UCASE(rsAlert("paxName"))&"</B> WITH REFNO "&rsAlert("refno")&" FOR COLLECTION FROM EMBASSY OF  "
call writeIDDescription("Embassy",rsAlert("countryID"))
response.write ". </FONT></td><td><a href='editEntry.asp?refno="&rsAlert("refno")&"' >Edit</a></td></tr>"

End if 
End if
rsAlert.movenext
wend
rsAlert.close
'-------------FOR SUBMISSION
stmt ="select Entrydetails.Totalpax, paxstatus.entrydatetime, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.subdate)="&day(today)&" and Month(paxstatus.subdate)="&Month(today)&" and year(paxstatus.subdate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"


rsAlert.open stmt,con
while not rsAlert.EOF
if NOT (IsNull(rsAlert("subdate")) or IsNull(rsAlert("entrydatetime")) ) then
if formatDateTime(rsAlert("subdate"),1) <> formatDateTime(rsAlert("entrydatetime"),1) then
if Writetableheadflag="Y" then
%>

<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
<tr bgcolor="#FFFFF0"> 
            <td colspan="2"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              ALERTS </font></font></b></div>
            </td>
          </tr>
<%

Writetableheadflag="N"
end if
response.write "<tr><td><font face='arial' size=1 color='#000000'>PLEASE CHECK  <B>"&UCASE(rsAlert("paxName"))&"</B> WITH REFNO "&rsAlert("refno")&" FOR SUBMISSION FROM EMBASSY OF  "
call writeIDDescription("Embassy",rsAlert("countryID"))
response.write ". </FONT></td><td><a href='editEntry.asp?refno="&rsAlert("refno")&"' >Edit</a></td></tr>"
End if 
end if
rsAlert.movenext
wend
rsAlert.close
'-------------FOR sent case
stmt ="select Entrydetails.Totalpax, paxstatus.entrydatetime, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.sentdate)="&day(today)&" and Month(paxstatus.sentdate)="&Month(today)&" and year(paxstatus.sentdate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"
rsAlert.open stmt,con
while not rsAlert.EOF

if NOT (IsNull(rsAlert("sentdate")) or IsNull(rsAlert("entrydatetime")) ) then
if formatDateTime(rsAlert("sentdate"),1) <> formatDateTime(rsAlert("entrydatetime"),1) then
if Writetableheadflag="Y" then
%>

<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
<tr bgcolor="#FFFFF0"> 
            <td colspan="2"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              ALERTS </font></font></b></div>
            </td>
          </tr>
<%

Writetableheadflag="N"
end if
response.write "<tr><td><font face='arial' size=1 color='#000000'>PLEASE CHECK  <B>"&UCASE(rsAlert("paxName"))&"</B> WITH REFNO "&rsAlert("refno")&" FOR SENDING THE VISA  OF  "
call writeIDDescription("Embassy",rsAlert("countryID"))
response.write ". </FONT></td><td><a href='editEntry.asp?refno="&rsAlert("refno")&"' >Edit</a></td></tr>"
End if 
End if 'closing is nullfor sentdate
rsAlert.movenext
wend
rsAlert.close


'response.write "paxname:"&rsAlert("paxName")&"<br>"

IF Writetableheadflag="N" THEN
response.write "</table>"
END IF
'end if 
End if
if Writetableheadflag="Y" then
%>
<table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
<tr bgcolor="#FFFFF0"> 
            <td colspan="2"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              ALERTS </font></font></b></div>
            </td>
            <tr bgcolor="#FFFFFF" > 
            <td colspan="2" BORDER=0> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font size="2" color="#000000">
             NO ALERTS FOR THE DAY </font></font></b></div>
            </td>
          </tr>
          </table>
<%end if
					%>	

                
                </td>
          
    </tr>
  <tr>
                <td><!-- #include file="empBottom.asp"--></td>
          
    </tr>
  
</table>

</body>
</html>
