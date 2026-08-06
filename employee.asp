<!-- #include file="connection.asp" -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Royal Routes - Employee Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
  <meta name="color-scheme" content="light dark" />
  <meta name="theme-color" content="#007bff" media="(prefers-color-scheme: light)" />
  <meta name="theme-color" content="#1a1a1a" media="(prefers-color-scheme: dark)" />

  <link rel="stylesheet" href="css/adminlte.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
  <script src="js/adminlte.min.js"></script>
</head>

<body class="layout-fixed sidebar-expand-lg bg-body-tertiary fixed-header">
  <div class="app-wrapper">
    <!-- #include file="top.asp" -->

    <main class="app-main">
      <div class="app-content-header">
        <div class="container-fluid">
          <div class="row">
            <div class="col-sm-6">
              <h3 class="mb-0">Employee Dashboard</h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="Default.asp">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Employee Dashboard</li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <div class="app-content">
        <div class="container-fluid">
          <div class="row">
            <!-- #include file="home.asp" -->
            <!-- #include file="myMessage.asp" -->
            <div class="col-12">
              <!-- #include file="empBottom.asp" -->
            </div>
          </div>
        </div>
      </div>
    </main>

    <footer class="app-footer">
      <div class="float-end d-none d-sm-inline">Royal Routes Employee Dashboard</div>
      <strong>Copyright &copy; 2014-2026&nbsp;
        <a href="https://royalroutes.com" class="text-decoration-none">Royal Routes</a>.
      </strong>
      All rights reserved.
    </footer>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>
