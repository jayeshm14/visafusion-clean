
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

<body >
<table width="99%" border="0">
                    <tr>
                      
    <td><font size="2" face="Arial, Helvetica, sans-serif"><a href="entry.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','images/submission2.jpg',1)"><img name="Image13" border="0" src="images/submission1.jpg" width="102" height="20"></a></font></td>
                      
    <td><a href="collection.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','images/collection2.jpg',1)"><img name="Image6" border="0" src="images/collection1.jpg" width="102" height="20"></a></td>
    <td><a href="collectionmain.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','images/edit2.jpg',1)"><img name="Image7" border="0" src="images/edit1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="collection.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','images/reports2.jpg',1)"><img name="Image8" border="0" src="images/reports1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','images/visa2.jpg',1)"><img name="Image9" border="0" src="images/visa1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="searchEntry.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','images/advsearch2.jpg',1)"><img name="Image10" border="0" src="images/advsearch1.jpg" width="102" height="20"></a>&nbsp;
    <a href="paymentReceive.asp">PAYMENT</a></td>
                    </tr>
                  </table>
<table width="99%" border="0">
  <tr> <%
             cmd=request("cmd")
             %> 
    <td colspan="8" align="center">&nbsp;</td>
  </tr>
  <tr> 
     
    <td> 
      <div align="center"><a href="collection.asp?cmd=today">Today's</a></div>
    </td>
    <td> 
    <td> 
      <div align="center"><a href="collection.asp?cmd=all">Show All</a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=agent">Agent Wise </a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=date">Date Wise</a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=status">Status Wise</a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=notsent">Not Sent</a></div>
    </td>
    <td> 
      <div align="center"><a href="javascript:print()">Print</a> </div>
    </td>
    <td> 
      <div align="center"><a href="colWithoutImg.asp?cmd=<%= cmd %>">Remove Images</a></div>
    </td>
  </tr>
</table>
             
<form name=collection action="collectionform.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" face="Arial, Helvetica, sans-serif"><font color="#000099"><i><% if cmd="date" then
              response.write"COLLECTION RESULTS(DATE WISE)"
              END IF
              if cmd="today" then
              response.write"COLLECTION RESULTS(TODAY)"
              END IF
              if cmd="agent" then
              response.write"COLLECTION RESULTS(AGENT WISE)"
              END IF
              if cmd="status" then
              response.write"COLLECTION RESULTS(STATUS WISE)"
              END IF
              if cmd="notsent" then
              response.write"COLLECTION RESULTS(PENDING)"
              END IF
              if cmd="all" then
              response.write"COLLECTION RESULTS(ALL CASES)"
              END IF
              if cmd="" or isNull(cmd) then
              response.write"COLLECTION RESULTS(REFNO. WISE)"
              end if
              %> </i></font></font></b></div>
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
                        <td>
                          <table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Collection</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                              <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              <td width="33"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Sent</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Edit/Email</b></font></td>
			      <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Hotel/
			      
			      
			      </b></font></td>                            
                            </tr>
                            <%  
                name=request("uname")
date1=date()-7
 set rs=server.createobject("adodb.recordset") 
set rs1=server.createobject("adodb.recordset") 
set rs2=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset") 
 stmt = "select * from agents where description='"&name&"'"
 rs.open stmt,con,2,3
agentsid= rs.fields("agentsID")

 stmt1="select * from Mainentry where agent="&agentsid
  rs1.open stmt1,con,2,3
  
   while not rs1.eof
   refno=rs1.fields("refno")
  'intremark=ucase(rs1.fields("internalremark"))
'retrieveremark=ucase(rs1.fields("AgentInstruction"))  
agent=rs1("agent")
'status=rs1("status")
recdate=rs1.fields("receivedate")
if  recdate <> "" then
recdate=day(recdate)&"/"&Month(recdate)&"/"&year(recdate)
End if

subdate=rs1.fields("subdate")
if  subdate <> "" then
subdate=day(subdate)&"/"&Month(subdate)&"/"&year(subdate)
End if

coldate=rs1.fields("coldate")
if  coldate <> "" then
coldate=day(coldate)&"/"&Month(coldate)&"/"&year(coldate)
End if
sentdate=rs1.fields("sentdate")
if  sentdate <> "" then
sentdate=day(sentdate)&"/"&Month(sentdate)&"/"&year(sentdate)
End if
response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#000000'>"&refno&"</font></td><td><font face='arial' size=2 color='#000000'>"& recdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& subdate &"</font></td><td><font face='arial' size=2 color='#000000'>"& coldate &"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"&ucase(rs1.fields("paxname"))&"</a></font></td><td><font face='arial' size=2 color='#000000'>"&rs1.fields("totalpassengers")&"</font></td><td><font face='arial' size=2 color='#000000'><a href=searchresult.asp?agent="&agent &" >"
call writeIddescription("agents",agent)
response.write "</a></font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"
if status <> "" then
call writeIddescription("status",status)
end if
response.write "</a></font></td><td><font face='arial' size=2 color='#000000'>&nbsp;"& sentdate &"&nbsp;</font></td><td>"

Tempstmt="select distinct(countryID) from PaxStatus where Refno="&refno
rsCountry.open Tempstmt,con
while not rsCountry.Eof
country=rsCountry.fields("countryID")
call writeIDDescription("Embassy",country)
Response.write ", "
rsCountry.movenext
Wend
rsCountry.close



response.write "&nbsp;</td><td><font face='arial' size=2 color='#000000'><a href='editEntry.asp?refno="&refno&"' >EDIT</a> / <a href='enterWP.asp?refno="&refno&"' >EMAIL</a></font></td>"
response.write "<td><font face='arial' size=2 color='#000000'><a href='hotel.asp?refno="&refno&"&N="&rs1.fields("paxname")&  "' >Hotel</a> / <a href='cabs.asp?refno="&refno&"&N="&rs1.fields("paxname")& "' >Cab</a></font></td></tr>"
if retrieveremark<>""  then
response.write "<tr bgcolor='#F0F0FF'><td colspan=12 align='left'><font size=2 face='arial' color='#0000CC'><b>Remark From Agent:</B> </font><font size=2 face='arial' color=#C35068>"&retrieveremark&"</font></td></tr>"
end if
if intremark<>""  then
response.write "<tr bgcolor='#F0F0FF'><td colspan=12 align='left'><font size=2 face='arial' color='#0000CC'><b>Internal Remark :</b><font size=2 face='arial' color=#C35068> "&intremark&"</font></font></td></tr>"
end if

  
  
  stmt2="select * from entrydetails where refno="&refno
  
  rs2.open stmt2,con,2,3
 while not rs2.eof
refno=rs2.fields("refno")
 
 paxid=rs2.fields("paxID")
 totalpax=rs2.fields("totalpax")
 
 
  stmt3= "select * from paxstatus where paxid="&paxid&" and refno="&refno 
rsCountry.open stmt3,con

while not rsCountry.Eof
response.write "<tr bgcolor='#F0F0FF'><td colspan=4 ><a href=paxstatus.asp?paxid="& paxID &" ><font size='2' face='Arial' color='#3300CC'><b>"& rs2("paxname")&"</b><font size=2 face='arial' color=#C35068> for </font><font size=2 face='arial' color=#C35068>"
Call WriteIDDescription("Embassy",rsCountry("countryID"))
Response.write "</a></font> </font><td colspan=4 ><font size=2 face='arial' color='#3300CC'><b>Status: </b></font><font size=2 face='arial' color=#C35068>" 
Call WriteIDDescription("Status",rsCountry("statusID"))
REsponse.write " </font><td colspan=4 > <font size='2' face='Arial' color='#0000CC'><b>REM: </b></font><font size=2 face='arial' color=#C35068>"&ucase(rsCountry("remarks"))&"</font></td></tr>"
rsCountry.movenext
Wend
rsCountry.close

rs2.movenext
wend
rs2.close()
response.write "<tr bgcolor='#F0F0FF'><td height=10 colspan=12 bgcolor='#A0A0A0'></td></tr>"
rs1.movenext
wend
  rs1.close()
rs.close()
%> 
                          </table>
                        </td>
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
            <td><img src="images/linebottom.jpg" width="660" height="13"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </form>
              </table>-->