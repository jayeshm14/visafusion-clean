
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

%>
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>
<table width="750" border="0" align="center">
  <tr>
    <td height="821"> 
      <table width="94%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr valign="middle" align="center"> 
          <td height="8"> 
            <p><font color="#000000" face="" size="5"><b> <font size="3">&nbsp;</font></b></font></p>
          </td>
        </tr>
        <tr> 
          <td  align="center" height="7"><font size="3" color="#000000" face="verdana"> 
            &nbsp; </font></td>
        </tr>
        <tr> 
          <td align="center" height="2"><font face="verdana" size="3" color="#000000"> 
            </font></td>
        </tr>
      </table>
      <table width="85%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr> 
          <td align="center" height="2">&nbsp;</td>
        </tr>
      </table>
      <form action="invoicesubmit.asp" method="post" name="regist">

<%
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
        <table width="748" border="0" align="center">
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td colspan="3" height="27">
              <div align="center"><BR>
                &nbsp;</div>
            </td>
          </tr>
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td width="400" height="27"><b><font size="3" face="Verdana">M/S.</font><font size="4" face="Verdana"> 
              <%= company %></font> <br>
              <font size="3" face="Verdana"> <%
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
            <td width="240" height="27"> 
              <div align="right"><b><font size="3" face="Verdana">INVOICE No.</font><font size="4"> 
                <%=temp_invoiceno%></font></b><br>
                <b><font size="3" face="Verdana">Date.</font><font size="3"> <%= systousrdate(temp_invoicedate) %> 
                </font></b></div>
            </td>
          </tr>
          <tr> 
            <td colspan="3" align="left"><b><font size="3" face="Verdana">Ref 
              No.</font></b> <font size="3"><%= refno %> <b><font face="Verdana">Rec. 
              Date.</font></b><font size="4"> <%= systousrdate(receivedate) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3" face="Verdana"><b><font size="2">Service 
              Tax No:- AAACU1041JST001</font></b></font></font></font></td>
          </tr>
          <tr bgcolor="#ffffff" border=0 valign="top"> 
            <td colspan="3" height="628"> 
              <table width="748" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" height="58">
                <tr > 
                  <td colspan="10" > 
                    <hr>
                  </td>
                </tr>
                <tr bgcolor="#FFFFFF" > 
                  <td width="47" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>S.No.</b></font></div>
                  </td>
                  <td width="143" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>Pax 
                      Name</b></font></div>
                  </td>
                  <td width="76" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>Country</b></font></div>
                  </td>
                  <td width="77" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>Visa 
                      Fee</b></font></div>
                  </td>
                  <td width="109" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>VFS/Others 
                      </b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>H/C</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>DD 
                      Fee</b></font></div>
                  </td>
                  <td width="80" bgcolor="#CCCCCC" > 
                    <div align="center"><font color="#000000" size="3" face="Verdana"><b>Total</b></font></div>
                  </td>
                  <td colspan="2" bgcolor="#CCCCCC" ><font size="4"></font></td>
                </tr>
                <tr> 
                  <td bgcolor=#FFFFFF valign="top" colspan="10" height="5"> 
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
stmt ="select b.paxname,a.visafee,a.VFSTTCharges,a.handlingfee,a.ddcharges,a.countryid from invoicedetail a,entrydetails b  where a.paxid=b.paxid and a.invoiceno="&invno&" and a.invtype='B' order by b.paxname"
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
                  <td bgcolor=#FFFFFF valign="top" width="37" height="5"></td>
                  <td bgcolor=#FFFFFF width="143" align=center height="5"> 
                    <div align="center"></div>
                    <font color="#000000" size="5"><%
	end if
	

   temp_handlingfee=rs("handlingfee")

   temp_visafee=rs("visafee")

   temp_VFSTTCharges=rs("VFSTTCharges")

   temp_dd=rs("ddcharges")
   temp_total=temp_handlingfee + temp_visafee + temp_VFSTTCharges + temp_dd


%></font></td>
                  <td bgcolor=#FFFFFF width="80" height="5"> 
                    <div align="center"><font color="#000000" size="4"><b><%
call writeIDDescription("embassy", rs("countryID"))
	%>&nbsp;</b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="80" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_visafee%> 
                      </font></b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="80" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_VFSTTCharges%> 
                      </font></b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="80" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_handlingfee%> 
                      </font></b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" width="45" height="5" > 
                    <div align="center"><font color="#000000"><b><font size="5"><%=temp_dd%> 
                      </font> </b></font></div>
                  </td>
                  <td bgcolor="#FFFFFF" colspan="3" height="5" > 
                    <div align="center"><font  color="#000000"><b><font size="5"><%=temp_total%></font></b></font></div>
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
                  <td colspan="10" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000" face="verdana"><b>CAB 
                      BOOKING CHARGES</b> </font></div>
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
                  <td colspan="7" align="center" bgcolor="#ffffFF" > <%=ucase(rs1.fields("name"))%> 
                    Book <%=ucase(rs1.fields("vehical"))%> From <%=systousrdate(rs1.fields("sdate"))%> 
                    To <%=systousrdate(rs1.fields("enddate"))%> <% if rs1.fields("actualkm")<>"" then %> 
                    Total Kms.:<%=rs1.fields("actualkm")%><% end if %><% if rs1.fields("actualkm")<>"" and rs1.fields("actualhour")<>"" then %> 
                    and <% end if %><% if rs1.fields("actualhour")<>"" then %>Total 
                    hours : <%=rs1.fields("actualhour")%> <% end if %></td>
                  <td valign="top" colspan="3" bgcolor="#ffffFF"> 
                    <div align="center"><font color="#000000"><font size="5" face="verdana"><%=temp_cabfee%> 
                      </font></font></div>
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
                  <td colspan="10" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000" face="verdana"><b>HOTEL 
                      BOOKING CHARGES</b></font></div>
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
                  <td colspan="7" align="center" bgcolor="#ffffFF"> <%=ucase(rs1.fields("name"))%> 
                    Book <% call writeIDDescription("hotel",ucase(rs1.fields("hotelname"))) %> 
                    FROM <%= sdate %> TO <%=enddate %> &nbsp;Tariff/day <%=rs1.fields("tariff")%> 
                    + 20% Tax. No of days.: <%= rs1.fields("nosofdays") %></td>
                  <td colspan="3" bgcolor="#ffffFF"> 
                    <div align="center"><font color="#000000"><font size="5"><%=temp_hotelfee%> 
                      </font> </font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" height="20" bgcolor="#ffffFF" >&nbsp;</td>
                  <td  align="center" height="20" colspan="3" bgcolor="#ffffFF" > 
                    <div align="center"></div>
                  </td>
                </tr>
                <%
			end if

rs1.close 
GrandTotal=GrandTotal+temp_courierfee+temp_misc+temp_poe+temp_attestfee
%> 
                <tr> 
                  <td colspan="10" height="2" bgcolor="#ffffFF" > 
                    <div align="right"> </div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" height="20" bgcolor="#ffffFF" > 
                    <div align="center"><font size="3" face="Verdana"><b>PoE.</b> 
                      <%=temp_poeremark %></font></div>
                  </td>
                  <td  align="center" height="20" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><font size="5" face="verdana"><%=temp_poe %> 
                      </font> </font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" height="22" bgcolor="#ffffFF" > 
                    <div align="center"><font size="3" face="Verdana"><b>Misc. 
                      Charges 1 :</b> <%=temp_miscremark%> </font> </div>
                  </td>
                  <td  align="center" height="22" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><font size="5" face="verdana"><%=temp_misc %> 
                      </font> </font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" height="22" bgcolor="#ffffFF" > 
                    <div align="center"><font size="3" face="Verdana"><b>Misc. 
                      Charges 2:</b> <%=temp_attestremark%> </font> </div>
                  </td>
                  <td  align="center" height="22" colspan="4" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000" size="5" face="verdana"><%=temp_attestfee %> 
                      </font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" height="20" bgcolor="#ffffFF" > 
                    <div align="right"><font color="#000000"><b><font size="3" face="Verdana">Courier:</font> 
                      </b></font></div>
                  </td>
                  <td  align="center" height="20" colspan="3" bgcolor="#ffffFF" > 
                    <div align="center"><font color="#000000"><font size="5" face="verdana"><%=temp_courierfee %> 
                      </font> </font></div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" bordercolor="#999999" bgcolor="#ffffFF" >&nbsp; </td>
                  <td colspan="3" bordercolor="#999999" bgcolor="#ffffFF" > 
                    <hr width="85" align="center" noshade size="2">
                  </td>
                </tr>
                <tr> 
                  <td colspan="7" bordercolor="#999999" bgcolor="#ffffFF" height="11" > 
                    <div align="right"><font color="#000000"><b><font size="4" face="Verdana">Gross 
                      Total:</font> </b></font></div>
                  </td>
                  <td  align="center" colspan="3" bgcolor="#ffffFF" height="11"> 
                    <div align="center"><font color="#000000"><b><font size="6" face="verdana"><%=GrandTotal%> 
                      </font> </b></font></div>
                  </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="7" bordercolor="#999999" height="23" bgcolor="#ffffFF" >&nbsp; 
                  </td>
                  <td colspan="3" bordercolor="#999999" height="23" bgcolor="#ffffFF" > 
                    <hr width="85" align="center" noshade size="2">
                  </td>
                </tr>
                <tr valign="top"> 
                  <td colspan="10" bordercolor="#999999" height="24" bgcolor="#ffffFF" > 
                    <% if trim(refferer)<>"" or trim(companyname)<>"" then %> 
                    <font size="3" face="Verdana"><b>Refferer : <%=ucase(refferer)%></b></font><font size="4"> 
                    | <b><font size="3" face="Verdana">Co./File No :</font></b> 
                    <%=ucase(companyname)%><br>
                    <br>
                    </font> <% end if %> <font size="3" face="Verdana"><b>Rs.</b></font><font size="4" face="Verdana"> 
                    <%=ucase(NumberAsWord(GrandTotal))%> <b><font face="Verdana" size="3">ONLY</font></b></font><font face="Verdana" size="3"><b><br>
                    </b></font><b><br>
                    <font size="3" face="Verdana">Remarks:</font><font size="4"> 
                    </font></b><%=temp_remark%></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="10" bordercolor="#999999" height="24" bgcolor="#ffffFF" >&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td colspan="10" bordercolor="#999999" height="133" bgcolor="#ffffFF" > 
                    <p>&nbsp;</p>
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