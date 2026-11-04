package com.rokid.phone

import java.io.File
import javax.xml.parsers.DocumentBuilderFactory
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class VideoReceive4kConfigContractTest {
    @Test
    fun `video stream demo uses camera2 supported common resolution presets`() {
        val source = File(
            "src/main/java/com/rokid/phone/VideoReceiveActivity.kt"
        ).readText()

        assertTrue(source.contains("private val defaultFps = 15"))
        assertTrue(source.contains("private val defaultBitrate = 20_000_000"))
        assertTrue(source.contains("val DEFAULT_RESOLUTION = ResolutionOption(2400, 1800)"))
        assertTrue(source.contains("ResolutionOption(2400, 1800)"))
        assertTrue(source.contains("ResolutionOption(1920, 1080)"))
        assertTrue(source.contains("ResolutionOption(1280, 720)"))
        assertTrue(source.contains("ResolutionOption(648, 648)"))
        assertTrue(source.contains("ResolutionOption(640, 480)"))
        assertTrue(!source.contains("ResolutionOption(2048, 1536)"))
        assertTrue(!source.contains("ResolutionOption(1600, 1200)"))
        assertTrue(!source.contains("ResolutionOption(1440, 1080)"))
        assertTrue(!source.contains("ResolutionOption(1024, 768)"))
        assertTrue(!source.contains("ResolutionOption(1920, 1440)"))
        assertTrue(!source.contains("ResolutionOption(2340, 1080)"))
        assertTrue(!source.contains("ResolutionOption(3840, 2160)"))
        assertTrue(source.contains("500_000..30_000_000"))
        assertEquals("15", inputHint("et_frame_rate"))
        assertEquals("20000000", inputHint("et_bitrate"))
        assertEquals("1800", inputHint("et_resolution_height"))
    }

    private fun inputHint(id: String): String {
        val parser = DocumentBuilderFactory.newInstance().newDocumentBuilder()
        val inputs = parser.parse(File("src/main/res/layout/activity_video_receive.xml"))
            .getElementsByTagName("EditText")
        val input = (0 until inputs.length).map { inputs.item(it) }
            .single { it.attributes.getNamedItem("android:id").nodeValue == "@+id/$id" }
        val hint = input.attributes.getNamedItem("android:hint").nodeValue
        if (!hint.startsWith("@string/")) return hint
        val strings = parser.parse(File("src/main/res/values/strings.xml"))
            .getElementsByTagName("string")
        return (0 until strings.length).map { strings.item(it) }
            .single { it.attributes.getNamedItem("name").nodeValue == hint.removePrefix("@string/") }
            .textContent
    }
}
