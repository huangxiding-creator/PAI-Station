package com.rokid.phone

import android.content.res.Configuration
import android.graphics.Bitmap
import android.graphics.Canvas
import android.os.LocaleList
import android.view.ContextThemeWrapper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.*
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File
import java.util.Locale
import kotlin.math.roundToInt

/** Measures production layouts without starting an Activity or connecting to the glasses SDK. */
@RunWith(AndroidJUnit4::class)
class PhoneTextPositionInstrumentedTest {
    private val instrumentation = InstrumentationRegistry.getInstrumentation()

    @Test
    fun homeDescriptionsKeepTheirOriginalLeftEdge() {
        verifyVariants(listOf(R.layout.layout_main_phone, R.layout.activity_main_phone)) { root, tag ->
            val entries = listOf(
                Triple(R.id.tv_desc_translate, R.id.tv_title_translate, R.id.iv_translate),
                Triple(R.id.tv_desc_notification, R.id.tv_title_notification, R.id.iv_notification),
                Triple(R.id.tv_desc_tutorial, R.id.tv_title_tutorial, R.id.iv_tutorial),
                Triple(R.id.tv_desc_guide, R.id.tv_title_guide, R.id.iv_guide),
                Triple(R.id.tv_desc_album, R.id.tv_title_album, R.id.iv_album),
                Triple(R.id.tv_desc_ai_assistant, R.id.tv_title_ai_assistant, R.id.iv_ai_assistant),
                Triple(R.id.tv_desc_app_install, R.id.tv_title_app_install, R.id.iv_app_install)
            )
            var checked = 0
            entries.forEach { (descriptionId, titleId, iconId) ->
                val description = root.findViewById<TextView>(descriptionId)
                if (description != null && isVisible(description, root)) {
                    checked++
                    assertHorizontalSpace(description, 11, 12, tag)
                    assertTextFits(description, tag)
                    assertTextStartsAtLeft(description, tag)
                    val title = root.findViewById<TextView>(titleId)
                    val icon = root.findViewById<View>(iconId)
                    assertEquals("$tag: title left margin", dp(title, 11), title.left)
                    assertTrue("$tag: title overlaps its icon", title.right <= icon.left - dp(title, 8))
                    assertTrue("$tag: description overlaps title or icon", description.top >= maxOf(title.bottom, icon.bottom))
                    assertTrue("$tag: description extends below its card", description.bottom <= (description.parent as View).height)
                    assertTextFits(title, tag)
                }
            }
            assertTrue("$tag: no visible descriptions were checked", checked >= 3)
        }
    }

    @Test
    fun settingsRowsKeepTheirOriginalLeftEdge() {
        verifyVariants(listOf(R.layout.activity_setting)) { root, tag ->
            listOf(R.id.tv_device_linker, R.id.tv_linker_tp, R.id.tv_ota).forEach { id ->
                val text = root.findViewById<TextView>(id)
                assertHorizontalSpace(text, 16, 52, tag)
                assertTextStartsAtLeft(text, tag)
                assertTextFits(text, tag)
                val parent = text.parent as ViewGroup
                for (index in 0 until parent.childCount) {
                    val sibling = parent.getChildAt(index)
                    if (sibling !is TextView && sibling.visibility == View.VISIBLE) {
                        assertTrue("$tag: settings text overlaps arrow", text.right <= sibling.left)
                    }
                }
            }
            listOf(R.id.tv_device_name, R.id.tv_device_sn, R.id.tv_device_system).forEach { id ->
                val text = root.findViewById<TextView>(id)
                assertHorizontalSpace(text, 16, 16, tag)
                assertTextStartsAtLeft(text, tag)
                assertTextFits(text, tag)
            }
        }
    }

    private fun verifyVariants(layoutIds: List<Int>, verify: (ViewGroup, String) -> Unit) {
        val failures = mutableListOf<String>()
        onMain {
            for (layoutId in layoutIds) {
                for (locale in listOf(Locale.SIMPLIFIED_CHINESE, Locale.ENGLISH)) {
                    for (fontScale in listOf(1f, 1.3f)) {
                        for (widthDp in listOf(360, 411)) {
                            val configuration = Configuration(instrumentation.targetContext.resources.configuration).apply {
                                setLocales(LocaleList(locale))
                                setLayoutDirection(locale)
                                this.fontScale = fontScale
                                densityDpi = 160
                                screenWidthDp = widthDp
                                screenHeightDp = 1100
                                smallestScreenWidthDp = widthDp
                                orientation = Configuration.ORIENTATION_PORTRAIT
                            }
                            val context = ContextThemeWrapper(
                                instrumentation.targetContext.createConfigurationContext(configuration),
                                R.style.Theme_Phonedemo
                            )
                            val root = LayoutInflater.from(context).inflate(layoutId, null) as ViewGroup
                            if (layoutId == R.layout.activity_setting) {
                                root.findViewById<TextView>(R.id.tv_device_name).text = "Glass3_000594"
                                root.findViewById<TextView>(R.id.tv_device_sn).text = "190109252400594"
                                root.findViewById<TextView>(R.id.tv_device_system).text = "V1.0.0"
                            }
                            val width = dp(root, widthDp)
                            val height = dp(root, 1100)
                            root.measure(
                                View.MeasureSpec.makeMeasureSpec(width, View.MeasureSpec.EXACTLY),
                                View.MeasureSpec.makeMeasureSpec(height, View.MeasureSpec.EXACTLY)
                            )
                            root.layout(0, 0, width, height)
                            val tag = "${context.resources.getResourceEntryName(layoutId)}-${locale.toLanguageTag()}-$fontScale-${widthDp}dp"
                            saveScreenshot(root, tag)
                            try {
                                verify(root, tag)
                            } catch (failure: AssertionError) {
                                failures += failure.message ?: tag
                            }
                        }
                    }
                }
            }
        }
        assertTrue(failures.joinToString("\n"), failures.isEmpty())
    }

    private fun assertHorizontalSpace(text: TextView, leftDp: Int, rightDp: Int, tag: String) {
        val parent = text.parent as View
        val name = text.resources.getResourceEntryName(text.id)
        assertEquals("$tag: $name left margin", dp(text, leftDp), text.left)
        assertEquals("$tag: $name right margin", parent.width - dp(text, rightDp), text.right)
        assertEquals("$tag: $name usable width", parent.width - dp(text, leftDp) - dp(text, rightDp), text.width)
    }

    private fun assertTextStartsAtLeft(text: TextView, tag: String) {
        val layout = text.layout
        assertNotNull("$tag: missing text layout", layout)
        for (line in 0 until layout.lineCount) {
            assertEquals("$tag: line $line is no longer left aligned: ${text.text}", 0f, layout.getLineLeft(line), 1f)
        }
    }

    private fun assertTextFits(text: TextView, tag: String) {
        val layout = text.layout
        assertNotNull("$tag: missing text layout", layout)
        assertTrue("$tag: empty text layout", layout.lineCount > 0)
        assertTrue("$tag: text is vertically clipped: ${text.text}", layout.height <= text.height - text.compoundPaddingTop - text.compoundPaddingBottom)
        assertEquals("$tag: missing trailing text", text.text.length, layout.getLineEnd(layout.lineCount - 1))
        for (line in 0 until layout.lineCount) {
            assertEquals("$tag: ellipsized line $line", 0, layout.getEllipsisCount(line))
            assertTrue("$tag: line $line exceeds its right edge", layout.getLineRight(line) <= layout.width + 1f)
            assertTrue("$tag: line $line exceeds its left edge", layout.getLineLeft(line) >= -1f)
        }
    }

    private fun isVisible(view: View, root: View): Boolean {
        var current = view
        while (true) {
            if (current.visibility != View.VISIBLE) return false
            if (current === root) return true
            current = current.parent as View
        }
    }

    private fun dp(view: View, value: Int): Int = (value * view.resources.displayMetrics.density).roundToInt()

    private fun saveScreenshot(root: View, tag: String) {
        val directory = File(instrumentation.targetContext.getExternalFilesDir(null), "phone-layout-regression").apply { mkdirs() }
        val bitmap = Bitmap.createBitmap(root.width, root.height, Bitmap.Config.ARGB_8888)
        try {
            root.draw(Canvas(bitmap))
            File(directory, "$tag.png").outputStream().use { bitmap.compress(Bitmap.CompressFormat.PNG, 100, it) }
        } finally {
            bitmap.recycle()
        }
    }

    private fun onMain(block: () -> Unit) {
        var failure: Throwable? = null
        instrumentation.runOnMainSync {
            try {
                block()
            } catch (error: Throwable) {
                failure = error
            }
        }
        failure?.let { throw it }
    }
}
