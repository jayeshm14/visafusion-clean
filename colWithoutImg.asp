<!-- #include file="connection.asp" -->
<html>
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

<body BGCOLOR="#FFFFFF">
<table width="99%" align="Center" border="0">
<tr><td align="Center" COLSPAN=2><font size="4" color="#000000" face="Arial, Helvetica, sans-serif"><b>
UDAAN INDIA PRIVATE LTD.</b></font></td></tr>
    
 <tr><td align="left"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b>Date: <%= formatDateTime(Now(),1) %>
  </b></font></td>
    
    <td align="right"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b>
    Time: <%= Time() %> </b></font></td>
    </tr>
                  </table>
	<%
             cmd=request("cmd")
        %> 
<table width="99%" border="0">
  
  <tr> 
     
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=today">Today's</a></div>
    </td>
    <td> 
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=all">Show All</a></div>
    </td>
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=agent">Agent Wise </a></div>
    </td>
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=date">Date Wise</a></div>
    </td>
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=status">Status Wise</a></div>
    </td>
    <td> 
      <div align="center"><a href="ColWithoutImg.asp?cmd=notsent">Pending</a></div>
    </td>
    <td> 
      <div align="center"><a href="javascript:print()">Print</a> </div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=<%= cmd %>">Show Images</a></div>
    </td>
  </tr>
</table>
             
<form name=ColWithoutImg action="collectionform.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFFF"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000000">
              <% if cmd="date" then
              response.write"COLLECTION RESULTS (DATE WISE)"
              END IF
              if cmd="today" then
              response.write"COLLECTION RESULTS (TODAY)"
              END IF
              if cmd="agent" then
              response.write"COLLECTION RESULTS (AGENT WISE)"
              END IF
              if cmd="status" then
              response.write"COLLECTION RESULTS (STATUS WISE)"
              END IF
              if cmd="notsent" then
              response.write"COLLECTION RESULTS (PENDING)"
              END IF
              if cmd="all" then
              response.write"COLLECTION RESULTS (ALL CASES)"
              END IF
              if cmd="" or isNull(cmd) then
              response.write"COLLECTION RESULTS (REFNO. WISE)"
              end if
              %> </font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
                      <tr> 
                        <td>
                          <table width="658" border="1" align="center">
                            <tr bgcolor="#FFFFFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Ref 
                                #</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Collection</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>PAX 
                                Name</b></font></td>
                              <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Total</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Agent 
                                Name</b></font></td>
                              <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Status</b></font></td>
                              <td width="33"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Sent</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#000000"><b>Country</b></font></td>
                              
                            </tr>
                            <%  
               
            date1=date()-3
            today=date() 
 if cmd="all" then
' Stmt="select * from Mainentry  order by refno desc"
 end if
 if cmd="agent" then
 'stmt="select * from Mainentry  where (Day(subdate)>"&day(date1)&" and month(subdate)>="&month(date1)&" and year(subdate)="&year(date1)&") order by agent"
 stmt="select * from Mainentry  where receivedate>#"&date1 &"# order by agent"
 end if
 if cmd="date" then
 'stmt="select * from Mainentry  where (Day(subdate)>="&day(date1)&" and month(subdate)>="&month(date1)&" and year(subdate)="&year(date1)&") order by receivedate desc"
 stmt="select * from Mainentry  where receivedate>#"&date1 &"# order by receivedate desc"
 end if
 if cmd="today" then
 stmt="select * from Mainentry  where (Day(receivedate)="&day(today)&" and month(receivedate)>="&month(today)&" and year(receivedate)="&year(today)&") order by refno desc"
 stmt="select * from Mainentry where receivedate>#"&today &"# order by refno desc"
 end if
 if cmd="" or isNull(cmd) then
  'stmt="select * from Mainentry where Day(subdate)>"&day(date1)&" and month(subdate)>="&month(date1)&" and year(subdate)="&year(date1)&" order by refno desc"
  stmt="select * from Mainentry where receivedate>#"&date1 &"# order by refno desc"
 end if
 if cmd="status" then
 'stmt="select * from Mainentry  where (Day(subdate)>="&day(date1)&" and month(subdate)>="&month(date1)&" and year(subdate)="&year(date1)&") order by status"
 stmt="select * from Mainentry  where receivedate>#"&date1 &"# order by Status"
 end if
 if cmd="notsent" then
 Stmt="select * from Mainentry  where status >400 and status <500 order by refno desc"
 end if

set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset") 

rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor='#FFFFFF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else 

while not rs.eof
refno=rs.fields("refno")  
intremark=rs.fields("internalremark")   
retrieveremark=rs.fields("AgentInstruction")  
agent=rs("agent")
status=rs("status")
recdate=rs.fields("receivedate")
if  recdate <> "" then
recdate=day(recdate)&"/"&Month(recdate)&"/"&year(recdate)
End if

subdate=rs.fields("subdate")
if  subdate <> "" then
subdate=day(subdate)&"/"&Month(subdate)&"/"&year(subdate)
End if

coldate=rs.fields("coldate")
if  coldate <> "" then
coldate=day(coldate)&"/"&Month(coldate)&"/"&year(coldate)
End if
sentdate=rs.fields("sentdate")
if  sentdate <> "" then
sentdate=day(sentdate)&"/"&Month(sentdate)&"/"&year(sentdate)
End if
response.write "<tr bgcolor='#FFFFFF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td><td><font face='arial' size=2 color='#000000'>"& recdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& subdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& coldate &"</font></td><td><font face='arial' size=2 color='#000000'>"&ucase(rs.fields("paxname"))&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("totalpassengers")&"</font></td><td><font face='arial' size=2 color='#000000'>"
call writeIddescription("agents",agent)
response.write "</font></td><td><font face='arial' size=2 color='#000000'>"
if status <> "" then
call writeIddescription("status",status)
end if
response.write "</font></td><td><font face='arial' size=2 color='#000000'>&nbsp;"& sentdate &"&nbsp;</font></td><td>"

set rs2=server.createobject("adodb.recordset")
Tempstmt="select distinct(countryID) from PaxStatus where Refno="&refno
rsCountry.open Tempstmt,con
firstflag="Y"
while not rsCountry.Eof
country=rsCountry.fields("countryID")
if firstflag="Y" then
call writeIDDescription("Embassy",country)
firstflag="N"
else
Response.write ", "
call writeIDDescription("Embassy",country)
end if
rsCountry.movenext
Wend
rsCountry.close

response.write "&nbsp;</td></tr>"
if retrieveremark<>""  then
response.write "<tr bgcolor='#FFFFFF'><td colspan=10 align='left'><font size=2 face='arial' color='#000000'><b>Remark From Agent:</B> </font><font size=2 face='arial' color=#000000>"&retrieveremark&"</font></td></tr>"
end if
if intremark<>""  then
response.write "<tr bgcolor='#FFFFFF'><td colspan=10 align='left'><font size=2 face='arial' color='#000000'><b>Internal Remark :</b><font size=2 face='arial' color=#000000> "&intremark&"</font></font></td></tr>"
end if
stmt2="select * from entryDetails where refno="&refno &" order by paxname"
rs2.open stmt2,con
while not rs2.eof
paxID=rs2("PaxID")
Tempstmt="select * from PaxStatus where paxID="&paxID
rsCountry.open Tempstmt,con
while not rsCountry.Eof
response.write "<tr bgcolor='#FFFFFF'><td colspan=4 ><font size='2' face='Arial' color='#000000'><b>"& rs2("paxname")&"</b><font size=2 face='arial' color=#000000> for </font><font size=2 face='arial' color=#000000> "
Call WriteIDDescription("Embassy",rsCountry("countryID"))
REsponse.write "</font> </font><td colspan=3 ><font size=2 face='arial' color='#000000'><b>Status: </b></font><font size=2 face='arial' color=#000000>" 
Call WriteIDDescription("Status",rsCountry("statusID"))
REsponse.write " </font><td colspan=4 > <font size='2' face='Arial' color='#000000'><b>REM: </b></font><font size=2 face='arial' color=#000000>"&rsCountry("remarks")&"</font></td></tr>"
rsCountry.movenext
Wend
rsCountry.close

rs2.movenext
wend
rs2.close()
response.write "<tr bgcolor='#FFFFFF'><td height=5 colspan=10 bgcolor='#A0A0A0'></td></tr>"
rs.movenext
wend
end if
rs.close()
%> 
                          </table>
                        </td>
                      </tr>
                    </table>
            </form>
            </html>