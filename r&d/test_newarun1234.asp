 <%
'***************Send Mail******************
SUB sendMail(fromwho,towho,subject,body)
 DIM myMail
 SET myMail = Server.CreateObject("CDONTS.Newmail")
 myMail.MailFormat = 0
 myMail.BodyFormat = 0
 myMail.From = fromwho
 myMail.To = towho
' myMail.Cc = towho1
 myMail.Subject = subject
 myMail.Body = body
 myMail.Send
 SET myMail = Nothing
END SUB


set myconn=server.createobject("ADODB.Connection")
myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=udaanuma"
'myconn.open "DRIVER={SQL Server};SERVER=SERVER;uid=sa;pwd=;DATABASE=netdb"

'set rs=server.createobject("ADODB.RecordSet")
'rs.open "select companyname,emailid from agents where emailid<>'' and agentsid>='4001' and agentsid<'6000' order by companyname" , myconn, 3,3
'rs.open "select companyname, agentsid,emailid,description from agents where city like '%CALCUTTA%' or city like '%CCU%' or city like '%KOLKATA%' or city like '%KOLKATTA%' or city like '%KOLKLATA%' order by description", myconn, 3,3
'if rs.eof then
'Response.write "you have no agent"
'else

'while not rs.eof

'towho=rs("emailid")

'towho="usbhardwaj@udaanindia.com"
towho="<arun@udaanindia.com>"
'towho="<harpreet@udaanindia.com>"
'towho="harpreet@udaanindia.com"
'if towho <> "" then

fromwho="UDAAN <udaan@udaanindia.com>"
subject="UPDATE OF UNITED KINGDOM!!!!"

body="<html><head><meta http-equiv='Content-Language' content='en-us'><meta name='GENERATOR' content='Microsoft FrontPage 5.0'><meta name='ProgId' content='FrontPage.Editor.Document'><meta http-equiv='Content-Type' content='text/html; charset=windows-1252'><title>Update of United Kingdom</title></head><body><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' id='AutoNumber1'>  <tr>    <td width='100%' colspan='2'>  <p align='center'>  <img border='0' img src='http://www.udaanindia.com/images/logo123.gif' width='374' height='71'></td>  </tr>  <tr>    <td width='100%' colspan='2'>    <p align='center'><b>          <font color='#000080' face='Vrinda' style='font-size: 20pt'><u>Update of     United Kingdom – Change in Visa fee and Visa Form</u></font></b></p>    <p class='MsoNormal' align='left'>    <font color='#000080' face='Vrinda' style='font-size: 16pt'>        <span style='font-weight:700'>Dear     Travel Partners,<BR></span></font><font face='Vrinda' style='font-size: 16pt'><span style='font-weight:700'><font color='#000080'>This is to bring to your     kind notice that the visa fee and visa form of United Kingdom has been     revised. The following information has been updated on our website i.e </font>        </font><font face='Vrinda' size='5'>        <a href='http://www.udaanindia.com/' style='text-decoration: underline; text-underline: single'> www.udaanindia.com</a></font><font color='#000080' face='Vrinda' style='font-size: 16pt'>.</font></span></p>        </td>  </tr>  <tr>          <td width='37%' align='center'><font color='#000080'><b>VISA TYPE</b></font></td>          <td width='63%' align='center'><font color='#000080'><b>VISA FEE</b></font></td>  </tr>  <tr>            <td width='36%'>            <font color='#000080' face='Vrinda' style='font-size: 16pt'>            <span style='font-weight:700'>BUSINESS/TOURIST/VISIT         VISA</span></font></td>            <td width='64%'>  <b><font color='#000080' face='MV Boli'>    1.) Rs.   5,200/- (6 MONTHS SINGLE, DOUBLE, MULTIPLE ENTRY)</font><br>  <font color='#000080' face='Vrinda'> <br>        </font>  <font color='#000080' face='MV Boli'>2.) Rs. 16, 400/- (1   YEAR, 2 YEAR, 5 YEAR AND 10 YEAR MULTIPLE ENTRY) <br> <br>         3.)Rs.   3,600(SINGLE OR DOUBLE VISIT UP TO 1 MONTH( INDIA ONLY))  </font></b></td>  </tr> <br> <tr>        <td width='36%' valign='bottom'>                <span style='font-weight:700; font-size:16pt'>    <font color='#000080' face='Vrinda'>DEPENDENT</font></span></td>            <td width='64%' valign='bottom'>    <b><font color='#000080' face='MV Boli'>Rs.     16, 400/ TILL SPONSOR's VISA IS VALID</font></b></td>  </tr>  <tr>        <td width='36%'>                <span style='font-weight:700; font-size:16pt'>    <font color='#000080' face='Vrinda'>RELIGIOUS</font></span></td>            <td width='64%'>    <b><font color='#000080' face='MV Boli'>1.) Rs. 5, 525/- (6     MONTHS SINGLE, DOUBLE, MULTIPLE ENTRY)<BR><br>2.) Rs. 17, 425/- (1 YEAR, 2     YEAR, 5 YEAR AND 10 YEAR MULTIPLE ENTRY)</font></b></td>  </tr>  <tr>            <td width='36%'>            <span style='font-weight:700; font-size:16pt'>    <font color='#000080' face='Vrinda'>STUDENT</font></span></td>        <td width='64%'>        <b><font color='#000080' face='MV Boli'>Rs. 7, 950/-</font></b></td>  </tr>  <tr>            <td width='36%'>        <span style='font-weight:700; font-size:16pt'>            <font color='#000080' face='Vrinda'>TRANSIT</font></span></td>            <td width='64%'>    <b><font color='#000080' face='MV Boli'>Rs. 3,600/- (6   MONTHS SINGLE, DOUBLE, MULTIPLE ENTRY)    </font></b></td>  </tr>  <tr>        <td width='36%'>            <span style='font-weight:700; font-size:16pt'>                <font color='#000080' face='Vrinda'>WORK</font></span></td>            <td width='64%'>    <b><font color='#000080' face='MV Boli'>1.) Rs.     16,400/- (TILL THE&nbsp; WORK PERMIT IS VALID)<br><br>        2.)VALIDITY OF     THE WORK PERMIT SHOULD BE FOR 6 MONTHS.</font></b></td>  </tr>  <tr>    <td width='100%' colspan='2'>  <br><b>"
body=body & "<font color='#000066'>YOU CAN DOWNLOAD VISA FORM HERE:-</font></b><BR><BR><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' id='AutoNumber2'>    <tr>      <td width='100%'>    <span style='font-weight: 700'><font color='#000080' size='4' face='Vrinda'>    <a href='http://www.udaanindia.com/forms/UK/ukb.pdf'>    BUSINESS VISA FORM</a></font><font size='4' face='Vrinda'> </font> </span>      </td>    </tr>    <tr>      <td width='100%'><a href='http://www.udaanindia.com/forms/UK/tourist.pdf'>      <font face='Vrinda' size='4'><span style='font-weight: 700'>    TOURIST VISA FORM</span></font></a></td>    </tr>    <tr>      <td width='100%'>                                                    <a href='http://www.udaanindia.com/forms/UK/fv.pdf'>                                                        <font face='Vrinda' size='4'>    <span style='font-weight: 700'>    FAMILY VISIT VISA</span></font></a></td>    </tr>    <tr>      <td width='100%'><a href='http://www.udaanindia.com/forms/UK/visitt.pdf'>        <font face='Vrinda' size='4'><span style='font-weight: 700'>        VISIT IN TRANSIT VISA FORM</span></font></a></td>    </tr>    <tr>      <td width='100%'><font color='#000080' face='Vrinda' size='4'>    <span style='font-weight: 700'> <a href='http://www.udaanindia.com/forms/UK/st2.pdf'>                                                        STUDENT VISIT(Less than Six Month)</a></span></font></td>    </tr>    <tr>      <td width='100%'>    <span style='font-weight: 700'><font color='#000080' face='Vrinda' size='4'>    <a href='http://www.udaanindia.com/forms/UK/STUDENT%20MORE%20THAT%20SIX%20MONTHS.pdf'>        STUDENT&nbsp; VISA FORM</a></font><font face='Vrinda' size='4'> </font><font color='#000080' face='Vrinda' size='4'>    <a href='http://www.udaanindia.com/forms/UK/STUDENT%20MORE%20THAT%20SIX%20MONTHS.pdf'>        (More Than Six Month)</a></font></span></td>    </tr>    <tr>      <td width='100%'><a href='http://www.udaanindia.com/forms/UK/WORK%20PERMIT.pdf'>                                                         <font face='Vrinda' size='4'>    <span style='font-weight: 700'>    WORK PERMIT VISA FORM</span></font></a></td>    </tr>    <tr>      <td width='100%'><a href='http://www.udaanindia.com/forms/UK/d1.pdf'>        <font face='Vrinda' size='4'><span style='font-weight: 700'>    DIRECT AIRSIDE TRANSIT FORM</span></font></a></td>    </tr>    <tr>      <td width='100%'><a href='http://www.udaanindia.com/forms/UK/VAF2%20-%20Settlement.pdf'>        <font face='Vrinda' size='4'><span style='font-weight: 700'>    PERMANENT RESIDENCE FORM</span></font></a></td>    </tr>    <tr>      <td width='100%'><b><font size='2' face='Verdana'>                                                       <a href='http://www.udaanindia.com/forms/UK/dworker.pdf'>        ADDITIONAL DOMESTIC WORKER FORM</a> </font></td>    </tr>  </table>    </td>  </tr>  </table></body></html>"






sendMail fromwho, towho, subject, body
'end if
'rs.movenext
'wend
'end if
response.write body

response.write("Update")
'***************End Send Mail******************
%>