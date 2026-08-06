<!-- #include file="connection.asp" -->
<%
con.execute("update paxstatus set subdate=#6/18/01#")
response.write("update paxstatus set coldate=#6/18/01#")
response.write("update paxstatus set sentdate=#6/18/01#")
response.write("update mainentry set receivedate=#6/18/01#")
response.write("Done")
%>