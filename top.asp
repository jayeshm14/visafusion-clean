<%
response.buffer = true

if session("priv") = "" then
  response.clear
  response.redirect "relogin.asp?rsn=usb"
end if

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
.employee-navbar-search {
  min-width: 210px;
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
}
</style>

<script language="javascript">
function checkup() {
  if (document.formup.keywords.value == "") {
    alert("Please enter any keyword !.")
    document.formup.keywords.focus()
    return false
  }
  document.formup.submit()
}

function ChatOnline() {
  window.open("http://www.udaanindia.com/chat/default.asp?username=UDAAN_<%=Chatid%>&mode=userLogin", null, "height=800,width=800,channelmode=yes,status=no,toolbar=yes,menubar=no,titlebar=no,resizable=yes");
}
</script>

<!--begin::Header-->
<nav class="app-header navbar navbar-expand bg-body">
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
        <a href="visaInfo.asp" class="nav-link"><i class="nav-icon bi bi-question-circle"></i> Queries</a>
      </li>
      <li class="nav-item">
        <a href="logout.asp" class="nav-link"><i class="nav-icon bi bi-box-arrow-right"></i> Logout</a>
      </li>
    </ul>
    <!--end::Start Navbar Links-->

    <!--begin::End Navbar Links-->
    <ul class="navbar-nav ms-auto flex-nowrap align-items-center">
      <li class="nav-item d-none d-md-block">
        <form class="d-flex employee-navbar-search" name="formup" action="searchPax.asp" method="get" onSubmit="return checkup()">
          <input class="form-control form-control-sm" type="text" name="keywords" placeholder="Search PAX">
          <button class="btn btn-sm btn-primary ms-1" type="submit"><i class="bi bi-search"></i></button>
        </form>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="javascript:print()" title="Print">
          <i class="bi bi-printer"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="javascript:ChatOnline()" title="Chat Online">
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
              <small><%if session("priv") = "adm" then %>Administrator<%else%>Employee<%end if%></small>
            </p>
          </li>
          <li class="user-footer">
            <a href="profile.asp" class="btn btn-outline-secondary">Profile</a>
            <a href="logout.asp" class="btn btn-outline-danger float-end">Sign out</a>
          </li>
        </ul>
      </li>
    </ul>
    <!--end::End Navbar Links-->
  </div>
</nav>
<!--end::Header-->

<!--begin::Sidebar-->
<aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
  <div class="sidebar-brand">
    <a href="employee.asp?uname=<%=session("uname")%>" class="brand-link">
      <span class="brand-text fw-light">Royal Routes</span>
    </a>
  </div>
  <div class="sidebar-wrapper">
    <nav class="mt-2">
      <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="navigation" aria-label="Employee navigation" data-accordion="false">
        <li class="nav-item menu-open">
          <a href="employee.asp?uname=<%=session("uname")%>" class="nav-link active">
            <i class="nav-icon bi bi-speedometer"></i>
            <p>Dashboard</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="employee.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-envelope"></i>
            <p>Udaan E-mails</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="calendar.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-pencil-square"></i>
            <p>New E-mail</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="agentHome.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-people"></i>
            <p>Agents</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="entry.asp#formtop?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-box-arrow-in-down"></i>
            <p>Submission</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="collection.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-cash-coin"></i>
            <p>Collection</p>
          </a>
        </li>
        <% if session("uname") = "uma" or ucase(session("su")) = "Y" then %>
        <li class="nav-item">
          <a href="holidayhome.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-calendar-check"></i>
            <p>Holidays</p>
          </a>
        </li>
        <% end if %>
        <li class="nav-item">
          <a href="visainfo.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-file-earmark-text"></i>
            <p>Visa Information</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="searchEntry.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-search"></i>
            <p>Advanced Search</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="dailyprintref.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-printer"></i>
            <p>Daily Print</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="dailybill.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-truck"></i>
            <p>Dispatch</p>
          </a>
        </li>
        <li class="nav-item">
          <a href="dailysentawb.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-send-check"></i>
            <p>Sent AWB</p>
          </a>
        </li>
        <% if session("priv") = "adm" then %>
        <li class="nav-header">ADMINISTRATION</li>
        <li class="nav-item">
          <a href="administrator.asp?uname=<%=session("uname")%>" class="nav-link">
            <i class="nav-icon bi bi-gear"></i>
            <p>Admin Panel</p>
          </a>
        </li>
        <% end if %>
      </ul>
    </nav>
  </div>
</aside>
<!--end::Sidebar-->
