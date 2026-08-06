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
              category=request("category")
			  countryF=request("countryFor")
'response.write request("flag")
'response.end
              description=trim(request("visaInfo"))
set rs= server.createobject("adodb.recordset")
set rs1= server.createobject("adodb.recordset")

    if request("flag")="first" then
                
              stmt="select* from visaInfo where countryID="&country&" and categoryID="&category&" and countryFor="&countryF
		rs.open stmt,con,2,3
		if rs.eof then
			rs.addnew
				rs("countryID")=country
                rs("categoryID")=category
                rs("information")=description
				rs("countryFor")=countryF
         	rs.update
                response.write "NEW INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write " AND CATEGORY "
                call writeIDDescription("category",category)
                response.write " HAS BEEN SAVED"
         else
                rs("information")=description
                rs.update
                response.write " INFORMATION FOR "
                call writeIDDescription("embassy",country)
                response.write " AND CATEGORY "
                call writeIDDescription("category",category)
                 response.write "UPDATED SUCCESSFULLY."
         end if 
         myurl="VisaInfo.asp?country="&country&"&category="&category
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
              response.write "<span class='WSRightBold'>EMAIL :</span><span class='WebSite'> "& rs1("emailID") &"</span></td></tr><tr><td>"
              response.write "<span class='WSRightBold'>WEB SITE :</span><span class='WebSite'> "& rs1("CHANCERY") &"</span></td></tr><tr><td></table>"

              end if
              rs1.close
              stmt="select* from visaInfo where countryID="&country&"and categoryID="&category&" and countryFor="&countryF
			rs.open stmt,con,2,3
			if not rs.eof then
				information=rs("information")
				rs.close
		
			end if
       end if
             flag=""
              %>

              <form method="post" action="visaInfoSubmit.asp" name="queries">
              
  <table width="75%" ALIGN="center">
   
    
        <input type="hidden" name="countrylist" value="<%= country %>">
        <input type="hidden" name="category" value="<%= category %>">
        <input type="hidden" name="countryFor" value="<%= countryF %>">    
    
    <tr> 
      <td colspan=6 ALIGN="center"> 
        <div align="left"><span class="WSRightBold"> VISA REQUIREMENTS</span> </div>
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
        <textarea name="visaInfo" cols="70" rows="10" ><%=information%></textarea>
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