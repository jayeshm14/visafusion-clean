
<%@ Language=VBScript %>
<%
set con=server.createobject("adodb.connection")
con.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"

set rs=server.createobject("adodb.recordset")
rs.open "select * from invoice where invoiceno>='98643' and invoiceno<='98728' order by invoiceno desc",con
if rs.eof then
response.write "No data"
else
while not rs.eof

if rs("hotelfee")="" or isnull(rs("hotelfee")) then
hotelfee=0
else
hotelfee=rs("hotelfee")
end if
if rs("cabfee")="" or isnull(rs("cabfee")) then
cabfee=0
else
cabfee=rs("cabfee")
end if
if rs("poe")="" then
poe=0
else
poe=rs("poe")
end if
if rs("misc")="" then
misc=0
else
misc=rs("misc")
end if
if rs("attestfee")="" then
attestfee=0
else
attestfee=rs("attestfee")
end if
if rs("courierfee")="" then
courierfee=0
else
courierfee=rs("courierfee")
end if
if rs("grandtotal")="" then
grandtotal=0
else
grandtotal=rs("grandtotal")
end if


stmt="insert into invoicetest(refno,invoiceno,hotelfee,cabfee,poeremark,poe,miscremark,misc,attestfee,attestremark,courierfee,grandtotal,invoicedate,remark,invtype) values("&rs("refno")&","&rs("invoiceno")&","&hotelfee&","&cabfee&",'"&rs("poeremark")&"',"&poe&",'"&rs("miscremark")&"',"&misc&","&attestfee&",'"&rs("attestremark")&"',"&courierfee&","&grandtotal&","&rs("invoicedate")&",'"&rs("remark")&"','"&rs("invtype")&"')"
response.write stmt
'  con.execute stmt
response.write(rs("invoiceno")&"<br>")
rs.movenext
wend
end if
rs.close
set rs=nothing

%>