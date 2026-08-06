
<script language="javascript">
<!--





function confirm1()
{
a1= document.searchform.keywords.value
a2= document.searchform.agent.value
a3= document.searchform.countryID.value
if (a1=="" &&  a3=="" )
{
conval=window.confirm("THIS WILL SHOW ALL THE DATA AND MAY TAKE TIME. CONTINUE???")
if(conval)
{
location.href="paxStatus.asp"
}
else
{
return false
}
}
}
//-->
</script>


<style type="text/css">
<!--
a {  font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #000000}
a:hover {  font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>

<table width="99%" border="0">
<%
agent=request("jn")

                            
 mydate=date()-90
 mydate1=date()-2
 mydate=Cdate(mydate)
 mydate1=Cdate(mydate1)
 today=date() 
if session("userid") <> "" then
agentID=session("userid")
else
if request("jn") <> "" then
agentID=Cint(request("jn"))

end if
end if

%>      
               </table>
<table width=780 border=0 align=center cellpadding=0 cellspacing=0><tr> 
    <td align=left valign=top background="images/bigtablebg.gif"> 
      <form>
        
<table width="742" border="0" align="center" cellpadding="0" cellspacing="0" height="199">
  <tr> 
            <td width="253" height="30">&nbsp;</td>
            <td width="490" height="30" align="right">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2" align="center" valign="top"> 
              <table width="700" border="0" cellpadding="0" cellspacing="0" class="tdborder">
                <tr> 
                  
          <td height="21" background="images/yellowbgband.gif" align="center"> 
            <p class="lbltext"><a href="Agent.asp?statustype=sub&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>">Submitted</a>&nbsp;| 
              <a href="Agent.asp?statustype=col&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>"> 
              Collected&nbsp;</a>| <a href="Agent.asp?statustype=pen&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>">Pending</a>&nbsp;| 
              <a href="Agent.asp?statustype=sen&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=<%=agentID%>">Sent</a>&nbsp;
            </p>
                  </td>
                </tr>
                <tr align="center"> 
                  <td height="21" bgcolor="BD402C"> 
                    <input type="hidden" name="seckey" value="xyz25g78M20422npr054416panftpRhjkslsktlsh456">
                    <input type="hidden" name="logonid" value="o9g67435jdpXZ">
                    <input type="hidden" name="usbmathura" value="o9g67435jdpXZ">
                    <input type="hidden" name="jn" value="<%=agentID%>" >
<div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">
                    Name: 
                    <input type="text " name="keywords" value="<%=request("keywords")%>" size=15 class=inputbox>
                    Country:  
                    <select name="countryID" size="1" class="dropdown">
                      <option value="">ALL</option>
                      <% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy","0")
	              	%> 
                    </select>
                    <input type="submit" value="GO" class="ud" name="submit"></font></div>
                  </td>
                </tr>
                <tr align="center"> 
                  <td height="20" valign="top" bgcolor="BD402C">&nbsp;</td>
                </tr>
                
        <tr align="center" bgcolor="BD402C"> 
          <td height="20" valign="top"> 
            <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
                      <tr> 
                        <td> 
                      <tr > 
                        <td colspan=8 align="center"> 
                          
                  <table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" >
                    <tr> 
                      <td height="2"> 
                        <div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">PAX 
                          STATUS </font></b></div>
                              </td>
                            </tr>
                            
                    <tr> 
                      <td height="19">
                      </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td height="2"> 
                          <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                  <tr> 
                                    <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                                    <td width="560"> 
                                      <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                                        <tr> 
                                          <table width="658" border="0" align="center">
                                            <tr> 
                                              <td width="70" height="25" align="right" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Ref#</p>
                                              </td>
                                              <td width="120" height="25" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">PAX 
                                                  Name </p>
                                              </td>
                                              <td width="150" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Agent 
                                                  Name</p>
                                              </td>
                                              <td width="60" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Status</p>
                                              </td>
                                              <td width="70" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Received</p>
                                              </td>
                                              <td width="70" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Submit</p>
                                              </td>
                                              <td width="70" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Collection</p>
                                              </td>
                                              <td width="60" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Total</p>
                                              </td>
                                              <td width="70" align="left" bgcolor="#FBBD06"> 
                                                <p class="dynamicheadingagent">Country</p>
                                              </td>
                                            </tr>
                                            <%  
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and Mainentry.Agent ="&agentID&"  and entrydetails.refno=mainentry.refno and entryDetails.Paxname LIKE '%"&request("keywords")&"%' order by entryDetails.refno desc"

if agentID<>""  and  request("keywords")<>"" then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&agentID&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' order by entryDetails.refno desc"
end if 

if agentID<>""  and  request("keywords") = "" then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&agentID&" and (paxstatus.sentdate > '"&mydate1&"' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if 

if agentID<>""  and  request("keywords") = "" and request("usbmathura")<>"" then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent ="&agentID&" and (paxstatus.sentdate > '"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if 

if request("countryID")<>""  then
countryID=Cint(request("countryID"))
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno  and Mainentry.Agent ="&agentID&"  and paxstatus.countryID="&countryID&" and paxstatus.Subdate >"& mydate&" order by entryDetails.refno desc"
end if 

if request("countryID")<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&"   and Mainentry.Agent ="&agentID&"  and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and paxstatus.Subdate >"& mydate&" order by entryDetails.refno desc"
end if 

if request("countryID")<>"" and agentID<>"" then
countryID=Cint(request("countryID"))
agentID=Cint(agentID)
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and (paxstatus.sentdate > '"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if 

if request("countryID")<>"" and agentID<>"" and  request("keywords")<>"" then
countryID=Cint(request("countryID"))
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID="&countryID&" and Mainentry.Agent="&agentID&" and entryDetails.Paxname LIKE '%"&request("keywords")&"%' and (paxstatus.sentdate > '"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if 

if request("sc_sdate")<>"" and agentID<>"" and  request("sc_edate")<>"" then
countryID=Cint(request("countryID"))

sdate=cdate(request("sc_sdate"))
edate=cdate(request("sc_edate"))
'stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and paxstatus.Subdate >='"& sdate&"' and  paxstatus.Subdate <='"& edate&"'  order by entryDetails.refno desc"
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent="&agentID&"  and paxstatus.Subdate >=01/01/01 and  paxstatus.Subdate <=5/5/01  order by entryDetails.refno desc"
end if 

if request("statustype") = "col" then
colStatusID=getIDForDescription("status","Collected")
if  agentID<>""  then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID="&colStatusID&"  and Mainentry.Agent="&agentID&"  order by entryDetails.refno desc"
end if 
end if

if request("statustype") = "sub" then
colStatusID=getIDForDescription("status","Submitted")
if  agentID<>""  then

stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID="&colStatusID&"  and Mainentry.Agent="&agentID&"  order by entryDetails.refno desc"
end if 
end if

if request("statustype") = "sen" then
colStatusID=getIDForDescription("status","Sent")
if  agentID<>""  then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID="&colStatusID&"  and Mainentry.Agent="&agentID&" and (paxstatus.sentdate > '"&mydate&"' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if 
end if

if request("statustype") = "pen" then
if  agentID<>""  then
stmt ="select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID>400 and paxstatus.statusID<500  and Mainentry.Agent="&agentID&"  order by entryDetails.refno desc"
end if 
end if
'response.write stmt
rs.open stmt,con
if agentID <>"" then 
if rs.eof then 
response.write "<tr><td colspan=11 align=center bgcolor='BD402C'><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
check=rs.fields("colcheck")

if check="chk" and coldate<>"" then
coldate="CHK - "&coldate
end if

response.write "<tr><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&refno
poe=rs.fields("poe")
if poe<>"1" then
poe=getDescriptionForID("poe",poe)
response.write("<br><b><font color='red'>"&poe&"</font></b>")
end if
response.write "</font></td>"
'response.write "<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'><a href='AgentPaxstatus.asp?refno="&refno & "&paxID="& paxID&  "&jn="& agentID&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'><a href='AgentPaxstatus.asp?refno="&refno & "&paxID="& paxID&  "&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn="&agentid&"&ses=k3456l7dj9javyemsn&company=udaan"&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&receivedate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&subdate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&coldate&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"&rs.fields("totalpax")&"</font></td><td width='70' height='25' align='right' bgcolor='BD402C'><p class='dynamictext1'>"
if cmd="country" then
'response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
'response.write "</a>"

else 
'response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
'response.write "</a>"

end if

'response.write "<tr bgcolor='#F0F0FF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
else
'response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>PLEASE LOG IN AGAIN</font></td></tr>" 
end if

rs.close()
%> 
                                          </table>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  
          </td>
                </tr>
              </table></form>
              </td></tr>
</table>