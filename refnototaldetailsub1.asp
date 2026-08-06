
<!-- #include file="connection.asp" -->
<%
'OPTION EXPLICIT

Dim UnitNames, TeenNames, DecadeNames
UnitNames = Array(" zero"," one"," two"," three"," four", _
                  " five"," six"," seven"," eight"," nine" )
TeenNames = Array(" ten"," eleven"," twelve"," thirteen"," fourteen", _
                  " fifteen"," sixteen"," seventeen"," eighteen"," nineteen" )
DecadeNames = Array(" zero"," ten"," twenty"," thirty"," forty", _
                    " fifty"," sixty"," seventy"," eighty"," ninety" )

Function NumberAsWord( num )
    Dim millions, thousands, hundreds, decades, result

    If Not isNumeric( num ) Then
        NumberAsWord = "<i>That is NOT a valid number!</i>"
        Exit Function
    End If

    result = ""
    num = CDbl(num)

	If num = 0 Then
		NumberAsWord = "zero"
		Exit Function
	End If

    If num < 0 Then
        num = - num
        result = "<i>NEGATIVE</i> "
    End If

    millions = 999999

    On Error Resume Next
    millions = num \ 1000000
    num = CLng( num MOD 1000000 )
    On Error GoTo 0

    If millions > 0 Then
        If millions > 999 Then
            NumberAsWord = result & "BILLIONS and BILLIONS"
            Exit Function
        End If
        result = result & NumberAsWord( millions ) & " million"
        If num = 0 Then
            NumberAsWord = result
            Exit Function
        End If
    End If
    
    thousands = num \ 1000
    num = num MOD 1000
    If thousands > 0 Then
        result = result & NumberAsWord( thousands ) & " thousand"
        If num = 0 Then
            NumberAsWord = result
            Exit Function
        End If
    End If
    
    hundreds = num \ 100
    num = num MOD 100           
    If hundreds > 0 Then
        result = result & UnitNames( hundreds ) & " hundred"
    End If
    
    decades = num \ 10
    num = num MOD 10
    If decades = 1 Then
        result = result & TeenNames( num ) 
    Else
        If decades > 1 Then
            result = result & DecadeNames( decades )
        End If
        If num > 0 Then
            result = result & UnitNames( num )
        End If
    End If

    NumberAsWord = result
End Function

'response.write(ucase(NumberAsWord(99999999)))
%>
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>
<table width="110%" border="0">
  <tr>
    <td height="821"> 
      <table width="94%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr valign="middle" align="center"> 
          <td> 
            <p><font color="#000000" face="" size="5"><b> <font size="7"><%=udaanName%></font></b></font></p>
          </td>
        </tr>
        <tr> 
          <td  align="center"><font size="3" color="#000000" face="Arial, Helvetica, sans-serif"><%=udaanAddress%> 
            </font></td>
        </tr>
        <tr> 
          <td align="center"><font face="Arial, Helvetica, sans-serif" size="3" color="#000000"> 
            <%=Contactaccounts%></font></td>
        </tr>
      </table>
      <table width="85%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr> 
          <td align="center">&nbsp; <b> <font size="4"> </font> </b></td>
        </tr>
      </table>
      <form action="invoicesubmit.asp" method="post" name="regist">
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

if request("refno")<>"" then
refno=cdbl(request("refno"))
GrandTotal=0

  set invoiceno=server.createobject("adodb.recordset")
  invoiceno.open "select invoiceno from invoice where refno="&refno&" and invtype='B'",con
  if not invoiceno.eof then
  invno=invoiceno("invoiceno")
  end if
  invoiceno.close
  set invoiceno=nothing
else
invno=cdbl(request("invno"))
GrandTotal=0

  set invoiceno=server.createobject("adodb.recordset")
  invoiceno.open "select refno from invoice where invoiceno="&invno&" and invtype='B'",con
  if not invoiceno.eof then
  refno=invoiceno("refno")
  else
  uma3=2
  end if
  invoiceno.close
  set invoiceno=nothing
end if


if uma3<>2 then
'********************************* UMA SHANKAR BHARDWAJ **********************************

  set rsuma=server.createobject("adodb.recordset")
  rsuma.open "select count(*) from invoicedetail where invoiceno="&invno&"",con
	uma1=rsuma(0)
  rsuma.close
  rsuma.open "select count(*) from paxstatus where refno="&refno&"",con
	uma2=rsuma(0)
  rsuma.close
  set invoiceno=nothing

if uma1<>uma2 then
response.write "<b><font color='red' size='5'> Please Check this bill it have wrong no. of pax and contact to project administrator(Uma Shankar Bhardwaj).</b></font><br>"
end if

'*****************************************************************************************

set rsmain=server.createobject("adodb.recordset")
stmt="select * from mainentry where  refno="&refno 
rsmain.open stmt,con
agentid=rsmain.fields("agent")
paxname=rsmain.fields("paxname")
recdate=SysTOUsrDate(rsmain.fields("receivedate"))
refferer=rsmain.fields("refferer")
companyname=rsmain.fields("companyname")
receivedate=rsmain.fields("receivedate")
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
stmt="select * from invoice where refno="&refno&" and invtype ='B'"
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
end if
rs.close()
%> 
        <input type="hidden" name="refno" value="<%=refno %>">
        <input type="hidden" name="invoiceno" value="<%=invno %>">
        <input type="hidden" name="invtype" value="B">
        <table width="658" border="0" align="center">
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td colspan="3" height="27">
              <div align="center"><b><font size="6"><U>I N V O I C E</U></font></b><BR>
                &nbsp;</div>
            </td>
          </tr>
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td width="400" height="27"><b><font size="5">M/S. <%= company %></font>
<br><font size="4">
<%
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
                             %> </font></b><br>
            </td>
            <td width="56" height="27"> 
              <div align="center"><font size="4"> </font> </div>
            </td>
            <td width="198" height="27"> 
              <div align="right"><b><font size="5">INVOICE No. <%=temp_invoiceno%></font></b><br>
                <b><font size="4">Date. <%= systousrdate(temp_invoicedate) %> 
                </font></b></div>
            </td>
          </tr>
          <tr> 
            <td colspan="1" align="left" width="400"><b><font size="4">Ref No.</font></b> 
              <font size="4"><%= refno %> <b>Rec. Date.</b><font size="4"> <%= systousrdate(receivedate) %></font></font></td>
          </tr>
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td colspan="3" height="628"> 
              <table width="658" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" height="58">
                <tr > 
                  <td colspan="9" > 
                    <hr align="left" width="654">
                  </td>
                </tr>
                <tr > 
                  <td width="37" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>S.No.</b></font></div>
                  </td>
                  <td width="143" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>Pax 
                      Name</b></font></div>
                  </td>
                  <td width="96" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>Country</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>Visa 
                      Fee</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>H/C</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>DD Fee</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="4"><b>Total</b></font></div>
                  </td>
                  <td colspan="2" bgcolor="#CCCCCC" ><font size="4"></font></td>
                </tr>
                <tr> 
                  <td bgcolor=#FFFFFF valign="top" colspan="8" height="5"> 
                    <hr>
                  </td>
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
stmt ="select b.paxname,a.visafee,a.handlingfee,a.ddcharges,a.countryid from invoicedetail a,entrydetails b  where a.paxid=b.paxid and a.invoiceno="&invno&" and a.invtype='B' order by b.paxname"
rs.open stmt,con
counter =1
if not rs.eof then
while not rs.eof
	one_name=trim(rs.fields("paxname"))
	'total=rs.fields("total")
	
if  strComp(one_name,old_name) then 
	%> 
                  <td bgcolor=#FFFFFF valign="top" width="37" height="5"> 
                    <div align="center"><font size="4"><b>&nbsp;<%= counter %></b></font></div>
                  </td>
                  <td bgcolor=#FFFFFF width="143" valign="top" align=center height="5"> 
                    <font size="4"><b> <%
response.write ucase(one_name)
	old_name=one_name

	counter =counter+1
	else
	%></b></font> 
                  <td bgcolor=#FFFFFF width="96" height="5"><font color="#000000"></font></td>
                  <td bgcolor=#FFFFFF width="143" align=center height="5"> 
                    <div align="center"></div>
                    <font color="#000000" size="6"><%
	end if
	

   temp_handlingfee=rs("handlingfee")

   temp_visafee=rs("visafee")

   temp_dd=rs("ddcharges")
   temp_total=temp_handlingfee + temp_visafee + temp_dd


%></font></td>
                  <td bgcolor=#FFFFFF width="80" height="5"> 
                    <div align="center"><font color="#000000" size="4"><b><%
call writeIDDescription("embassy", rs("countryID"))
	%>&nbsp;</b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="80" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_visafee%> 
                      </font></b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="80" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_handlingfee%> 
                      </font></b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="45" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_dd%> 
                      </font> </b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" colspan="3" height="5" > 
                    <div align="center"><font  color="#000000"><b><font size="6"><%=temp_total%></font></b></font></div>
                    <div align="right"><font size="4" color="#000000"><b></b></font></div>
                    <div align="right"><font size="2" color="#000000" face="Arial, Helvetica, sans-serif"><b> 
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
                <tr> 
                  <td colspan="9" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><b>CAB BOOKING CHARGES</b> 
                      </font></div>
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
                <tr> 
                  <td colspan="6" align="center" bgcolor="#ffffFF" > <%=ucase(rs1.fields("name"))%> 
                    Book <%=ucase(rs1.fields("vehical"))%> From <%=systousrdate(rs1.fields("sdate"))%> 
                    To <%=systousrdate(rs1.fields("enddate"))%> <% if rs1.fields("actualkm")<>"" then %> 
                    Total Kms.:<%=rs1.fields("actualkm")%><% end if %><% if rs1.fields("actualkm")<>"" and rs1.fields("actualhour")<>"" then %> 
                    and <% end if %><% if rs1.fields("actualhour")<>"" then %>Total 
                    hours : <%=rs1.fields("actualhour")%> <% end if %></td>
                  <td valign="top" colspan="3" bgcolor="#ffffFF"> 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_cabfee%> 
                      </font><font size="4"> </font> </b></font></div>
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
                <tr> 
                  <td colspan="9" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><b>HOTEL BOOKING 
                      CHARGES</b></font></div>
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
                <tr> 
                  <td colspan="6" align="center" bgcolor="#ffffFF"> <%=ucase(rs1.fields("name"))%> 
                    Book <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname"))) %> 
                    FROM <%= sdate %> TO <%=enddate %> &nbsp;Tariff/day <%=rs1.fields("tariff")%> 
                    + 20% Tax. No of days.: <%= rs1.fields("nosofdays") %></td>
                  <td colspan="3" bgcolor="#ffffFF"> 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_hotelfee%> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" height="20" bgcolor="#ffffFF" >&nbsp;</td>
                  <td  align="center" height="20" colspan="3" bgcolor="#ffffFF" >&nbsp;</td>
                </tr>
                <%
			end if

rs1.close 
GrandTotal=GrandTotal+temp_courierfee+temp_misc+temp_poe+temp_attestfee
%> 
                <tr> 
                  <td colspan="9" height="2" bgcolor="#ffffFF" > 
                    <div align="right"> </div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" height="20" bgcolor="#ffffFF" > 
                    <div align="center"><b><font size="4">PoE.</font></b> <font size="4"><%=temp_poeremark %></font></div>
                  </td>
                  <td  align="center" height="20" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_poe %> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" height="22" bgcolor="#ffffFF" > 
                    <div align="center"><b><font size="4">Misc. Charges 1 :</font></b> 
                      <font size="4"><%=temp_miscremark%> </font> </div>
                  </td>
                  <td  align="center" height="22" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_misc %> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" height="22" bgcolor="#ffffFF" > 
                    <div align="center"><b><font size="4">Misc. Charges 2:</font></b> 
                      <font size="4"><%=temp_attestremark%> </font> </div>
                  </td>
                  <td  align="center" height="22" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000" size="6"><b><%=temp_attestfee %> 
                      </b></font><font color="#000000"><b> </b></font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" height="20" bgcolor="#ffffFF" > 
                    <div align="right"><font color="#000000"><b><font size="4">Courier:</font> 
                      </b></font></div>
                  </td>
                  <td  align="center" height="20" colspan="3" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><b><font size="6"><%=temp_courierfee %> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="9" bordercolor="#999999" bgcolor="#ffffFF" > 
                    <hr width="65" align="right" noshade size="2">
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" bordercolor="#999999" bgcolor="#ffffFF" > 
                    <div align="right"><font color="#000000"><b><font size="4">Gross 
                      Total:</font> </b></font></div>
                  </td>
                  <td  align="center" colspan="3" bgcolor="#ffffFF"> 
                    <div align="center"><font color="#000000"><b><font size="6"><%=GrandTotal%> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="9" bordercolor="#999999" height="24" bgcolor="#ffffFF" > 
                    <hr width="65" align="right" noshade>
                    <% if trim(refferer)<>"" or trim(companyname)<>"" then %> 
                    <font size="4">Refferer : <%=ucase(refferer)%> | Co./File 
                    No : <%=ucase(companyname)%><br>
                    <br>
                    </font> <% end if %> <font size="4">Rs. <%=ucase(NumberAsWord(GrandTotal))%> 
                    ONLY</font><b><br>
                    <br>
                    <font size="4">Remarks:</font></b><%=temp_remark%></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="9" bordercolor="#999999" height="24" bgcolor="#ffffFF" >&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td colspan="9" bordercolor="#999999" height="133" bgcolor="#ffffFF" > 
                    <p><b><font size="4">E. & O. E.</font></b><br>
                      1. &nbsp;No dispute or objection will be entertained if 
                      not brought to our notice within 7 days from the date <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hereof in writing. <br>
                      2.&nbsp;&nbsp;We reserve the right to charge interest @ 
                      18 % per annum on all overdue outstanding.<br>
                      3. &nbsp;Cash Payment should be made only to the cashier 
                      direct against official receipt.<br>
                      4.&nbsp;&nbsp;A/c Payee cheques / drafts should be drawn 
                      in favour of UDAAN INDIA (P) LTD.<br>
                      5.&nbsp;&nbsp;All disputes subject to delhi jurisdiction 
                      only. </p>
                    <p><br>
                      <br>
                    </p>
                    <p><b>Authorised Signatory</b> </p>
                  </td>
                </tr>
                <input type ="hidden" name ="i2" value= "<%=i%>">
              </table>
            </td>
          </tr>
        </table>
        </form>
    </td>
  </tr>
</table>
</body>
</html>
<%
	else
	response.write "<b><font color='red' size='5'> Please Check Your Invoice No. I Think it's Wrong Invoice no. or Should be Void bill. if u have Prob. Then contact to project administrator(Uma Shankar Bhardwaj).</b></font><br>"
 	end if 
%>