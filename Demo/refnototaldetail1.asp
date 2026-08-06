<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"><script language="JavaScript">
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
<tr>
    <td align="center"><font face='arial' size=2 color='#000000'> <%=contactaccounts%></font></td>
  </tr></table>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center"><tr>
<td align="center">&nbsp;
<b> <font size="4"> </font> </b></td></tr>
<form action="listbill1.asp" method="post" name="regist">
<INPUT type="hidden" name="cmd1" value="<%=request("cmd") %>">

<%

refno=cdbl(request("refno"))
GrandTotal=0

set invoiceno=server.createobject("adodb.recordset")
invoiceno.open "select invoiceno from invoice where invtype='B' order by invoiceno desc",con
if invoiceno.eof then
	'  stmt="insert into invoice(refno,invtype) values("&refno&",'B')"
	'  con.execute stmt
invno=1
else
invno=invoiceno("invoiceno")
invno=invno+1
end if
invoiceno.close

	'  invoiceno.open "select invoiceno from invoice where refno="&refno&" and invtype ='B' ",con
	'  if not invoiceno.eof then
	'  invno=invoiceno("invoiceno")
	'  end if
	'  invoiceno.close
set invoiceno=nothing

set rsmain=server.createobject("adodb.recordset")
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con
agentid=rsmain.fields("agent")
paxname=rsmain.fields("paxname")
recdate=SysTOUsrDate(rsmain.fields("receivedate"))
internalremark=rsmain.fields("internalremark")

poe=rsmain.fields("poe")
poe=getDescriptionForID("poe",poe)
if ucase(poe)<>ucase("None") then
poe=poe
else
poe=""
end if
rsmain.close

stmt="select * from agents where  agentsid="&agentid 
rsmain.open stmt,con
company=rsmain.fields("companyname")
street1=rsmain.fields("street1")
street2=rsmain.fields("street2")
area=rsmain.fields("area")
city=rsmain.fields("city")
pincode=rsmain.fields("pincode")
payment=rsmain.fields("payment")
rsmain.close

uma=0
sdate=date()

set rsi=server.createobject("adodb.recordset")
rsi.open "select refno, invoiceno from invoice where day(invoicedate) = "&day(sdate)&" and month(invoicedate)="&month(sdate)&" and year(invoicedate)="&year(sdate)&" order by invoiceno desc",con

if not rsi.eof then
set rsj=server.createobject("adodb.recordset")

while not rsi.eof

refno1=rsi.fields("refno")
rsj.open "select agent from mainentry where refno='"&refno1&"'",con
if agentid=rsj.fields("agent") then
uma=uma+1
end if
rsj.close
rsi.movenext
wend
end if

%>



</TABLE>


<input type="hidden" name="refno" value="<%=refno %>">
<input type="hidden" name="agent" value="<%=agentid %>">
<input type="hidden" name="invoiceno" value="<%=invno %>">
<input type="hidden" name="invoicedate" value="<%=date() %>">
<input type="hidden" name="paxname" value="<%=paxname%>">
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
      <div align="center"><b>INVOICE NO. <%= invno %> </b></div>
    </td>
    <td width="255"> 
      <div align="center">DATED. <%= systousrdate(date()) %> </div>
    </td>
  </tr>
  <tr>
    <td colspan="3" align="left"><b>Ref No.</b> <%= refno %>
<% if uma<>0 then %>
&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000"><b>You 
      have already make <%=uma%> Bill for this agent</b></font>
<% end if %>
</td>
  </tr>
</table>                       
 
<table width="658" border="0" align="center">
  <tr > 
    <td colspan="7" ><% if payment<>"" then %><img src="images/alert1.gif" width="40" height="20"> 
      Payment Condition is : <font color="#FF0000"><b><%=payment%>&nbsp;<% end if %></b></font></td>
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
stmt ="select Entrydetails.Totalpax,paxstatus.paxid, paxstatus.total,paxstatus.refno, paxstatus.visafee,paxstatus.handlingfee,paxstatus.ddcharges,paxstatus.colcheck, paxstatus.paxID,EntryDetails.paxname,paxstatus.countryID,paxstatus.statusID,paxstatus.sentdate,entryDetails.Paxname, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.refno="&refno&"   order by entryDetails.Paxname"
rs.open stmt,con
  
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

'temp_total=rs("total")UdaanIndia.commp_handlingfee + temp_visafee + temp_ddcharges

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
      <div align="center"><font color="#000000"><b>CAB BOOKING CHARGES</b> </font></div>
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
			if not (isNull(tot1) or tot1="" )then
			GrandTotal=GrandTotal+tot1
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" align="center" > <%=ucase(rs1.fields("name"))%> Book <%=ucase(rs1.fields("vehical"))%> 
      From <%=systousrdate(rs1.fields("sdate"))%> To <%=systousrdate(rs1.fields("enddate"))%> 
      <% if rs1.fields("actualkm")<>"" then %> Total Kms.:<%=rs1.fields("actualkm")%><% end if %><% if rs1.fields("actualkm")<>"" and rs1.fields("actualhour")<>"" then %> 
      and <% end if %><% if rs1.fields("actualhour")<>"" then %>Total hours : 
      <%=rs1.fields("actualhour")%> <% end if %></td>
    <td width="66"> 
      <input type="text" name="cabfee" value="<%=tot1%>" size="8" onChange="add2Total()">
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
      <div align="center"><font color="#000000"><b>HOTEL BOOKING CHARGES</b></font></div>
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
			if not (isNull(tot2) or tot2="" )then
			GrandTotal=GrandTotal+tot2
			end if
			%> 
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" align="center"> <%=ucase(rs1.fields("name"))%> Book <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname"))) %> 
      FROM <%= sdate %> TO <%=enddate %> &nbsp;Tariff/day <%=rs1.fields("tariff")%> 
      + 20% Tax. No of days.: <%= rs1.fields("nosofdays") %></td>
    <td width="66"> 
      <input type="text" name="hotelfee" value="<%=tot2%>" size="8" onChange="add2Total()">
    </td>
  </tr>
  <%
			end if

rs1.close 
	'stmt="select * from mainentry where  refno="&refno 
	'rsmain.open stmt,con,2,3
	'rsmain.fields("bill")="Y"
	'rsmain.update
	'rsmain.close
%> 
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Poe: 
        <input type="text" name="poeremark"  size="50" value="<%=poe%>">
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='poe' size='10' onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" >&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Misc. Charges 1: 
        <input type="text" name="miscremark"  size="50" >
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='misc' size='10' onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" ><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"></font></td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="6" height="20" > 
      <div align="right">Misc. Charges 2: 
        <input type="text" name="attestremark"  size="50" >
      </div>
    </td>
    <td width="66" > 
      <input type='text' name='attest' size='10' onchange ="add2Total()">
    </td>
    <td  align="center" height="20" width="78" ><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"></font></td>
  </tr>
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" > 
      <div align="right">Courier: </div>
    </td>
    <td width="66" > 
      <input type='text' name='courier' size='10' onchange ="add2Total()">
    </td>
  </tr>
  <tr bgcolor="#ffffFF" bordercolor="#FFFFFF"> 
    <td colspan="7" bordercolor="#999999" >&nbsp; </td>
  </tr>
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" > 
      <div align="right">Gross Total: </div>
    </td>
    <td width="66" > 
      <input type="text" name="GrandTotal" value="<%=GrandTotal%>" size="10" maxlength="20" readonly>
    </td>
  </tr>
  <input type ="hidden" name ="i" value= "<%=i%>">
  <input type ="hidden" name ="invtype" value= "B">
  <input type ="hidden" name ="message" value= "bill formed">
  <tr bgcolor="#ffffFF"> 
    <td colspan="6" >&nbsp;</td>
  
</table>
<table width="658" border="0" align="center">
  <tr bgcolor="#ffffff" > 
    <td colspan="2">Remarks: 
      <input type="text" name="remark"  size="72" value="<%=internalremark%>" >
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
      <input type="submit" value=" Submit " size="20">
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
 

