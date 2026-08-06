
<%
response.buffer= true

if session("priv")="" then
response.clear
response.redirect "relogin.asp?rsn=usb"
end if
%>

<style>
/* Prevent navbar menu wrapping */
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

      <!--begin::Messages Dropdown Menu-->
      <li class="nav-item dropdown">
        <a class="nav-link" data-bs-toggle="dropdown" href="#">
          <i class="bi bi-chat-text"></i>
          <span class="navbar-badge badge text-bg-danger">3</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
          <a href="#" class="dropdown-item">
            <!--begin::Message-->
            <div class="d-flex">
              <div class="flex-shrink-0">
                <img
                  src="./assets/img/user1-128x128.jpg"
                  alt="User Avatar"
                  class="img-size-50 rounded-circle me-3"
                />
              </div>
              <div class="flex-grow-1">
                <h3 class="dropdown-item-title">
                  Brad Diesel
                  <span class="float-end fs-7 text-danger"
                    ><i class="bi bi-star-fill"></i
                  ></span>
                </h3>
                <p class="fs-7">Call me whenever you can...</p>
                <p class="fs-7 text-secondary">
                  <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                </p>
              </div>
            </div>
            <!--end::Message-->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!--begin::Message-->
            <div class="d-flex">
              <div class="flex-shrink-0">
                <img
                  src="./assets/img/user8-128x128.jpg"
                  alt="User Avatar"
                  class="img-size-50 rounded-circle me-3"
                />
              </div>
              <div class="flex-grow-1">
                <h3 class="dropdown-item-title">
                  John Pierce
                  <span class="float-end fs-7 text-secondary">
                    <i class="bi bi-star-fill"></i>
                  </span>
                </h3>
                <p class="fs-7">I got your message bro</p>
                <p class="fs-7 text-secondary">
                  <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                </p>
              </div>
            </div>
            <!--end::Message-->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!--begin::Message-->
            <div class="d-flex">
              <div class="flex-shrink-0">
                <img
                  src="./assets/img/user3-128x128.jpg"
                  alt="User Avatar"
                  class="img-size-50 rounded-circle me-3"
                />
              </div>
              <div class="flex-grow-1">
                <h3 class="dropdown-item-title">
                  Nora Silvester
                  <span class="float-end fs-7 text-warning">
                    <i class="bi bi-star-fill"></i>
                  </span>
                </h3>
                <p class="fs-7">The subject goes here</p>
                <p class="fs-7 text-secondary">
                  <i class="bi bi-clock-fill me-1"></i> 4 Hours Ago
                </p>
              </div>
            </div>
            <!--end::Message-->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
        </div>
      </li>
      <!--end::Messages Dropdown Menu-->

      <!--begin::Notifications Dropdown Menu-->
      <li class="nav-item dropdown">
        <a class="nav-link" data-bs-toggle="dropdown" href="#">
          <i class="bi bi-bell-fill"></i>
          <span class="navbar-badge badge text-bg-warning">15</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
          <span class="dropdown-item dropdown-header">15 Notifications</span>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="bi bi-envelope me-2"></i> 4 new messages
            <span class="float-end text-secondary fs-7">3 mins</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="bi bi-people-fill me-2"></i> 8 friend requests
            <span class="float-end text-secondary fs-7">12 hours</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <i class="bi bi-file-earmark-fill me-2"></i> 3 new reports
            <span class="float-end text-secondary fs-7">2 days</span>
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item dropdown-footer"> See All Notifications </a>
        </div>
      </li>
      <!--end::Notifications Dropdown Menu-->

      <!--begin::Fullscreen Toggle-->
      <li class="nav-item">
        <a class="nav-link" href="#" data-lte-toggle="fullscreen">
          <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
          <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
        </a>
      </li>
      <!--end::Fullscreen Toggle-->

      <!--begin::User Menu Dropdown-->
      <li class="nav-item dropdown user-menu">
        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
          <img
            src="./assets/img/user2-160x160.jpg"
            class="user-image rounded-circle shadow"
            alt="User Image"
          />
          <span class="d-none d-md-inline"><%=session("uname")%></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
          <!--begin::User Image-->
          <li class="user-header text-bg-primary">
            <img
              src="./assets/img/user2-160x160.jpg"
              class="rounded-circle shadow"
              alt="User Image"
            />
            <p>
              <%=session("uname")%>
              <small><%if session("priv")="adm" then %>Administrator<%else%>User<%end if%></small>
            </p>
          </li>
          <!--end::User Image-->
          <!--begin::Menu Body-->
          <li class="user-body">
            <!--begin::Row-->
            <div class="row">
              <div class="col-4 text-center">
                <a href="#">Followers</a>
              </div>
              <div class="col-4 text-center">
                <a href="#">Sales</a>
              </div>
              <div class="col-4 text-center">
                <a href="#">Friends</a>
              </div>
            </div>
            <!--end::Row-->
          </li>
          <!--end::Menu Body-->
          <!--begin::Menu Footer-->
          <li class="user-footer">
            <a href="#" class="btn btn-outline-secondary">Profile</a>
            <a href="logoff.asp" class="btn btn-outline-danger float-end">Sign out</a>
          </li>
          <!--end::Menu Footer-->
        </ul>
      </li>
      <!--end::User Menu Dropdown-->
    </ul>
    <!--end::End Navbar Links-->
  </div>
  <!--end::Container-->
</nav>
<!--end::Header-->
    <!--begin::Sidebar-->
      <aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
        <div class="sidebar-brand">
          <a href="Default.asp" class="brand-link">
            <span class="brand-text fw-light">Royal Routes</span>
          </a>
        </div>
        <div class="sidebar-wrapper">
          <nav class="mt-2">
            <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="navigation" aria-label="Main navigation" data-accordion="false">
              <li class="nav-item menu-open">
                <a href="Default.asp" class="nav-link active">
                  <i class="nav-icon bi bi-speedometer"></i>
                  <p>Dashboard</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="employee.asp" class="nav-link">
                  <i class="nav-icon bi bi-envelope"></i>
                  <p>E-mails</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="agentHome.asp" class="nav-link">
                  <i class="nav-icon bi bi-people"></i>
                  <p>Agents</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="embassyhome.asp" class="nav-link">
                  <i class="nav-icon bi bi-building"></i>
                  <p>Embassy</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="userhome.asp" class="nav-link">
                  <i class="nav-icon bi bi-person-badge"></i>
                  <p>Users</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="nav-icon bi bi-file-text"></i>
                  <p>
                    Visa Info
                    <i class="nav-arrow bi bi-chevron-right"></i>
                  </p>
                </a>
                <ul class="nav nav-treeview">
                  <li class="nav-item">
                    <a href="visainfo.asp" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Visa Information</p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="DailySentVisasPost.asp" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Daily Visa Posts</p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="nav-icon bi bi-receipt"></i>
                  <p>
                    Billing & Finance
                    <i class="nav-arrow bi bi-chevron-right"></i>
                  </p>
                </a>
                <ul class="nav nav-treeview">
                  <li class="nav-item">
                    <a href="listbill.asp?cmd=all" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Bills</p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="collection.asp" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Collections</p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="creditnote.asp" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Credit Notes</p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="financialalerts.asp" class="nav-link">
                      <i class="nav-icon bi bi-circle"></i>
                      <p>Financial Alerts</p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="nav-item">
                <a href="searchEntry.asp" class="nav-link">
                  <i class="nav-icon bi bi-search"></i>
                  <p>Advanced Search</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="securityHome.asp" class="nav-link">
                  <i class="nav-icon bi bi-shield-check"></i>
                  <p>Security</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="contact.asp" class="nav-link">
                  <i class="nav-icon bi bi-telephone"></i>
                  <p>Contact Us</p>
                </a>
              </li>
              <%if session("priv")="adm" then %>
              <li class="nav-header">ADMINISTRATION</li>
              <li class="nav-item">
                <a href="Administrator.asp" class="nav-link">
                  <i class="nav-icon bi bi-gear"></i>
                  <p>Admin Panel</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="holidayhome.asp" class="nav-link">
                  <i class="nav-icon bi bi-calendar-check"></i>
                  <p>Holidays</p>
                </a>
              </li>
              <%end if %>
            </ul>
          </nav>
        </div>
      </aside>
<!--end::Sidebar-->
      

