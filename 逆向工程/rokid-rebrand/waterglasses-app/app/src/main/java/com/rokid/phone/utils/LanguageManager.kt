package com.rokid.phone.utils

import android.content.Context
import android.content.res.Configuration
import android.content.res.Resources
import android.os.Build
import android.os.LocaleList
import android.util.Log
import java.util.Locale

/**
 * 管理应用内语言选择与持久化。
 * Manage and persist the application's language selection.
 */
object LanguageManager {
    private const val TAG = "LanguageManager"
    private const val PREF_NAME = "language_pref"
    private const val KEY_LANGUAGE = "current_language"

    // 支持的语言类型
    // Supported language types.
    enum class Language(val code: String, val displayName: String) {
        CHINESE("zh", "中文"),
        ENGLISH("en", "English"),
        FOLLOWSYSTEM("system", "FollowSystem")
    }

    // 默认语言为中文
    // Chinese is the default language.
    private var currentLanguage: Language = Language.FOLLOWSYSTEM

    /**
     * 初始化语言管理器
     * Initialize the language manager.
     * @param context 应用上下文
     * Application context.
     */
    fun init(context: Context) {
        // 从本地存储中获取保存的语言设置
        // Read the saved language setting from local storage.
        val savedLanguageCode = SPUtil.getInstance(context).getString( KEY_LANGUAGE, Language.FOLLOWSYSTEM.code)
        currentLanguage = Language.values().find { it.code == savedLanguageCode } ?: Language.FOLLOWSYSTEM
        Log.d(TAG, "初始化语言: $currentLanguage")
    }

    /**
     * 获取当前选择的语言
     * Get the currently selected language.
     * @return 当前语言
     * Current language.
     */
    fun getCurrentLanguage(): Language {
        return currentLanguage
    }

    /**
     * 设置应用语言
     * Set the application's language.
     * @param context 上下文
     * Context.
     * @param language 要设置的语言
     * Language to set.
     */
    fun setLanguage(context: Context, language: Language) {
        currentLanguage = language
        // 保存语言设置到本地存储
        // Save the language setting to local storage.
        SPUtil.getInstance(context).putString(KEY_LANGUAGE, language.code)
        Log.d(TAG, "设置语言: $language, 需要重启Activity生效")
        // 语言的实际应用将在Activity重启后的attachBaseContext中完成
        // Apply the language in attachBaseContext after the Activity restarts.
    }

    fun wrapContext(context: Context): Context {
        val lang = Language.values().find { it.code == currentLanguage.code } ?: Language.FOLLOWSYSTEM

        val locale = when (lang) {
            Language.CHINESE -> Locale.SIMPLIFIED_CHINESE
            Language.ENGLISH -> Locale.ENGLISH
            Language.FOLLOWSYSTEM -> {if (LanguageUtils.isCurrentLanguageChinese()) Locale.SIMPLIFIED_CHINESE else Locale.ENGLISH}
        }

        val resources = context.resources
        val configuration = resources.configuration
        configuration.setLocale(locale)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            val localeList = LocaleList(locale)
            LocaleList.setDefault(localeList)
            configuration.setLocales(localeList)
        }
        @Suppress("DEPRECATION")
        resources.updateConfiguration(configuration, resources.displayMetrics)
        return context
    }

    /**
     * 获取所有支持的语言
     * Get all supported languages.
     * @return 语言列表
     * List of languages.
     */
    fun getSupportedLanguages(): List<Language> {
        return Language.values().toList()
    }

    fun isCurrentLanguageChinese(): Boolean {
        return currentLanguage == Language.CHINESE ||  (currentLanguage == Language.FOLLOWSYSTEM && LanguageUtils.isCurrentLanguageChinese())
    }
}
