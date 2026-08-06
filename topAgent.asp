<%
response.buffer = true

if session("priv") = "" then
  response.clear
  response.redirect "relogin.asp?rsn=usb"
end if

Dim agentID, agentQS, Chatid
agentID = ""

if request("jn") <> "" then
  agentID = request("jn")
elseif session("userid") <> "" then
  agentID = session("userid")
elseif session("agentid") <> "" then
  agentID = session("agentid")
end if

agentQS = "logon=Y&anp=34&cd=2345&seckey=xyz25g78md20422npr054416panftphjkslsktls&ses=k3456l7dj9javyemsn&company=udaan&jn=" & agentID

Chatid = session("uname")
if Chatid <> "" then
  Chatid = replace(Chatid, "&", "*")
  Chatid = ucase(Chatid)
end if
%>

<style>
.app-header .navbar-nav {
  flex-wrap: nowrap;
  gap: 0;
}
.app-header .navbar-nav .nav-item {
  white-space: nowrap;
  flex-shrink: 0;
}
.app-header .navbar-nav .nav-link {
  padding: 0.5rem 0.75rem;
  font-size: 0.875rem;
  display: flex;
  align-items: center;
  gap: 0.25rem;
}
.app-header .navbar-nav .nav-icon {
  margin-right: 0.25rem;
}
.agent-navbar-search {
  min-width: 230px;
}
@media (max-width: 1024px) {
  .app-header .navbar-nav .nav-link {
    font-size: 0.8rem;
    padding: 0.5rem 0.6rem;
  }
}
@media (max-width: 768px) {
  .app-header .navbar-nav .nav-link {
    font-size: 0.7rem;
    padding: 0.5rem 0.4rem;
  }
  .agent-navbar-search {
    min-width: 160px;
  }
}
</style>

<script language="JavaScript1.2" type="text/javascript">
function UdaanChat() {
  window.open("http://www.udaanindia.com/chat/Clientdefault.asp?uname=<%=Chatid%>", "", "height=500,width=500,left=80,top=80");
}
</script>

<!--begin::Header-->
<nav class="app-header navbar navbar-expand bg-body">
  <!--begin::Container-->
  <div class="container-fluid">
    <!--begin::Start Navbar Links-->
    <ul class="navbar-nav me-auto flex-nowrap">
      <li class="nav-item">
        <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
          <i class="bi bi-list"></i>
        </a>
      </li>
      <li class="nav-item">
        <a href="Default.asp" class="nav-link"><i class="nav-icon bi bi-house"></i> Home</a>
      </li>
      <li class="nav-item">
        <a href="profile.asp" class="nav-link"><i class="nav-icon bi bi-people"></i> Profile</a>
      </li>
      <li class="nav-item">
        <a href="update.asp" class="nav-link"><i class="nav-icon bi bi-check-circle"></i> Update</a>
      </li>
      <li class="nav-item">
        <a href="registration.asp" class="nav-link"><i class="nav-icon bi bi-person-badge"></i> Registration</a>
      </li>
      <li class="nav-item">
        <a href="contactus.asp" class="nav-link"><i class="nav-icon bi bi-phone"></i> Contact Us</a>
      </li>
      <li class="nav-item">
        <a href="queries.asp" class="nav-link"><i class="nav-icon bi bi-question-circle"></i> Queries</a>
      </li>
      <li class="nav-item">
        <a href="logon.asp" class="nav-link"><i class="nav-icon bi bi-person-circle"></i> Logon</a>
      </li>
    </ul>
    <!--end::Start Navbar Links-->

    <!--begin::End Navbar Links-->
    <ul class="navbar-nav ms-auto flex-nowrap">
      <!--begin::Navbar Search-->
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="bi bi-search"></i>
        </a>
      </li>
      <!--end::Navbar Search-->

      <li class="nav-item">
        <a class="nav-link" href="javascript:print()" title="Print">
          <i class="bi bi-printer"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="javascript:UdaanChat()" title="Chat Online">
          <i class="bi bi-chat-dots"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" data-lte-toggle="fullscreen">
          <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
          <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
        </a>
      </li>
      <li class="nav-item dropdown user-menu">
        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
          <img src="./assets/img/user2-160x160.jpg" class="user-image rounded-circle shadow" alt="User Image">
          <span class="d-none d-md-inline"><%=session("uname")%></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
          <li class="user-header text-bg-primary">
            <img src="./assets/img/user2-160x160.jpg" class="rounded-circle shadow" alt="User Image">
            <p>
              <%=session("uname")%>
              <small>Agent</small>
            </p>
          </li>
          <li class="user-footer">
            <a href="editbyagent.asp?uname=<%=session("uname")%>&<%=agentQS%>" class="btn btn-outline-secondary">Profile</a>
            <a href="logout.asp?<%=agentQS%>" class="btn btn-outline-danger float-end">Sign out</a>
          </li>
        </ul>
      </li>
    </ul>
    <!--end::End Navbar Links-->
  </div>
  <!--end::Container-->
</nav>
<!--end::Header-->

<aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
  <div class="sidebar-brand">
    <a href="Agent.asp?<%=agentQS%>" class="brand-link">
      <span class="brand-text fw-light">Royal Routes</span>
    </a>
  </div>
  <div class="sidebar-wrapper">
    <nav class="mt-2">
      <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="navigation" aria-label="Agent navigation" data-accordion="false">
        <li class="nav-item menu-open">
          <a href="Agent.asp?<%=agentQS%>" class="nav-link active">
            <i class="nav-icon bi bi-speedometer"></i>
            <p>Visa Tracking</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link">
            <i class="nav-icon bi bi-list-check"></i>
            <p>
              Status
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview">
            <li class="nav-item">
              <a href="Agent.asp?statustype=sub&<%=agentQS%>" class="nav-link">
                <i class="nav-icon bi bi-circle"></i>
                <p>Submitted</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="Agent.asp?statustype=col&<%=agentQS%>" class="nav-link">
                <i class="nav-icon bi bi-circle"></i>
                <p>Collected</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="Agent.asp?statustype=pen&<%=agentQS%>" class="nav-link">
                <i class="nav-icon bi bi-circle"></i>
                <p>Pending</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="Agent.asp?statustype=sen&<%=agentQS%>" class="nav-link">
                <i class="nav-icon bi bi-circle"></i>
                <p>Sent</p>
              </a>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <a href="holidaylist.asp?<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-calendar-check"></i>
            <p>Holidays</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="visainfo.asp?agentusb=yesuma&<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-file-earmark-text"></i>
            <p>Visa Information</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="forms.asp?agentusb=yesuma&<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-journal-text"></i>
            <p>Visa Forms</p>
          </a>
        </li>
        <li class="nav-header">ACCOUNT</li>
        <li class="nav-item">
          <a href="changepasswordforagent.asp?uname=<%=session("uname")%>&<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-key"></i>
            <p>Change Password</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="editbyagent.asp?uname=<%=session("uname")%>&<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-person-lines-fill"></i>
            <p>Edit Info</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="queries.asp?agentusb=yesuma&<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-question-circle"></i>
            <p>Queries</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="logout.asp?<%=agentQS%>" class="nav-link">
            <i class="nav-icon bi bi-box-arrow-right"></i>
            <p>Logout</p>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</aside>

<script language="javascript">
function checkup() {
  if (document.formup.keywords.value == "") {
    alert("Please enter any keyword !.")
    document.formup.keywords.focus()
    return false
  }
  document.formup.submit()
}
</script>
