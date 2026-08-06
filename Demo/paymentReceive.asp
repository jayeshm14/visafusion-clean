<%@ Language=VBScript %>
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
          
          <td width="98%" VALIGN="TOP"> 
          <!-- #include file="topAdmin.asp" -->
            <table width="75%" border="0" cellspacing="0" cellpadding="0" align="center">
              <tr valign="top" > 
                <td>
                  <div align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">RECEIPT</font></div>
                </td>
                <% 
                agent=cint(REQUEST("pname"))
                
                if request("msgID")="1" then
                response.write "PAYMENT ADDED FOR AGENT "
                call WriteIDDescription("agents",agent)
                end if
                %>
              </tr>
              <tr> 
                <td> 
                  <div align="center">
                    <table width="50%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                        <td width="65%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                        <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                        <td width="2%">&nbsp;</td>
                      </tr>
                      <form action="paymentsubmit.asp" method="post">
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">AGENT</font></td>
                          <td width="65%"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <select name="agent">
                              <%
                      	call loadlistbox("agents",request("agent"))
                      	%> 
                            </select>
                            </font></td>
                          <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="65%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">AMOUNT</font></td>
                          <td width="65%"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <input type="text" name="amount">
                            </font></td>
                          <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td colspan="2">&nbsp;</td>
                          <td width="0%">&nbsp;</td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">PAYMENT 
                            </font></td>
                          <td width="65%"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <select name="paidas">
                              <option value="Cash">CASH</option>
                              <option value="DD">DD</option>
                              <option value="CHEQUE">CHEQUE</option>
                              <option value="M.O.">M.O.</option>
                            </select>
                            </font></td>
                          <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">BANK 
                            </font></td>
                          <td width="65%"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <select name="bank">
                              <%
                      	call loadlistbox("bank",bankid)
                      	%> 
                            </select>
                            </font></td>
                          <td width="0%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font></td>
                          <td width="2%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">DD/CHEQUE 
                            NO.</font></td>
                          <td width="65%"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <input type="text" name="ddno">
                            </font></td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">DATED</font></td>
                          <td colspan="2"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <input type="text" name="dddate">
                            </font></td>
                        </tr>
                        <tr> 
                          <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">REMARK</font></td>
                          <td colspan="2"> <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                            <input type="text" name="remark" size="50">
                            </font></td>
                        </tr>
                        <tr> 
                          <td colspan="3"> 
                            <div align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"></font> 
                              <font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> 
                              <input type="submit" value="SUBMIT" size="50">
                              <input type="reset" value="RESET" size="50">
                              </font></div>
                          </td>
                        </tr>
                      </form>
                    </table>
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
