<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<html>
<head>
<title>www.udaanindia.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<body bgcolor="#FFFFFF"  topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >

</form>
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
              <% 
            
              country=cint(request("countrylist"))
              category=cint(request("category"))
              %>
              
              
             
              <tr>
             
              <table width="75%" >
              <tr> 
              
                <td colspan=6 ALIGN="center">
                 VISA INFORMATION FOR INDIAN NATIONS</TD></TR>
                 <tr> 
              
                <td colspan=4 align="center"> 
                  COUNTRY</td> <td colspan=4 align=="center">CATEGORY
                  
                </td></tr>
                <tr> 
              
                <td colspan=4 align="center"> 
                                              <%
              set rs= server.createobject("adodb.recordset")
              stmt="select* from visaInfo where countryID="&country&"and categoryID="&category
            
            	rs.open stmt,con,2,3
		if rs.eof then
		response.write "NO INFORMATION FOUND FOR THIS CATEGORY AND THE COUNTRY."
		else
		description=rs("information")
		response.write country&"</td><td>"&category
                response.write "</td></tr><tr><td colspan=2>"&description
                response.write "</td></tr>"
                
                
                end if
              
              
              %>
                   
                   
                </table>
               <div align="center"> For the personal queries contact udaan at <a href=""mailToUdaan.asp"">Click here</a></div>
                
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
<p>&nbsp;</p>
</body>
</html>
