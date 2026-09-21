package ir.hhm.fdweb

import android.annotation.SuppressLint
import android.app.AlertDialog
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Bundle
import android.view.KeyEvent
import android.view.View
import android.view.inputmethod.EditorInfo
import android.webkit.*
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private lateinit var urlBar: EditText
    private lateinit var btnBack: ImageButton
    private lateinit var btnForward: ImageButton
    private lateinit var btnHome: ImageButton
    private lateinit var btnMenu: ImageButton
    private lateinit var progressBar: ProgressBar
    private lateinit var btnShield: ImageButton

    private val homeUrl = "https://www.bing.com"
    private var adBlockEnabled = true
    private var blockedCount = 0

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        webView = findViewById(R.id.webView)
        urlBar = findViewById(R.id.urlBar)
        btnBack = findViewById(R.id.btnBack)
        btnForward = findViewById(R.id.btnForward)
        btnHome = findViewById(R.id.btnHome)
        btnMenu = findViewById(R.id.btnMenu)
        progressBar = findViewById(R.id.progressBar)
        btnShield = findViewById(R.id.btnShield)

        setupWebView()
        setupToolbar()

        if (savedInstanceState != null) {
            webView.restoreState(savedInstanceState)
        } else {
            webView.loadUrl(homeUrl)
        }

        updateShieldIcon()
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun setupWebView() {
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            databaseEnabled = true
            setSupportZoom(true)
            builtInZoomControls = true
            displayZoomControls = false
            loadWithOverviewMode = true
            useWideViewPort = true
            mediaPlaybackRequiresUserGesture = false
            allowFileAccess = true
            cacheMode = WebSettings.LOAD_DEFAULT
        }

        webView.webViewClient = object : WebViewClient() {
            override fun shouldInterceptRequest(
                view: WebView?,
                request: WebResourceRequest?
            ): WebResourceResponse? {
                if (!adBlockEnabled) return null
                val url = request?.url?.toString() ?: return null
                if (AdBlocker.shouldBlock(url)) {
                    blockedCount++
                    return AdBlocker.getEmptyResponse()
                }
                return null
            }

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                urlBar.setText(url ?: "")
                progressBar.visibility = View.VISIBLE
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                progressBar.visibility = View.GONE
                updateNavButtons()
            }

            override fun shouldOverrideUrlLoading(
                view: WebView?,
                request: WebResourceRequest?
            ): Boolean {
                val url = request?.url?.toString() ?: return false
                if (url.startsWith("tel:") || url.startsWith("mailto:") ||
                    url.startsWith("sms:") || url.startsWith("whatsapp:") ||
                    url.startsWith("intent:") || url.startsWith("market:")
                ) {
                    try {
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                        startActivity(intent)
                        return true
                    } catch (_: Exception) { }
                }
                return false
            }
        }

        webView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                progressBar.progress = newProgress
                if (newProgress >= 100) progressBar.visibility = View.GONE
            }
        }

        webView.setDownloadListener { url, _, _, _, _ ->
            try {
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                startActivity(intent)
            } catch (_: Exception) { }
        }
    }

    private fun setupToolbar() {
        urlBar.setOnEditorActionListener { _, actionId, event ->
            if (actionId == EditorInfo.IME_ACTION_GO ||
                (event != null && event.keyCode == KeyEvent.KEYCODE_ENTER)
            ) {
                navigateTo(urlBar.text.toString())
                true
            } else false
        }

        btnBack.setOnClickListener { if (webView.canGoBack()) webView.goBack() }
        btnForward.setOnClickListener { if (webView.canGoForward()) webView.goForward() }
        btnHome.setOnClickListener { webView.loadUrl(homeUrl) }
        btnMenu.setOnClickListener { showMenu() }
        btnShield.setOnClickListener { toggleAdBlock() }
    }

    private fun navigateTo(input: String) {
        if (input.isBlank()) return
        val url = when {
            input.startsWith("http://") || input.startsWith("https://") -> input
            !input.contains(" ") && input.contains(".") -> "https://$input"
            else -> "https://www.bing.com/search?q=" + Uri.encode(input)
        }
        webView.loadUrl(url)
    }

    private fun updateNavButtons() {
        btnBack.isEnabled = webView.canGoBack()
        btnForward.isEnabled = webView.canGoForward()
        btnBack.alpha = if (btnBack.isEnabled) 1f else 0.3f
        btnForward.alpha = if (btnForward.isEnabled) 1f else 0.3f
    }

    private fun toggleAdBlock() {
        adBlockEnabled = !adBlockEnabled
        updateShieldIcon()
        val msg = if (adBlockEnabled) "AdBlock: ON" else "AdBlock: OFF"
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
        webView.reload()
    }

    private fun updateShieldIcon() {
        btnShield.alpha = if (adBlockEnabled) 1f else 0.3f
    }

    private fun showMenu() {
        val items = arrayOf(
            "Home",
            "Refresh",
            "AdBlock: " + (if (adBlockEnabled) "ON" else "OFF"),
            "Blocked: $blockedCount",
            "Copy URL",
            "About"
        )
        AlertDialog.Builder(this)
            .setTitle("FDweb Menu")
            .setItems(items) { _, which ->
                when (which) {
                    0 -> webView.loadUrl(homeUrl)
                    1 -> webView.reload()
                    2 -> toggleAdBlock()
                    3 -> showBlockedStats()
                    4 -> copyCurrentUrl()
                    5 -> showAbout()
                }
            }
            .setNegativeButton("Close", null)
            .show()
    }

    private fun showBlockedStats() {
        AlertDialog.Builder(this)
            .setTitle("AdBlock Stats")
            .setMessage("Blocked: $blockedCount\nStatus: " + (if (adBlockEnabled) "Active" else "Disabled"))
            .setPositiveButton("Reset") { _, _ ->
                blockedCount = 0
                Toast.makeText(this, "Reset", Toast.LENGTH_SHORT).show()
            }
            .setNegativeButton("OK", null)
            .show()
    }

    private fun copyCurrentUrl() {
        val url = webView.url ?: return
        val clipboard = getSystemService(CLIPBOARD_SERVICE) as android.content.ClipboardManager
        clipboard.setPrimaryClip(android.content.ClipData.newPlainText("URL", url))
        Toast.makeText(this, "URL copied", Toast.LENGTH_SHORT).show()
    }

    private fun showAbout() {
        AlertDialog.Builder(this)
            .setTitle("About FDweb")
            .setMessage("FDweb v1.0\n\nLightweight fast browser for Android\n\nMade by HHM")
            .setPositiveButton("OK", null)
            .show()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if (webView.canGoBack()) {
                webView.goBack()
                return true
            }
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        webView.saveState(outState)
    }
}
