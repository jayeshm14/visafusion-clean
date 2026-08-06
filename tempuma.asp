<%
Function getDescriptionForID1(tablename,IDToWrite)
key=tablename&"ID"
set rsWriteDesc1=server.createobject("adodb.recordset")
rsWriteDesc1.activeconnection=con
qry1="select * from "& tablename &" where "& key & " = '"&IDToWrite&"'"

rsWriteDesc1.open qry1,con,2,3
while not rsWriteDesc1.eof
getDescriptionForID1=ucase(rsWriteDesc1("description"))

rsWriteDesc1.movenext
wend
rsWriteDesc1.close
set rsWriteDesc1=nothing
End Function

today=date() 

refno=request("refno")

stmt="select * from Mainentry where refno = '"&refno&"'"

set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset") 
rs.open stmt,con,3,3

%>
<html>
<head>
<title>www.udaanindia.com</title>
</head>
<body>
<table width="475" border="1" align="center">
  <tr bgcolor="#CCCCFF"> 
    <td width="25"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Ref 
      #</font></b></font></td>
    <td width="30"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Date</font></b></font></td>
    <td width="90"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">PAX 
      Name</font></b></font></td>
    <td width="5"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">T</font></b></font></td>
    <td width="100"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Agent 
      Name</font></b></font></td>
    <td colspan="2"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Country</font></b></font></td>
    <td width="90"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Passport 
      No.</font> </b></font></td>
    <td width="40"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Visa 
      Type</font> </b></font></td>
    <td width="40"><font size="2" face="Arial, Helvetica, sans-serif" color="#3300CC"><b><font color="#000000">Entry 
      Type </font></b></font></td>
  </tr>
  <%                            
if rs.eof then %> 
  <tr bgcolor="#F0F0FF"> 
    <td colspan=12 align=center><font face="arial" size=2 color="#ff0000">NO DATA 
      FOUND</font></td>
  </tr>
  <%
 else
while not rs.eof
refno=rs.fields("refno")  
intremark=ucase(rs.fields("internalremark"))
retrieveremark=ucase(rs.fields("AgentInstruction"))  
agent=rs("agent")
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

countryList=""
categorylist=""
entrytypelist=""
Tempstmt="select distinct(refno),countryID,entrytype,category from PaxStatus where Refno="&refno
rsCountry.open Tempstmt,con
firstflag="Y"
catflag="Y"
entflag="Y"
while not rsCountry.Eof
country=rsCountry.fields("countryID")
if firstflag="Y" then
countryList=countryList& getDescriptionForID("Embassy",country)
firstflag="N"
else
countryList=countryList&", "& getDescriptionForID("Embassy",country)
end if

category=rsCountry.fields("category")
if catflag="Y" then
categoryList=categoryList& getDescriptionForID1("category",category)
catflag="N"
else
categoryList=categoryList&", "& getDescriptionForID1("category",category)
end if

entrytype=rsCountry.fields("entrytype")
if entflag="Y" then
entrytypeList=entrytypeList& getDescriptionForID("entrytype",entrytype)
entflag="N"
else
entrytypeList=entrytypeList&", "& getDescriptionForID("entrytype",entrytype)
end if

rsCountry.movenext
Wend
rsCountry.close


paxList=""
passlist=""
Tempstmt1="select distinct(paxname),passportno from entrydetails where Refno="&refno
rs1.open Tempstmt1,con
paxflag="Y"
passflag="Y"

while not rs1.Eof
paxname=rs1.fields("paxname")
if paxflag="Y" then
paxList=paxList& paxname
paxflag="N"
else
paxList=paxList&", "& paxname
end if

passport=rs1.fields("passportno")
if passflag="Y" then
passList=passList& passport
passflag="N"
else
passList=passList&", "& passport
end if

rs1.movenext
Wend
rs1.close

%> 
  <tr bgcolor="#F0F0FF" valign="top"> 
    <td width="25"><font face="arial" size="4" color="red"><b><a href="editEntry.asp?refno=<%=refno%>&page=1&cmd="><%=refno%></a></b></font></td>
    <td width="30"><font face="arial" size="2" color="#000000"><%=recdate%> <% 
poe=rs.fields("poe")
poe=getDescriptionForID("poe",poe)
if ucase(poe)<>ucase("None") then
response.write("<br><b>"&poe&"</b>")
end if
%> </font></td>
    <td width="90"><font size="2" color="#000000"><% if countryList="" then 
response.write "<b>"&ucase(paxlist)&"</b>"
else
response.write "<b>"&ucase(paxlist)&"</b>"
end if
%> </font></td>
    <td width="5"><font face="arial" size="2" color="#000000"><%=rs.fields("totalpassengers")%></font></td>
    <td width="100"><font size="2" color="#000000"><%
call writeIddescription("agents",agent)
%> </font></td>
    <td colspan="2"><font size="2" color="#000000"><%=countryList%> &nbsp;</font></td>
    <td width="90"><font face="arial" size="1" color="#000000"><%=passlist%></font><font size="1" color="#000000"> 
      </font></td>
    <td width="40"><font size="1" color="#000000"><%=categoryList%> </font></td>
    <td width="40"><font size="2" color="#000000"><%=entrytypeList%> </font></td>
  </tr>
  <% if retrieveremark<>""  then %> 
  <tr bgcolor="#F0F0FF" valign="top"> 
    <td width="25">&nbsp;</td>    
    <td width="30">&nbsp;</td>
    <td colspan=13 align="left"><font size=2 face="arial" color="#0000CC"><b><font color="#000000">Remark 
      From Agent:</font></B> </font><font size="2" face="arial" color="#000000"><%=retrieveremark%></font></td>
  </tr>
  <% end if
if intremark<>""  then %> 
  <tr bgcolor="#F0F0FF"> 
    <td width="25">&nbsp;</td>
    <td width="29">&nbsp;</td>
    <td colspan=13 align="left"><font size=2 face="arial" color="#0000CC"><b><font color="#000000">Internal 
      Remark :</font></b><font size="2" face="arial" color="#000000"><%=intremark%></font></font></td>
  </tr>
  <% end if %> 
  <tr bgcolor="#F0F0FF"> 
    <td height=5 colspan=13 bgcolor="#A0A0A0"></td>
  </tr>
  <%
rs.movenext
wend
 end if
%> <%
rs.close()
%> 
</table>
</body>
</html>
