<%@ Page Language="C#" AutoEventWireup="true" %>
<!doctype html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Vehicle Inspection Panel (ASPX)</title>
  <style>
    :root {
      --bg: #f4f7fb;
      --card: #ffffff;
      --text: #182230;
      --muted: #5f6b7a;
      --primary: #0d6efd;
      --success: #198754;
      --warning: #fd7e14;
      --border: #dce3ec;
      --shadow: 0 8px 20px rgba(15, 23, 42, 0.08);
      --radius: 14px;
    }

    * { box-sizing: border-box; }

    body {
      margin: 0;
      background: var(--bg);
      color: var(--text);
      font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      line-height: 1.45;
    }

    .container {
      max-width: 760px;
      margin: 0 auto;
      padding: 14px;
    }

    .card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 14px;
      margin-bottom: 12px;
    }

    h1 {
      font-size: 1.25rem;
      margin: 6px 0 14px;
      text-align: center;
    }

    h2 {
      font-size: 1rem;
      margin: 0 0 10px;
    }

    .lead-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 8px;
      font-size: 0.94rem;
    }

    .lead-grid .label {
      color: var(--muted);
      display: block;
      font-size: 0.82rem;
    }

    a.call-link {
      color: var(--primary);
      text-decoration: none;
      font-weight: 600;
    }

    .status-bar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      border: 1px dashed var(--border);
      border-radius: 10px;
      padding: 10px;
      background: #f9fbff;
      margin-top: 10px;
    }

    #statusBadge {
      font-weight: 700;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 0.82rem;
      color: #fff;
      background: #6c757d;
    }

    .status-assigned { background: #6c757d !important; }
    .status-in-process { background: var(--warning) !important; }
    .status-completed { background: var(--success) !important; }

    .field { margin-bottom: 11px; }

    .field label {
      display: block;
      font-size: 0.84rem;
      color: var(--muted);
      margin-bottom: 6px;
    }

    input[type="text"],
    input[type="number"],
    textarea,
    select {
      width: 100%;
      border: 1px solid var(--border);
      border-radius: 10px;
      padding: 11px 12px;
      font-size: 0.95rem;
      background: #fff;
    }

    textarea {
      min-height: 86px;
      resize: vertical;
    }

    .capture-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }

    .capture-item {
      border: 1px solid var(--border);
      border-radius: 10px;
      padding: 10px;
      background: #fdfefe;
    }

    .capture-btn {
      width: 100%;
      border: none;
      background: var(--primary);
      color: #fff;
      padding: 10px;
      border-radius: 10px;
      font-weight: 600;
      cursor: pointer;
      font-size: 0.9rem;
    }

    .hidden-input {
      position: absolute;
      left: -9999px;
      opacity: 0;
      width: 1px;
      height: 1px;
    }

    .preview {
      margin-top: 8px;
      width: 100%;
      border-radius: 8px;
      border: 1px solid var(--border);
      background: #f0f3f8;
      min-height: 82px;
      object-fit: cover;
    }

    video.preview {
      min-height: 140px;
    }

    .meta {
      margin-top: 6px;
      font-size: 0.74rem;
      color: var(--muted);
      min-height: 30px;
      word-break: break-word;
    }

    .small-note {
      margin-top: 8px;
      font-size: 0.8rem;
      color: var(--muted);
    }

    .submit-btn {
      width: 100%;
      border: none;
      background: var(--success);
      color: #fff;
      padding: 13px;
      border-radius: 11px;
      font-size: 1rem;
      font-weight: 700;
      cursor: pointer;
    }

    @media (max-width: 460px) {
      .capture-grid { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <form id="inspectionFormMain" runat="server">
    <div class="container">
      <h1>Vehicle Inspection Panel</h1>

      <section class="card">
        <h2>Lead Details</h2>
        <div class="lead-grid">
          <div><span class="label">Customer Name</span><strong id="customerName">Rahul Sharma</strong></div>
          <div><span class="label">Mobile</span><a id="mobileLink" class="call-link" href="tel:+919876543210">+91 98765 43210</a></div>
          <div><span class="label">Address</span><span id="addressText">24 MG Road, Bengaluru, Karnataka</span></div>
        </div>

        <div class="status-bar">
          <span>Inspection Status</span>
          <span id="statusBadge" class="status-assigned">Assigned</span>
        </div>
        <div class="small-note" id="gpsStatus">Fetching GPS coordinates…</div>
      </section>

      <section class="card" id="inspectionFields">
        <h2>Vehicle Parameters</h2>

        <div class="field">
          <label for="caseId">Case ID</label>
          <input type="text" id="caseId" value="CASE-2026-001" readonly />
        </div>

        <div class="field">
          <label for="odometer">Odometer (km)</label>
          <input type="number" id="odometer" inputmode="numeric" placeholder="Enter odometer reading" />
        </div>

        <div class="field">
          <label for="engineCondition">Engine Condition</label>
          <select id="engineCondition">
            <option value="">Select condition</option>
            <option>Excellent</option>
            <option>Good</option>
            <option>Average</option>
            <option>Poor</option>
          </select>
        </div>

        <div class="field">
          <label for="exteriorCondition">Exterior Condition</label>
          <select id="exteriorCondition">
            <option value="">Select condition</option>
            <option>Excellent</option>
            <option>Good</option>
            <option>Average</option>
            <option>Poor</option>
          </select>
        </div>

        <div class="field">
          <label for="notes">Inspection Notes</label>
          <textarea id="notes" placeholder="Add remarks..."></textarea>
        </div>
      </section>

      <section class="card">
        <h2>Capture Photos (with watermark)</h2>
        <div class="capture-grid">
          <div class="capture-item" data-view="Front">
            <button class="capture-btn" type="button">Capture Front View</button>
            <input class="hidden-input photo-input" type="file" accept="image/*" capture="environment" />
            <img class="preview" alt="Front view preview" />
            <div class="meta"></div>
          </div>

          <div class="capture-item" data-view="Back">
            <button class="capture-btn" type="button">Capture Back View</button>
            <input class="hidden-input photo-input" type="file" accept="image/*" capture="environment" />
            <img class="preview" alt="Back view preview" />
            <div class="meta"></div>
          </div>

          <div class="capture-item" data-view="Left">
            <button class="capture-btn" type="button">Capture Left View</button>
            <input class="hidden-input photo-input" type="file" accept="image/*" capture="environment" />
            <img class="preview" alt="Left view preview" />
            <div class="meta"></div>
          </div>

          <div class="capture-item" data-view="Right">
            <button class="capture-btn" type="button">Capture Right View</button>
            <input class="hidden-input photo-input" type="file" accept="image/*" capture="environment" />
            <img class="preview" alt="Right view preview" />
            <div class="meta"></div>
          </div>
        </div>
      </section>

      <section class="card">
        <h2>Capture Video</h2>
        <button class="capture-btn" id="videoCaptureBtn" type="button">Capture Walkaround Video</button>
        <input class="hidden-input" id="videoInput" type="file" accept="video/*" capture="environment" />
        <video id="videoPreview" class="preview" controls playsinline></video>
        <div class="meta" id="videoMeta"></div>
      </section>

      <button class="submit-btn" id="submitInspection" type="button">Submit Inspection</button>
    </div>
  </form>

  <script>
    (function () {
      const statusBadge = document.getElementById('statusBadge');
      const gpsStatus = document.getElementById('gpsStatus');
      const caseIdInput = document.getElementById('caseId');
      const fieldSection = document.getElementById('inspectionFields');
      const submitBtn = document.getElementById('submitInspection');
      const videoInput = document.getElementById('videoInput');
      const videoCaptureBtn = document.getElementById('videoCaptureBtn');
      const videoPreview = document.getElementById('videoPreview');
      const videoMeta = document.getElementById('videoMeta');

      let status = 'Assigned';
      const gps = { latitude: 'NA', longitude: 'NA' };

      function setStatus(nextStatus) {
        status = nextStatus;
        statusBadge.textContent = status;
        statusBadge.classList.remove('status-assigned', 'status-in-process', 'status-completed');
        if (status === 'Assigned') statusBadge.classList.add('status-assigned');
        if (status === 'In Process') statusBadge.classList.add('status-in-process');
        if (status === 'Completed') statusBadge.classList.add('status-completed');
      }

      function nowText() {
        return new Date().toLocaleString();
      }

      function fetchGps() {
        if (!navigator.geolocation) {
          gpsStatus.textContent = 'GPS not supported on this device/browser.';
          return;
        }

        navigator.geolocation.getCurrentPosition(
          function (position) {
            gps.latitude = position.coords.latitude.toFixed(6);
            gps.longitude = position.coords.longitude.toFixed(6);
            gpsStatus.textContent = 'GPS: ' + gps.latitude + ', ' + gps.longitude;
          },
          function (error) {
            gpsStatus.textContent = 'GPS unavailable: ' + error.message;
          },
          { enableHighAccuracy: true, timeout: 10000, maximumAge: 0 }
        );
      }

      function drawWatermarkedImage(imageEl, viewLabel, capturedAt, onDone) {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        canvas.width = imageEl.naturalWidth;
        canvas.height = imageEl.naturalHeight;

        ctx.drawImage(imageEl, 0, 0, canvas.width, canvas.height);

        const padding = Math.max(16, Math.round(canvas.width * 0.02));
        const fontSize = Math.max(18, Math.round(canvas.width * 0.028));
        const lines = [
          'Case: ' + caseIdInput.value,
          'View: ' + viewLabel,
          'DateTime: ' + capturedAt,
          'GPS: ' + gps.latitude + ', ' + gps.longitude
        ];

        ctx.font = '600 ' + fontSize + 'px Arial';
        const lineHeight = fontSize + 8;
        const boxHeight = lines.length * lineHeight + padding;
        const boxWidth = Math.min(canvas.width - (padding * 2), canvas.width * 0.92);
        const boxX = padding;
        const boxY = canvas.height - boxHeight - padding;

        ctx.fillStyle = 'rgba(0, 0, 0, 0.56)';
        ctx.fillRect(boxX, boxY, boxWidth, boxHeight);

        ctx.fillStyle = '#ffffff';
        lines.forEach(function (line, idx) {
          ctx.fillText(line, boxX + padding, boxY + padding + ((idx + 1) * lineHeight) - 8);
        });

        onDone(canvas.toDataURL('image/jpeg', 0.92));
      }

      function moveToInProcess() {
        if (status === 'Assigned') setStatus('In Process');
      }

      fieldSection.addEventListener('input', moveToInProcess);

      document.querySelectorAll('.capture-item').forEach(function (item) {
        const button = item.querySelector('.capture-btn');
        const input = item.querySelector('.photo-input');
        const preview = item.querySelector('.preview');
        const meta = item.querySelector('.meta');
        const view = item.getAttribute('data-view');

        button.addEventListener('click', function () {
          input.click();
        });

        input.addEventListener('change', function () {
          const file = input.files && input.files[0];
          if (!file) return;

          moveToInProcess();
          const capturedAt = nowText();
          const image = new Image();
          image.onload = function () {
            drawWatermarkedImage(image, view, capturedAt, function (dataUrl) {
              preview.src = dataUrl;
              meta.textContent = 'Captured: ' + capturedAt;
            });
          };
          image.src = URL.createObjectURL(file);
        });
      });

      videoCaptureBtn.addEventListener('click', function () {
        videoInput.click();
      });

      videoInput.addEventListener('change', function () {
        const file = videoInput.files && videoInput.files[0];
        if (!file) return;

        moveToInProcess();
        const capturedAt = nowText();
        videoPreview.src = URL.createObjectURL(file);
        videoMeta.textContent = 'Video captured: ' + capturedAt;
      });

      submitBtn.addEventListener('click', function () {
        setStatus('Completed');
        alert('Inspection submitted successfully.');
      });

      setStatus('Assigned');
      fetchGps();
    })();
  </script>
</body>
</html>
