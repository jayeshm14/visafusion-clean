<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<script language="javascript">
<!--
function CheckNum(var1)
{
if (isNaN(var1))
{
alert("Please enter a valid number.")
return false;
}
}

function putvalue1(var1)
{
CheckNum(var1)
document.entry.entries.value = document.entry.totalp.value
}
function checkAll()
{
getentries=document.entry.entries.value
gettotalp=document.entry.totalp.value
getcountry=document.entry.countrylist.value
flag=0
msg=""
if (isNaN(getentries))
{
msg=msg+"Please enter a valid number in the entries.\n"
flag=1
}
if (isNaN(gettotalp))
{
msg=msg+"Please enter a valid number in the Passengers.\n"
flag=1
}

if (getcountry=="")
{
msg=msg+"Please select a country.\n"
}
if (flag==1)
{
alert(msg)
return false;
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

<body onLoad="MM_preloadImages('images/submission2.jpg','images/edit2.jpg','images/reports2.jpg','images/visa2.jpg','images/advsearch2.jpg','images/collection2.jpg')">

<table width="75%" align="Center" border="0">
<tr><td align="Center" COLSPAN=2><font size="4" color="#000000" face="Arial, Helvetica, sans-serif"><b>
UDAAN INDIA PRIVATE LTD.</b></font></td></tr>
    
 <tr><td align="left"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b>Date: <%= formatDateTime(Now(),1) %> Time: <%= Time() %></b></font></td>
    
    <td align="right"><a href="javascript:print()">Print</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
    <a href="employee.asp">Show Image</a></td>
    </tr>
                  </table>

             
<form name=collection action="tasks.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
          <tr bgcolor="#FFFFFF"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#000000" face="Arial, Helvetica, sans-serif"><font color="#000000">
              TODAY's SUBMISSION </font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td > 
            
                    <table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" >
                      <tr> 
                        
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#FFFFFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Agent 
                                Name</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Total</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Country</b></font></td>
                                </tr>
                               
                            <%  
          
           
                  
            date1=date()-3
            today=date() 
 


taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.refno, paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.subdate)="&day(today)&" and Month(paxstatus.subdate)="&Month(today)&" and year(paxstatus.subdate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#FFFFFF'><td colspan=11 align=center><font face='arial' size=2 color='#000000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=CINT(rs.fields("paxID"))
refno=cint(rs.fields("refno"))
agent=cint(rs.fields("agent"))
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
response.write "<tr bgcolor='#FFFFFF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno &"&paxID="&paxID&"' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write "</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
call writeIDDescription("embassy",rs.fields("countryID"))
else 
call writeIDDescription("embassy",rs.fields("countryID"))
end if
response.write "<tr bgcolor='#FFFFFF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()
%> 

                          
                 
<form name=collection action="tasks.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> <br>
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
          <tr bgcolor="#FFFFFF"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#000000" face="Arial, Helvetica, sans-serif"><font color="#000000">
              TODAY's COLLECTIONS </font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" >
          
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1">&nbsp;</td>
                  <td width="560"> 
                    <table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                        
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#FFFFFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Agent 
                                Name</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Total</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Country</b></font></td>
                                </tr>
                            <%  
          
           
                  
            date1=date()-3
            today=date() 
 


taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.coldate)="&day(today)&" and Month(paxstatus.coldate)="&Month(today)&" and year(paxstatus.coldate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#FFFFFF'><td colspan=11 align=center><font face='arial' size=2 color='#000000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
receivedate=SysToUsrDate(rs.fields("receivedate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
response.write "<tr bgcolor='#FFFFFF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
call writeIDDescription("embassy",rs.fields("countryID"))
else 
call writeIDDescription("embassy",rs.fields("countryID"))
end if
response.write "<tr bgcolor='#FFFFFF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()
%> 
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td align="right" width="1"> &nbsp; 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
        </table>
      </td>
    </tr>
  </table>
  </form>
  
  <form name=collection action="tasks.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
          <tr bgcolor="#FFFFFF"> 
            <td> 
              <div align="center"><b><font size="3" color="#000000" face="Arial, Helvetica, sans-serif"><font color="#000000">
              TO BE SENT TODAY </font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" >
          
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1">&nbsp;</td>
                  <td width="560"> 
                    <table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                        
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#FFFFFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Ref 
                                #</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>PAX 
                                Name</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Agent 
                                Name</b></font></td>
                                <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Status</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Sent</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Collection</b></font></td>
                             <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Total</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Country</b></font></td>
                                </tr>
                            <%  
          
           
                  
            date1=date()-3
            today=date() 
 


taskdate=cdate(request.form("taskdate"))
set rs=server.createobject("adodb.recordset")
stmt ="select Entrydetails.Totalpax, paxstatus.refno,paxstatus.colcheck,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where day(paxstatus.sentDate)="&day(today)&" and Month(paxstatus.sentDate)="&Month(today)&" and year(paxstatus.sentDate)="&year(today)&" and paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno order by entryDetails.Paxname"
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#FFFFFF'><td colspan=11 align=center><font face='arial' size=2 color='#000000'>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
paxID=rs.fields("paxID") 
refno=rs.fields("refno") 
agent=rs.fields("agent")
sentdate=SysToUsrDate(rs.fields("sentdate"))
subdate=SysToUsrDate(rs.fields("subdate"))
coldate=SysToUsrDate(rs.fields("coldate"))
colcheck=rs.fields("colcheck")
if colcheck="chk" then
coldate="CHK-"& coldate
end if
response.write "<tr bgcolor='#FFFFFF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='Paxstatus.asp?refno="&refno & "&paxID="& paxID& "' >"&ucase(rs.fields("paxname"))&"</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'>"
call writeIDDescription("agents",agent)
response.write"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
call writeIDDescription("status",rs.fields("statusid"))
response.write"</a></font></td><td><font face='arial' size=2 color='#000000'>"&sentdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&subdate&"</font></td><td><font face='arial' size=2 color='#000000'>"&coldate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpax")&"</font></td><td>"
if cmd="country" then
call writeIDDescription("embassy",rs.fields("countryID"))
else 
call writeIDDescription("embassy",rs.fields("countryID"))
end if
response.write "<tr bgcolor='#FFFFFF'><td height=2 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()
%> 
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td align="right" width="1"> &nbsp; 
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
  </form>