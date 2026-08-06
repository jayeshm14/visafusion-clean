<% 
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

refno=12345
stmt="select * from mainentry where refno='"&refno&"'"
response.write(stmt)

'function dateten(a)
'tdate()=""
'adate=a
'if Day(adate)<10 then
'tdate=tdate&"0"&Day(adate)&"/"
'else
'tdate=tdate&""&Day(adate)&"/"
'end if 
'if Month(adate)<10 then
'tdate=tdate&"0"&Month(adate)&"/"
'else
'tdate=tdate&""&Month(adate)&"/"
'end if
'tdate=tdate&""&Year(adate)
'return tdate
'end function

'response.write(dateten(date()))

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="javascript" src="datecheck.js"></script>

<script language="javascript">

function check()
{
//if(document.form1.testDateFormat.value==""){
//alert("Please enter your Login name!.")
//document.form1.testDateFormat.focus()
//return false
//}

if((document.form1.select1.value=="") && (document.form1.select2.value=="") && (document.form1.testDateFormat.value==""))
	{
	alert ("Please Select the Month in which you were born.");
	return false;
	}
document.form1.submit()
}
</script>
</head>
<body bgcolor="#FFFFFF">
<form method="post" action="" name="form1" onSubmit="return check()">
  <p> 
    <input type="text" name="testDateFormat" maxlength="10" size="10" onFocus="javascript:vDateType='3'" onKeyUp="DateFormat(this,this.value,event,false,'3')" onBlur="DateFormat(this,this.value,event,true,'3')" value="1/1/2002">
  </p>
  <p> 
    <select name="select1">
      <option selected>all</option>
      <option value="uma">uma</option>
      <option value="seema">seema</option>
    </select>
  </p>
  <p> 
    <select name="select2">
      <option selected>all</option>
      <option value="uma">uma</option>
      <option value="seema">seema</option>
    </select>
    <br>
  </p>
  <p> 
    <input type="submit" name="Submit" value="Submit">
  </p>
</form>
</body>
</html>
