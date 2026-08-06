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

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
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

         
                          
      <div align="center">
                              <form name="searchform" action="agent.asp" >
                              <input type="hidden" name="seckey" value="xyz25g78M20422npr054416panftpRhjkslsktlsh456">
                              <input type="hidden" name="logonid" value="o9g67435jdpXZ">
                              <input type="hidden" name="usbmathura" value="o9g67435jdpXZ">
                              <input type="hidden" name="jn" value="<%=agentID%>" >
                             
                              <span class="WSRightBold">Name:</span><input type="text " name="keywords" value="<%=request("keywords")%>" SIZE=15>
                              
                                <span class="WSRightBold">Country:</span>
                                <select name="countryID" size="1">
                                 <option value="">ALL</OPTION>
                          <% 
                          			countryID=request("countryID")
                                             
						if Isnull(countryID) or IsEmpty(countryID) or countryID="" then
						countryID=0
						End If
	             	 			call loadlistbox("embassy","0")
	              	%> 
                        </select>
                                
                              <input type="submit" value="GO" class="ud">
                            </form>  
</div>
  
      
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
       <tr > 
                              <td colspan=8 align="center">
                              


                            
        <table width="85%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099">
              CURRENT PAX  STATUS </font></font></b></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <b><font size="2" face="Arial, Helvetica, sans-serif" color="red">
              <MARQUEE BEHAVIOR="ALTERNATE">CLICK PAX NAME TO KNOW THE VISA CASE HISTORY </MARQUEE></font></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000C80">
          <tr> 
            <td><img src="images/linetop.jpg" width="660" height="13"></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="0" bgcolor="#FFFFF8" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                 
                          <table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
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
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
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

response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno
poe=rs.fields("poe")
if poe<>"1" then
poe=getDescriptionForID("poe",poe)
response.write("<br><b><font color='red'>"&poe&"</font></b>")
end if
response.write "</font></td>"
'response.write "<td><font face='arial' size=2 color='#000000'><a href='AgentPaxstatus.asp?refno="&refno & "&paxID="& paxID&  "&jn="& agentID&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='AgentPaxstatus.asp?refno="&refno & "&paxID="& paxID&  "&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn="&agentid&"&ses=k3456l7dj9javyemsn&company=udaan"&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
'response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
'response.write "</a>"

else 
'response.write "<a href='collectionFormAgentPaxCountry.asp?refno="&refno&"&paxID="&paxID&"&agent="&agent&"&country="&rs.fields("countryID")&"&pname="&rs.fields("paxname")&"' > "
call writeIDDescription("embassy",rs.fields("countryID"))
'response.write "</a>"

end if

response.write "<tr bgcolor='#F0F0FF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
else
response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>PLEASE LOG IN AGAIN</font></td></tr>" 
end if

rs.close()
%> 
                          </table>
                         
                        </table></td>
                      </tr>
                    </table>
                    
                  </td>
                  <td align="right" width="1"> <img src="images/pixelsline.gif" width="1" height="7"> 
                  </td>
                </tr>
              </table>
                          </td>
          </tr>
          <tr> 
            <td align="center"><img src="images/linebottom.jpg" width="660" height="13"></td>
          </tr>
        </table>
         