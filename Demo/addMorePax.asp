<!-- #include file="connection.asp" -->
<% 
response.buffer=true 
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
%>
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="styles.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onLoad="MM_preloadImages('images/home2.jpg','#982339540000');MM_preloadImages('images/news2.jpg','#982339618320');MM_preloadImages('images/services2.jpg','#982339651880');MM_preloadImages('images/about2.jpg','#982339709880');MM_preloadImages('images/contact2.jpg','#982339751960');MM_preloadImages('images/go2.jpg','#982340617580')">
<table width="75%" border="0" cellspacing="0" cellpadding="0">
<tr>
                <td><!-- #include file="top.asp" --></td>
          
    </tr>
  

   <tr>
                <td>
               

<% 

refno=request("refno")
pname=request("pname")
passno=request("passport")
totalp=request("totalp")
refno=request("refno")
subdate=request("subdate")
if subdate<>"" then
subdate=UsrToSysDate(subdate)
End if
coldate=request("coldate")
if coldate<>"" then
coldate=UsrToSysDate(coldate)
End if
set rs=server.createobject("adodb.recordset")
set rsHistory=server.createobject("adodb.recordset")
set rsCountry=server.createobject("adodb.recordset")
set rsTemp=server.createobject("adodb.recordset")
if request("insertflag")="" then
%>
<form name=addpax action="addMorePAX.asp">
<table border=0>
<input type=hidden value="go" name="insertflag">
<input type=hidden value=<%= refno %> name="refno">
<tr> 
                    <td><font size="2" color="#0000CC"><b>PAX Name</b></font></td>
                    <td> <font size="2" color="#006600"><b> 
                      <input type="text" name="pname" value="" >
                      </b></font></td></tr>
                    <tr><td><font size="2" color="#0000CC"><b>Passport No </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                      <input type="text" name="passport" value="" >
                      </b></font></td>
                  <tr> 
                    <td><font size="2" color="#0000CC"><b>Total Pessengers</b></font></td>
                    <td> <font size="2" color="#006600"><b> 
                      <input type="text" name="totalp" value="1" size=4>
                      </b></font></td>
                      </tr>
                  </tr>
                  <tr><td>Submission Date </td>
			<td><input type=text size=10 name="subdate">
			</td></tr>
			</td></tr>
			<tr><td>Collection Date </td>
			<td><input type=text size=10 name="coldate"> CONF.<input type=radio name="colcheck"  value='conf'> CHK.<input type=radio name="colcheck"  value='chk' checked>
			</td></tr>
			</td></tr>
                  
                   
                  <tr> 
                    <td><font size="2" color="#0000CC"><b> Select countries </b></font></td>
                    <td> <select size=10 name="countrylist" multiple>
                      <%

Call LoadListBox("Embassy",0)
%> 
                    </select></td>
                  </tr>
                 <tr><td>Status</td>
		<td><select size=1 name="status">
		<%
		call loadlistbox("Status",0)                   
		%>
		</select>
		</td></tr> 
		 <tr> 
                    <td><font size="2" color="#0000CC"><b>Entry Type</b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    
                    <select name="entrytype" size="1">
                     <%
Call LoadListBox("entrytype",entrytype)

%> 
                    </select>
       <tr><td><font size="2" color="#0000CC"><b>Category </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <select name="categorytype" size="1">
                     <% Call LoadListBox("category",2) %> 
                    </select>
       </b></font></td></tr>

                      </b></font></td></tr>


                  <tr><td>Remarks</td>
		<td><input type=text size=80 name="remarks">
		</td></tr>
		</td></tr><tr>
                    <td><input type=submit value="ADD"> </td>
                    <td> </td>
                  </tr>
 </table>
 
 </form>
 
 <% else
 
 
set rs=server.createobject("adodb.recordset")
rs.activeconnection=con
rs.open "select * from entrydetails where refno="&refno,con,2,3

count=0
count=request("countrylist").count
rs.addnew
rs("refno")=refno
rs("paxname")=pname
rs("passportno")=passno
if totalp<>"" then
rs("totalpax")=cint(totalp)
end if
rs.update
		Paxid=1
	       	rsTemp.open "select max(PaxID) from entryDetails ",con,2,3
		if not rsTemp.eof then
		Paxid=rsTemp(0)
		end if
		rsTemp.close

for ii=1 to count
if request("countrylist")(ii)<> "" then



				rsCountry.open "Select * from PaxStatus where paxid=1",con,2,3
				rsCountry.addnew
				rsCountry("PaxID")=cdbl(paxid)
				rsCountry("Refno")=cdbl(Refno)
				rsCountry("CountryID")=Cint(request("countrylist")(ii))
				if subdate <> "" then
				rsCountry("subdate")=subdate
				End if
				if coldate <> "" then
				rsCountry("coldate")=coldate
				rsCountry("colcheck")=request("colcheck")
				End if
				rsCountry("statusID")=cint(request("status"))
				rsCountry("entrytype")=request("entrytype")
				rsCountry("category")=request("categorytype")
				rsCountry("remarks")=trim(request("remarks"))
				rsCountry.update
				rsCountry.close
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=cdbl(paxid)
				rsHistory("CountryID")=Cint(request("countrylist")(ii))
				rsHistory("statusID")=cint(request("status"))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("remarks")=trim(request("remarks"))
				rsHistory("updatedby")=session("uname")
				rsHistory.update
				rsHistory.close
				
		
end if
next
rs.close

rs.open "select * from MainEntry where refno="&refno,con,2,3

totalpassengers=rs("totalpassengers")+cint(totalp)
entries=rs("entries")+1


rs("entries")=entries
rs("totalpassengers")=totalpassengers

rs.update
rs.close

set rsc=server.createobject("adodb.recordset")
rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close


 response.write " <a href='editEntry.asp?refno="&refno&"' >CLICK HERE TO GO TO EDIT PAGE</a>"
 End if 
 %>
                
                
                
                </td>
          
    </tr>
  <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  
</table>

</body>
</html>
