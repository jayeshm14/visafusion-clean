<script language="javascript">
function confirm1() {
  var keyword = document.searchform.keywords.value;
  var country = document.searchform.countryID.value;

  if (keyword == "" && country == "") {
    return window.confirm("THIS WILL SHOW ALL THE DATA AND MAY TAKE TIME. CONTINUE???");
  }
}
</script>

<style>
.agent-status-card .card-header {
  border-bottom: 1px solid rgba(0, 0, 0, 0.075);
}
.agent-status-table {
  min-width: 920px;
}
.agent-status-table th,
.agent-status-table td {
  vertical-align: middle;
  white-space: nowrap;
}
.agent-status-table .pax-name {
  white-space: normal;
  min-width: 150px;
}
.agent-status-table .country-name {
  white-space: normal;
  min-width: 120px;
}
.agent-empty-row td {
  padding: 2rem 1rem;
}
</style>

<%
agent = request("jn")

mydate = date() - 90
mydate1 = date() - 2
mydate = Cdate(mydate)
mydate1 = Cdate(mydate1)
today = date()

if session("userid") <> "" then
  agentID = session("userid")
else
  if request("jn") <> "" then
    agentID = Cint(request("jn"))
  end if
end if
%>

<div class="card card-outline card-primary agent-status-card">
  <div class="card-header">
    <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3">
      <div>
        <h3 class="card-title mb-0">
          <i class="bi bi-list-check me-1"></i>
          Current PAX Status
        </h3>
        <div class="text-secondary small mt-1">Click a PAX name to view the visa case history.</div>
      </div>

      <form class="row g-2 align-items-end" name="searchform" action="agent.asp" method="get" onSubmit="return confirm1()">
        <input type="hidden" name="seckey" value="xyz25g78M20422npr054416panftpRhjkslsktlsh456">
        <input type="hidden" name="logonid" value="o9g67435jdpXZ">
        <input type="hidden" name="usbmathura" value="o9g67435jdpXZ">
        <input type="hidden" name="jn" value="<%=agentID%>">

        <div class="col-12 col-sm-auto">
          <label class="form-label mb-1 small fw-semibold" for="agentKeywords">Name</label>
          <input class="form-control form-control-sm" id="agentKeywords" type="text" name="keywords" value="<%=request("keywords")%>" placeholder="PAX name">
        </div>

        <div class="col-12 col-sm-auto">
          <label class="form-label mb-1 small fw-semibold" for="agentCountry">Country</label>
          <select class="form-select form-select-sm" id="agentCountry" name="countryID" size="1">
            <option value="">ALL</option>
            <%
            countryID = request("countryID")

            if Isnull(countryID) or IsEmpty(countryID) or countryID = "" then
              countryID = 0
            end if
            call loadlistbox("embassy", "0")
            %>
          </select>
        </div>

        <div class="col-12 col-sm-auto">
          <button class="btn btn-sm btn-primary" type="submit">
            <i class="bi bi-search me-1"></i>
            Search
          </button>
        </div>
      </form>
    </div>
  </div>

  <div class="card-body p-0">
    <div class="table-responsive">
      <table class="table table-sm table-striped table-hover mb-0 agent-status-table">
        <thead class="table-light">
          <tr>
            <th>Ref #</th>
            <th class="pax-name">PAX Name</th>
            <th>Agent Name</th>
            <th>Status</th>
            <th>Received</th>
            <th>Submit</th>
            <th>Collection</th>
            <th>Total</th>
            <th class="country-name">Country</th>
          </tr>
        </thead>
        <tbody>
<%
set rs = server.createobject("adodb.recordset")
stmt = ""

if agentID <> "" then
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and Mainentry.Agent =" & agentID & "  and entrydetails.refno=mainentry.refno and entryDetails.Paxname LIKE '%" & request("keywords") & "%' order by entryDetails.refno desc"
end if

if agentID <> "" and request("keywords") <> "" then
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent =" & agentID & " and entryDetails.Paxname LIKE '%" & request("keywords") & "%' order by entryDetails.refno desc"
end if

if agentID <> "" and request("keywords") = "" then
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent =" & agentID & " and (paxstatus.sentdate > '" & mydate1 & "' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if

if agentID <> "" and request("keywords") = "" and request("usbmathura") <> "" then
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent =" & agentID & " and (paxstatus.sentdate > '" & mydate & "' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if

if request("countryID") <> "" then
  countryID = Cint(request("countryID"))
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno  and Mainentry.Agent =" & agentID & "  and paxstatus.countryID=" & countryID & " and paxstatus.Subdate >" & mydate & " order by entryDetails.refno desc"
end if

if request("countryID") <> "" and request("keywords") <> "" then
  countryID = Cint(request("countryID"))
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID=" & countryID & "   and Mainentry.Agent =" & agentID & "  and entryDetails.Paxname LIKE '%" & request("keywords") & "%' and paxstatus.Subdate >" & mydate & " order by entryDetails.refno desc"
end if

if request("countryID") <> "" and agentID <> "" then
  countryID = Cint(request("countryID"))
  agentID = Cint(agentID)
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID=" & countryID & " and Mainentry.Agent=" & agentID & " and (paxstatus.sentdate > '" & mydate & "' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if

if request("countryID") <> "" and agentID <> "" and request("keywords") <> "" then
  countryID = Cint(request("countryID"))
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.countryID=" & countryID & " and Mainentry.Agent=" & agentID & " and entryDetails.Paxname LIKE '%" & request("keywords") & "%' and (paxstatus.sentdate > '" & mydate & "' or paxstatus.sentdate is null) order by entryDetails.refno desc"
end if

if request("sc_sdate") <> "" and agentID <> "" and request("sc_edate") <> "" then
  countryID = Cint(request("countryID"))
  sdate = cdate(request("sc_sdate"))
  edate = cdate(request("sc_edate"))
  'stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent=" & agentID & "  and paxstatus.Subdate >='" & sdate & "' and  paxstatus.Subdate <='" & edate & "'  order by entryDetails.refno desc"
  stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and Mainentry.Agent=" & agentID & "  and paxstatus.Subdate >=01/01/01 and  paxstatus.Subdate <=5/5/01  order by entryDetails.refno desc"
end if

if request("statustype") = "col" then
  colStatusID = getIDForDescription("status", "Collected")
  if agentID <> "" then
    stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID=" & colStatusID & "  and Mainentry.Agent=" & agentID & "  order by entryDetails.refno desc"
  end if
end if

if request("statustype") = "sub" then
  colStatusID = getIDForDescription("status", "Submitted")
  if agentID <> "" then
    stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID=" & colStatusID & "  and Mainentry.Agent=" & agentID & "  order by entryDetails.refno desc"
  end if
end if

if request("statustype") = "sen" then
  colStatusID = getIDForDescription("status", "Sent")
  if agentID <> "" then
    stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID=" & colStatusID & "  and Mainentry.Agent=" & agentID & " and (paxstatus.sentdate > '" & mydate & "' or paxstatus.sentdate is null) order by entryDetails.refno desc"
  end if
end if

if request("statustype") = "pen" then
  if agentID <> "" then
    stmt = "select Entrydetails.Totalpax, mainentry.poe, paxstatus.refno,paxstatus.paxID,MainEntry.internalRemark,MainEntry.agentInstruction,EntryDetails.paxname,paxstatus.coldate,paxstatus.colcheck,paxstatus.Subdate, paxstatus.countryID,paxstatus.statusID,paxstatus.remarks,paxstatus.sentdate,entryDetails.Paxname,MainEntry.receivedate, Mainentry.Agent from Mainentry,EntryDetails,Paxstatus where paxstatus.paxid=entrydetails.paxid and entrydetails.refno=mainentry.refno and paxstatus.statusID>400 and paxstatus.statusID<500  and Mainentry.Agent=" & agentID & "  order by entryDetails.refno desc"
  end if
end if

    response.write stmt

if agentID <> "" and stmt <> "" then
  rs.open stmt, con

  if rs.eof then
    response.write "<tr class='agent-empty-row'><td colspan='9' class='text-center text-danger fw-semibold'>NO DATA FOUND</td></tr>"
  else
    while not rs.eof
      paxID = rs.fields("paxID")
      refno = rs.fields("refno")
      agent = rs.fields("agent")
      receivedate = SysToUsrDate(rs.fields("receivedate"))
      subdate = SysToUsrDate(rs.fields("subdate"))
      coldate = SysToUsrDate(rs.fields("coldate"))
      check = rs.fields("colcheck")

      if check = "chk" and coldate <> "" then
        coldate = "CHK - " & coldate
      end if

      response.write "<tr>"
      response.write "<td class='fw-semibold'>" & refno

      poe = rs.fields("poe")
      if poe <> "1" then
        poe = getDescriptionForID("poe", poe)
        response.write "<br><span class='badge text-bg-danger'>" & poe & "</span>"
      end if

      response.write "</td>"
      response.write "<td class='pax-name'><a class='fw-semibold text-decoration-none' href='AgentPaxstatus.asp?refno=" & refno & "&paxID=" & paxID & "&logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&jn=" & agentID & "&ses=k3456l7dj9javyemsn&company=udaan'>" & ucase(rs.fields("paxname")) & "</a></td>"
      response.write "<td>"
      call writeIDDescription("agents", agent)
      response.write "</td>"
      response.write "<td>"
      call writeIDDescription("status", rs.fields("statusid"))
      response.write "</td>"
      response.write "<td>" & receivedate & "</td>"
      response.write "<td>" & subdate & "</td>"
      response.write "<td>" & coldate & "</td>"
      response.write "<td>" & rs.fields("totalpax") & "</td>"
      response.write "<td class='country-name'>"
      call writeIDDescription("embassy", rs.fields("countryID"))
      response.write "</td>"
      response.write "</tr>"

      rs.movenext
    wend
  end if

  rs.close()
else
  response.write "<tr class='agent-empty-row'><td colspan='9' class='text-center text-danger fw-semibold'>PLEASE LOG IN AGAIN</td></tr>"
end if
%>
        </tbody>
      </table>
    </div>
  </div>
</div>
