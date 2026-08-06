<%@ Language=VBScript %>
<!-- #include file="connection.asp" -->
<%

stmt="insert into subscriber(name,email) values('"&request("name")&"','"&request("u_mail")&"')"
'response.write stmt
  con.execute stmt
response.redirect "subscribedone.asp?un="&request("name")&"&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn=253&ses=k3456l7dj9javyemsn&company=udaan"
%>