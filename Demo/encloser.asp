
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.UdaanIndia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<table width="700" border="0" height="900" align="center">
  <tr valign="top"> 
    <td height="236"> 
      <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
        <tr> 
          <td  align="center"></td>
        </tr>
        <tr> 
          <td align="center" height="22">
            <div align="left"><img src="images/Encltop.gif" width="675" height="112"></div>
          </td>
        </tr>
        <tr valign="top"> 
          <td align="center" height="2"><b><font size="4"><br>
            &nbsp; <u>DESPATCH SHEET</u></font> </b></td>
        </tr>
      </table>
      <form action="invoicesubmit.asp" method="post" name="regist">
        <%
refno=cdbl(request("refno"))
GrandTotal=0

  set invoiceno=server.createobject("adodb.recordset")
  invoiceno.open "select invoiceno,remark from invoice where refno="&refno&" and invtype='B'",con
  if not invoiceno.eof then
  invno=invoiceno("invoiceno")
  end if
  remark=invoiceno("remark")
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
kind=rsmain.fields("directorname")
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
        <table width="658" border="0" align="center">
          <tr border=0 valign="top"> 
            <td width="397" height="27" bgcolor="#ffffff"><font size="4"><b><font size="3">M/S. 
              <%
                             response.write company &"<br>"
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
                             %> </font></b></font><br>
            </td>
            <td width="118" height="27" bgcolor="#ffffff"> 
              <div align="center"><font size="4"> </font> </div>
            </td>
            <td width="184" height="27" bgcolor="#ffffff"> 
              <div align="right"><b> <font size="3">Date</font></b><font size="3">. 
                <%= systousrdate(NOW()) %> </font></div>
            </td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2"><b><font size="3">Kind Attention 
              : <% if kind<>"" then %><%=kind%><% else %> Sir<%end if %></font></b></td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2">We are here with enclosing 
              the following document :-</td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2">1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Passport/Passports 
              Favouring :<b> <%= paxname%></b></td>
          </tr>
          <tr> 
            <td colspan="2" align="left" height="2">2. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Air 
              Ticket </td>
            <td width="184" height="2"> 
              <input type="checkbox" name="checkbox" value="checkbox">
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="left" height="2">3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Overseas 
              Mediclaim Policy.</td>
            <td width="184" height="2"> 
              <input type="checkbox" name="checkbox2" value="checkbox">
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="left">4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attestation 
              Papers </td>
            <td width="184" height="27"> 
              <input type="checkbox" name="checkbox3" value="checkbox">
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="left">5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Original 
              Tax Papers/Salary Cirtificate/Property Papers/Credit Card</td>
            <td width="184" height="27"> 
              <input type="checkbox" name="checkbox4" value="checkbox">
            </td>
          </tr>
          <tr> 
            <td colspan="3" align="left">6.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice 
              No.<font size="4"><b> <%= invno%></font></b></td>
          </tr>
          <tr> 
            <td colspan="3" align="left">7. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other 
              Documents :</td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2">_________________________________________________________________________________</td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2">_________________________________________________________________________________</td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2"><b><font size="4"><u>Additional 
              Information</u></font></b></td>
          </tr>
          <tr> 
            <td colspan="3" align="left" height="2"><b><font size="4">Ref No.</font></b> 
              <font size="5"><%= refno %></font><font size="4"> </font> </td>
          </tr>
          <tr border=0 valign="top"> 
            <td colspan="3" height="42"> 
              <table width="680" align="center" cellpadding="0" cellspacing="0" height="58">
                <tr > 
                  <td colspan="10" height="2" ><img src="images/thinline.gif" width="650" height="4"> 
                  </td>
                </tr>
                <tr > 
                  <td width="59" height="2" > 
                    <div align="center"><font color="#000000" size="4"><b><font size="3">S.No.</font></b></font></div>
                  </td>
                  <td width="309" align="left" height="2" > 
                    <div align="left"><font color="#000000" size="4"><b><font size="3">Pax 
                      Name</font></b></font></div>
                  </td>
                  <td colspan="8" align="left" height="2" width="310" ><font color="#000000" size="4"><b><font size="3">Country</font></b></font></td>
                </tr>
                <tr> 
                  <td valign="top" colspan="9" height="2"><img src="images/thinline.gif" width="650" height="4"></td>
                </tr>
                <%
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
%> 
                <tr> 
                  <td valign="top" width="59" height="5"> 
                    <div align="center"><font size="4"><font size="3">&nbsp;
<% if  strComp(one_name,old_name) then  %>
<%= counter %>
<% end if %></font></font></div>
                  </td>
                  <td width="309" valign="top" align=center height="5"> 
                    <div align="left"><font size="3"> <%
if  strComp(one_name,old_name) then 
response.write ucase(one_name)
	old_name=one_name
	counter =counter+1
	end if
%> </font> </div>
                  </td>
                  <td width="310" valign="top" align=left height="5"><font color="#000000" size="3"><%
call writeIDDescription("embassy", rs("countryID"))
	%></font> </td>
                </tr>
                <%
	rs.movenext
	i=i+1
	wend
end if  
rs.close
%> 
                <tr> 
                  <td valign="top" colspan="3" height="2"> 
                    <div align="left"><font color="#000000" size="3"><img src="images/thinline.gif" width="650" height="4"> 
                      </font> </div>
                  </td>
                </tr>
                <tr>
                  <td valign="top" colspan="3" height="2"><b>Remark.:</b> <font size="3"><%= remark %></font></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
  <tr valign="bottom"> 
    <td height="65"> 
      <table width="680" border="0" align="center">
        <tr bgcolor="#ffffff" > </tr>
        <tr width="300"> 
          <td align="left" colspan=2>Thanking you and assuring you of our best 
            attention, always.<br>
            Yours Truly</td>
          <td align="CENTER" colspan=2>&nbsp;</td>
        </tr>
        <tr width="300"> 
          <td align="right" colspan=2> 
            <div align="left"><br>
            </div>
          </td>
          <br>
          <td align="CENTER" colspan=2>&nbsp; </td>
        </tr>
        <tr width="300" align="left"> 
          <td colspan=4>For <font size="5"><b><font size="3">Udaan</font></b><font size="3"> 
            India Pvt. Ltd.</font></font></td>
        </tr>
        <tr width="300" align="left"> 
          <td colspan=4> 
            <hr>
          </td>
        </tr>
        <tr width="300" align="center"> 
          <td colspan=4><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"><%=udaanAddress%> 
            </font></td>
        </tr>
        <tr width="300" align="center"> 
          <td colspan=4><font face="Arial, Helvetica, sans-serif" size="2" color="#000000"><%=Contactaccounts%> 
            </font></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
