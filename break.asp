<%@ Language=VBScript %> 
<%
Public Function  UsrToSysDate(str)
str=str&"/"
tempstr=""
store=""
tot=len(str)
j=1
mm=""
dd=""
yy=""
for i=1 to tot+1
tempstr=left(str,i)
tempstr=right(tempstr,1)
response.write tempstr&"<br>"
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
End function
usrdate="20/3/1717"
hh = UsrToSysDate(usrdate)
response.write hh
%>