<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->

<%
              country=cint(request("countrylist"))
              category=cint(request("category"))
              description=trim(request("visaInfo"))
              
              
              set rs= server.createobject("adodb.recordset")
              stmt="select* from visaInfo where countryID="&country&"and categoryID="&category
		rs.open stmt,con,2,3
		if rs.eof then
		rs.addnew
		rs("countryID")=country
                rs("categoryID")=category
                rs("information")=description
                rs.update
                response.write "new information saved"
             else
                rs("information")=description
                rs.update
                response.write "exist information updated"
                end if               
            
            
            
            
              %>