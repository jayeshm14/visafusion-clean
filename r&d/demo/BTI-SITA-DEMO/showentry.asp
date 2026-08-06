<%
total=cint(Request.Form ("raj"))
count=cint(Request.Form ("venesh"))





'this loop must be used to insert data in entrydetail  table
for k=1 to total
response.write "<br>name"&k&" : " &request.form("name"&k)&" age: "& request.form("age"&k) &"<br>"

for l=1 to count

response.write " "& request.form("country"&k&l)

next
next
%>