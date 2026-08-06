 <table width="75%" border="1" align="center">
                <tr bgcolor="#CCCCFF"> 
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref #</b></font></td>
                  <td><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>STATUS</b></font></td>
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
            country=cint(request.form("countrylist"))
            
            date1=date()
 set rs=server.createobject("adodb.recordset")
 set rs1=server.createobject("adodb.recordset") 
set rsp=server.createobject("adodb.recordset") 
'stmt="select * from (select Mainentry.refno, Mainentry.agent, entrydetails.passengername, entrydetails.paxID from Mainentry, entrydetails where entrydetails.refno=Mainentry.refno ) order by entrydetails.paxID,Mainentry.agent"
'stmt="select Mainentry.refno, Mainentry.receivedate, Mainentry.subdate, Mainentry.coldate, Mainentry.agentsID, entrydetails.paxname, entrydetails.paxID from Mainentry, entrydetails where entrydetails.c='"&request("countrylist")&"' and entrydetails.refno=Mainentry.refno order by entrydetails.cname,Mainentry.agent,entrydetails.passengername,Mainentry.refno"
stmt="select * from paxstatus where countryID=" & country
 rs.open stmt,con

if rs.eof then 
response.write "<tr><td colspan=8><font size=2 color=#0000CC>Data not found.</font></td></tr>" 
else 
 while not rs.eof
 pax=cint(rs.fields("paxID"))
 refno=cint(rs.fields("refno"))
stmtagent="select * from mainentry where refno=" & refno 
rs1.open stmtagent,con
stmtname="select * from entrydetails where paxID=" & pax 

rsp.open stmtname,con


response.write "<tr><td>" & rs("refno") & "</td><td>" 
call writeIDDescription("status", rs("statusID"))
response.write "</td><td>" & rs("subdate")& "</td><td>" & rs("coldate")&"</td><td><a href=showStatus.asp?refno="& rs("refno") & ">"& rsp.fields("paxname")& "</a></td><td>" 
call writeIDDescription("agents",rs1("agent"))
response.write "</td><td><font size='3' color='#CC0000'>"
call writeIDDescription("embassy",rs("countryID")) 
response.write"</font></td></tr>"

rs.movenext
rsp.close
rs1.close
wend

end if
rs.close()
%> 
              </table>
