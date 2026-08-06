<!DOCTYPE html>
<html lang="en">
<!--begin::Head-->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Royal Routes - Admin Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
  <meta name="color-scheme" content="light dark" />
  <meta name="theme-color" content="#007bff" media="(prefers-color-scheme: light)" />
  <meta name="theme-color" content="#1a1a1a" media="(prefers-color-scheme: dark)" />
  
  <link rel="stylesheet" href="css/adminlte.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
  <script src="js/adminlte.min.js"></script>
</head>
<!--end::Head-->

<!--begin::Body-->
<body class="layout-fixed sidebar-expand-lg bg-body-tertiary fixed-header">
  <!--begin::App Wrapper-->
  <div class="app-wrapper">
    <!-- #include file="connection.asp" -->
    <!-- #include file="topAdmin.asp" -->
    
    <!--begin::App Main-->
    <main class="app-main">
      <!--begin::App Content Header-->
      <div class="app-content-header">
        <div class="container-fluid">
           <!--begin::Row-->
            <div class="row">
              <div class="col-sm-6">
                <h3 class="mb-0">Dashboard</h3>
              </div>
              <div class="col-sm-6">
                <ol class="breadcrumb float-sm-end">
                  <li class="breadcrumb-item"><a href="#">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                </ol>
              </div>
            </div>
            <!--end::Row-->
        </div>
      </div>
      <!--end::App Content Header-->
      
      <!--begin::App Content-->
      <div class="app-content">
        <div class="container-fluid">
          <!--begin::Row-->
          <div class="row">
            <!-- #include file="home.asp" -->
            <!-- #include file="myMessage.asp" -->
            <!-- #include file="adminBottom.asp" -->
          </div>
          <!--end::Row-->
        </div>
      </div>
      <!--end::App Content-->
    </main>
    <!--end::App Main-->
    
    <!--begin::Footer-->
    <footer class="app-footer">
      <div class="float-end d-none d-sm-inline">Royal Routes Admin Dashboard</div>
      <strong>Copyright &copy; 2014-2026&nbsp;
        <a href="https://royalroutes.com" class="text-decoration-none">Royal Routes</a>.
      </strong>
      All rights reserved.
    </footer>
    <!--end::Footer-->
  </div>
  <!--end::App Wrapper-->
  
  <!--begin::Third Party Plugin(OverlayScrollbars)-->
  <script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js" crossorigin="anonymous"></script>
  <!--end::Third Party Plugin(OverlayScrollbars)-->
  
  <!--begin::Required Plugin(popperjs for Bootstrap 5)-->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
  <!--end::Required Plugin(popperjs for Bootstrap 5)-->
  
  <!--begin::Required Plugin(Bootstrap 5)-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
  <!--end::Required Plugin(Bootstrap 5)-->
</body>
<!--end::Body-->
</html>

