<%
response.buffer= true
if session("uname")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if
if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=V"
end if

%>
<!-- #include file="connection.asp" -->
<% 

set rsc=server.createobject("adodb.recordset")

                refno=request("refno")
               Paxid=request("Paxid")
               countryID=cint(request("countryID"))
               totalp=request("totalp")
               set rs=server.createobject("adodb.recordset")
               if countryID<>"" then
                Con.execute("delete from entrydetails where paxid="&PaxID)
                Con.execute("delete from paxstatus where paxid="&PaxID )

                Con.execute("insert into deleteditem values("&refno&","&PaxID &","&countryID&", '"&session("uname")&"', 'Delete Pax')")

rsc.open "select refno from changes where refno="&cdbl(refno)&"", con, 2,3
if rsc.eof then
rsc.addnew
rsc("refno")=cdbl(refno)
rsc.update
end if
rsc.close

                response.write("delete from entrydetails where paxid="&PaxID &" and refno="&refno )
               response.write("delete from paxstatus where paxid="&PaxID &" and countryID="&countryID )
                
                rs.open "select * from MainEntry where refno="&refno,con,2,3
		totalpassengers=rs("totalpassengers")-cint(totalp)
		entries=rs("entries")-1
		rs("entries")=entries
		rs("totalpassengers")=totalpassengers
		rs.update
		rs.close
                
                
                msg= "THE COUNTRY  "
                call WriteIDDescription("embassy",countryID)
                response.write " HAS BEEN DELETED SUCCESSFULLY"
                End if
                myurl="editEntry.asp?refno="&refno
                'response.flush
               ' response.redirect myurl
                
        


response.write " <a href='editEntry.asp?refno="&refno&"' >click here to go to edit page</a>"
 %>