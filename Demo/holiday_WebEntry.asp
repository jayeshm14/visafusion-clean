<!-- #include file="connectionweb.asp" -->
<%               
dim WebCon
set WebCon=server.createobject("adodb.connection")
WebCon.ConnectionTimeout = 0
WebCon.CommandTimeout = 0
WebCon.open "DRIVER={SQL Server};SERVER=rajvenesh\msde2k;uid=arun;pwd=sharma;DATABASE=arun"

 flag=request("flag")
                 
                 holiday=request.form("holiday_date")
                  
                 description=request.form("holiday_desc")
                if not (flag="" or isempty(flag)) then
                  count=cint(request.form("countrylist").count)
                  set rs=server.createobject("adodb.recordset")
                  
                  
                 for ii=1 to count
			CountryID=request.form("countrylist")(ii)
			if request.form("countrylist")(ii)<> "" and request.form("holiday_date") <> "" then
				
		          stmt="select * from holidaylist where holiday='"&usrtosysdate(holiday)&"' and countryid="&request.form("countrylist")(ii)
                  		rs.open stmt,WebCon,2,3       
		          if rs.EOF then
		                  rs.addnew
		                  rs("countryid")=cint(CountryID)
		                  rs("holiday")=usrtosysdate(holiday)
		                  rs("description")=description
		                  rs.update
		                  
		                  sucessStr=sucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		                  response.write " "
		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if
		           rs.close    
		        end if
		     
		    if request("WO")="Y" and CountryID<>"" then
		    stmt="delete from weeklyoff where Embassyid="&CountryID
            rs.open stmt,WebCon,2,3  
		    		    
		    stmt="select * from weeklyoff where  Embassyid="&CountryID
              rs.open stmt,WebCon,2,3       
		          if rs.EOF then
		                  for dn=1 to 7
		                  if request("day"&dn)<>"" then
		                  rs.addnew
		                  rs("Embassyid")=cint(CountryID)
		                  rs("weekend")=cint(request("day"&dn))
		                  rs("description")=description
		                  rs.update
		                  end if
		                  next
		                  sucessStr=sucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		                  response.write " "
		                  
		           Else
		           notsucessStr=notsucessStr&getDescriptionForID("Embassy",CountryID)&"  "
		           End if
		           
		        
		     rs.close    
			
            end if 
                       
		next
      
                
                 if sucessStr<>"" then
                 response.write "<span class='WSRightBold'>HOLIDAY FOR "&sucessStr&"  ENTERED SUCCESSFULLY AT UDAANINDIA.COM </span><BR>"
                 end if
                  if notsucessStr<>"" then
                  response.write "<span class='WSRightBold'>HOLIDAY FOR "&notsucessStr&" ALREADY EXISTS </span>"
                 end if
                 end if 
                %>
                       
