<%
Public Function  cnvstr(str)
if str<>"" then
str=Trim(str)
tempstr=""
store=""
tot=len(str)

for charcounter=1 to tot
tempstr=left(str,charcounter)
tempstr=right(tempstr,1)
if tempstr="1" then
store=store&" One /"
end if
if tempstr="2" then
store=store&" Two /"
end if
if tempstr="3" then
store=store&" Three /"
end if
if tempstr="4" then
store=store&" Four /"
end if
if tempstr="5" then
store=store&" Five /"
end if
if tempstr="6" then
store=store&" Six /"
end if
if tempstr="7" then
store=store&" Seven /"
end if
if tempstr="8" then
store=store&" Eight /"
end if
if tempstr="9" then
store=store&" Nine /"
end if
if tempstr="0" then
store=store&" Zero /"
end if

Next

cnvstr=store
end if
End function


response.write(cnvstr(1234567890))


%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

</body>
</html>
