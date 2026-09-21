@echo off
chcp 65001 >nul
setlocal

set "P=FDweb-Android"

echo ==========================================
echo   FDweb-Android Project Generator
echo ==========================================
echo.
echo Creating folders...
mkdir "%P%\.github\workflows" 2>nul
mkdir "%P%\app\src\main\java\ir\hhm\fdweb" 2>nul
mkdir "%P%\app\src\main\res\drawable" 2>nul
mkdir "%P%\app\src\main\res\layout" 2>nul
mkdir "%P%\app\src\main\res\values" 2>nul

echo Creating files...
call :f1
call :f2
call :f3
call :f4
call :f5
call :f6
call :f7
call :f8
call :f9
call :f10
call :f11
call :f12
call :f13
call :f14
call :f15

echo.
echo ==========================================
echo   Done! Project: %CD%\%P%
echo ==========================================
echo.
echo Next steps:
echo   1. Create GitHub repo named "FDweb-Android"
echo   2. Upload contents of "%P%" folder
echo   3. Wait for GitHub Actions to build APK
echo   4. Download APK from Actions tab
echo.
pause
exit /b

:: ============ File 1: .github/workflows/build.yml ============
:f1
set "F=%P%\.github\workflows\build.yml"
>"%F%" echo name: Build FDweb APK
>>"%F%" echo.
>>"%F%" echo on:
>>"%F%" echo   push:
>>"%F%" echo     branches: [ main, master ]
>>"%F%" echo   workflow_dispatch:
>>"%F%" echo.
>>"%F%" echo jobs:
>>"%F%" echo   build:
>>"%F%" echo     runs-on: ubuntu-latest
>>"%F%" echo.
>>"%F%" echo     steps:
>>"%F%" echo       - name: Checkout
>>"%F%" echo         uses: actions/checkout@v4
>>"%F%" echo.
>>"%F%" echo       - name: Setup JDK 17
>>"%F%" echo         uses: actions/setup-java@v4
>>"%F%" echo         with:
>>"%F%" echo           distribution: temurin
>>"%F%" echo           java-version: 17
>>"%F%" echo.
>>"%F%" echo       - name: Setup Android SDK
>>"%F%" echo         uses: android-actions/setup-android@v3
>>"%F%" echo.
>>"%F%" echo       - name: Setup Gradle
>>"%F%" echo         uses: gradle/actions/setup-gradle@v4
>>"%F%" echo         with:
>>"%F%" echo           gradle-version: 8.4
>>"%F%" echo.
>>"%F%" echo       - name: Build APK
>>"%F%" echo         run: gradle assembleDebug --no-daemon
>>"%F%" echo.
>>"%F%" echo       - name: Upload APK
>>"%F%" echo         uses: actions/upload-artifact@v4
>>"%F%" echo         with:
>>"%F%" echo           name: FDweb-APK
>>"%F%" echo           path: app/build/outputs/apk/debug/*.apk
>>"%F%" echo           retention-days: 30
exit /b

:: ============ File 2: settings.gradle ============
:f2
set "F=%P%\settings.gradle"
>"%F%" echo pluginManagement {
>>"%F%" echo     repositories {
>>"%F%" echo         google()
>>"%F%" echo         mavenCentral()
>>"%F%" echo         gradlePluginPortal()
>>"%F%" echo     }
>>"%F%" echo }
>>"%F%" echo.
>>"%F%" echo dependencyResolutionManagement {
>>"%F%" echo     repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
>>"%F%" echo     repositories {
>>"%F%" echo         google()
>>"%F%" echo         mavenCentral()
>>"%F%" echo     }
>>"%F%" echo }
>>"%F%" echo.
>>"%F%" echo rootProject.name = "FDweb"
>>"%F%" echo include ':app'
exit /b

:: ============ File 3: build.gradle ============
:f3
set "F=%P%\build.gradle"
>"%F%" echo plugins {
>>"%F%" echo     id 'com.android.application' version '8.2.0' apply false
>>"%F%" echo     id 'org.jetbrains.kotlin.android' version '1.9.20' apply false
>>"%F%" echo }
exit /b

:: ============ File 4: gradle.properties ============
:f4
set "F=%P%\gradle.properties"
>"%F%" echo android.useAndroidX=true
>>"%F%" echo android.enableJetifier=true
>>"%F%" echo org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
>>"%F%" echo kotlin.code.style=official
>>"%F%" echo android.nonTransitiveRClass=true
exit /b

:: ============ File 5: app/build.gradle ============
:f5
set "F=%P%\app\build.gradle"
>"%F%" echo plugins {
>>"%F%" echo     id 'com.android.application'
>>"%F%" echo     id 'org.jetbrains.kotlin.android'
>>"%F%" echo }
>>"%F%" echo.
>>"%F%" echo android {
>>"%F%" echo     namespace 'ir.hhm.fdweb'
>>"%F%" echo     compileSdk 34
>>"%F%" echo.
>>"%F%" echo     defaultConfig {
>>"%F%" echo         applicationId "ir.hhm.fdweb"
>>"%F%" echo         minSdk 21
>>"%F%" echo         targetSdk 34
>>"%F%" echo         versionCode 1
>>"%F%" echo         versionName "1.0"
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     buildTypes {
>>"%F%" echo         release {
>>"%F%" echo             minifyEnabled false
>>"%F%" echo             proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
>>"%F%" echo         }
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     compileOptions {
>>"%F%" echo         sourceCompatibility JavaVersion.VERSION_17
>>"%F%" echo         targetCompatibility JavaVersion.VERSION_17
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     kotlinOptions {
>>"%F%" echo         jvmTarget = '17'
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     buildFeatures {
>>"%F%" echo         buildConfig = true
>>"%F%" echo     }
>>"%F%" echo }
>>"%F%" echo.
>>"%F%" echo dependencies {
>>"%F%" echo     implementation 'androidx.appcompat:appcompat:1.6.1'
>>"%F%" echo     implementation 'androidx.core:core-ktx:1.12.0'
>>"%F%" echo     implementation 'androidx.webkit:webkit:1.10.0'
>>"%F%" echo     implementation 'com.google.android.material:material:1.11.0'
>>"%F%" echo }
exit /b

:: ============ File 6: app/proguard-rules.pro ============
:f6
set "F=%P%\app\proguard-rules.pro"
>"%F%" echo -keep class ir.hhm.fdweb.** { *; }
>>"%F%" echo -keepclassmembers class * {
>>"%F%" echo     @android.webkit.JavascriptInterface ^<methods^>;
>>"%F%" echo }
exit /b

:: ============ File 7: AndroidManifest.xml ============
:f7
set "F=%P%\app\src\main\AndroidManifest.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<manifest xmlns:android="http://schemas.android.com/apk/res/android"^>
>>"%F%" echo.
>>"%F%" echo     ^<uses-permission android:name="android.permission.INTERNET" /^>
>>"%F%" echo     ^<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /^>
>>"%F%" echo.
>>"%F%" echo     ^<application
>>"%F%" echo         android:label="FDweb"
>>"%F%" echo         android:icon="@drawable/ic_launcher"
>>"%F%" echo         android:roundIcon="@drawable/ic_launcher"
>>"%F%" echo         android:theme="@style/Theme.FDweb"
>>"%F%" echo         android:usesCleartextTraffic="true"
>>"%F%" echo         android:hardwareAccelerated="true"
>>"%F%" echo         android:supportsRtl="true"^>
>>"%F%" echo.
>>"%F%" echo         ^<activity
>>"%F%" echo             android:name=".MainActivity"
>>"%F%" echo             android:exported="true"
>>"%F%" echo             android:launchMode="singleTop"
>>"%F%" echo             android:configChanges="orientation^|screenSize^|keyboardHidden^|screenLayout"^>
>>"%F%" echo             ^<intent-filter^>
>>"%F%" echo                 ^<action android:name="android.intent.action.MAIN" /^>
>>"%F%" echo                 ^<category android:name="android.intent.category.LAUNCHER" /^>
>>"%F%" echo             ^</intent-filter^>
>>"%F%" echo         ^</activity^>
>>"%F%" echo     ^</application^>
>>"%F%" echo ^</manifest^>
exit /b

:: ============ File 8: AdBlocker.kt ============
:f8
set "F=%P%\app\src\main\java\ir\hhm\fdweb\AdBlocker.kt"
>"%F%" echo package ir.hhm.fdweb
>>"%F%" echo.
>>"%F%" echo import android.webkit.WebResourceResponse
>>"%F%" echo import java.io.ByteArrayInputStream
>>"%F%" echo.
>>"%F%" echo object AdBlocker {
>>"%F%" echo.
>>"%F%" echo     private val blockedDomains = setOf(
>>"%F%" echo         "doubleclick.net",
>>"%F%" echo         "googlesyndication.com",
>>"%F%" echo         "googleadservices.com",
>>"%F%" echo         "google-analytics.com",
>>"%F%" echo         "googletagmanager.com",
>>"%F%" echo         "googletagservices.com",
>>"%F%" echo         "adservice.google.com",
>>"%F%" echo         "pagead2.googlesyndication.com",
>>"%F%" echo         "adclick.g.doubleclick.net",
>>"%F%" echo         "partner.googleadservices.com",
>>"%F%" echo         "amazon-adsystem.com",
>>"%F%" echo         "adnxs.com",
>>"%F%" echo         "adsrvr.org",
>>"%F%" echo         "criteo.com",
>>"%F%" echo         "criteo.net",
>>"%F%" echo         "outbrain.com",
>>"%F%" echo         "taboola.com",
>>"%F%" echo         "scorecardresearch.com",
>>"%F%" echo         "quantserve.com",
>>"%F%" echo         "pubmatic.com",
>>"%F%" echo         "rubiconproject.com",
>>"%F%" echo         "openx.net",
>>"%F%" echo         "casalemedia.com",
>>"%F%" echo         "indexexchange.com",
>>"%F%" echo         "sharethrough.com",
>>"%F%" echo         "teads.tv",
>>"%F%" echo         "smartadserver.com",
>>"%F%" echo         "advertising.com",
>>"%F%" echo         "bidswitch.net",
>>"%F%" echo         "sitescout.com",
>>"%F%" echo         "turn.com",
>>"%F%" echo         "mathtag.com",
>>"%F%" echo         "tremorhub.com",
>>"%F%" echo         "spotxchange.com",
>>"%F%" echo         "yieldmo.com",
>>"%F%" echo         "gumgum.com",
>>"%F%" echo         "sovrn.com",
>>"%F%" echo         "lijit.com",
>>"%F%" echo         "hotjar.com",
>>"%F%" echo         "mixpanel.com",
>>"%F%" echo         "segment.com",
>>"%F%" echo         "segment.io",
>>"%F%" echo         "amplitude.com",
>>"%F%" echo         "newrelic.com",
>>"%F%" echo         "nr-data.net",
>>"%F%" echo         "sentry.io",
>>"%F%" echo         "bugsnag.com",
>>"%F%" echo         "raygun.io",
>>"%F%" echo         "mouseflow.com",
>>"%F%" echo         "crazyegg.com",
>>"%F%" echo         "fullstory.com",
>>"%F%" echo         "inspectlet.com",
>>"%F%" echo         "luckyorange.com",
>>"%F%" echo         "connect.facebook.net",
>>"%F%" echo         "analytics.twitter.com",
>>"%F%" echo         "ads.linkedin.com",
>>"%F%" echo         "platform.linkedin.com",
>>"%F%" echo         "bat.bing.com",
>>"%F%" echo         "ads.pinterest.com",
>>"%F%" echo         "ct.pinterest.com",
>>"%F%" echo         "yektanet.com",
>>"%F%" echo         "cdn.yektanet.com",
>>"%F%" echo         "an.yandex.ru",
>>"%F%" echo         "mc.yandex.ru",
>>"%F%" echo         "yadro.com",
>>"%F%" echo         "clickyab.com",
>>"%F%" echo         "tapsell.ir",
>>"%F%" echo         "sabavision.com",
>>"%F%" echo         "mediaad.org",
>>"%F%" echo         "adad.ir",
>>"%F%" echo         "goon.ir",
>>"%F%" echo         "mihanads.com",
>>"%F%" echo         "sanjagh.pro",
>>"%F%" echo         "sanjagh.com",
>>"%F%" echo         "adtrace.org",
>>"%F%" echo         "adcolony.com",
>>"%F%" echo         "applovin.com",
>>"%F%" echo         "unityads.unity3d.com",
>>"%F%" echo         "vungle.com",
>>"%F%" echo         "chartboost.com",
>>"%F%" echo         "inmobi.com",
>>"%F%" echo         "mopub.com",
>>"%F%" echo         "startapp.com",
>>"%F%" echo         "supersonicads.com",
>>"%F%" echo         "flurry.com",
>>"%F%" echo         "adjust.com",
>>"%F%" echo         "appsflyer.com",
>>"%F%" echo         "branch.io",
>>"%F%" echo         "kochava.com",
>>"%F%" echo         "onesignal.com"
>>"%F%" echo     )
>>"%F%" echo.
>>"%F%" echo     private val blockedPrefixes = setOf(
>>"%F%" echo         "ad.", "ads.", "advert.", "advertising.",
>>"%F%" echo         "banner.", "click.", "track.", "tracker.",
>>"%F%" echo         "analytics.", "stats.", "stat.", "pixel.", "beacon."
>>"%F%" echo     )
>>"%F%" echo.
>>"%F%" echo     private val emptyResponse = ByteArray(0)
>>"%F%" echo.
>>"%F%" echo     fun shouldBlock(url: String): Boolean {
>>"%F%" echo         if (url.isBlank()) return false
>>"%F%" echo         val lower = url.lowercase()
>>"%F%" echo.
>>"%F%" echo         for (domain in blockedDomains) {
>>"%F%" echo             if (lower.contains(domain)) return true
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         try {
>>"%F%" echo             val host = url.substringAfter("://").substringBefore("/").substringBefore(":")
>>"%F%" echo             for (prefix in blockedPrefixes) {
>>"%F%" echo                 if (host.startsWith(prefix)) return true
>>"%F%" echo             }
>>"%F%" echo         } catch (_: Exception) { }
>>"%F%" echo.
>>"%F%" echo         return false
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     fun getEmptyResponse(): WebResourceResponse {
>>"%F%" echo         return WebResourceResponse(
>>"%F%" echo             "text/plain",
>>"%F%" echo             "utf-8",
>>"%F%" echo             200,
>>"%F%" echo             "OK",
>>"%F%" echo             emptyMap(),
>>"%F%" echo             ByteArrayInputStream(emptyResponse)
>>"%F%" echo         )
>>"%F%" echo     }
>>"%F%" echo }
exit /b

:: ============ File 9: MainActivity.kt ============
:f9
set "F=%P%\app\src\main\java\ir\hhm\fdweb\MainActivity.kt"
>"%F%" echo package ir.hhm.fdweb
>>"%F%" echo.
>>"%F%" echo import android.annotation.SuppressLint
>>"%F%" echo import android.app.AlertDialog
>>"%F%" echo import android.content.Intent
>>"%F%" echo import android.graphics.Bitmap
>>"%F%" echo import android.net.Uri
>>"%F%" echo import android.os.Bundle
>>"%F%" echo import android.view.KeyEvent
>>"%F%" echo import android.view.View
>>"%F%" echo import android.view.inputmethod.EditorInfo
>>"%F%" echo import android.webkit.*
>>"%F%" echo import android.widget.*
>>"%F%" echo import androidx.appcompat.app.AppCompatActivity
>>"%F%" echo.
>>"%F%" echo class MainActivity : AppCompatActivity() {
>>"%F%" echo.
>>"%F%" echo     private lateinit var webView: WebView
>>"%F%" echo     private lateinit var urlBar: EditText
>>"%F%" echo     private lateinit var btnBack: ImageButton
>>"%F%" echo     private lateinit var btnForward: ImageButton
>>"%F%" echo     private lateinit var btnHome: ImageButton
>>"%F%" echo     private lateinit var btnMenu: ImageButton
>>"%F%" echo     private lateinit var progressBar: ProgressBar
>>"%F%" echo     private lateinit var btnShield: ImageButton
>>"%F%" echo.
>>"%F%" echo     private val homeUrl = "https://www.bing.com"
>>"%F%" echo     private var adBlockEnabled = true
>>"%F%" echo     private var blockedCount = 0
>>"%F%" echo.
>>"%F%" echo     @SuppressLint("SetJavaScriptEnabled")
>>"%F%" echo     override fun onCreate(savedInstanceState: Bundle?) {
>>"%F%" echo         super.onCreate(savedInstanceState)
>>"%F%" echo         setContentView(R.layout.activity_main)
>>"%F%" echo.
>>"%F%" echo         webView = findViewById(R.id.webView)
>>"%F%" echo         urlBar = findViewById(R.id.urlBar)
>>"%F%" echo         btnBack = findViewById(R.id.btnBack)
>>"%F%" echo         btnForward = findViewById(R.id.btnForward)
>>"%F%" echo         btnHome = findViewById(R.id.btnHome)
>>"%F%" echo         btnMenu = findViewById(R.id.btnMenu)
>>"%F%" echo         progressBar = findViewById(R.id.progressBar)
>>"%F%" echo         btnShield = findViewById(R.id.btnShield)
>>"%F%" echo.
>>"%F%" echo         setupWebView()
>>"%F%" echo         setupToolbar()
>>"%F%" echo.
>>"%F%" echo         if (savedInstanceState != null) {
>>"%F%" echo             webView.restoreState(savedInstanceState)
>>"%F%" echo         } else {
>>"%F%" echo             webView.loadUrl(homeUrl)
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         updateShieldIcon()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     @SuppressLint("SetJavaScriptEnabled")
>>"%F%" echo     private fun setupWebView() {
>>"%F%" echo         webView.settings.apply {
>>"%F%" echo             javaScriptEnabled = true
>>"%F%" echo             domStorageEnabled = true
>>"%F%" echo             databaseEnabled = true
>>"%F%" echo             setSupportZoom(true)
>>"%F%" echo             builtInZoomControls = true
>>"%F%" echo             displayZoomControls = false
>>"%F%" echo             loadWithOverviewMode = true
>>"%F%" echo             useWideViewPort = true
>>"%F%" echo             mediaPlaybackRequiresUserGesture = false
>>"%F%" echo             allowFileAccess = true
>>"%F%" echo             cacheMode = WebSettings.LOAD_DEFAULT
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         webView.webViewClient = object : WebViewClient() {
>>"%F%" echo             override fun shouldInterceptRequest(
>>"%F%" echo                 view: WebView?,
>>"%F%" echo                 request: WebResourceRequest?
>>"%F%" echo             ): WebResourceResponse? {
>>"%F%" echo                 if (!adBlockEnabled) return null
>>"%F%" echo                 val url = request?.url?.toString() ?: return null
>>"%F%" echo                 if (AdBlocker.shouldBlock(url)) {
>>"%F%" echo                     blockedCount++
>>"%F%" echo                     return AdBlocker.getEmptyResponse()
>>"%F%" echo                 }
>>"%F%" echo                 return null
>>"%F%" echo             }
>>"%F%" echo.
>>"%F%" echo             override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
>>"%F%" echo                 urlBar.setText(url ?: "")
>>"%F%" echo                 progressBar.visibility = View.VISIBLE
>>"%F%" echo             }
>>"%F%" echo.
>>"%F%" echo             override fun onPageFinished(view: WebView?, url: String?) {
>>"%F%" echo                 progressBar.visibility = View.GONE
>>"%F%" echo                 updateNavButtons()
>>"%F%" echo             }
>>"%F%" echo.
>>"%F%" echo             override fun shouldOverrideUrlLoading(
>>"%F%" echo                 view: WebView?,
>>"%F%" echo                 request: WebResourceRequest?
>>"%F%" echo             ): Boolean {
>>"%F%" echo                 val url = request?.url?.toString() ?: return false
>>"%F%" echo                 if (url.startsWith("tel:") ^|^| url.startsWith("mailto:") ^|^|
>>"%F%" echo                     url.startsWith("sms:") ^|^| url.startsWith("whatsapp:") ^|^|
>>"%F%" echo                     url.startsWith("intent:") ^|^| url.startsWith("market:")
>>"%F%" echo                 ) {
>>"%F%" echo                     try {
>>"%F%" echo                         val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
>>"%F%" echo                         startActivity(intent)
>>"%F%" echo                         return true
>>"%F%" echo                     } catch (_: Exception) { }
>>"%F%" echo                 }
>>"%F%" echo                 return false
>>"%F%" echo             }
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         webView.webChromeClient = object : WebChromeClient() {
>>"%F%" echo             override fun onProgressChanged(view: WebView?, newProgress: Int) {
>>"%F%" echo                 progressBar.progress = newProgress
>>"%F%" echo                 if (newProgress ^>= 100) progressBar.visibility = View.GONE
>>"%F%" echo             }
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         webView.setDownloadListener { url, _, _, _, _ -^>
>>"%F%" echo             try {
>>"%F%" echo                 val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
>>"%F%" echo                 startActivity(intent)
>>"%F%" echo             } catch (_: Exception) { }
>>"%F%" echo         }
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun setupToolbar() {
>>"%F%" echo         urlBar.setOnEditorActionListener { _, actionId, event -^>
>>"%F%" echo             if (actionId == EditorInfo.IME_ACTION_GO ^|^|
>>"%F%" echo                 (event != null ^&^& event.keyCode == KeyEvent.KEYCODE_ENTER)
>>"%F%" echo             ) {
>>"%F%" echo                 navigateTo(urlBar.text.toString())
>>"%F%" echo                 true
>>"%F%" echo             } else false
>>"%F%" echo         }
>>"%F%" echo.
>>"%F%" echo         btnBack.setOnClickListener { if (webView.canGoBack()) webView.goBack() }
>>"%F%" echo         btnForward.setOnClickListener { if (webView.canGoForward()) webView.goForward() }
>>"%F%" echo         btnHome.setOnClickListener { webView.loadUrl(homeUrl) }
>>"%F%" echo         btnMenu.setOnClickListener { showMenu() }
>>"%F%" echo         btnShield.setOnClickListener { toggleAdBlock() }
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun navigateTo(input: String) {
>>"%F%" echo         if (input.isBlank()) return
>>"%F%" echo         val url = when {
>>"%F%" echo             input.startsWith("http://") ^|^| input.startsWith("https://") -^> input
>>"%F%" echo             !input.contains(" ") ^&^& input.contains(".") -^> "https://$input"
>>"%F%" echo             else -^> "https://www.bing.com/search?q=" + Uri.encode(input)
>>"%F%" echo         }
>>"%F%" echo         webView.loadUrl(url)
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun updateNavButtons() {
>>"%F%" echo         btnBack.isEnabled = webView.canGoBack()
>>"%F%" echo         btnForward.isEnabled = webView.canGoForward()
>>"%F%" echo         btnBack.alpha = if (btnBack.isEnabled) 1f else 0.3f
>>"%F%" echo         btnForward.alpha = if (btnForward.isEnabled) 1f else 0.3f
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun toggleAdBlock() {
>>"%F%" echo         adBlockEnabled = !adBlockEnabled
>>"%F%" echo         updateShieldIcon()
>>"%F%" echo         val msg = if (adBlockEnabled) "AdBlock: ON" else "AdBlock: OFF"
>>"%F%" echo         Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
>>"%F%" echo         webView.reload()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun updateShieldIcon() {
>>"%F%" echo         btnShield.alpha = if (adBlockEnabled) 1f else 0.3f
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun showMenu() {
>>"%F%" echo         val items = arrayOf(
>>"%F%" echo             "Home",
>>"%F%" echo             "Refresh",
>>"%F%" echo             "AdBlock: " + (if (adBlockEnabled) "ON" else "OFF"),
>>"%F%" echo             "Blocked: $blockedCount",
>>"%F%" echo             "Copy URL",
>>"%F%" echo             "About"
>>"%F%" echo         )
>>"%F%" echo         AlertDialog.Builder(this)
>>"%F%" echo             .setTitle("FDweb Menu")
>>"%F%" echo             .setItems(items) { _, which -^>
>>"%F%" echo                 when (which) {
>>"%F%" echo                     0 -^> webView.loadUrl(homeUrl)
>>"%F%" echo                     1 -^> webView.reload()
>>"%F%" echo                     2 -^> toggleAdBlock()
>>"%F%" echo                     3 -^> showBlockedStats()
>>"%F%" echo                     4 -^> copyCurrentUrl()
>>"%F%" echo                     5 -^> showAbout()
>>"%F%" echo                 }
>>"%F%" echo             }
>>"%F%" echo             .setNegativeButton("Close", null)
>>"%F%" echo             .show()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun showBlockedStats() {
>>"%F%" echo         AlertDialog.Builder(this)
>>"%F%" echo             .setTitle("AdBlock Stats")
>>"%F%" echo             .setMessage("Blocked: $blockedCount\nStatus: " + (if (adBlockEnabled) "Active" else "Disabled"))
>>"%F%" echo             .setPositiveButton("Reset") { _, _ -^>
>>"%F%" echo                 blockedCount = 0
>>"%F%" echo                 Toast.makeText(this, "Reset", Toast.LENGTH_SHORT).show()
>>"%F%" echo             }
>>"%F%" echo             .setNegativeButton("OK", null)
>>"%F%" echo             .show()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun copyCurrentUrl() {
>>"%F%" echo         val url = webView.url ?: return
>>"%F%" echo         val clipboard = getSystemService(CLIPBOARD_SERVICE) as android.content.ClipboardManager
>>"%F%" echo         clipboard.setPrimaryClip(android.content.ClipData.newPlainText("URL", url))
>>"%F%" echo         Toast.makeText(this, "URL copied", Toast.LENGTH_SHORT).show()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     private fun showAbout() {
>>"%F%" echo         AlertDialog.Builder(this)
>>"%F%" echo             .setTitle("About FDweb")
>>"%F%" echo             .setMessage("FDweb v1.0\n\nLightweight fast browser for Android\n\nMade by HHM")
>>"%F%" echo             .setPositiveButton("OK", null)
>>"%F%" echo             .show()
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
>>"%F%" echo         if (keyCode == KeyEvent.KEYCODE_BACK) {
>>"%F%" echo             if (webView.canGoBack()) {
>>"%F%" echo                 webView.goBack()
>>"%F%" echo                 return true
>>"%F%" echo             }
>>"%F%" echo         }
>>"%F%" echo         return super.onKeyDown(keyCode, event)
>>"%F%" echo     }
>>"%F%" echo.
>>"%F%" echo     override fun onSaveInstanceState(outState: Bundle) {
>>"%F%" echo         super.onSaveInstanceState(outState)
>>"%F%" echo         webView.saveState(outState)
>>"%F%" echo     }
>>"%F%" echo }
exit /b

:: ============ File 10: activity_main.xml ============
:f10
set "F=%P%\app\src\main\res\layout\activity_main.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
>>"%F%" echo     android:layout_width="match_parent"
>>"%F%" echo     android:layout_height="match_parent"
>>"%F%" echo     android:orientation="vertical"
>>"%F%" echo     android:background="@color/bg_dark"^>
>>"%F%" echo.
>>"%F%" echo     ^<LinearLayout
>>"%F%" echo         android:layout_width="match_parent"
>>"%F%" echo         android:layout_height="wrap_content"
>>"%F%" echo         android:orientation="horizontal"
>>"%F%" echo         android:padding="8dp"
>>"%F%" echo         android:background="@color/bg_tab_bar"
>>"%F%" echo         android:gravity="center_vertical"^>
>>"%F%" echo.
>>"%F%" echo         ^<ImageButton
>>"%F%" echo             android:id="@+id/btnShield"
>>"%F%" echo             android:layout_width="40dp"
>>"%F%" echo             android:layout_height="40dp"
>>"%F%" echo             android:layout_marginEnd="6dp"
>>"%F%" echo             android:background="?android:attr/selectableItemBackgroundBorderless"
>>"%F%" echo             android:src="@android:drawable/ic_lock_lock"
>>"%F%" echo             android:tint="@color/accent" /^>
>>"%F%" echo.
>>"%F%" echo         ^<EditText
>>"%F%" echo             android:id="@+id/urlBar"
>>"%F%" echo             android:layout_width="0dp"
>>"%F%" echo             android:layout_height="40dp"
>>"%F%" echo             android:layout_weight="1"
>>"%F%" echo             android:background="@drawable/url_bar_bg"
>>"%F%" echo             android:hint="@string/url_hint"
>>"%F%" echo             android:textColor="@color/fg"
>>"%F%" echo             android:textColorHint="@color/fg_muted"
>>"%F%" echo             android:paddingHorizontal="14dp"
>>"%F%" echo             android:imeOptions="actionGo"
>>"%F%" echo             android:inputType="textUri"
>>"%F%" echo             android:singleLine="true"
>>"%F%" echo             android:textSize="14sp" /^>
>>"%F%" echo     ^</LinearLayout^>
>>"%F%" echo.
>>"%F%" echo     ^<ProgressBar
>>"%F%" echo         android:id="@+id/progressBar"
>>"%F%" echo         style="?android:attr/progressBarStyleHorizontal"
>>"%F%" echo         android:layout_width="match_parent"
>>"%F%" echo         android:layout_height="2dp"
>>"%F%" echo         android:visibility="gone"
>>"%F%" echo         android:progressTint="@color/accent" /^>
>>"%F%" echo.
>>"%F%" echo     ^<WebView
>>"%F%" echo         android:id="@+id/webView"
>>"%F%" echo         android:layout_width="match_parent"
>>"%F%" echo         android:layout_height="0dp"
>>"%F%" echo         android:layout_weight="1"
>>"%F%" echo         android:background="@color/bg_dark" /^>
>>"%F%" echo.
>>"%F%" echo     ^<LinearLayout
>>"%F%" echo         android:layout_width="match_parent"
>>"%F%" echo         android:layout_height="56dp"
>>"%F%" echo         android:orientation="horizontal"
>>"%F%" echo         android:background="@color/bg_tab_bar"^>
>>"%F%" echo.
>>"%F%" echo         ^<ImageButton
>>"%F%" echo             android:id="@+id/btnBack"
>>"%F%" echo             android:layout_width="0dp"
>>"%F%" echo             android:layout_height="match_parent"
>>"%F%" echo             android:layout_weight="1"
>>"%F%" echo             android:background="?android:attr/selectableItemBackground"
>>"%F%" echo             android:src="@android:drawable/ic_media_previous"
>>"%F%" echo             android:tint="@color/fg" /^>
>>"%F%" echo.
>>"%F%" echo         ^<ImageButton
>>"%F%" echo             android:id="@+id/btnForward"
>>"%F%" echo             android:layout_width="0dp"
>>"%F%" echo             android:layout_height="match_parent"
>>"%F%" echo             android:layout_weight="1"
>>"%F%" echo             android:background="?android:attr/selectableItemBackground"
>>"%F%" echo             android:src="@android:drawable/ic_media_next"
>>"%F%" echo             android:tint="@color/fg" /^>
>>"%F%" echo.
>>"%F%" echo         ^<ImageButton
>>"%F%" echo             android:id="@+id/btnHome"
>>"%F%" echo             android:layout_width="0dp"
>>"%F%" echo             android:layout_height="match_parent"
>>"%F%" echo             android:layout_weight="1"
>>"%F%" echo             android:background="?android:attr/selectableItemBackground"
>>"%F%" echo             android:src="@android:drawable/ic_menu_view"
>>"%F%" echo             android:tint="@color/fg" /^>
>>"%F%" echo.
>>"%F%" echo         ^<ImageButton
>>"%F%" echo             android:id="@+id/btnMenu"
>>"%F%" echo             android:layout_width="0dp"
>>"%F%" echo             android:layout_height="match_parent"
>>"%F%" echo             android:layout_weight="1"
>>"%F%" echo             android:background="?android:attr/selectableItemBackground"
>>"%F%" echo             android:src="@android:drawable/ic_menu_more"
>>"%F%" echo             android:tint="@color/fg" /^>
>>"%F%" echo     ^</LinearLayout^>
>>"%F%" echo ^</LinearLayout^>
exit /b

:: ============ File 11: url_bar_bg.xml ============
:f11
set "F=%P%\app\src\main\res\drawable\url_bar_bg.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<shape xmlns:android="http://schemas.android.com/apk/res/android"
>>"%F%" echo     android:shape="rectangle"^>
>>"%F%" echo     ^<solid android:color="@color/bg_url" /^>
>>"%F%" echo     ^<corners android:radius="20dp" /^>
>>"%F%" echo ^</shape^>
exit /b

:: ============ File 12: ic_launcher.xml ============
:f12
set "F=%P%\app\src\main\res\drawable\ic_launcher.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<vector xmlns:android="http://schemas.android.com/apk/res/android"
>>"%F%" echo     android:width="108dp"
>>"%F%" echo     android:height="108dp"
>>"%F%" echo     android:viewportWidth="108"
>>"%F%" echo     android:viewportHeight="108"^>
>>"%F%" echo     ^<path
>>"%F%" echo         android:fillColor="#1e1e2e"
>>"%F%" echo         android:pathData="M0,0 H108 V108 H0 Z" /^>
>>"%F%" echo     ^<path
>>"%F%" echo         android:fillColor="#89b4fa"
>>"%F%" echo         android:pathData="M24,32 L54,24 L84,32 L84,76 L54,84 L24,76 Z" /^>
>>"%F%" echo     ^<path
>>"%F%" echo         android:fillColor="#cba6f7"
>>"%F%" echo         android:pathData="M30,38 L54,32 L78,38 L78,72 L54,78 L30,72 Z" /^>
>>"%F%" echo     ^<path
>>"%F%" echo         android:fillColor="#1e1e2e"
>>"%F%" echo         android:pathData="M38,46 L70,46 L70,54 L38,54 Z M38,60 L62,60 L62,66 L38,66 Z" /^>
>>"%F%" echo ^</vector^>
exit /b

:: ============ File 13: colors.xml ============
:f13
set "F=%P%\app\src\main\res\values\colors.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<resources^>
>>"%F%" echo     ^<color name="bg_dark"^>#1e1e2e^</color^>
>>"%F%" echo     ^<color name="bg_tab_bar"^>#181825^</color^>
>>"%F%" echo     ^<color name="bg_active"^>#2a2a3c^</color^>
>>"%F%" echo     ^<color name="bg_url"^>#313244^</color^>
>>"%F%" echo     ^<color name="bg_hover"^>#45475a^</color^>
>>"%F%" echo     ^<color name="fg"^>#cdd6f4^</color^>
>>"%F%" echo     ^<color name="fg_muted"^>#a6adc8^</color^>
>>"%F%" echo     ^<color name="accent"^>#89b4fa^</color^>
>>"%F%" echo     ^<color name="accent_pink"^>#cba6f7^</color^>
>>"%F%" echo     ^<color name="err"^>#f38ba8^</color^>
>>"%F%" echo ^</resources^>
exit /b

:: ============ File 14: strings.xml ============
:f14
set "F=%P%\app\src\main\res\values\strings.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<resources^>
>>"%F%" echo     ^<string name="app_name"^>FDweb^</string^>
>>"%F%" echo     ^<string name="url_hint"^>Search or URL...^</string^>
>>"%F%" echo     ^<string name="back"^>Back^</string^>
>>"%F%" echo     ^<string name="forward"^>Forward^</string^>
>>"%F%" echo     ^<string name="home"^>Home^</string^>
>>"%F%" echo     ^<string name="menu"^>Menu^</string^>
>>"%F%" echo     ^<string name="adblock"^>AdBlock^</string^>
>>"%F%" echo ^</resources^>
exit /b

:: ============ File 15: themes.xml ============
:f15
set "F=%P%\app\src\main\res\values\themes.xml"
>"%F%" echo ^<?xml version="1.0" encoding="utf-8"?^>
>>"%F%" echo ^<resources^>
>>"%F%" echo     ^<style name="Theme.FDweb" parent="Theme.AppCompat.NoActionBar"^>
>>"%F%" echo         ^<item name="android:windowBackground"^>@color/bg_dark^</item^>
>>"%F%" echo         ^<item name="android:colorBackground"^>@color/bg_dark^</item^>
>>"%F%" echo         ^<item name="android:statusBarColor"^>@color/bg_tab_bar^</item^>
>>"%F%" echo         ^<item name="android:navigationBarColor"^>@color/bg_tab_bar^</item^>
>>"%F%" echo         ^<item name="android:windowLightStatusBar"^>false^</item^>
>>"%F%" echo         ^<item name="colorAccent"^>@color/accent^</item^>
>>"%F%" echo         ^<item name="colorPrimary"^>@color/accent^</item^>
>>"%F%" echo         ^<item name="colorPrimaryDark"^>@color/bg_tab_bar^</item^>
>>"%F%" echo         ^<item name="colorControlActivated"^>@color/accent^</item^>
>>"%F%" echo     ^</style^>
>>"%F%" echo ^</resources^>
exit /b