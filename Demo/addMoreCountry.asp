<%@ Language=VBScript %>
<% 
response.buffer=true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
 %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="75%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top" align="left">
         
          <td width="98%"> 
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top" align="left"> 
                <td><!-- #include file="top.asp" --></td>
              </tr>
              <tr>
                <td>
               
<% 
refno=request("refno")
paxID=request("paxID")
status=request("status")
entrytype=request("entrytype")
categorytype=request("categorytype")
remarks=request("remarks")
subdate=request("subdate")
pname=request("pname")
if subdate<>"" then
subdate=UsrToSysDate(subdate)
End if
coldate=request("coldate")
if coldate<>"" then
coldate=UsrToSysDate(coldate)
End if

if request("insertFlag")="" then
REsponse.write "Add more country(s) for passenger <B> "&pname&"</b><br>"
%>

<form Name=addmore action=addMoreCountry.asp>
<input type="hidden" name="insertFlag" value="go">
<input type="hidden" name="refno" value="<%= refno %>">
<input type="hidden" name="paxID" value="<%= paxID %>">
<input type="hidden" name="pname" value="<%= pname %>">
<table>

<tr><td>Submission Date </td>
<td><input type=text size=10 name="subdate">
</td></tr>
</td></tr>
<tr><td>Collection Date </td>
<td><input type=text size=10 name="coldate"> CONF.<input type=radio name="colcheck"  value='conf'> CHK.<input type=radio name="colcheck"  value='chk' checked>
</td></tr>
</td></tr>
<tr><td>Select Country(s)</td>
<td>
<select size=10 name="countrylist" multiple>
<%
call loadlistbox("embassy",countryid)                   
%> </select>
</td></tr>
 <tr> 
                    <td><font size="2" color="#0000CC"><b>Entry Type</b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    
                    <select name="entrytype" size="1">
                     <%
Call LoadListBox("entrytype",entrytype)

%> 
                    </select>
                     
                      
                      </b></font></td></tr>
<tr><td>Status</td>
<td><select size=1 name="status">
<%
call loadlistbox("Status",0)                   
%>
</select>
</td></tr>

       <tr><td><font size="2" color="#0000CC"><b>Category </b></font></td>
                    <td> <font size="2" color="#006600"><b>
                    <select name="categorytype" size="1">
                     <% Call LoadListBox("category",2) %> 
                    </select>
       </b></font></td></tr>


<tr><td>Remarks</td>
<td><input type=text size=80 name="remarks">
</td></tr>
</td></tr>
<tr><td>
<input type="submit" name="submit" value="add">                    
</td></tr>
</table>                    
 </form>
 
 <% Else

set rs=server.createobject("adodb.recordset")
set rsHistory=server.createobject("adodb.recordset")
count=0
count=request("countrylist").count


for ii=1 to count
if request("countrylist")(ii)<> "" then
rs.activeconnection=con
 

stmt="select * from paxstatus where paxID="&paxID&" and countryID="&request("countrylist")(ii)
rs.open stmt,con,2,3
if rs.eof then
rs.addnew

rs("refno")=refno
rs("paxID")=paxID
rs("statusID")=cint(status)
rs("entrytype")=entrytype
rs("category")=categorytype
rs("remarks")=remarks
rs("countryID")=request("countrylist")(ii)
if subdate<>"" then
rs("subdate")=subdate
end if
if coldate<>"" then
rs("coldate")=coldate
rs("colcheck")=request("colcheck")
end if
rs.update

rs.close
				rsHistory.open "Select * from StatusHistory where paxid=1",con,2,3
				rsHistory.addNew
				rsHistory("PaxID")=cdbl(paxid)
				rsHistory("CountryID")=Cint(request("countrylist")(ii))
				rsHistory("statusID")=cint(request("status"))
				rsHistory("Date")=FormatDateTime(now(),0)
				rsHistory("updatedby")=session("uname")
				rsHistory.update
				rsHistory.close

Response.Write "<P align=center> Country <b>"
call writeIddescription("embassy",request("countrylist")(ii))
response.write  " </b>added successfully for PAX <B>"&pname&"</B><br></p>"
else
Response.Write "<P align=center> Country <b> "
call writeIddescription("embassy",request("countrylist")(ii))
response.write "</b> already added for PAX <B>"&pname&"</B><br></p>"

end if
end if


				
next

set rsc=server.createobject("adodb.recordset")
rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close


Response.Write "<P align=center><a href='editEntry.asp?refno="&refno &"'>Click here to  view changes</a>.</p>"

End if
%>
                
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
   <tr>
                <td><!-- #include file="empBottom.asp" --></td>
          
    </tr>
  
</table>
</body>
</html>
