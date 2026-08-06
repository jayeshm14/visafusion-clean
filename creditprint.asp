
<!-- #include file="connection.asp" -->

<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr valign="middle" align="center"> 
    <td> 
      <p><font color="#000000" face="Arial, Helvetica, sans-serif" size="3"><b> 
        <%=udaanName%></b></font></p>
    </td>
  </tr>
  <tr> 
    <td  align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"><%=udaanAddress%> 
      </font></TD>
  </TR>
  <tr> 
    <td align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"> 
      <%=udaanContact%></font></td>
  </tr>
</table>
<table width="85%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td align="center">&nbsp; <b> <font size="4"> </font> </b></td>
  </tr>
  <tr> 
    <td align="center">&nbsp;</td>
  </tr>
  <tr> 
    <td align="center">&nbsp;</td>
  </tr>
</TABLE>

<%
refno=cint(request("refno"))
GrandTotal=0

  set invoiceno=server.createobject("adodb.recordset")
  invoiceno.open "select invoiceno from invoice where refno="&refno&" and invtype='C'",con
  if not invoiceno.eof then
  invno=invoiceno("invoiceno")
  end if
  invoiceno.close
  set invoiceno=nothing
 
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

set rs=server.createobject("adodb.recordset")
stmt="select * from invoice where refno="&refno&" and invtype ='C'"
rs.open stmt,con,2,3
if not rs.eof then
temp_invoiceno=rs.fields("invoiceno")
temp_hotelfee=rs.fields("hotelfee")
temp_cabfee=rs.fields("cabfee")
temp_invoicedate=rs.fields("invoicedate")
temp_courierfee=rs.fields("courierfee")
temp_attestfee=rs.fields("attestfee")
temp_attestremark=rs.fields("attestremark")
temp_misc=rs.fields("misc")
temp_miscremark=rs.fields("miscremark")
temp_poe=rs.fields("poe")
temp_poeremark=rs.fields("poeremark")
temp_remark=rs.fields("remark")
rs.close()
%> 
<table width="658" border="0" align="center">
  <tr bgcolor="#ffffff" border=0 valign="top"> 
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
                             %> </b></font><br>
    </td>
    <td width="331"> 
      <div align="center"><b>Credit No.</b> <%=temp_invoiceno%> </div>
    </td>
    <td width="160"> 
      <div align="center"><b>Dated</b>. <%= systousrdate(temp_invoicedate) %> </div>
    </td>
  </tr>
  <tr><td colspan="1" align="left"><b>Ref No.</b> <%= refno %></td>
  <td colspan="2"> <b>We Have Credited Your Account With Us As Follows :</b> <td>
  </tr>
  <tr bgcolor="#ffffff" border=0 valign="top">
    <td width="153">&nbsp;</td>
    <td width="331">&nbsp;</td>
    <td width="160">&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffff" border=0 valign="top"> 
    <td colspan="3"> 
      <table width="658" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bgcolor="#999999" height="58">
        <tr bgcolor="#CCCCCC" > 
          <td width="37" > 
            <div align="center"><font color="#000000"><b>S.No.</b></font></div>
          </td>
          <td width="143" > 
            <div align="center"><font color="#000000"><b>Name</b></font></div>
          </td>
          <td width="96" > 
            <div align="center"><font color="#000000"><b>Country</b></font></div>
          </td>
          <td width="80" > 
            <div align="center"><font color="#000000"><b>Visa Fee</b></font></div>
          </td>
          <td width="80" > 
            <div align="center"><font color="#000000"><b>H/C</b></font></div>
          </td>
          <td width="80" > 
            <div align="center"><font color="#000000"><b>DD Fee</b></font></div>
          </td>
          <td width="80" > 
            <div align="center"><font color="#000000"><b>Total</b></font></div>
          </td>
          <td colspan="2" >&nbsp;</td>
        </tr>
        <tr> <%
total=0
old_name=""
i=0
tot1=0
tot2=0

set rs=server.createobject("adodb.recordset")
set rs1=server.createobject("adodb.recordset")
set rs2=server.createobject("adodb.recordset")
stmt ="select b.paxname,a.visafee,a.handlingfee,a.ddcharges,a.countryid from invoicedetail a,entrydetails b  where a.paxid=b.paxid and a.invoiceno="&invno&" and a.invtype='C' order by b.paxname"
rs.open stmt,con
counter =1
if not rs.eof then
while not rs.eof
	one_name=trim(rs.fields("paxname"))
	'total=rs.fields("total")
	
if  strComp(one_name,old_name) then 
	%> 
          <td bgcolor=#FFFFFF valign="top" width="37"> 
            <div align="center">&nbsp;<%= counter %></div>
          </td>
          <td bgcolor=#FFFFFF width="143" valign="top" align=center> <font size="2" face="Arial, Helvetica, sans-serif"><%
response.write ucase(one_name)
	old_name=one_name

	counter =counter+1
	else
	%> </font> 
          <td bgcolor=#FFFFFF width="96"><font color="#000000"></font></td>
          <td bgcolor=#FFFFFF width="143" align=center> 
            <div align="center"></div>
            <font color="#000000"><%
	end if
	

   temp_handlingfee=rs("handlingfee")

   temp_visafee=rs("visafee")

   temp_dd=rs("ddcharges")
   temp_total=temp_handlingfee + temp_visafee + temp_dd


%></font></td>
          <td bgcolor=#FFFFFF width="80"> 
            <div align="center"><font color="#000000" size="2" face="Arial, Helvetica, sans-serif"><%
call writeIDDescription("embassy", rs("countryID"))
	%>&nbsp;</font></div>
          </td>
          <td bgcolor="#FFFFFF" width="80" > 
            <div align="center"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b> 
              <%=temp_visafee%> </b></font></div>
          </td>
          <td bgcolor="#FFFFFF" width="80" > 
            <div align="center"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b> 
              <%=temp_handlingfee%> </b></font></div>
          </td>
          <td bgcolor="#FFFFFF" width="45" >
            <div align="center"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b><%=temp_dd%></b></font></div>
          </td>
          <td bgcolor="#FFFFFF" colspan="3" > 
            <div align="center"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b><%=temp_total%></b></font></div>
            <div align="right"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b> 
              </b></font></div>
            <div align="center"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b> 
              </b></font></div>
          </td>
        </tr>
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

%> 
        <tr bgcolor="#ffffFF"> 
          <td colspan="9" > 
            <div align="center"><font color="#000000">Cab booking chages :</font></div>
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
			
			'tot1=rs1.fields("total")
			
			GrandTotal=GrandTotal+temp_cabfee

			%> 
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" align="center" > <font color="#000000"><%=ucase(rs1.fields("name"))%> 
            Booke <%=ucase(rs1.fields("vehical"))%> From <%=rs1.fields("sdate")%> 
            TO <%=rs1.fields("enddate")%> &nbsp;</font></td>
          <td valign="top" colspan="3"> 
            <div align="center"><font color="#000000"><b><%=temp_cabfee%> </b></font></div>
          </td>
        </tr>
        <%
 
			end if

rs1.close 
tot2="0"
stmt="select * from paxhotel where refno="&refno

rs1.open stmt,con
if not rs1.eof then

%> 
        <tr bgcolor="#ffffFF"> 
          <td colspan="9" > 
            <div align="center"><font color="#000000">Hotel booking charges :</font></div>
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
	
			'tot2=rs1.fields("total")
			'if not (isNull(tot2) or tot2="" )then
			GrandTotal=GrandTotal+temp_hotelfee
			'end if
			%> 
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" align="center"> <font color="#000000"><%=ucase(rs1.fields("name"))%> 
            Booked <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname")))
                              response.write " FROM"& sdate&" TO"&enddate
                              %> &nbsp;</font></td>
          <td colspan="3"> 
            <div align="center"><font color="#000000"><b><%=temp_hotelfee%> </b></font></div>
          </td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" height="20" >&nbsp;</td>
          <td  align="center" height="20" colspan="3" >&nbsp;</td>
        </tr>
        <%
			end if

rs1.close 
GrandTotal=GrandTotal+temp_courierfee+temp_misc+temp_poe+temp_attestfee
%> 
        <tr bgcolor="#ffffFF"> 
          <td colspan="9" height="20" > 
            <div align="right"> 
              <hr width="654" align="center">
            </div>
          </td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" height="20" > 
            <div align="center"><b>PoE.</B> <%=temp_poeremark %></div>
          </td>
          <td  align="center" height="20" colspan="4" > <font color="#000000"><b><%=temp_poe %> 
            </b></font></td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" height="20" > 
            <div align="center"><B>Misc. Charges:</B> <%=temp_remark%> </div>
          </td>
          <td  align="center" height="20" colspan="4" > <font color="#000000"><b><%=temp_misc %> 
            </b></font></td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" height="20" > 
            <div align="center"><B>Attest Charges:</B> <%=temp_attestremark%> </div>
          </td>
          <td  align="center" height="20" colspan="4" > <font color="#000000"><b><%=temp_attestfee %> 
            </b></font></td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" height="20" > 
            <div align="right"><font color="#000000"><B>Courier: </B></font></div>
          </td>
          <td  align="center" height="20" colspan="3" > <font color="#000000"><b><%=temp_courierfee %> 
            </b></font></td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="9" bordercolor="#999999" > 
            <hr width="65" align="right" noshade size="2">
          </td>
        </tr>
        <tr bgcolor="#ffffFF"> 
          <td colspan="6" bordercolor="#999999" > 
            <div align="right"><font color="#000000"><B>Gross Total: </B></font></div>
          </td>
          <td  align="center" colspan="3"> <font color="#000000"><b><%=GrandTotal%> 
            </b></font></td>
        </tr>
        <tr bgcolor="#ffffFF" valign="top"> 
          <td colspan="9" bordercolor="#999999" height="24" > 
            <hr width="65" align="right" noshade>
            <B>Remarks:</B><%=temp_remark%></td>
        </tr>
        <tr bgcolor="#ffffFF" valign="top"> 
          <td colspan="9" bordercolor="#999999" height="24" >&nbsp;</td>
        </tr>
        <tr bgcolor="#ffffFF" valign="top"> 
          <td colspan="9" bordercolor="#999999" height="24" >E. & O. E.<br>
            1. Subject to Delhi Juridiction. <br>
            2.Please check, Interest chargeable on the bill not paid with in 15 
            days.<br>
            3.Service tax, if applicable will be charged separate.<br>
            4.In case of the discrepency, kindly return the bill for necessary 
            correction with in 10 days. </td>
        </tr>
        <input type ="hidden" name ="i2" value= "<%=i%>">
      </table>
    </td>
  </tr>
</table>                       
 
<table width="658" border="0" align="center">
  <tr bgcolor="#ffffff" > 
    <td colspan="2" rowspan="2">&nbsp;</td>
  </tr>
  <tr bgcolor="#ffffff" > </tr>
  <tr width="300"> 
    <td align="right" colspan=2>&nbsp;</td>
    <td align="CENTER" colspan=2>&nbsp;</td>
  </tr>
  <tr width="300"> 
    <td align="right" colspan=2>&nbsp;</td>
    <td align="CENTER" colspan=2>&nbsp;</td>
  </tr>
  <tr width="300"> 
    <td align="right" colspan=2> 
      <div align="left"><b><a href="javascript:print()">Authorised Signatory.</a></b> 
      </div>
    </td>
    <br>
    <td align="CENTER" colspan=2>&nbsp; </td>
  </tr>
</table>
<%

else
response.write"<b><center>Cr. Note of this invoice is not available</b></center>"
end if
%>
 </body>
</html>
 