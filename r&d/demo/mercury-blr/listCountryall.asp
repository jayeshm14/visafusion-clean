 <table width="75%" border="1" align="center">
                <tr bgcolor="#CCCCFF"> 
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref #</b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Rec Date</b></font></td>
		  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submition</b></font></td>
		  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>

                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                    Name</b></font></td>
                  
                   
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                    Name</b></font></td>

                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                </tr>
                <%  
              'refno=request("refno")
            'date1=cdate(request.form("date1"))
            'coldate=cdate(request.form("date1"))
            'agent=request.form("agentlist")
            date1=date()
 set rs=server.createobject("adodb.recordset")
 set rs1=server.createobject("adodb.recordset") 

'stmt="select * from (select Mainentry.refno, Mainentry.agent, entrydetails.passengername, entrydetails.cname from Mainentry, entrydetails,paxstatus where entrydetails.refno=Mainentry.refno ) order by entrydetails.cname,Mainentry.agent"
stmt="select Mainentry.refno, Mainentry.receivedate, Paxstatus.subdate, Paxstatus.coldate, Mainentry.agent, entrydetails.paXname, entrydetails.paxID,paxstatus.countryID from Mainentry, paxstatus, entrydetails where paxstatus.refno=mainentry.refno and paxstatus.paxid=entrydetails.paxid order by Mainentry.refno, Mainentry.agent, entrydetails.paxname"

rs.open stmt,con
 
if rs.eof then 
response.write "<tr><td colspan=8><font size=2 color=#0000CC>Data not found.</font></td></tr>" 
else 

while not rs.eof
refno=cint(rs.fields("refno"))
stmt1="select * from paxstatus where refno=" & refno 
response.write "<tr><td>" & rs("refno") & "</td><td>" & rs("receivedate")& "</td><td>" & rs("subdate")& "</td><td>" & rs("coldate")&"</td><td>&nbsp;<a href=showStatus.asp?refno="& rs("refno") & ">" & ucase(rs("paxname"))&"</a></td><td>" 
call writeIDDescription("agents",rs("agent")) 
response.write  "</td><td><font size='3' color='#CC0000'>" 
call writeIDDescription("embassy",rs("countryID"))
response.write  "</font></td></tr>"

rs.movenext

wend

end if
rs.close()
%> 
              </table>
