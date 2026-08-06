
<script language="javascript">
<!--

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
a {  font-family: Arial; font-size: 10pt; font-weight: bold; text-decoration: none; color: #006600}
a:hover {  font-family: Arial; font-size: 10pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>

<body >

<table width="99%" border="0">
  
  <tr> 
     
    <td> 
      <div align="center"><a href="collection.asp?cmd=today"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Today's</font></a></div>
    </td>
    <td> 
    <td> 
      <div align="center"><a href="collection.asp?cmd=all"><b><font size="3"color="#006600" face="Arial, Helvetica, sans-serif">Show All</font></a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=agent"><b><font size="3"color="#006600" face="Arial, Helvetica, sans-serif">Agent Wise </font></a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=date"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Date Wise</font></a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=status"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Status Wise</font></a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=notsent"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Pending</font></a></div>
    </td>
    <td> 
      <div align="center"><a href="collection.asp?cmd=doxre"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Received</font></a></div>
    </td>
    <td> 
      <div align="center"><a href="javascript:print()"><b><font size="3" color="#006600" face="Arial, Helvetica, sans-serif">Print</font></a> </div>
    </td>
    <td> 
      <div align="center"><a href="colWithoutImg.asp?cmd=<%= cmd %>"><b><font size="3"color="#006600" face="Arial, Helvetica, sans-serif">Remove Images</font></a></div>
    </td>
  </tr>
  <tr> <%
             cmd=request("cmd")
             PageNo = request("page")
IF PageNo="" then
	PageNo=1

END IF
 %>
    <td colspan="8" align="center">
    <p align="center"><font size="2" color="#006600"><b>
    <%
     if request("msgID")="1" then 
                   response.write " The information regarding "&ucase(request("pname"))&" updated successfully."
   end if
    
                IF request("sentEmail")="Y" THEN
                response.write "<BR>"
                %>
                <!-- #include file="emailReceipt.asp" -->
                 <%
                END IF 
                %>
                 <%
                IF request("sendSMS")="Y" THEN
                response.write "<BR>"
                %>
                <!-- #include file="sendSMStoQueue.asp" -->
                 <%
                END IF 
                %>
                
     </font></b>
    </td>
  </tr>
</table>
             
<form name=collection action="collection.asp" method="post">
  <table width="44%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td> 
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000090">
          <tr bgcolor="#FFFFF0"> 
            <td height="19"> 
              <div align="center"><b><font size="3" color="#CC0000" ><font color="#000099"><i><% if cmd="date" then
              response.write"COLLECTION RESULTS(DATE WISE)"
              END IF
              if cmd="today" then
              response.write"COLLECTION RESULTS ( TODAY )"
              END IF
              if cmd="agent" then
              response.write"COLLECTION RESULTS ( AGENT  )"
              END IF
              if cmd="status" then
              response.write"COLLECTION RESULTS ( STATUS  )"
              END IF
              if cmd="notsent" then
              response.write"COLLECTION RESULTS ( PENDING )"
              END IF
              if cmd="doxre" then
              response.write"COLLECTION RESULTS ( RECEIVED )"
              END IF
              if cmd="all" then
              response.write"COLLECTION RESULTS ( ALL CASES )"
              END IF
              if cmd="" or isNull(cmd) then
              response.write"COLLECTION RESULTS ( REF.# )"
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
                          
                            <%  
               
            date1=date()-5
            date2=date()-60
            today=date() 
            categoryid=getIDForDescription("category","Attestation")
  
 if cmd="all" then
 Stmt="select * from Mainentry  where receivedate>'"&date2 &"' order by refno desc"
 end if
 if cmd="agent" then

 stmt="select * from Mainentry  where receivedate>'"&date1 &"' order by agent"
 end if
 if cmd="date" then
 
 stmt="select * from Mainentry  where receivedate>'"&date1 &"' order by receivedate desc"
 end if
 if cmd="today" then
 stmt="select * from Mainentry  where (Day(receivedate)="&day(today)&" and month(receivedate)>="&month(today)&" and year(receivedate)="&year(today)&") order by refno desc"
 end if

 if cmd="" or isNull(cmd) then
  stmt="select * from Mainentry where receivedate>'"&date1 &"' order by refno desc"
 end if

 if cmd="status" then
 stmt="select * from Mainentry  where receivedate>'"&date1 &"' order by Status"
 end if

 if cmd="doxre" then
 Stmt="select * from mainentry,paxstatus  where ((paxstatus.statusid =101) or (mainentry.status=101)) and paxstatus.refno=mainentry.refno order by paxstatus.refno desc"
 end if

 if cmd="notsent" then
 Stmt="select * from mainentry,paxstatus  where ((paxstatus.statusid >400 and paxstatus.statusid <500) or (mainentry.status>400 and mainentry.status<500)) and paxstatus.refno=mainentry.refno order by paxstatus.refno desc"
' Stmt="select * from Mainentry  where status >400 and status <500 order by refno desc"
 end if

set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset") 
'response.write(stmt)
rs.open stmt,con,3,3
TotalRecs = rs.recordcount
rs.Pagesize=10
TotalPages = cInt(rs.pagecount)
response.write "<table width='100%'> <tr bgcolor='#CCCCFF'><td>"
If PageNo = 1 then
	response.write "<Font face='arial' size=2 color='#006600'>Total <b>" & TotalRecs & "</b> entries in <b>" & TotalPages & "</b> page(s).</b></font>"
else 
	response.write "<Font face='arial' size=2 color='#006600'><b> Page " & pageno & " of " & TotalPages & "</b></font>"
End If

if TotalPages>1 then
response.write "</td><td align=right><Font face='arial' size=2 color='#006600'>Pages :</font> "

for i=1 to TotalPages
if (i mod 20)=0 then 
response.write "<br>"
end if
if i=cint(pageno) then
    	response.write "&nbsp;<Font face='arial' size=2 color='#0000FF'><b>"&i &"</b></font>&nbsp;"
    else
    
    	response.write "&nbsp;<a href='collection.asp?page="&i&"&cmd="&cmd&"'><Font face='arial' size=2 color='#006600'>"&i &"</font></a>&nbsp;"
    end if
 next
end if 
 response.write "</td></tr></table>"

 %>
 <table width="658" border="0" align="center">
                            <tr bgcolor="#CCCCFF"> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Ref 
                                #</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Recieved</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>PAX 
                                Name</b></font></td>
                              <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Total</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Agent 
                                Name</b></font></td>
                              <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Status</b></font></td>
                              
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Country</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Edit/Email</b></font></td>
			      <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b>Hotel/Cab
			      
			      
			      </b></font></td>                            
                            </tr>
<%                            

if rs.eof then 
 response.write "<tr bgcolor='#F0F0FF'><td colspan=11 align=center><font face='arial' size=2 color='#ff0000'>NO DATA FOUND</font></td></tr>" 
else
rs.absolutepage=PageNo
 end if

For x = 1 to rs.Pagesize
if rs.eof then 
  exit for
else 

'while not rs.eof
refno=rs.fields("refno")  
intremark=ucase(rs.fields("internalremark"))
retrieveremark=ucase(rs.fields("AgentInstruction"))  
agent=rs("agent")
status=rs("status")
category=rs("category")
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

set rs2=server.createobject("adodb.recordset")
countryList=""
Tempstmt="select distinct(countryID) from PaxStatus where Refno="&refno
rsCountry.open Tempstmt,con
firstflag="Y"
while not rsCountry.Eof
country=rsCountry.fields("countryID")
if firstflag="Y" then
countryList=countryList& getDescriptionForID("Embassy",country)
firstflag="N"
else
countryList=countryList&", "& getDescriptionForID("Embassy",country)
end if
rsCountry.movenext
Wend
rsCountry.close



response.write "<tr bgcolor='#F0F0FF'><td><font face='arial' size=2 color='#006600'>"&refno&"</font></td><td><font face='arial' size=2 color='#006600'>"& recdate &"</font></td><td><font face='arial' size=2 color='#006600'>"
if countryList="" then
response.write ""&ucase(rs.fields("paxname"))&""
else
if cint(category)=cint(categoryid) then
response.write "<a href='refnoDetail.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >"&ucase(rs.fields("paxname"))&"</a>(ATTEST)"
else
response.write "<a href='refnoDetail.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >"&ucase(rs.fields("paxname"))&"</a>"
end if
end if
response.write "</font></td><td><font face='arial' size=2 color='#006600'>"&rs.fields("totalpassengers")&"</font></td><td><font face='arial' size=2 color='#006600'><a href='searchPax.asp?agent="& agent&"&page="&pageno&"&cmd="&cmd&"' >"
call writeIddescription("agents",agent)
response.write "</a></font></td><td><font face='arial' size=2 color='#006600'><a href='collectionform.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"'>"
if status <> "" then
call writeIddescription("status",status)
end if
response.write "</a></font></td><td><font face='arial' size=2 color='#006600'>"&countryList






response.write "&nbsp;</font></td><td><font face='arial' size=2 color='#006600'><a href='editEntry.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >EDIT</a> / <a href='enterWP.asp?refno="&refno&"&page="&pageno&"&cmd="&cmd&"' >EMAIL</a></font></td>"
response.write "<td><font face='arial' size=2 color='#006600'><a href='hotel.asp?refno="&refno&"&N="&rs.fields("paxname")&"&agent="&agent&"&page="&pageno&"&cmd="&cmd&"'>Hotel</a> / <a href='cabs.asp?refno="&refno&"&N="&rs.fields("paxname")&"&agent="&agent&"&page="&pageno&"&cmd="&cmd&"' >Cab</a></font></td></tr>"
if retrieveremark<>""  then
response.write "<tr bgcolor='#F0F0FF'><td colspan=12 align='left'><font size=2 face='arial' color='#0000CC'><b>Remark From Agent:</B> </font><font size=2 face='arial' color=#C35068>"&retrieveremark&"</font></td></tr>"
end if
if intremark<>""  then
response.write "<tr bgcolor='#F0F0FF'><td colspan=12 align='left'><font size=2 face='arial' color='#0000CC'><b>Internal Remark :</b><font size=2 face='arial' color=#C35068> "&intremark&"</font></font></td></tr>"
end if
response.write "<tr bgcolor='#F0F0FF'><td height=5 colspan=12 bgcolor='#A0A0A0'></td></tr>"

rs.movenext
'wend
 end if
Next
response.write "<table width=300 border=0><tr bgcolor='#CCCCFF'>"
response.write "<td align='center'>"
If PageNo > 1 then
	response.write "<form method='post' action='collection.asp'>"
	response.write "<input type='hidden' name='Page' value=" & PageNo-1 & " >"
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='<< Prev'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td><td align='center'>"
If NOT rs.eof then
	response.write "<form method='post' action='collection.asp'>"	
	response.write "<input type='hidden' name='cmd' value="&cmd& " >"
		response.write "<input type='hidden' name='Page' value=" & PageNo+1 & ">"
	response.write "<font face='arial' size=2>"
	response.write "<input type='submit' value='Next >>'></form>"
Else
	response.write "&nbsp;"
End If
response.write "</td></tr></table>"				 

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