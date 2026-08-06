<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript">
<!--
function MM_preloadImages() { //v2.0
  if (document.images) {
    var imgFiles = MM_preloadImages.arguments;
    if (document.preloadArray==null) document.preloadArray = new Array();
    var i = document.preloadArray.length;
    with (document) for (var j=0; j<imgFiles.length; j++) if (imgFiles[j].charAt(0)!="#"){
      preloadArray[i] = new Image;
      preloadArray[i++].src = imgFiles[j];
  } }
}

function MM_swapImgRestore() { //v2.0
  if (document.MM_swapImgData != null)
    for (var i=0; i<(document.MM_swapImgData.length-1); i+=2)
      document.MM_swapImgData[i].src = document.MM_swapImgData[i+1];
}

function MM_swapImage() { //v2.0
  var i,j=0,objStr,obj,swapArray=new Array,oldArray=document.MM_swapImgData;
  for (i=0; i < (MM_swapImage.arguments.length-2); i+=3) {
    objStr = MM_swapImage.arguments[(navigator.appName == 'Netscape')?i:i+1];
    if ((objStr.indexOf('document.layers[')==0 && document.layers==null) ||
        (objStr.indexOf('document.all[')   ==0 && document.all   ==null))
      objStr = 'document'+objStr.substring(objStr.lastIndexOf('.'),objStr.length);
    obj = eval(objStr);
    if (obj != null) {
      swapArray[j++] = obj;
      swapArray[j++] = (oldArray==null || oldArray[j-1]!=obj)?obj.src:oldArray[j];
      obj.src = MM_swapImage.arguments[i+2];
  } }
  document.MM_swapImgData = swapArray; //used for restore
}
//-->
</script>
</head>
<body>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">
<a Href="listBill.asp?cmd=<%=request("cmd") %>"><b> <font size="4" color="#000000"> <%=udaanName%></font></b></a></td></tr>
<tr><td  align="center"><font face='arial' size=2 color='#000000'> <%=udaanAddress%></font></TD></TR>
<tr><td align="center"><font face='arial' size=2 color='#000000'> <%=udaanContact%></font></td></tr></table>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">&nbsp;
<b> <font size="4"> </font> </b></td></tr>
<form action="invoicecreditsubmit.asp" method="post" name="regist">
<INPUT type="hidden" name="cmd1" value="<%=request("cmd") %>">

<%
refno=cint(request("refno"))
GrandTotal=0
flaginv=0
tempinv=0

'set paxi=server.createobject("adodb.recordset")
'paxi.open "select paxid from entrydetails where refno="&refno,con
'paxid=paxi("paxid")

  set invoiceno=server.createobject("adodb.recordset")
  set invoiceno1=server.createobject("adodb.recordset")
  set tempinvoiceno=server.createobject("adodb.recordset")
  
  invoiceno.open "select invoiceno from invoice where refno="&refno&" and invtype ='C'",con

  if not invoiceno.eof then
  invno=invoiceno("invoiceno")
  flaginv=1

  else

    invoiceno1.open "select invoiceno from invoice where refno="&refno&" and invtype ='B'",con
tempinvno=invoiceno1("invoiceno")
invoiceno1.close
set invoiceno1=nothing

  tempinvoiceno.open "select invoiceno from invoice where invtype ='C' order by invoiceno desc",con
if not tempinvoiceno.eof then
  invno=tempinvoiceno("invoiceno")
  invno=cint(invno)+1
else
  invno=1
end if

'  stmt="insert into invoice(refno,invtype) values("&refno&",'C')"
'  con.execute stmt
'  stmt="insert into invoicedetail(invoiceno,invtype) values("&invno&",'C')"
'  con.execute stmt
'  tempinvoiceno.close
'  stmt="select invoiceno from invoice where refno="&refno&" and invtype ='C'" 
'  tempinvoiceno.open stmt,con
'  tempinv=tempinvoiceno("invoiceno")
'  invno=tempinv

  tempinvoiceno.close
  set tempinvoiceno=nothing
  
  end if
  invoiceno.close
  set invoiceno=nothing
  
'  set invoiceno=server.createobject("adodb.recordset")
'  stmt="insert into invoice(refno) values("&refno&")"
'  con.execute stmt

set rs=server.createobject("adodb.recordset")

if flaginv=0 then
stmt="select * from invoice where refno="&refno&" and invtype ='B'"
else
stmt="select * from invoice where invoiceno="&invno&" and invtype ='C'"
end if
'response.write stmt
rs.open stmt,con,2,3
if not rs.eof then
'invno=rs.fields("invoiceno")
temp_hotelfee=rs.fields("hotelfee")
temp_cabfee=rs.fields("cabfee")
temp_invoicedate=rs.fields("invoicedate")
if rs.fields("courierfee")<>"" then
temp_courierfee=rs.fields("courierfee")
else
temp_courierfee=0
end if
if rs.fields("attestfee")<> "" then
temp_attestfee=rs.fields("attestfee")
else
temp_attestfee=0
end if
temp_attestremark=rs.fields("attestremark")
if rs.fields("misc")<> "" then
temp_miscfee=rs.fields("misc")
else
temp_miscfee=0
end if
temp_miscremark=rs.fields("miscremark")
if rs.fields("poe")<> "" then
temp_poefee=rs.fields("poe")
else
temp_poefee=0
end if
if rs.fields("poeremark")<> "" then
temp_poeremark=rs.fields("poeremark")

end if
if rs.fields("remark")<> "" then
temp_remark=rs.fields("remark")
end if
Temp_grandTotal =rs.fields("grandTotal")
end if
rs.close()

set rsmain=server.createobject("adodb.recordset")
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con
agentid=rsmain.fields("agent")
paxname=rsmain.fields("paxname")
recdate=SysTOUsrDate(rsmain.fields("receivedate"))

rsmain.close

stmt="select * from agents where  agentsid="&agentid 
rsmain.open stmt,con
company=rsmain.fields("companyname")
street1=rsmain.fields("street1")
street2=rsmain.fields("street2")
area=rsmain.fields("area")
city=rsmain.fields("city")
pincode=rsmain.fields("pincode")
rsmain.close

%>



</TABLE>


<input type="hidden" name="refno" value="<%=refno %>">
<input type="hidden" name="agent" value="<%=agentid %>">
<input type="hidden" name="invoiceno" value="<%=invno %>">
<input type="hidden" name="invoicedate" value="<%=date() %>">
<input type="hidden" name="paxname" value="<%=paxname %>">
<table width="658" border="0" align="center">
  <tr bgcolor="#ffffff" border=0> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffff" border=0> 
    <td width="153"><b>Company:</b><font face="Arial, Helvetica, sans-serif" size="1"><b><br>
      <%
                             response.write company 
                             if street1<>"" then
                             response.write street1 &"<br>"
                             end if
                             if street2<>"" then
                             response.write street2 &"<br>"
                             end if
                             if area<>"" then
                             response.write area &"<br>"
                             end if
                             if city<>"" then
                             response.write city &" - "&pincode
                             end if
                             %> </b></font>&nbsp;<br>
      <br>
    </td>
    <td width="236"> 
      <div align="center"><b>CREDIT NOTE NO. <%= invno %> </b></div>
    </td>
    <td width="255"> 
      <div align="center">DATED. <%= systousrdate(date()) %> </div>
    </td>
  </tr>
  <tr><td colspan="1" align="left"><b>Ref No.</b> <%= refno %></td>
  <td colspan="2" ><b>We Have Credited Your Account With Us As Follows : </b></td></tr>
</table>                       
 
<table width="658" border="0" align="center">
  <tr > 
    <td colspan="7" >&nbsp;</td>
  </tr>
  <tr bgcolor="#CCCCCC" bordercolor="#FFFFFF" > 
    <td width="37" > 
      <div align="center"><font color="#000000"><b>S.No.</b></font></div>
    </td>
    <td width="169" > 
      <div align="center"><font color="#000000"><b>Name</b></font></div>
    </td>
    <td width="112" > 
      <div align="center"><font color="#000000"><b>Country</b></font></div>
    </td>
    <td width="59" > 
      <div align="left"><font color="#000000"><b>Visa Fee</b></font></div>
    </td>
    <td width="50" > 
      <div align="center"><font color="#000000"><b>H/C</b></font></div>
    </td>
    <td width="53" > 
      <div align="left"><font color="#000000"><b>DD Fee</b></font></div>
    </td>
    <td width="66" > 
      <div align="center"><font color="#000000"><b>Total</b></font></div>
    </td>
  </tr>
<%  
total=0
old_name=""
i=0
tot1=0
tot2=0
uma1=0
uma2=0
set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
if flaginv=0 then
stmt ="select b.paxid, b.paxname,a.visafee,a.handlingfee,a.ddcharges,a.countryid from invoicedetail a,entrydetails b  where a.paxid=b.paxid and a.invoiceno="&tempinvno&" and a.invtype='B' order by b.paxname"
else
stmt ="select b.paxid, b.paxname,a.visafee,a.handlingfee,a.ddcharges,a.countryid from invoicedetail a,entrydetails b  where a.paxid=b.paxid and a.invoiceno="&invno&" and a.invtype='C' order by b.paxname"
end if
'response.write stmt
rs.open stmt,con

counter =1
if not rs.eof then
while not rs.eof
	one_name=trim(rs.fields("paxname"))
	'total=rs.fields("total")
	
%> 
  <tr> 
    <TD width="37">&nbsp;</TD>
    <td ALIGN='CENTER' width="169"> <%
	if  strComp(one_name,old_name) then 
	response.write ucase(one_name)
	old_name=one_name
	else
	response.write "&nbsp;"
	end if
	

temp_handlingfee=rs("handlingfee")

temp_visafee=rs("visafee")

temp_ddcharges=rs("ddcharges")

'temp_total=rs("total")
temp_total=temp_handlingfee + temp_visafee + temp_ddcharges

%> </td>
    <td width="112"> <%
	call writeIDDescription("embassy", rs("countryID"))
	%> </td>
    <td width="59" > <font size="2" color="#006600"><b> 
      <input type="text" name="visafee" value="<%=temp_visafee%>" size="8" onChange="add2Total()" maxlength="20">
      </b></font></td>
    <td width="50" > <font size="2" color="#006600"><b> 
      <input type="text" name="handling" value="<%=temp_handlingfee%>" size="8" onChange="add2Total()" maxlength="20">
      </b></font></td>
    <td width="53"> <font size="2" color="#006600"><b> 
      <input type="text" name="dd" value="<%=temp_ddcharges%>" size="8" onChange="add2Total()" maxlength="20">
      </b></font></td>
    <td width="66"> <font size="2" color="#006600"><b> 
      <input type="text" name="total" value="<%=temp_total%>" size="10" maxlength="20" readonly>
      </b></font></td>
  </tr>
  <input type="hidden" name="country" value="<%=rs("countryID")%>">
  <input type="hidden" name="paxid" value="<%=rs("paxid")%> ">
  <%
	GrandTotal=GrandTotal+temp_total
	rs.movenext
	i=i+1
	wend

end if  
 
rs.close

 
stmt="select * from paxcab where refno="&refno

rs1.open stmt,con
if not rs1.eof then
uma1=2
%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="7" > 
      <div align="center">Cab booking chages :</div>
    </td>
  </tr>
  <%
			
			if rs1.fields("sdate")<>"" then
			sdate=systousrdate(rs1.fields("sdate"))
			end if
			if rs1.fields("enddate")<>"" then
			enddate=systousrdate(rs1.fields("enddate")) 
			end if
			cabno=rs1.fields("cabno")
			
			tot1=rs1.fields("total")
			if not (isNull(temp_cabfee) or temp_cabfee="" )then
			GrandTotal=GrandTotal+temp_cabfee
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" align="center" > <%=ucase(rs1.fields("name"))%> Booked from<%=ucase(rs1.fields("vehical"))%> 
      From <%=rs1.fields("sdate")%> To <%=rs1.fields("enddate")%> &nbsp;</td>
    <td width="66"> 
      <input type="text" name="cabfee" value="<%=temp_cabfee%>" size="8" onblur="add2Total()">
    </td>
  </tr>
  <%
 
			end if

rs1.close 
tot2="0"
stmt="select * from paxhotel where refno="&refno

rs1.open stmt,con
if not rs1.eof then
uma2=2
%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="7" > 
      <div align="center">Hotel booking charges :</div>
    </td>
  </tr>
  <%
			
			if rs1.fields("arrivaldate")<>"" then
			sdate=systousrdate(rs1.fields("arrivaldate"))
			end if
			if rs1.fields("departdate")<>"" then
			enddate=systousrdate(rs1.fields("departdate")) 
			end if
			cabno=rs1.fields("nosofdays")
	
			tot2=rs1.fields("total")
			if not (isNull(temp_hotelfee) or temp_hotelfee="" )then
			GrandTotal=GrandTotal+temp_hotelfee
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" align="center"> <%=ucase(rs1.fields("name"))%> Booked <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname")))
                              response.write " FROM"& sdate&" TO"&enddate
                              %> &nbsp;</td>
    <td width="66"> 
      <input type="text" name="hotelfee" value="<%=temp_hotelfee%>" size="8" onblur="add2Total()">
    </td>
  </tr>
  <%
			end if

rs1.close 
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con,2,3
rsmain.fields("bill")="Y"
rsmain.update
rsmain.close
%> 
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Poe: 
        <input type="text" name="poeremark"  size="50" value ="<%=temp_poeremark%>" >
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='poe' size='10' value="<%=temp_poefee%>" onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" >&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Misc. Charges : 
        <input type="text" name="miscremark"  size="50" value="<%=temp_miscremark%>" >
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='misc' size='10' value="<%=temp_miscfee%>" onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" ><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"></font></td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Attest Charges : 
        <input type="text" name="attestremark"  size="50" value="<%=temp_attestremark%>" >
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='attest' size='10' value="<%=temp_attestfee%>" onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" ><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"></font></td>
  </tr>
  
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" > 
      <div align="right">Courier: </div>
    </td>
    <td width="66" > 
      <input type='text' name='courier' size='10' value="<%=temp_courierfee%>" onchange ="add2Total()">
    </td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="7" bordercolor="#999999" >&nbsp; </td>
  </tr>
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" > 
      <div align="right">Gross Total: </div>
    </td>
    <% grandtotal=grandtotal+temp_courierfee+temp_attestfee+temp_miscfee+temp_poefee
    %>
    <td width="66" > 
      <input type="text" name="GrandTotal" value="<%=GrandTotal%>" size="10" maxlength="20" readonly>
    </td>
  </tr>
  <input type ="hidden" name ="i" value= "<%=i%>">
  <input type ="hidden" name ="invtype" value= "B">
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" >&nbsp;</td>
  
</table>
<table width="658" border="0" align="center">
  <tr bgcolor="#ffffff" > 
    <td colspan="2">Remarks: 
      <input type="text" name="remark" value="<%=temp_remark%>" size="72" >
    </td>
  </tr>
  <tr bgcolor="#ffffff" > 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffff" > 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffff" > 
    <td colspan="2"> E. & O. E.<br>
      1. Subject to Delhi Juridiction. <br>
      2.Please check, Interest chargeable on the bill not paid with in 15 days.<br>
      3.Service tax, if applicable will be charged separate.<br>
      4.In case of the discrepency, kindly return the bill for necessary correction 
      with in 10 days. </td>
  </tr>
  <tr width="300"> 
    <td align="right" colspan=2> <b>Authorised Signatory.</b> </td>
  </tr>
  <tr> 
    <td align="center"> 
    <% if flaginv=0 then %>
      <input type="submit" value=" Submit " size="20">
      <% else %>
      <input type="submit" value=" Back" size="20" onclick="history.back()">
      <% end if%>
    </td>
  </tr></form>
</table>
     <script language="javascript">
				function add2Total()
				{
				var z =document.regist.i.value;
				window.document.regist.GrandTotal.value =0;
				if (parseInt(z)==1)
				{
				  var visa=parseFloat(eval("document.regist.visafee.value"));
				  if (isNaN(visa)) 
				  {
				  visa=0;
				  }
				
				
				  var handling=parseFloat(eval("document.regist.handling.value"));
				  if (isNaN(handling)) 
				  {
				  handling=0;
			  	  }
				  var dd=parseFloat(eval("document.regist.dd.value"));
				  if (isNaN(dd)) 
				  {
				  dd=0;
				  }
				
				  document.regist.total.value= eval(visa+handling+dd);
				  window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(eval("document.regist.total.value"))
				} 
				else
				{
				for (i=0;i<z;i++)
				{
				  var visa=parseFloat(eval("document.regist.visafee("+i+").value"));
				  if (isNaN(visa)) 
				  {
				  visa=0;
				  }
				
				
				  var handling=parseFloat(eval("document.regist.handling("+i+").value"));
				  if (isNaN(handling)) 
				  {
				  handling=0;
			  	  }
				  var dd=parseFloat(eval("document.regist.dd("+i+").value"));
				  if (isNaN(dd)) 
				  {
				  dd=0;
				  }
				
				  document.regist.total(i).value= eval(visa+handling+dd);
				  window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(eval("document.regist.total(i).value"))
				}
				}
				if (document.regist.courier.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.courier.value);
				if (document.regist.attest.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.attest.value);
				if (document.regist.misc.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.misc.value);
				if (document.regist.poe.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.poe.value);
				
				<% if  uma1<>0 then %>
				if (document.regist.cabfee.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.cabfee.value);
				<%end if
				if  uma2<>0 then %>
				
				if (document.regist.hotelfee.value !='' )
				window.document.regist.GrandTotal.value =parseFloat(window.document.regist.GrandTotal.value)+parseFloat(document.regist.hotelfee.value);
				<%
				end if
				%>
				} 
				
		</script>
 </body>
</html>
 