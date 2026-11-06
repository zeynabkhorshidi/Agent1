# پروژه سایه‌سمن

[دانلود مستقیم ZIP پروژه](https://github.com/zeynabkhorshidi/Agent1/raw/refs/heads/main/releases/sayesaman-agentic-marketplace-v1.0.0.zip)

فایل حدود ۱۹ مگابایت است. اگر صفحه پیش‌نمایش باز شد، گزینه **Download raw file** را بزنید.

پس از استخراج، راهنمای `README.fa.md` و `GETTING_STARTED.fa.md` را بخوانید. سورس، Docker Compose، تست‌ها، داده مصنوعی و مستندات داخل ZIP هستند. checksum در پوشه releases قرار دارد.

این نسخه دموی تراکنشی قابل‌اجراست و تکمیل تمام الزامات سند یا آمادگی production را ادعا نمی‌کند. اتصال‌های واقعی ERP، VTT، نقشه و مدل زبانی تأیید نشده‌اند؛ جزئیات ناتمام‌ها داخل `BLOCKERS.fa.md` و ماتریس پذیرش آمده است. هیچ رمز عملیاتی یا داده مشتری واقعی در بسته قرار نگرفته است.

## به‌روزرسانی ظاهر با ایران‌سنس
[دانلود بسته کوچک به‌روزرسانی رابط](https://github.com/zeynabkhorshidi/Agent1/raw/refs/heads/main/releases/sayesaman-ui-update.zip)

فونت ایران‌سنس ارسالی مالک، متن‌های خواناتر و حذف یادداشت‌ها و منابع تکراری از صفحات اصلی. وضعیت محیط آزمایشی و اتصال‌ها همچنان مشخص است.

برای نصب فعلی، محتوای بسته را در پوشه پروژه استخراج و فایل‌های هم‌نام را جایگزین کنید. سپس در PowerShell همان پوشه:

```powershell
docker compose build api
if ($LASTEXITCODE -eq 0) {
    docker compose up -d --no-build --wait api worker web
}
```

مرورگر را با Ctrl+F5 تازه کنید. پیش‌نمایش: [داشبورد](previews/dashboard.png)، [موبایل](previews/mobile.png)، [ورود](previews/login.png).
فایل ZIP کامل پروژه نیز به‌روز شده است. مجوز MIT پروژه شامل فونت‌های ثالث نمی‌شود؛ جزئیات در مستندات بسته است.

## رفع 502 پس از به‌روزرسانی API
[دانلود بسته کوچک اصلاح اتصال پراکسی](https://github.com/zeynabkhorshidi/Agent1/raw/refs/heads/main/releases/sayesaman-proxy-update.zip)

محتوا را داخل پوشه پروژه استخراج و فایل‌های هم‌نام را جایگزین کنید. وقتی API سالم و روشن است، در همان پوشه اجرا کنید:

```powershell
docker compose up -d --no-deps --no-build --force-recreate --wait web
```

Nginx اکنون آدرس API را از DNS داخلی Docker دوباره resolve می‌کند. healthcheck وب نیز مسیر کامل تا API را بررسی می‌کند. آزمون تغییر واقعی IP در کانتینرهای ایزوله، بدون restart شدن Nginx، موفق بود.
برای رفع فوری روی نسخه قدیمی: `docker compose restart web`.
