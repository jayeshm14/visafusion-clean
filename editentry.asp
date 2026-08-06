<!-- #include file="connection.asp" -->
<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

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
                <td><!-- #include file="top.asp" --></td>
              </tr>
                    <tr> 
                      <td colspan="6" align="center"><b><font size="3" color="#CC0000">EDIT  
                        FORM</font></b> </td>
                    </tr>
                   
                
                  
                </td>
              </tr>
           
<form name=collection action="editEntrySubmit.asp" method="post">
<input type="hidden" name="username" value="<%= session("uname")%>" >

<%
refno=cdbl(request("refno"))
categoryid=getIDForDescription("category","Attestation")
set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rsStatus=server.createobject("adodb.recordset")
set rscountry=server.createobject("adodb.recordset")
set rsinvoice=server.createobject("adodb.recordset")
set rscert=server.createobject("adodb.recordset")

'if IsNumber(refno) then
stmt="select * from mainEntry where refno="&refno
'else
'stmt="select * from mainEntry"
'end if
rs.open stmt,con,2,3
if rs.eof then
response.write "<font size=2 color=#0000CC> Please check the reference number.</font>"
else
bill = rs.fields("bill")
agent=rs.fields("agent")
refname=rs.fields("refferer")
recdate=rs.fields("receivedate")
travdate=rs.fields("traveldate")
if rs.fields("sentdate")<>""  then
sentdate=SysToUsrDate(rs.fields("sentdate"))
end if
pname=rs.fields("paxname")
dob=rs.fields("dateofbirth")
passport=rs.fields("passportno")
entries=rs.fields("entries")
company=rs.fields("companyname")
totalp=rs.fields("totalpassengers")
subdate=rs.fields("subdate")
coldate=rs.fields("coldate")
category=rs.fields("category")
attestation=rs.fields("attestation")
poe=rs.fields("poe")
entrytype=rs.fields("entrytype")
status=rs.fields("status")
externalremark=rs.fields("externalremark")
internalremark=rs.fields("internalremark")
clientmessage=rs.fields("Agentinstruction")
%> 
              <table width=75% border=0 cellspacing=1 cellpadding=1 align="center">
                <tr> 
                  <td colspan="2"><font size="2" color="#0000CC"><b>Date: <% response.write(formatdatetime(now(),1))%></b></font></td>
                  <td colspan="2"><font size="2" color="#0000CC"><b>Refrence Number: 
                    <%= refno %> 
                    <input type="hidden" name="refno" value="<%= refno %>" ></b></font></td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Agent</b></font></td>
                  <td colspan=3> <font size="2" color="#006600"><b>
	<%  if rs.fields("bill")="Y" and session("uname")<>"uma" then
		Call WriteIDDescription("agents",agent) %> <input type="hidden" name="agentlist" value=<%=agent%> >
	<% else %>
                   <select size=1  name="agentlist">
                      <%
Call LoadFullListBox("agents",agent)

%> 
                    </select>
<% end if %>
                    </b></font>
                    
                    <input type="hidden" name="entries" value=<%=entries %> >
                    
                    
                    </td>
                </tr>
                           
                  <tr> 
                    <td><font size="2" color="#0000CC"><b>Refferer Name</b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="refname" value="<%=ucase(refname) %>" >
                      </b></font></td>
                    <td><font size="2" color="#0000CC"><b>Company / File No.</b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="company" value="<%=ucase(company) %>" >
                      </b></font></td>
                  <tr> 
                    <td><font size="2" color="#0000CC"><b>PAX Name</b></font></td>
                    <td> <font size="2" color="#006600"><b> 
                      <input type="text" name="pname" value="<%=ucase(pname) %>" >
                      </b></font></td>
                    <td><font size="2" color="#0000CC"><b>Receive date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="recdate" value="<%=SysToUsrDate(recdate) %>" size="10">
                      </b></font></td>
                      
                  </tr>
                  
                  
                  
                  <tr> 
                    
                    <td><font size="2" color="#0000CC"><b>POE/ECNR </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <select name="poe" size="1">
                    
                      <%
                  'call LoadListBox("poe",poe)
                  %> 
					<option value=1 Selected>NONE</option>
                    </select>
                      
                      </b></font></td>
                    <td><font size="2" color="#0000CC"><b>Travel date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="travdate" value="<%=SysToUsrDate(travdate) %>" size="10">
                      </b></font></td>
                  </tr>
                  <tr> 
                    
                    <td><font size="2" color="#0000CC"><b>Status</b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <select size=1  name="status" >
                      <%
Call LoadListBox("status",status)

%> 

                      
                      </b></font></td>
                      <td><font size="2" color="#0000CC"><b>TOTAL PAX</b></font></td>
                      <td><input type="hidden" name="totalp" value="<%=totalp %>" ><font size="2" color="#0000CC"><b><%= totalp %></b></font> </td>                 
                  </tr>
                  
               
                
                
                </tr>
                <tr bgcolor="#F0F0FF" > 
                  <td colspan=4><font size="2" color="#0000CC"><b>
	<%  if rs.fields("bill")="Y" and session("uname")<>"uma" then    %>
		     YOU CAN NOT ADD MORE PAX, BILL HAVE FORMED.
	<% else %>
                     <a href="addMorePAX.asp?refno=<%= refno %>"> To ADD MORE PAX CLICK HERE</a>.
	<% end if %>                                 
                     </b></font>
                     
                     </td>
                </tr>
<%
i=0

countrylist=""

GetALLData="select * from entrydetails where  refno="&refno &" Order by paxname"
rscountry.activeconnection=con
rscountry.open GetALLData,con
while not rscountry.eof

pname1=rscountry.fields("paxname")
PaxID=rscountry.fields("Paxid")
totalp11=rscountry("totalpax")
passno11=rscountry("passportno")
pax_dob=rscountry("dateofbirth")

i=i+1
%>
		<tr> 
                  <td colspan="4" width=75%> 
                    <hr>
                  </td>
                </tr>
		<tr> 
                  <td colspan="4"> 
                    <div align="center"><font size="2" color="#0000CC"><b>PLEASE
                      ENTER THE INFORMATION REGARDING <font size="3" color="#006600"><b> 
                      <%= ucase(pname1) %></b></font> 
                      </b></font> </div>
                      <input type="hidden" name="paxid<%=i%>" value="<%=paxID %>" >
                  </td>
                </tr>
                <tr> 
                  <td colspan="1"> 
                    <font size="2" color="#0000CC"><b>PAX Name</b></font> </div>
                      
                  </td>
                  <td colspan="3"> 
                    <div align="center"><font size="2" color="#0000CC"><b></b></font> </div>
                     
                      <input type="text" name="pname<%=i%>" value="<%=ucase(pname1)  %>" >
                  </td>
                </tr>
                <tr> 
                  <td colspan="1"> 
                    <font size="2" color="#0000CC"><b>Passport Number </b></font> </div>
                      
                  </td>
                  <td colspan="3"> 
                    <div align="center"><font size="2" color="#0000CC"><b></b></font> </div>
                    
                      <input type="text" name="passport<%=i%>" value="<%= ucase(passno11) %>" >
                  </td>
                </tr>
                <tr> 
                  <td><font size="2" color="#0000CC"><b>Date Of Birth </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="dob<%=i%>" value="<%=SysToUsrDate(pax_dob) %>" >
                      
      </b></font>
                  <td > 
                    <div align="center"><font size="2" color="#0000CC"><b></b></font> </div>
                      <input type="hidden" name="totalp<%=i%>" value="<%= totalp11 %>" size=4 >
                  </td>
                </tr>
<%
getinvoice="select * from paxstatus where  PaxID="&PaxID
rsInvoice.open getinvoice,con
l=0
while not rsInvoice.EOF 
l=l+1
temp_countryID=rsinvoice.fields("countryID")
temp_ddcharges=rsInvoice("ddcharges")
temp_handlingfee=rsInvoice("handlingfee")
temp_visafee=rsInvoice("visafee")

temp_colcheck=rsInvoice("colcheck")
temp_entrytype=rsInvoice("entrytype")
temp_total=rsInvoice("total")
temp_subdate=SysToUsrDate(rsInvoice("subdate"))
temp_coldate=SysToUsrDate(rsInvoice("coldate"))
temp_sentdate=SysToUsrDate(rsInvoice("sentdate"))
%>
                
   
    		
    		
   <tr> 
                  <td colspan="4"> 
                    <div align="left"><font size="2" color="#0000CC"><b>
                      <font size="3" color="#006600"><b> 
                      <%= ucase(pname1) %></b></font> FOR COUNTRY
                      <%
                      call writeIDDescription("embassy", temp_countryID) 
                      %> </b></font> </div>
                     <input type=hidden name="country<%=i&l%>" value="<%=temp_countryID%>">
                  </td>
                </tr>            
                  
                       <% 
                       certcount=0
                      
                      if categoryid=category then
                      
                      stmt="select * from paxAttestation where paxID="&PaxID&" and countryID="&rsinvoice.fields("countryID")
                      rscert.open stmt,con
                      if not rscert.eof then
                      response.write "<tr><td valign='top'><font size='2' color='#0000cc'><b> CERTIFICATES:</b></font></td><td colspan=3><font size='2' color='#006600'><b> " 
                      while not rscert.eof
                        certcount=certcount+1
                      response.write "<input type=checkbox name=CertificateID"&i&l&certcount& " value="&rscert("certificateID")&" checked>"
                      call writeIDDescription("certificate",rscert("certificateID"))
                       response.write " ( "
                       call writeIDDescription("Attestation",rscert("AttestationID"))
                       response.write ")<br> "
                       temp_Attestation=rscert("AttestationID")
                       rscert.movenext
                     
			wend
			 response.write " </b></font></td></tr>"
			
			End if
			rscert.close
	                response.write "<tr><td colspan='4' align='right'> <font size=""1"" color=""#0000CC""><b>TO ADD MORE CERTIFICATE(S)<a href=addMoreCertificate.asp?refno="&refno&"&paxID="&paxID&"&country="&temp_countryID&"&pname="&pname1&">CLICK HERE</a></b></font>"
			end if
                      %>
                      	 <tr> 
                      	  <input type=hidden name="totalcert<%=i&l%>" value="<%=certcount%>">
                      	<td> 
                    <font size="2" color="#0000CC"><b>Country:</b></font> </div>
                      
                  </td>
                  <td > 
                   <font size="2" color="#000000"><b>
                      	<%
			
					
                      call writeIDDescription("embassy", temp_countryID) 
                     
                      %>
			
			
			</b></font> </td><td  colspan="2"><font size="2" color="#0000CC"><b>
<% if temp_total=0 or isnull(temp_total) then %>
<% if rs.fields("bill")="Y" and session("uname")<>"uma" then %>
YOU CAN'T REMOVE COUNTRY AFTER BILLING.
<% ELSE %>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(TO REMOVE THIS COUNTRY CLICK <A HREF="javascript:removeCountry<%=i&l%>()" >HERE</a>)
<% end if %>
<% end if %>
</b></font>
			</td>
			</tr>
			<tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Status for 
                  <%  call writeIDDescription("embassy", temp_countryID) 
                      %></b></font></td>
                  <td width="30%"> <font size="2" color="#006600"><b> 
                   <input type="hidden" name="oldstatus<%=i&l%>" value="<%= rsinvoice.fields("statusID")%>" >
                   <select name="status<%=i&l%>" size="1">
                      
                     <%
Call LoadListBox("status",rsinvoice.fields("statusID"))

%> 

                      
                    </select>
                    </b></font>
                    </td>
                    
                   <% if categoryid=category then %>
                       
                    
                  <td width="25%"><font size="2" color="#0000CC"><b>Attestation Type</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b>
                  
                  
                  
                  <select name="AttestationID<%=i&l%>" size=""1"">"
	  <% Call LoadListBox("Attestation",temp_Attestation) %>
                                          
		</SELECT>
                   &nbsp;
                     </b></font></td>
                     <% else %>
                     <td width="25%"><font size="2" color="#0000CC"><b>Entry Type</b></font></td>
                  <td width="19%"> <font size="2" color="#006600"><b>
                  
                  
                  
                  <select name="entrytype<%=i&l%>" size=""1"">"
	  <% Call LoadListBox("entrytype",temp_entrytype) %>
                                          
		</SELECT>
                   &nbsp;
                     </b></font></td>
                     
                     <%end if %>
                </tr>
                <tr> 
                <td><font size="2" color="#0000CC"><b>Sent date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="sentdate<%=i&l%>" value="<%=temp_sentdate %>" >
                      </b></font></td>
                       <% if not categoryid=category then
                       %>
                                <td> <font size="2" color="#006600"><b>Category </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <select name="categorymain<%=i&l%>" size="1">
                      <%
                  call LoadListBox("category",rsinvoice.fields("category"))
                  %> 
                    </select>
                    <%
                    end if
                    %>
                      </b></font></td>
                     
                      
      </b></font> </td></tr>
                    
                  <tr> 
                    <td><font size="2" color="#0000CC"><b>Submit Date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="subdate<%=i&l%>" value="<%=temp_subdate %>" size="10">
                      </b></font></td>
                    <td><font size="2" color="#0000CC"><b>Collection Date </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="coldate<%=i&l%>" value="<%=temp_coldate %>" size="10">
                      CONF.<input type=radio name="colcheck<%=i&l%>"  value='conf'
                      <% if temp_colcheck="conf" then 
                      response.write " Checked"
                      End if 
                      %>
                       >CHK.<input type=radio name="colcheck<%=i&l%>"  value='chk' 
                       <% if temp_colcheck="chk" then 
                      response.write " Checked"
                      End if 
                      %>
                      > 
                      </b></font></td>
                  </tr>
                <tr> 
                  <td width="20%"><font size="2" color="#0000CC"><b>Remarks for<%  call writeIDDescription("embassy", temp_countryID)%> </b></font></td>
                  <td width="80%" colspan=3> <font size="2" color="#006600"><b> 
                    <input type="text" name="remark<%=i&l%>" value="<%= ucase(rsinvoice.fields("remarks")) %>" size="70" ><br>
		    
                  </td>
                </tr>
                <tr > 
                  <td width="20%"><font size="2" color="#0000CC"><b>&nbsp;</b></font></td>
                  <td width="80%" colspan=3 bgcolor="#F0F0FF"> <font size="2" color="#006600"><b> 
                    
                     
                     
<script language="javascript">
function remove<%=i%>()
{
conval=window.confirm("All information regarding <%=ucase(pname1)  %> will be deleted. Are you Sure?")
if(conval)
{
location.href="removePAX.asp?refno=<%= refno %>&paxid=<%= paxid %>&pname=<%=pname1  %>&totalp=<%=totalp11  %>"
}
}
function removeCountry<%=i&l%>()
{
conval=window.confirm("All information regarding <%=ucase(pname1)  %>  for this Country will be deleted. Are you Sure?")
if(conval)
{
location.href="deletePaxCountry.asp?refno=<%=refno%>&countryID=<%=temp_countryID%>&PaxID=<%=PaxID%>"
}
}
</script>
                     
                    
                     
                     <%
		        rsinvoice.movenext
		        wend
			%>
<% if rs.fields("bill")="Y" and session("uname")<>"uma" then %>
CAN'T ADD COUNTRY AFTER BILL FORMED
<% else %>
		         <a href="addMoreCountry.asp?refno=<%= refno %>&paxid=<%= paxid %>&pname=<%=pname1  %>&totalp=<%=totalp11  %>"> TO ADD MORE COUNTRY(s) CLICK HERE</a>.
<% end if %>
                     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% if temp_total=0 or isnull(temp_total) then %>
<% if rs.fields("bill")="Y" and session("uname")<>"uma" then %>
CAN'T DELETE COUNTRY AFTER BILL FORMED
<% else %>
                      <a href="javascript:remove<%=i%>()"> TO DELETE THIS PAX CLICK HERE</a>.
<% end if %>
<% end if %>
			<input type="hidden" name="totalcountry<%=i%>" value="<%=l%>"  >
			<%
			rsinvoice.close()
	
                        rscountry.movenext
                        wend 
                        rscountry.close()
              
                        end if

                        %>
               

                
                     </b></font> </td>
                     
                
               <tr> 
                  <td colspan="4" width=75%> 
                    <hr>
                  </td>
                </tr> 
                
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Internal Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols=50 rows=5 name="internalrem"><%= ucase(internalremark) %></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Client Remarks</b></font></td>
                  <td colspan="2"> 
                    <textarea cols=50 rows=5 name="externalrem"><%= ucase(externalremark) %></textarea>
                  </td>
                  <td width="19%"></td>
                  <td width="5%"><font color="#006600"></font></td>
                </tr>
                <% 'if clientmessage<>"" then %>
                <tr> 
                  <td width="21%"><font size="2" color="#0000CC"><b>Insurance Remark</b></font></td>
                  <td colspan="2"> 
        <input type="text" name="instruction" value="<%=ucase(clientmessage)%>" size="66" >
                  </td>
                  <td width="19%"></td>
                  <td width="5%"><font color="#006600"></font></td>
                </tr>
		<% 'end if %>
                <tr> 
                  <td colspan="2"> 
                    <div align="right"> <font size="2" color="#0000CC"><b> 

                      <input type="hidden" name="ivalue" value="<%=i%>">
<% if session("priv")="adm" then %>
                     <input type="submit" value="Submit" id=submit1 name=submit1>
<% end if %>
                      </b></font></div>
                  </td>
                  <td colspan="2"> <font size="2" color="#0000CC"><b> 
                    <!--<input type="reset" value="reset"   name=reset1>-->
                    </b></font></td>
                </tr>
                <tr> 
                  <td colspan="2"></td>
                  <td colspan="2"></td>
                </tr>
              </table>
              
            </form>
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
