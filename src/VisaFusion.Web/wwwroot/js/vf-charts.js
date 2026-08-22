/**
 * VisaFusion Chart.js Initialization
 * SPEC-0009 T087 — Wire chart.js for dashboard canvas elements.
 *
 * Finds all <canvas> elements with data-chart-type attributes inside
 * .role-dashboard containers and initializes Chart.js instances using
 * data stored in data-chart-data and data-chart-options attributes.
 *
 * Chart data is serialized as JSON by _RoleDashboard.cshtml.
 * This script runs after DOMContentLoaded and is loaded via _Layout.cshtml
 * only on pages that include chart canvases.
 *
 * @see https://www.chartjs.org/docs/latest/getting-started/
 */
(function () {
  'use strict';

  // Color palette matching CoreUI design tokens
  var colors = {
    primary: 'rgba(13, 102, 204, 0.8)',
    primaryLight: 'rgba(13, 102, 204, 0.1)',
    secondary: 'rgba(108, 117, 125, 0.8)',
    secondaryLight: 'rgba(108, 117, 125, 0.1)',
    success: 'rgba(25, 135, 84, 0.8)',
    successLight: 'rgba(25, 135, 84, 0.1)',
    danger: 'rgba(220, 53, 69, 0.8)',
    dangerLight: 'rgba(220, 53, 69, 0.1)',
    warning: 'rgba(255, 193, 7, 0.8)',
    warningLight: 'rgba(255, 193, 7, 0.1)',
    info: 'rgba(13, 202, 240, 0.8)',
    infoLight: 'rgba(13, 202, 240, 0.1)'
  };

  // Default chart options matching CoreUI styling
  var defaultOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        display: true,
        position: 'bottom'
      },
      tooltip: {
        mode: 'index',
        intersect: false
      }
    },
    scales: {
      x: {
        grid: {
          color: 'rgba(0, 0, 0, 0.05)'
        }
      },
      y: {
        beginAtZero: true,
        grid: {
          color: 'rgba(0, 0, 0, 0.05)'
        }
      }
    }
  };

  /**
   * Parse JSON data attribute safely
   */
  function parseJsonAttr(el, attr) {
    var raw = el.getAttribute(attr);
    if (!raw) return null;
    try {
      return JSON.parse(raw);
    } catch (e) {
      console.warn('Chart.js: Invalid JSON in ' + attr, e);
      return null;
    }
  }

  /**
   * Create a default dataset for a chart type when no data is provided
   */
  function createDefaultDataset(type) {
    var palette = [colors.primary, colors.success, colors.danger, colors.warning, colors.info];
    if (type === 'doughnut' || type === 'pie' || type === 'polarArea') {
      return {
        data: [30, 25, 20, 15, 10],
        backgroundColor: palette,
        borderWidth: 0
      };
    }
    return {
      label: 'Sample Data',
      data: [12, 19, 8, 15, 11, 13],
      backgroundColor: colors.primaryLight,
      borderColor: colors.primary,
      borderWidth: 2,
      fill: type === 'line',
      tension: type === 'line' ? 0.4 : 0
    };
  }

  /**
   * Create a default chart config
   */
  function createDefaultConfig(type, data, options) {
    var dataset = createDefaultDataset(type);
    var defaultLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    var config = {
      type: type,
      data: {
        labels: data && data.labels ? data.labels : defaultLabels,
        datasets: data && data.datasets ? data.datasets : [dataset]
      },
      options: Object.assign({}, defaultOptions, options || {})
    };

    // Remove scales for non-cartesian chart types
    if (['doughnut', 'pie', 'polarArea', 'radar'].indexOf(type) !== -1) {
      delete config.options.scales;
    }

    return config;
  }

  /**
   * Initialize all chart canvases on the page
   */
  function initCharts() {
    var canvases = document.querySelectorAll('.role-dashboard canvas[data-chart-type]');
    for (var i = 0; i < canvases.length; i++) {
      var canvas = canvases[i];
      var chartType = canvas.getAttribute('data-chart-type') || 'line';
      var chartData = parseJsonAttr(canvas, 'data-chart-data');
      var chartOptions = parseJsonAttr(canvas, 'data-chart-options');

      // Skip if already initialized
      if (canvas._chartInstance) continue;

      var config = createDefaultConfig(chartType, chartData, chartOptions);
      canvas._chartInstance = new Chart(canvas, config);
    }
  }

  // Initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCharts);
  } else {
    initCharts();
  }
})();
