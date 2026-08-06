<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<% response.buffer=true

      jn=request("jn")
            

set rs=server.createobject("adodb.recordset")
stmt="select* from udaan_users where username='"&request("username")&"'" & "and password='"& request("pass1")&"'"
rs.open stmt,con,2,3
if rs.eof then
'response.write "YOU ARE NOT AUTHORIZED TO CHANGE THE PASSWORD. <br>PLEASE CHECK USERNAME OR PASSWORD."
response.clear
  myurl= "changepasswordforagent.asp?uname="&request("username")&"&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn="&jn&"&flag=3"
  response.redirect(myurl)
else
if lcase(request("pass2"))<>lcase(request("pass3")) then
'response.write"PLEASE ENTER THE SAME VALUES FOR NEW AND CONFIRM PASSWORD. "
response.clear
  myurl= "changepasswordforagent.asp?uname="&request("username")&"&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn="&jn&"&flag=2"
  response.redirect(myurl)
else
rs("password")=lcase(request("pass2"))
rs.update
'response.write "PASSWORD CHANGED SUCCESSFULLY."
response.clear
  myurl= "changepasswordforagent.asp?uname="&request("username")&"&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn="&jn&"&flag=1"
  response.redirect(myurl)
end if
end if
rs.close

%>
