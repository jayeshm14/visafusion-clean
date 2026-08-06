<!-- #include file="../connection.asp" -->
<%
TODAY=date()
TILLDAY=TODAY+30

'function MonthlyHolidayList(currentdate)
set rs=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
'today=currentdate

'stmt ="select * from holidaylist where day(holiday)>= "&day(today)&" and month(Holiday)="&month(today)&" and year(Holiday)="&year(today)&" ORDER BY HOLIDAY"
stmt ="select * from holidaylist where holiday between '"&today&"' and '"&tillday&"' ORDER BY HOLIDAY"

rs.open stmt,con
if rs.eof then 
Display="NO HOLIDAY IN ANY EMBASSY THIS MONTH" 
else 

while not rs.eof
if datecheck<>FormatdateTime(rs("holiday"),2) then
Display=Display& " <font color='red'>" &SysToUsrDate(FormatdateTime(rs("holiday"),2))&" - </font>"
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
HolidayList=ucase(Display)
'End function

'holidaylist= MonthlyHolidayList(today)

RESPONSE.WRITE TODAY&","&TILLDAY

RESPONSE.WRITE HolidayList
%>