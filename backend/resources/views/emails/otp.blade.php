<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kode Verifikasi</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: #0f0f0f;
            font-family: 'Segoe UI', sans-serif;
            color: #ffffff;
            padding: 40px 20px;
        }
        .container {
            max-width: 560px;
            margin: 0 auto;
            background: #1a1a1a;
            border: 1px solid #2a2a2a;
            border-radius: 16px;
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            padding: 40px;
            text-align: center;
        }
        .header h1 { font-size: 28px; font-weight: 700; letter-spacing: 2px; }
        .header p { font-size: 13px; opacity: 0.8; margin-top: 6px; }
        .body { padding: 40px; }
        .greeting { font-size: 18px; font-weight: 600; margin-bottom: 16px; color: #e2e8f0; }
        .message { font-size: 14px; color: #94a3b8; line-height: 1.7; margin-bottom: 32px; }
        .otp-wrapper { text-align: center; margin-bottom: 32px; }
        .otp-code {
            display: inline-block;
            background: #111111;
            border: 2px solid #6366f1;
            border-radius: 12px;
            padding: 20px 40px;
            font-size: 42px;
            font-weight: 800;
            letter-spacing: 12px;
            color: #6366f1;
        }
        .divider { border: none; border-top: 1px solid #2a2a2a; margin: 24px 0; }
        .expire-note { font-size: 12px; color: #64748b; margin-top: 16px; }
        .footer { background: #111111; padding: 24px 40px; text-align: center; }
        .footer p { font-size: 12px; color: #475569; line-height: 1.6; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>LEKSIKA</h1>
            <p>Email Verification</p>
        </div>
        <div class="body">
            <p class="greeting">Halo, {{ $userName }}! 👋</p>
            <p class="message">
                Gunakan kode OTP berikut untuk verifikasi email kamu.
                Jangan bagikan kode ini ke siapapun.
            </p>

            <div class="otp-wrapper">
                <div class="otp-code">{{ $otp }}</div>
            </div>

            <hr class="divider">

            <p class="expire-note">
                ⏱ Kode ini berlaku selama <strong>10 menit</strong>.<br>
                Jika kamu tidak merasa mendaftar, abaikan email ini.
            </p>
        </div>
        <div class="footer">
            <p>
                © {{ date('Y') }} Leksika. All rights reserved.<br>
                Email ini dikirim otomatis, mohon tidak membalas.
            </p>
        </div>
    </div>
</body>
</html>