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

<!--<body onLoad="MM_preloadImages('images/submission2.jpg','images/edit2.jpg','images/reports2.jpg','images/visa2.jpg','images/advsearch2.jpg','images/collection2.jpg')">-->
<table width="99%" border="0">
                    <tr>
                      
    <!-- <td><font size="2" face="Arial, Helvetica, sans-serif"><a href="entry.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','images/submission2.jpg',1)"><img name="Image13" border="0" src="images/submission1.jpg" width="102" height="20"></a></font></td>
                      
    <td><a href="collection.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','images/collection2.jpg',1)"><img name="Image6" border="0" src="images/collection1.jpg" width="102" height="20"></a></td>
    <td><a href="collectionmain.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','images/edit2.jpg',1)"><img name="Image7" border="0" src="images/edit1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="collection.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','images/reports2.jpg',1)"><img name="Image8" border="0" src="images/reports1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','images/visa2.jpg',1)"><img name="Image9" border="0" src="images/visa1.jpg" width="102" height="20"></a></td>
                      
    <td><a href="searchEntry.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','images/advsearch2.jpg',1)"><img name="Image10" border="0" src="images/advsearch1.jpg" width="102" height="20"></a></td>
    --></tr><td>
    <tr> <%
    cmd=request("cmd")
    %>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    
    <td><a href="taskswithoutimage.asp?cmd=sub">submit date wise</a></td>
    <td><a href="taskswithoutimage.asp?cmd=">Collection Date wise</a></td>
    <td><a href="taskswithoutimage.asp?cmd=country">Country wise</a></td>
    <td><a href="javascript:print()">Print</a></td>    
    <td><a href="tasks.asp?cmd=<%=cmd %>">Show images</a></td>
    </tr>
                  </table>

             
<form name=collection action="tasks.asp" method="post">
        <table width="75%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="">
          <tr bgcolor=""> 
            <td height="19"> 
              <div align="center"><b><i>
              SELECTED TASKS </i></font></font></b></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td height="2"> 
        <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="">
          <tr> 
            <td></td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td align="left" width="1"><img src="images/pixelsline.gif" width="1" height="7"></td>
                  <td width="560"> 
                    <table width="100%" border="0" bgcolor="" cellpadding="0" cellspacing="0" background="images/backform.jpg">
                      <tr> 
                        
                          <table width="658" border="1" align="center">
                            <tr bgcolor=""> 
                              <td width="39"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Ref 
                                #</b></font></td>
                              <td width="59"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Recieved</b></font></td>
                              <td width="46"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Submit</b></font></td>
                              <td width="65"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Collection</b></font></td>
                              <td width="70"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>PAX 
                                Name</b></font></td>
                              <td width="36"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Total</b></font></td>
                              <td width="95"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Agent 
                                Name</b></font></td>
                              <td width="47"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Status</b></font></td>
                              <td width="33"><font size="2" face="Arial, Helvetica, sans-serif" color=""><b>Sent</b></font></td>
                              <td width="52"><font size="2" face="Arial, Helvetica, sans-serif" color="0CC"><b>Country</b></font></td>
                                </tr>
                            <%  
          
            
                  
            date1=date()-3
            today=date() 
 
 submit2=cdate(request.form("submit1"))
if cmd="" or isNull(cmd) then
stmt="select * from entrydetails  where (Day(coldate)="&day(today)&" and month(coldate)>="&month(today)&" and year(coldate)="&year(today)&") order by entrydetails.coldate,entrydetails.cname "
end if
if cmd="sub" then
stmt="select * from entrydetails  where (Day(subdate)="&day(today)&" and month(subdate)>="&month(today)&" and year(subdate)="&year(today)&") order by entrydetails.subdate,entrydetails.cname desc"
end if
if cmd="country" then
stmt="select * from entrydetails  where (Day(subdate)="&day(today)&" and month(subdate)>="&month(today)&" and year(subdate)="&year(today)&") order by cname "
end if
if submit2<>"" then
stmt="select * from entrydetails  where (Day(subdate)="&day(submit2)&" and month(subdate)>="&month(submit2)&" and year(subdate)="&year(submit2)&")"
end if
set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset") 
response.write stmt
rs.open stmt,con
if rs.eof then 
response.write "<tr bgcolor=''><td colspan=11 align=center><font face='arial' size=2 color=''>NO DATA FOUND</font></td></tr>" 
else 
while not rs.eof
refno=rs.fields("refno") 
stmt1="select receivedate, agent from Mainentry where refno="&refno
rs1.open stmt1,con
internalremark=rs.fields("remarks")   
agent=rs1.fields("agent")
receivedate=rs1.fields("receivedate")
response.write "<tr bgcolor=''><td><font face='arial' size=2 color=''>"&refno&"</font></td><td><font face='arial' size=2 color='#000000'>"&receivedate&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("subdate")&"</font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("coldate")&"</font></td><td><a href='collectionform.asp?refno="&refno&"' >"&ucase(rs.fields("passengername"))&"</a></td><td>"&rs.fields("totalpassengers")&"</font></td><td><font face='arial' size=2 color='#000000'>"&agent&"</font></td><td><font face='arial' size=2 color='#000000'><a href='collectionform.asp?refno="&refno&"' >"&ucase(rs.fields("status"))&"</a></font></td><td><font face='arial' size=2 color='#000000'>"&rs.fields("sentdate")&"</font></td><td>"

response.write ucase(rs.fields("cname"))

response.write "<tr bgcolor=''><td height=10 colspan=11 bgcolor='#A0A0A0'></td></tr>"
rs1.close()
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
                  <td align="right" width="1"> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </form>