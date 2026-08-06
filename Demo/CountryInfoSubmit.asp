<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<%

response.buffer= true
                
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

if request("agentusb")="yesuma" then
%>
<!-- #include file="topagent.asp" -->           
<% else
if session("priv")="adm" then
%> 
              
<!-- #include file="topadmin.asp" -->           
      <%
else
%>
<!-- #include file="top.asp" --> 
<% 
end if
end if
              country=cint(request("countrylist"))
			About = trim(request("About"))
			Climate = trim(request("Climate"))
			Language = trim(request("Language"))
			Religion= trim(request("Religion"))
			Curency = trim(request("Curency"))
			TimeZone = trim(request("TimeZone"))

			Continent_File = trim(request("Continent_File"))
			Flag_File = trim(request("Flag_File"))
			Visa_File = trim(request("Visa_File"))

set rs= server.createobject("adodb.recordset")
set rs1= server.createobject("adodb.recordset")

    if request("flag")="first" then
                
              stmt="select* from CountryInfo where countryID="&country
		rs.open stmt,con,2,3
		if rs.eof then
			rs.addnew
				rs("countryID")=country
			rs("About") = About
			rs("Climate") = Climate
			rs("Language") = Language
			rs("Religion") = Religion
			rs("Curency") = Curency
			rs("TimeZone") = TimeZone

				rs("Continent_File")=Continent_File
				rs("Flag_File")=Flag_File
				rs("Visa_File")=Visa_File
         	rs.update
                response.write "NEW INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write " HAS BEEN SAVED"
         else
			rs("About") = About
			rs("Climate") = Climate
			rs("Language") = Language
			rs("Religion") = Religion
			rs("Curency") = Curency
			rs("TimeZone") = TimeZone
				rs("Continent_File")=Continent_File
				rs("Flag_File")=Flag_File
				rs("Visa_File")=Visa_File
                rs.update
                response.write " INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write "UPDATED SUCCESSFULLY."
         end if 
         myurl="CountryInfo.asp?country="&country
                'response.flush
                response.redirect(myurl)      
                
      else
                %>
                <table width=90% align="center"><tr><td align="center"><span class="WSRightBold">
                <%            
              stmt2="select* from embassy where embassyID="&country
              rs1.open stmt2,con,2,3
              if not rs1.eof then
              response.write ucase(rs1("description"))&"</span></td><tr><td align='center'><span class='WSRightBold'>"
              response.write ucase(rs1("embassyname")) & " </span></td></tr><TR><td>"
              response.write "<span class='WSRightBold'>CHANCERY : </span><span class='WebSite'>"& ucase(rs1("street2")) & ","& ucase(rs1("area"))&"," & ucase(rs1("city"))&"."& "</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>PHONE :</span><span class='WebSite'>"& rs1("phoneno") &"</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>FACSIMILE :</span><span class='WebSite'>"& rs1("faxno") &"</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>EMAIL :</span><span class='WebSite'> "& rs1("emailID") &"</span></td></tr><tr><td></table>"
              end if
              rs1.close
              stmt="select* from CountryInfo where countryID="&country
			rs.open stmt,con,2,3
			if not rs.eof then
			About = rs("About") 
			Climate = rs("Climate")
			Language = rs("Language")
			Religion = rs("Religion")
			Curency = rs("Curency")
			TimeZone = rs("TimeZone")
				Continent_File = rs("Continent_File")
				Flag_File = rs("Flag_File")
				Visa_File = rs("Visa_File")
				rs.close
		
			end if
       end if
             flag=""
              %>

              <form method="post" action="CountryInfoSubmit.asp" name="queries">
              
  <table width="75%" ALIGN="center">
   
    
        <input type="hidden" name="countrylist" value="<%= country %>">
		<tr> 
      <td colspan=6 ALIGN="center"> 
        <div align="left"><span class="WSRightBold">COUNTRY INFORMATION</span> </div>
      </TD>
    </tr>
    <tr> 
      <td colspan=6 align=="center"> <%
      if request("submit")="Get Information" then
              response.write information
         test
     	public sub test
         aj =""
         x = len(information)
'         response.write x
         for i = 1 to x-1
         ch = mid(information,i,1)
         'response.write Cstr(ch)
         if ch = "," then
         ch = "<br>"
         aj = aj & ch
         else
         aj = aj & ch
         end if
         next
         'response.write "<br> test"
'        response.write aj
        
        end sub
             
       else %> 

       About Country :<br> <textarea name="About" cols="70" rows="4" ><%=About%></textarea><BR><BR>
       Climate :<br> <textarea name="Climate" cols="70" rows="4" ><%=Climate%></textarea><BR><BR>
       Language :<br> <textarea name="Language" cols="70" rows="3" ><%=Language%></textarea><BR><BR>
       Religion :<br> <textarea name="Religion" cols="70" rows="3" ><%=Religion%></textarea><BR><BR>
       Currency : <br><textarea name="Curency" cols="70" rows="3" ><%=Curency%></textarea><BR><BR>
       TimeZone : <textarea name="TimeZone" cols="70" rows="3" ><%=TimeZone%></textarea><BR><BR>
		Continent File Name : <input type="Text" name="Continent_File" value="<%=Continent_File%>"><BR><BR>
		Flag File Name : <input type="Text" name="Flag_File" value="<%=Flag_File%>"><BR><BR>
		Visa File Name : <input type="Text" name="Visa_File" value="<%=Visa_File%>"><BR>

        <input class="ud" type="submit" value="ADD / Edit">
        <% end if%> </td>
    </tr>
    <td colspan=4 align="center">&nbsp; </td>
    <td colspan=4 align=="center" width="52%"> 
      <input type="hidden" name="flag" value="first">
    </td>
    </tr>
  </table>
</form>