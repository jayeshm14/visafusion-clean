<head>
<style type="text/css">
<!--
a.udtop {  font-family: Arial; font-size: 8pt; font-weight: bold; text-decoration: none; color: #000000}
a.udtop:hover {  font-family: Arial; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
<!--
a {  font-family: Arial; font-size: 8pt; font-weight: bold; text-decoration: none; color: #000000}
a:hover {  font-family: Arial; font-size: 8pt; font-weight: bold; color: #FF0000; text-decoration: none}
-->
</style>                         
 </head>               
   


<table wodth="100%" align="center" border="0" cellspacing="1" cellpadding="1" width="90%">
  <tr valign="top" align="left" bgcolor="#FFF3CA"> 
    <td width="16%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="alerts.asp?uname=<%=session("uname")%>" class="udtop">Alerts</a></font></div>
    </td>
    <td width="16%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="todayCollection.asp?uname=<%=session("uname")%>" 
        class="udtop">Today's Collection</a></font></div>
    </td>
    <td width="16%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="urgent.asp?uname=<%=session("uname")%>" class="udtop">Urgents</a></font></div>
    </td>
    <td width="16%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="priwork.asp?uname=<%=session("uname")%>" class="udtop">Priority 
        Works</a></font></div>
    </td>
    <td width="18%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="todaySubmission.asp?uname=<%=session("uname")%>" 
        class="udtop">Today's Submission</a></font></div>
    </td>
    <td width="18%"> 
      <div align="center"><font face="Verdana" size="2" color="#0000FF"><a href="todayToBeSent.asp?uname=<%=session("uname")%>" 
        class="udtop">To Be Sent Today</a></font></div>
    </td>
  </tr>
</table>
         