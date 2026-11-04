package com.rokid.phone

import android.annotation.SuppressLint
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.rokid.phone.base.BaseActivity

/**
 * 水利安全AI眼镜 — 五页底导主控
 * 扫描 | 主页(V3官网) | 助手 | 相册 | 我的
 */
class WaterSafetyMainActivity : BaseActivity() {

    private lateinit var bottomNav: BottomNavigationView
    private lateinit var container: FrameLayout
    private var webView: WebView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_water_safety_main)
        title = "水利安全AI眼镜"

        bottomNav = findViewById(R.id.bottom_nav)
        container = findViewById(R.id.fragment_container)

        bottomNav.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.nav_scan -> { showScan(); true }
                R.id.nav_home -> { showHome(); true }
                R.id.nav_assistant -> { showAssistant(); true }
                R.id.nav_gallery -> { showGallery(); true }
                R.id.nav_profile -> { showProfile(); true }
                else -> false
            }
        }
        // 默认进主页
        bottomNav.selectedItemId = R.id.nav_home
    }

    private fun showHome() {
        container.removeAllViews()
        if (webView == null) {
            webView = WebView(this).apply {
                settings.javaScriptEnabled = true
                settings.domStorageEnabled = true
                settings.useWideViewPort = true
                settings.loadWithOverviewMode = true
                webViewClient = WebViewClient()
                webChromeClient = WebChromeClient()
                loadUrl("http://47.120.43.20:8090/")
            }
        }
        container.addView(webView, FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT
        ))
    }

    private fun showScan() {
        container.removeAllViews()
        // 蓝牙设备扫描（SDK 核心功能）
        startActivity(android.content.Intent(this, com.rokid.phone.ui.classicbt.ui.ClassicBtActivity::class.java))
    }

    private fun showAssistant() {
        container.removeAllViews()
        val tv = android.widget.TextView(this).apply {
            text = "水利安全AI助手\n\n连接眼镜后即可使用\n语音唤醒词：小禹"
            gravity = android.view.Gravity.CENTER
            textSize = 18f
            setTextColor(0xFF08233e.toInt())
        }
        container.addView(tv, FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT
        ))
    }

    private fun showGallery() {
        container.removeAllViews()
        startActivity(android.content.Intent(this, GalleryActivity::class.java))
    }

    private fun showProfile() {
        container.removeAllViews()
        startActivity(android.content.Intent(this, SettingActivity::class.java))
    }

    override fun onDestroy() {
        webView?.destroy()
        super.onDestroy()
    }
}
